#!/bin/sh
# Copied from mediagg-arr-stack/install.sh — edit it there, then copy it here (README.md).
# Mediagg Arr Stack — installs Docker if it is missing, then starts the manager, which does the rest
# in your browser.
#
#   curl -fsSL https://mediagg.app/install.sh | sh
#
# Running it again is safe: it restarts the manager on the newest version and keeps everything.
# macOS only for now; Linux and Windows follow.
set -eu

IMAGE="${MEDIAGG_IMAGE:-ghcr.io/m3ugoat/mediagg-arr-stack:latest}"
STACK_HOME="${MEDIAGG_STACK_HOME:-$HOME/MediaggStack}"
NAME="mediagg-manager"
NETWORK="mediagg"

say() { printf '\033[1m%s\033[0m\n' "$*"; }
fail() { printf '\033[31m%s\033[0m\n' "$*" >&2; exit 1; }

[ "$(uname -s)" = "Darwin" ] || fail "This installer is for macOS for now."

# ---------------------------------------------------------------- Docker
if ! command -v docker >/dev/null 2>&1 && [ ! -d /Applications/Docker.app ]; then
    case "$(uname -m)" in arm64) arch=arm64 ;; *) arch=amd64 ;; esac
    say "Mediagg Arr Stack runs on Docker Desktop, which is not installed. Installing it now."
    say "Your Mac will ask for your password once."
    dmg="$(mktemp -d)/Docker.dmg"
    curl -fL --progress-bar "https://desktop.docker.com/mac/main/$arch/Docker.dmg" -o "$dmg"
    sudo hdiutil attach -nobrowse -quiet "$dmg"
    sudo /Volumes/Docker/Docker.app/Contents/MacOS/install --accept-license --user="$(id -un)" </dev/tty
    sudo hdiutil detach -quiet /Volumes/Docker
    rm -f "$dmg"
fi
PATH="$PATH:/Applications/Docker.app/Contents/Resources/bin"

if ! docker info >/dev/null 2>&1; then
    say "Starting Docker Desktop…"
    open -a Docker
    i=0
    until docker info >/dev/null 2>&1; do
        i=$((i + 1))
        [ "$i" -gt 90 ] && fail "Docker Desktop did not start. Open it once from Applications, then run this again."
        sleep 2
    done
fi

# ---------------------------------------------------------------- after a restart
# Docker Desktop does not start at sign-in unless told to, and its own setting lives in a file
# macOS will not let a script touch. So a login item of ours opens it, hidden; every container is
# `restart: unless-stopped`, so once Docker is up the whole stack is back without anyone asking.
agent="$HOME/Library/LaunchAgents/app.mediagg.arrstack.plist"
mkdir -p "$HOME/Library/LaunchAgents"
cat >"$agent" <<'PLIST'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>app.mediagg.arrstack</string>
    <key>ProgramArguments</key>
    <array>
        <string>/usr/bin/open</string>
        <string>-g</string>
        <string>-j</string>
        <string>-a</string>
        <string>Docker</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
</dict>
</plist>
PLIST
launchctl bootout "gui/$(id -u)" "$agent" 2>/dev/null || true
launchctl bootstrap "gui/$(id -u)" "$agent" 2>/dev/null || true

# ---------------------------------------------------------------- the manager
mkdir -p "$STACK_HOME/manager"
docker network inspect "$NETWORK" >/dev/null 2>&1 || docker network create "$NETWORK" >/dev/null

if [ -z "${MEDIAGG_NO_PULL:-}" ]; then
    say "Downloading Mediagg Arr Stack…"
    docker pull --quiet "$IMAGE" >/dev/null
fi

# A token only while the stack is unclaimed; afterwards the page asks for the login instead.
token=""
if ! grep -q '"dashboardPasswordHash": "[^"]' "$STACK_HOME/manager/state.json" 2>/dev/null; then
    token="$(LC_ALL=C tr -dc 'A-Za-z0-9' </dev/urandom | head -c 20)"
fi

port=7979
while lsof -nP -iTCP:"$port" -sTCP:LISTEN >/dev/null 2>&1 && ! docker port "$NAME" 2>/dev/null | grep -q ":$port\$"; do
    port=$((port + 1))
done

zone="$(readlink /etc/localtime | sed 's#.*/zoneinfo/##')"
# A container cannot see the computer's own addresses, so they are found here and handed in.
addresses="$(for i in $(ifconfig -l); do ipconfig getifaddr "$i" 2>/dev/null || true; done | grep -E '^(192\.168|10\.|172\.(1[6-9]|2[0-9]|3[01])\.)' | paste -sd, -)"
computer="$(scutil --get ComputerName 2>/dev/null || hostname)"
# Phones and TVs keep reaching it after a re-run if they were let in before.
bind=127.0.0.1
grep -q '"network": true' "$STACK_HOME/manager/state.json" 2>/dev/null && bind=0.0.0.0
docker rm -f "$NAME" >/dev/null 2>&1 || true
docker run -d --name "$NAME" --restart unless-stopped \
    --network "$NETWORK" \
    --label app.mediagg.stack=manager \
    -p "$bind:$port:7979" \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v "$HOME:$HOME" \
    -v /Volumes:/Volumes \
    -e STACK_HOME="$STACK_HOME" \
    -e HOST_USER="$(id -un)" \
    -e PUID="$(id -u)" -e PGID="$(id -g)" \
    -e TZ="${zone:-Etc/UTC}" \
    -e BROWSE_ROOTS="$HOME:/Volumes" \
    -e SETUP_TOKEN="$token" \
    -e HOST_ADDRESSES="$addresses" \
    -e HOST_NAME="$computer" \
    -e MANAGER_PORT="$port" \
    "$IMAGE" >/dev/null

i=0
until curl -fs -o /dev/null "http://127.0.0.1:$port/login"; do
    i=$((i + 1))
    [ "$i" -gt 60 ] && fail "The manager did not start. See: docker logs $NAME"
    sleep 1
done

if [ -n "$token" ]; then
    url="http://localhost:$port/setup?token=$token"
    say ""
    say "Mediagg Arr Stack is running. Open this link to set it up (it works once, for 30 minutes):"
else
    url="http://localhost:$port/"
    say ""
    say "Mediagg Arr Stack is running:"
fi
printf '\n    %s\n\n' "$url"
[ -n "${MEDIAGG_NO_OPEN:-}" ] || open "$url" 2>/dev/null || true
