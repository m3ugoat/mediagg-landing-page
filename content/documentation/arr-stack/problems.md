---
title: Problems and removing it
summary: A step that failed, a missing drive, a phone that cannot reach it, and taking it all away.
order: 50
---

## A step failed, or a connection shows ✗

Open `Settings` and press `Repair everything`, beside `Connections`. It starts anything that is not
running, sets each service up again and remakes every connection — without resetting anything that
already works. If the same step fails again, `Details`, in the progress card, says why. Fix what it
says and repair again; nothing that worked is undone.

## `Your media folder is not there`

The folder for your films and series cannot be reached — usually because it is on an external drive
that is not plugged in, or was renamed. The services that use it stop until it is back. Plug the drive
in, with the same name, then press `Repair everything`. The dashboard keeps working either way.

## My phone cannot reach the server

- Is the computer awake? See `Keep this computer awake` in
  [Using it day to day](/documentation/arr-stack/everyday).
- Are the phone and the computer on the same network?
- Did you press `Open to my home network`, under `Devices`?
- Did the computer's address change? A paired phone or TV finds it again the next time Mediagg starts.

## Why does it say my drive cannot link files?

A finished download is normally linked into your library: one file in two places, using its space
once. Drives formatted as exFAT, and network drives, cannot do that, so each download is copied and
takes its space twice. Everything still works; a drive formatted as APFS on a Mac, or ext4 on Linux,
avoids it.

## Is opening it to my home network safe?

It opens the services to your home network, not the internet, and every service asks for your
password. Two limits to know: the pages are plain HTTP, so a password typed on your phone crosses your
Wi-Fi unencrypted, and anyone on your network can see the sign-in pages. On a home network you trust,
that is reasonable. `Limit to this computer`, under `Devices`, closes it again — and phones and TVs
stop reaching your server.

Your phone and TV never need the dashboard — the code does it.

## Removing it

**One service:** under `Settings`, in `All services`, its `•••` →
`Uninstall, keep settings` or `Uninstall and delete settings`. A switch in your library does the same
for what it turned on.

**Everything:** under `Settings`, `Uninstall Mediagg Server`. It uninstalls every service, deletes
their settings and keys, and removes the dashboard. **Your films and series stay**; if they are inside
`MediaggStack`, a box — `Delete my films and series too` — deletes them as well. Then, to remove what the
install command added to the computer — on a Mac two small login items, one starting Docker Desktop
when you sign in and one keeping the Mac awake; on Linux the small service that keeps it awake — run:

```
curl -fsSL https://mediagg.app/install.sh | sh -s -- --uninstall
```

That command on its own also uninstalls everything, if the dashboard is not there any more, and asks
before it deletes any folder. Docker stays installed: on a Mac remove Docker Desktop from Applications
if nothing else uses it.
