---
title: Your phone and TV
summary: Let them in, scan or type one code, and Mediagg adds Jellyfin and every service.
platforms: android, ios
order: 30
---

Once the stack is set up, Mediagg can take everything it installed — Jellyfin and every service, with
their keys — in one go. Nothing is typed but a six-digit code.

## On the computer

Under `Watch it on your phone and TV`, press `Let my phone and TV in`. Until then the stack answers
the computer only; afterwards it answers your home network — not the internet. Every service still asks
for your password, and FlareSolverr, which has none, stays on the computer.

The page then shows a **QR code** and a **six-digit code**. Each code works once, for ten minutes;
`New code` gives another.

## On your phone

Either:

- **Scan it.** Point the phone's camera app at the QR code and tap `Open in Mediagg`. Mediagg opens
  with the code already filled in.
- **Type it.** In Mediagg, open `Media servers` in the Library and press `Add a server`. The first
  choice is `Mediagg Arr Stack` — `Everything your stack installed, added in one go`.

Mediagg looks for the stack on your network by itself (`Looking for it on your network…`) and fills
in the `Computer address`. Type the `Code` and press `Add everything`.

## On your TV

In Mediagg, open `Add` and choose `Mediagg Arr Stack`. It finds the computer by itself; type the code
with the remote and confirm.

## What you get

- **Jellyfin** joins your media servers, signed in with your stack's login. Your films and series are
  in the Library like any other server's.
- **Sonarr, Radarr and the rest** appear under `Mediarr` in `Media servers`, already connected.

When it is done Mediagg says `Added everything from` and your computer's name. If one service could not be
added, it says which, and why; the others are kept.

## Paired

The first code a phone or TV takes **pairs** it: the stack gives it a pairing token, which Mediagg
keeps in the device's secure storage. With it, Mediagg keeps up by itself:

- **When the computer's address changes** — routers sometimes hand out a new one — Mediagg looks for the
  stack on your network the next time it starts, recognises it, and moves every service to the new
  address.
- **When you install a service later**, or reinstall one with new keys, Mediagg picks it up. It checks
  at most twice a day.

The stack's page shows how many phones and TVs are paired. `Forget my phones and TVs` stops every
token working; a device keeps what it has until something moves, and then needs a new code.

To stop the address changing at all, reserve the computer's address in your router.

## If it does not work

- `No stack answered on this network.` — the phone is on another Wi-Fi, or the stack has not been
  let in. Type the address the stack's page shows, or press `Look again`.
- `That code was not accepted.` — it was mistyped, used already or more than ten minutes old. Show a
  new one on the stack's page.
- `This stack is newer than this version of Mediagg.` — update Mediagg, then try again.
