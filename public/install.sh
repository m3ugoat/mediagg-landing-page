#!/bin/sh
# Copied from mediagg-arr-stack/install.sh — edit it there, then copy it here (README.md).
# Mediagg Arr Stack — installs Docker if it is missing, then starts the manager, which does the rest
# in your browser.
#
#   curl -fsSL https://mediagg.app/install.sh | sh
#   curl -fsSL https://mediagg.app/install.sh | sh -s -- --uninstall
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
PATH="$PATH:/Applications/Docker.app/Contents/Resources/bin"

# ---------------------------------------------------------------- removing it
# Everything the stack put on this Mac: its containers and network, its two login items, and — only
# when asked, and only from a terminal that can answer — its folder. The films and series are asked
# about on their own, and only when they are inside that folder: one elsewhere is never touched.
ask() { printf '%s [y/N] ' "$1"; read -r answer </dev/tty 2>/dev/null || answer=""; [ "$answer" = "y" ] || [ "$answer" = "Y" ]; }
if [ "${1:-}" = "--uninstall" ]; then
    say "Removing Mediagg Arr Stack…"
    if docker info >/dev/null 2>&1; then
        ids="$(docker ps -aq --filter label=app.mediagg.stack)"
        [ -n "$ids" ] && docker rm -f $ids >/dev/null
        docker network rm "$NETWORK" >/dev/null 2>&1 || true
    fi
    for item in app.mediagg.arrstack app.mediagg.arrstack.awake; do
        launchctl bootout "gui/$(id -u)" "$HOME/Library/LaunchAgents/$item.plist" 2>/dev/null || true
        rm -f "$HOME/Library/LaunchAgents/$item.plist"
    done
    if [ -d "$STACK_HOME" ]; then
        media="$(sed -n 's/.*"mediaFolder": "\(.*\)".*/\1/p' "$STACK_HOME/manager/state.json" 2>/dev/null | head -1)"
        if ask "Delete $STACK_HOME — the stack's settings, keys and passwords?"; then
            case "$media/" in
                "$STACK_HOME"/*)
                    if ask "Delete your films and series in $media too?"; then
                        rm -rf "$STACK_HOME"
                    else
                        find "$STACK_HOME" -mindepth 1 -maxdepth 1 ! -path "$media" -exec rm -rf {} +
                    fi
                    ;;
                *) rm -rf "$STACK_HOME" ;;
            esac
        fi
    fi
    say "Mediagg Arr Stack is removed. Docker Desktop stays; remove it from Applications if nothing else uses it."
    exit 0
fi

# ---------------------------------------------------------------- where the media goes
# Asked first, with the ordinary macOS folder picker, so the manager is only ever given this folder
# and its own — never the whole home folder, which made macOS ask about Dropbox, Desktop and drives
# the user never pointed it at. Kept from the last run once the stack is set up.
state="$STACK_HOME/manager/state.json"
media="${MEDIAGG_MEDIA:-}"
if [ -z "$media" ] && [ -f "$state" ]; then
    media="$(sed -n 's/.*"mediaFolder": "\(.*\)".*/\1/p' "$state" | head -1)"
fi
if [ -z "$media" ] && [ -z "${SSH_CONNECTION:-}" ] && command -v osascript >/dev/null 2>&1; then
    say "Choose where your films and series will go. Mediagg Arr Stack will only ever see that folder."
    media="$(osascript -e 'POSIX path of (choose folder with prompt "Where should your films and series go? Mediagg Arr Stack will only ever see this folder." default location (path to movies folder))' 2>/dev/null || true)"
fi
media="${media%/}"
if [ -z "$media" ]; then
    media="$STACK_HOME/media"
    say "Using $media for your films and series."
fi
mkdir -p "$media" || fail "Cannot create $media."
case "$media" in
    /Volumes/*) say "macOS may ask once whether Docker can use that drive — it is the folder you just chose." ;;
esac

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

# ---------------------------------------------------------------- keeping the Mac awake
# The dashboard's "Keep this Mac awake" switch. The manager is in Docker's Linux VM and cannot ask
# macOS for anything, so it only creates or deletes a file; this login item runs macOS's own
# caffeinate while that file exists — launchd starts it when the file appears, and it ends within
# 20 seconds of the file going. -i stops idle sleep; -s stops system sleep, only on mains power.
awake_flag="$STACK_HOME/manager/keep-awake"
awake_agent="$HOME/Library/LaunchAgents/app.mediagg.arrstack.awake.plist"
awake_xml="$(printf '%s' "$awake_flag" | sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g')"
cat >"$awake_agent" <<PLIST
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>app.mediagg.arrstack.awake</string>
    <key>ProgramArguments</key>
    <array>
        <string>/usr/bin/caffeinate</string>
        <string>-i</string>
        <string>-s</string>
        <string>/bin/sh</string>
        <string>-c</string>
        <string>while [ -e "\$0" ]; do sleep 20; done</string>
        <string>$awake_xml</string>
    </array>
    <key>KeepAlive</key>
    <dict>
        <key>PathState</key>
        <dict>
            <key>$awake_xml</key>
            <true/>
        </dict>
    </dict>
</dict>
</plist>
PLIST
launchctl bootout "gui/$(id -u)" "$awake_agent" 2>/dev/null || true
launchctl bootstrap "gui/$(id -u)" "$awake_agent" 2>/dev/null || true

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
    -v "$STACK_HOME:$STACK_HOME" \
    -e STACK_HOME="$STACK_HOME" \
    -e HOST_USER="$(id -un)" \
    -e PUID="$(id -u)" -e PGID="$(id -g)" \
    -e TZ="${zone:-Etc/UTC}" \
    -e BROWSE_ROOTS="$media" \
    -e MEDIA_FOLDER="$media" \
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
say "Your films and series go in: $media"
say "Your password and every service's API key are kept in: $state (only your account can read it)"
[ -n "${MEDIAGG_NO_OPEN:-}" ] || open "$url" 2>/dev/null || true
