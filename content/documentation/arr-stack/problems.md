---
title: Problems and removing it
summary: A step that failed, a missing drive, a phone that cannot reach it, and taking it all away.
order: 50
---

## A step failed, or a connection shows ✗

Press `Repair everything`. If the same step fails again, `Details`, in the progress card, says why.
Fix what it says and repair again; nothing that worked is undone.

## `Your media folder is not there`

The folder for your films and series cannot be reached — usually because it is on an external drive
that is not plugged in, or was renamed. The services that use it stop until it is back. Plug the drive
in, with the same name, then press `Repair everything`. The stack's page keeps working either way.

## My phone cannot reach the stack

- Is the computer awake? See `Keep this computer awake` in
  [Using it day to day](/documentation/arr-stack/everyday).
- Are the phone and the computer on the same network?
- Did you press `Let my phone and TV in`?
- Did the computer's address change? A paired phone or TV finds it again the next time Mediagg starts.

## Why does it say my drive cannot link files?

A finished download is normally linked into your library: one file in two places, using its space
once. Drives formatted as exFAT, and network drives, cannot do that, so each download is copied and
takes its space twice. Everything still works; a drive formatted as APFS avoids it.

## Is letting my phone and TV in safe?

It opens the services to your home network, not the internet, and every service asks for your
password. Two limits to know: the pages are plain HTTP, so a password typed on your phone crosses your
Wi-Fi unencrypted, and anyone on your network can see the sign-in pages. On a home network you trust,
that is reasonable. `Close it to my network` closes it again.

Your phone and TV never need the stack's own page — the code does it.

## Removing it

**One service:** on its tile, `Remove` — keeping its settings, or deleting them.

**Everything:** at the bottom of the stack's page, `Remove everything`. It removes every service,
their settings and keys, and the page itself. **Your films and series stay**, unless you tick
`Delete my films and series too`. Then, to remove what the install command added to the computer —
on a Mac two small login items, one starting Docker Desktop when you sign in and one keeping the Mac
awake; on Linux the small service that keeps it awake — run:

```
curl -fsSL https://mediagg.app/install.sh | sh -s -- --uninstall
```

That command on its own also removes everything, if the page is not there any more, and asks before it
deletes any folder. Docker stays installed: on a Mac remove Docker Desktop from Applications if nothing
else uses it.
