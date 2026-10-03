#!/bin/sh
# Mediagg Arr Stack — installs Docker if it is missing, then starts the manager, which does the rest
# in your browser.
#
#   curl -fsSL https://mediagg.app/install.sh | sh
#   curl -fsSL https://mediagg.app/install.sh | sh -s -- --uninstall
#
# Running it again is safe: it restarts the manager on the newest version and keeps everything.
# macOS and Linux; Windows follows. What differs between them is in the functions below, named by
# platform — the manager itself is the same container on both.
set -eu

IMAGE="${MEDIAGG_IMAGE:-ghcr.io/m3ugoat/mediagg-arr-stack:latest}"
STACK_HOME="${MEDIAGG_STACK_HOME:-$HOME/MediaggStack}"
NAME="mediagg-manager"
NETWORK="mediagg"

say() { printf '\033[1m%s\033[0m\n' "$*"; }
fail() { printf '\033[31m%s\033[0m\n' "$*" >&2; exit 1; }
ask() { printf '%s [y/N] ' "$1"; read -r answer </dev/tty 2>/dev/null || answer=""; [ "$answer" = "y" ] || [ "$answer" = "Y" ]; }

case "$(uname -s)" in
    Darwin) OS=macos ;;
    Linux) OS=linux ;;
    *) fail "Mediagg Arr Stack installs on macOS and Linux for now." ;;
esac

# On Linux, Docker is the system's: the script asks sudo for what needs it, and runs `docker` itself
# through sudo until the user's new docker group takes effect at their next sign-in.
SUDO=""
DOCKER="docker"
if [ "$OS" = linux ]; then
    if [ "$(id -u)" = 0 ]; then
        if [ -n "${SUDO_USER:-}" ]; then
            fail "Run this as yourself, without sudo — it asks for sudo when it needs it, and your films should be yours, not root's."
        fi
    else
        SUDO="sudo"
    fi
    if ! docker info >/dev/null 2>&1 && command -v docker >/dev/null 2>&1 && [ -n "$SUDO" ]; then
        DOCKER="sudo docker"
    fi
else
    PATH="$PATH:/Applications/Docker.app/Contents/Resources/bin"
fi

# ---------------------------------------------------------------- removing it
# Everything the stack put on this computer: its containers and network, what it added to start
# Docker and keep the computer awake, and — only when asked, and only from a terminal that can
# answer — its folder. The films and series are asked about on their own, and only when they are
# inside that folder: one elsewhere is never touched.
remove_added_macos() {
    for item in app.mediagg.arrstack app.mediagg.arrstack.awake; do
        launchctl bootout "gui/$(id -u)" "$HOME/Library/LaunchAgents/$item.plist" 2>/dev/null || true
        rm -f "$HOME/Library/LaunchAgents/$item.plist"
    done
}
remove_added_linux() {
    if [ -f /etc/systemd/system/mediagg-awake.path ]; then
        $SUDO systemctl disable --now mediagg-awake.path mediagg-awake.service >/dev/null 2>&1 || true
        $SUDO rm -f /etc/systemd/system/mediagg-awake.path /etc/systemd/system/mediagg-awake.service
        $SUDO systemctl daemon-reload || true
    fi
}
if [ "${1:-}" = "--uninstall" ]; then
    say "Removing Mediagg Arr Stack…"
    if $DOCKER info >/dev/null 2>&1; then
        ids="$($DOCKER ps -aq --filter label=app.mediagg.stack)"
        if [ -n "$ids" ]; then $DOCKER rm -f $ids >/dev/null; fi
        $DOCKER network rm "$NETWORK" >/dev/null 2>&1 || true
    fi
    "remove_added_$OS"
    if [ -d "$STACK_HOME" ]; then
        media="$(sed -n 's/.*"mediaFolder": "\(.*\)".*/\1/p' "$STACK_HOME/manager/state.json" 2>/dev/null | head -1)"
        # A service may have left files owned by root on Linux; sudo removes those too.
        rm="rm"
        if [ "$OS" = linux ]; then rm="$SUDO rm"; fi
        if ask "Delete $STACK_HOME — the stack's settings, keys and passwords?"; then
            case "$media/" in
                "$STACK_HOME"/*)
                    if ask "Delete your films and series in $media too?"; then
                        $rm -rf "$STACK_HOME"
                    else
                        find "$STACK_HOME" -mindepth 1 -maxdepth 1 ! -path "$media" -exec $rm -rf {} +
                    fi
                    ;;
                *) $rm -rf "$STACK_HOME" ;;
            esac
        fi
    fi
    if [ "$OS" = macos ]; then
        say "Mediagg Arr Stack is removed. Docker Desktop stays; remove it from Applications if nothing else uses it."
    else
        say "Mediagg Arr Stack is removed. Docker stays installed; other things may use it."
    fi
    exit 0
fi

# ---------------------------------------------------------------- can it run here
if [ "$OS" = linux ]; then
    # Every image the stack runs is published for 64-bit Intel/AMD and 64-bit ARM, nothing else. A
    # Raspberry Pi with a 64-bit kernel under a 32-bit system says aarch64 to uname, so ask dpkg.
    arch="$(dpkg --print-architecture 2>/dev/null || uname -m)"
    case "$arch" in
        amd64 | x86_64 | arm64 | aarch64) ;;
        *) fail "Mediagg Arr Stack needs a 64-bit system ($arch here). On a Raspberry Pi, that is the 64-bit Raspberry Pi OS." ;;
    esac
fi

# A computer set up from another one — over SSH, or with no screen — is reached by its address from
# the start: its page goes on the home network straight away, and the link printed is that address.
headless=false
if [ "$OS" = linux ]; then
    if [ -n "${SSH_CONNECTION:-}" ] || [ -z "${DISPLAY:-}${WAYLAND_DISPLAY:-}" ]; then headless=true; fi
fi

# ---------------------------------------------------------------- where the media goes
# Asked first, so the manager is only ever given this folder and its own — never the whole home
# folder, which made macOS ask about Dropbox, Desktop and drives the user never pointed it at. Kept
# from the last run once the stack is set up.
QUESTION="Where are your films, series and music — or where should they go? Mediagg Arr Stack will only ever see this folder."
pick_folder_macos() {
    if [ -n "${SSH_CONNECTION:-}" ] || ! command -v osascript >/dev/null 2>&1; then return 0; fi
    say "Choose the folder your films, series and music are in — or a new one for them. Mediagg Arr Stack will only ever see that folder." >&2
    osascript -e "POSIX path of (choose folder with prompt \"$QUESTION\" default location (path to movies folder))" 2>/dev/null || true
}
pick_folder_linux() {
    if [ "$headless" = false ] && command -v zenity >/dev/null 2>&1; then
        say "Choose the folder your films, series and music are in — or a new one for them. Mediagg Arr Stack will only ever see that folder." >&2
        zenity --file-selection --directory --title="$QUESTION" --filename="$HOME/Videos/" 2>/dev/null || true
        return 0
    fi
    # No picker: asked in the terminal. Under `curl | sh` the script is stdin, so the answer comes
    # from the terminal itself.
    { printf '\033[1m%s\033[0m\n' "$QUESTION"; printf 'A folder, or Enter for %s: ' "$STACK_HOME/media"; } >/dev/tty 2>/dev/null || return 0
    read -r answer </dev/tty 2>/dev/null || answer=""
    printf '%s' "$answer"
}
state="$STACK_HOME/manager/state.json"
media="${MEDIAGG_MEDIA:-}"
if [ -z "$media" ] && [ -f "$state" ]; then
    media="$(sed -n 's/.*"mediaFolder": "\(.*\)".*/\1/p' "$state" | head -1)"
fi
if [ -z "$media" ]; then media="$("pick_folder_$OS")"; fi
case "$media" in
    "~") media="$HOME" ;;
    "~/"*) media="$HOME/${media#"~/"}" ;;
    "" | /*) ;;
    *) media="$PWD/$media" ;;
esac
media="${media%/}"
if [ -z "$media" ]; then
    media="$STACK_HOME/media"
    say "Using $media for your films and series."
fi
mkdir -p "$media" 2>/dev/null || fail "Cannot create $media. Choose a folder you can write to — for a drive, its folder under /media or /mnt."
[ -w "$media" ] || fail "Cannot write to $media. Choose a folder you can write to."
case "$media" in
    /Volumes/*) say "macOS may ask once whether Docker can use that drive — it is the folder you just chose." ;;
esac

# ---------------------------------------------------------------- Docker
install_docker_macos() {
    if command -v docker >/dev/null 2>&1 || [ -d /Applications/Docker.app ]; then return 0; fi
    case "$(uname -m)" in arm64) arch=arm64 ;; *) arch=amd64 ;; esac
    say "Mediagg Arr Stack runs on Docker Desktop, which is not installed. Installing it now."
    say "Your Mac will ask for your password once."
    dmg="$(mktemp -d)/Docker.dmg"
    curl -fL --progress-bar "https://desktop.docker.com/mac/main/$arch/Docker.dmg" -o "$dmg"
    sudo hdiutil attach -nobrowse -quiet "$dmg"
    sudo /Volumes/Docker/Docker.app/Contents/MacOS/install --accept-license --user="$(id -un)" </dev/tty
    sudo hdiutil detach -quiet /Volumes/Docker
    rm -f "$dmg"
}
start_docker_macos() {
    if docker info >/dev/null 2>&1; then return 0; fi
    say "Starting Docker Desktop…"
    open -a Docker
    i=0
    until docker info >/dev/null 2>&1; do
        i=$((i + 1))
        [ "$i" -gt 90 ] && fail "Docker Desktop did not start. Open it once from Applications, then run this again."
        sleep 2
    done
}
# Docker Engine, from Docker's own install script — it knows Debian, Ubuntu, Raspberry Pi OS, Fedora
# and the rest. Started with the computer by systemd, so the stack is back after a restart with
# nobody signed in.
install_docker_linux() {
    if command -v docker >/dev/null 2>&1; then return 0; fi
    say "Mediagg Arr Stack runs on Docker, which is not installed. Installing it now with Docker's own install script."
    if [ -n "$SUDO" ]; then say "It needs your password for sudo."; fi
    # Its own output is pages of versions and advice; kept, and shown only if it fails.
    log="$(mktemp)"
    if ! curl -fsSL https://get.docker.com | $SUDO sh >"$log" 2>&1; then
        tail -20 "$log" >&2
        fail "Docker's install script failed (all of its output: $log)."
    fi
    rm -f "$log"
    if [ -n "$SUDO" ]; then
        $SUDO usermod -aG docker "$(id -un)"
        DOCKER="sudo docker"
    fi
}
start_docker_linux() {
    $SUDO systemctl enable --now docker >/dev/null 2>&1 || $SUDO service docker start >/dev/null 2>&1 || true
    i=0
    until $DOCKER info >/dev/null 2>&1; do
        i=$((i + 1))
        [ "$i" -gt 30 ] && fail "Docker did not start. See: sudo systemctl status docker"
        sleep 2
    done
    # The manager drives Docker through its socket, where a system Docker keeps it. Rootless Docker
    # and Docker Desktop for Linux keep theirs elsewhere.
    [ -S /var/run/docker.sock ] || fail "Mediagg Arr Stack needs Docker Engine's socket at /var/run/docker.sock. Rootless Docker and Docker Desktop for Linux are not supported yet."
}
"install_docker_$OS"
"start_docker_$OS"

# ---------------------------------------------------------------- after a restart, and staying awake
# The dashboard's "Keep this computer awake" switch: the manager is in a container and cannot ask
# the computer for anything, so it only creates or deletes a file, and what is added here keeps the
# computer awake while that file exists.
awake_flag="$STACK_HOME/manager/keep-awake"
add_items_macos() {
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

    # macOS's own caffeinate while the file exists — launchd starts it when the file appears, and it
    # ends within 20 seconds of the file going. -i stops idle sleep; -s system sleep, on mains power.
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
}
add_items_linux() {
    # Docker already starts with the computer (above). Staying awake is a path unit watching the
    # file and a service holding systemd's sleep inhibitor while it exists. A system unit, not a
    # user one, so it works with nobody signed in — which is how a home server usually is.
    inhibit="$(command -v systemd-inhibit || true)"
    if [ -z "$inhibit" ] || ! command -v systemctl >/dev/null 2>&1 || [ ! -d /run/systemd/system ]; then
        say "This computer does not run systemd, so Keep this computer awake will do nothing here."
        return 0
    fi
    # systemd reads \ and % in a unit file, and quotes with "; a path with those is left unwatched.
    case "$awake_flag" in
        *[\\%\"]*)
            say "Keep this computer awake cannot watch a folder named like $STACK_HOME."
            return 0
            ;;
    esac
    $SUDO tee /etc/systemd/system/mediagg-awake.path >/dev/null <<UNIT
[Unit]
Description=Mediagg Arr Stack: keep this computer awake while its page asks

[Path]
PathExists=$awake_flag
Unit=mediagg-awake.service

[Install]
WantedBy=multi-user.target
UNIT
    $SUDO tee /etc/systemd/system/mediagg-awake.service >/dev/null <<UNIT
[Unit]
Description=Mediagg Arr Stack: keeping this computer awake

[Service]
ExecStart=$inhibit --what=sleep:idle --who="Mediagg Arr Stack" --why="Serving films and series" --mode=block /bin/sh -c 'while [ -e "\$\$1" ]; do sleep 20; done' mediagg-awake "$awake_flag"
UNIT
    $SUDO systemctl daemon-reload
    $SUDO systemctl enable --now mediagg-awake.path >/dev/null 2>&1 || say "Could not start the keep-awake service; see: systemctl status mediagg-awake.path"
}
"add_items_$OS"

# ---------------------------------------------------------------- what the manager is told
# A container cannot see the computer's own addresses, name or time zone, so they are found here
# and handed in.
facts_macos() {
    zone="$(readlink /etc/localtime | sed 's#.*/zoneinfo/##')"
    addresses="$(for i in $(ifconfig -l); do ipconfig getifaddr "$i" 2>/dev/null || true; done)"
    computer="$(scutil --get ComputerName 2>/dev/null || hostname)"
}
facts_linux() {
    zone="$(timedatectl show -p Timezone --value 2>/dev/null || true)"
    if [ -z "$zone" ]; then zone="$(cat /etc/timezone 2>/dev/null || true)"; fi
    # Docker's own bridges are private addresses too, and no phone can reach them.
    addresses="$(ip -4 -o addr show scope global 2>/dev/null | awk '$2 !~ /^(docker|br-|veth|virbr|cni|flannel)/ {print $4}' | cut -d/ -f1)"
    computer="$(hostnamectl --pretty 2>/dev/null || true)"
    if [ -z "$computer" ]; then computer="$(hostname)"; fi
}
port_taken_macos() { lsof -nP -iTCP:"$1" -sTCP:LISTEN >/dev/null 2>&1; }
port_taken_linux() { ss -Hltn "sport = :$1" 2>/dev/null | grep -q .; }
"facts_$OS"
addresses="$(printf '%s\n' $addresses | grep -E '^(192\.168|10\.|172\.(1[6-9]|2[0-9]|3[01])\.)' | paste -sd, - || true)"

# ---------------------------------------------------------------- the manager
mkdir -p "$STACK_HOME/manager"
$DOCKER network inspect "$NETWORK" >/dev/null 2>&1 || $DOCKER network create "$NETWORK" >/dev/null

if [ -z "${MEDIAGG_NO_PULL:-}" ]; then
    say "Downloading Mediagg Arr Stack…"
    $DOCKER pull --quiet "$IMAGE" >/dev/null
fi

# A token only while the stack is unclaimed; afterwards the page asks for the login instead.
token=""
if ! grep -q '"dashboardPasswordHash": "[^"]' "$state" 2>/dev/null; then
    token="$(LC_ALL=C tr -dc 'A-Za-z0-9' </dev/urandom | head -c 20)"
fi

port=7979
while "port_taken_$OS" "$port" && ! $DOCKER port "$NAME" 2>/dev/null | grep -q ":$port\$"; do
    port=$((port + 1))
done

# Phones and TVs keep reaching it after a re-run if they were let in before.
bind=127.0.0.1
if grep -q '"network": true' "$state" 2>/dev/null || [ "$headless" = true ]; then bind=0.0.0.0; fi
$DOCKER rm -f "$NAME" >/dev/null 2>&1 || true
$DOCKER run -d --name "$NAME" --restart unless-stopped \
    --network "$NETWORK" \
    --label app.mediagg.stack=manager \
    -p "$bind:$port:7979" \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v "$STACK_HOME:$STACK_HOME" \
    -e STACK_HOME="$STACK_HOME" \
    -e HOST_OS="$OS" \
    -e HOST_USER="$(id -un)" \
    -e PUID="$(id -u)" -e PGID="$(id -g)" \
    -e TZ="${zone:-Etc/UTC}" \
    -e BROWSE_ROOTS="$media" \
    -e MEDIA_FOLDER="$media" \
    -e SETUP_TOKEN="$token" \
    -e HOST_ADDRESSES="$addresses" \
    -e HOST_NAME="$computer" \
    -e MANAGER_PORT="$port" \
    -e PAGE_ON_NETWORK="$headless" \
    "$IMAGE" >/dev/null

i=0
until curl -fs -o /dev/null "http://127.0.0.1:$port/login"; do
    i=$((i + 1))
    [ "$i" -gt 60 ] && fail "The manager did not start. See: $DOCKER logs $NAME"
    sleep 1
done

host=localhost
if [ "$headless" = true ]; then
    host="${addresses%%,*}"
    if [ -z "$host" ]; then host="$(hostname).local"; fi
fi
say ""
if [ -n "$token" ]; then
    url="http://$host:$port/setup?token=$token"
    if [ "$headless" = true ]; then
        say "Mediagg Arr Stack is running. On a computer or phone on the same network, open this link to set it up"
        say "(it works once, for 30 minutes):"
    else
        say "Mediagg Arr Stack is running. Open this link to set it up (it works once, for 30 minutes):"
    fi
else
    url="http://$host:$port/"
    say "Mediagg Arr Stack is running:"
fi
printf '\n    %s\n\n' "$url"
say "Your films and series go in: $media"
say "Your password and every service's API key are kept in: $state (only your account can read it)"
if [ "$DOCKER" = "sudo docker" ]; then
    say "To use docker without sudo yourself, sign out and back in once. The stack does not need it."
fi
if [ -z "${MEDIAGG_NO_OPEN:-}" ]; then
    if [ "$OS" = macos ]; then
        open "$url" 2>/dev/null || true
    elif [ "$headless" = false ] && command -v xdg-open >/dev/null 2>&1; then
        xdg-open "$url" >/dev/null 2>&1 || true
    fi
fi
