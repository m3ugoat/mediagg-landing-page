---
title: Installing it
summary: One command in a terminal, a folder for your films, and a link to open.
order: 10
---

The same command installs it on a Mac and on Linux. Open a terminal — on a Mac, **Terminal**, in
Applications → Utilities — and paste:

```
curl -fsSL https://mediagg.app/install.sh | sh
```

That is the whole install. Run it as yourself, not with `sudo`: it asks for your password when it
needs it.

## On a Mac

1. **You choose a folder for your films and series.** The ordinary macOS folder picker opens, asking
   `Where should your films and series go?` Pick a folder in your home folder or on an external drive.
   The stack will only ever see this folder and its own — not your Desktop, Documents, Dropbox or
   anything else — so macOS has nothing else to ask about.
2. **Docker Desktop is installed, if it is not already.** Your Mac asks for your password once.
3. **Docker Desktop starts**, and the stack's own page is downloaded and started inside it.
4. **Terminal prints a link** — `Open this link to set it up (it works once, for 30 minutes)` — and
   opens it in your browser.

If your folder is on an external drive, macOS asks once whether Docker may use it. That is the folder
you just chose — say yes.

## On Linux

1. **You choose a folder for your films and series.** On a desktop a folder picker opens; otherwise
   the terminal asks, and Enter takes `MediaggStack/media` in your home folder. For an external drive,
   give its folder under `/media` or `/mnt` — and keep it mounted there.
2. **Docker is installed, if it is not already**, with Docker's own install script, and set to start
   with the computer — so the stack is back after a restart even with nobody signed in.
3. **The stack's own page is downloaded and started**, and a link is printed.

**Setting up a computer with no screen** — a Raspberry Pi or a server you reach over SSH — works the
same way. The link printed is the computer's address on your network, such as
`http://192.168.1.20:7979/setup?token=…`: open it on any computer or phone on the same network.

Your Linux computer needs to be 64-bit. On a Raspberry Pi that is the 64-bit Raspberry Pi OS.

## Where everything goes

The last lines say:

- `Your films and series go in:` the folder you picked.
- `Your password and every service's API key are kept in:` a file in `MediaggStack` in your home
  folder, readable only by your account.

## The setup link

The link holds a one-time code, so only the person who ran the command can set the stack up. If it
has expired, run the install command again for a new one; nothing you have is lost.

Next: [Setting it up](/documentation/arr-stack/set-up).

## Running it again

The same command updates the stack when a new version is out, and repairs an install that went wrong.
It keeps your folder, your password and everything you have set up.
