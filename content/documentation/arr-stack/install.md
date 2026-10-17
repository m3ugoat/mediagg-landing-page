---
title: Installing it
summary: One command in a terminal, a folder for your films, and a link to open.
order: 10
---

The server calls itself **Mediagg Server**; in the Mediagg app it is still `Mediagg Arr Stack`. The
same command installs it on a Mac and on Linux. Open a terminal — on a Mac, **Terminal**, in
Applications → Utilities — and paste:

```
curl -fsSL https://mediagg.app/install.sh | sh
```

That is the whole install. Run it as yourself, not with `sudo`: it asks for your password when it
needs it.

## On a Mac

1. **You choose the drive or folder the server may use** — the one your media is in, or a new one for
   it. The ordinary macOS folder picker opens, asking
   `Which drive or folder may Mediagg Server use? Your media goes in it, or already is. It will only ever see this folder.`
   Pick a folder in your home folder or on an external drive. The server will only ever see this
   folder and its own — not your Desktop, Documents, Dropbox or anything else — so macOS has nothing
   else to ask about.
2. **Docker Desktop is installed, if it is not already.** Your Mac asks for your password once.
3. **Docker Desktop starts**, and Mediagg Server is downloaded and started inside it.
4. **Terminal prints a link** —
   `Mediagg Server is running. Open this link to set it up (it works once, for 30 minutes):` — and
   opens it in your browser.

If your folder is on an external drive, macOS asks once whether Docker may use it. That is the folder
you just chose — say yes.

## On Linux

1. **You choose the drive or folder the server may use** — the one your media is in, or a new one for
   it. On a desktop a folder picker opens; otherwise the terminal asks, **Tab completes the path** as
   at any prompt, and Enter takes `MediaggStack/media` in your home folder. For an external drive,
   give its folder under `/media` or `/mnt` — and keep it mounted there.
2. **Docker is installed, if it is not already**, with Docker's own install script, and set to start
   with the computer — so the server is back after a restart even with nobody signed in.
3. **Mediagg Server is downloaded and started**, and a link is printed.

**Setting up a computer with no screen** — a Raspberry Pi or a server you reach over SSH — works the
same way. The link printed is to open on any computer or phone on the same network. It uses the
computer's name on your network where it has one, such as `http://raspberrypi.local:7979/setup?token=…`,
with its number address on the next line, `(or http://192.168.1.20:7979/…)`, for a phone or network
that does not know the name. Because you set it up from another computer, its services are on your
network from the start, so every service the dashboard links to opens from where you are.

Your Linux computer needs to be 64-bit. On a Raspberry Pi that is the 64-bit Raspberry Pi OS.

## Where everything goes

The last lines say:

- `Your films and series go in:` the folder you picked.
- `Your password and every service's API key are kept in:` a file in `MediaggStack` in your home
  folder, readable only by your account.

## The setup link

The link holds a one-time code, so only the person who ran the command can set the server up. If it
has expired, run the install command again for a new one; nothing you have is lost.

Next: [Setting it up](/documentation/arr-stack/set-up).

## Running it again

The same command updates the server when a new version is out, and repairs an install that went wrong.
It keeps your folder, your password and everything you have set up, and prints
`Mediagg Server is running:` with the dashboard's address.
