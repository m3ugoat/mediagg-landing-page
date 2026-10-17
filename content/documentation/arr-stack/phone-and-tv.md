---
title: Your phone and TV
summary: Open the server to your home network, scan or type one code, and Mediagg adds Jellyfin and every service.
platforms: android, ios
order: 30
---

Once the server is set up, Mediagg can take everything it installed — Jellyfin and every service, with
their keys — in one go. Nothing is typed but a six-digit code.

## On the computer

On the dashboard, open `Devices` — or press `Pair a phone or TV`. Under
`Watch it on your phone and TV`, press `Open to my home network` and confirm: each service restarts,
and so does the dashboard, back in a few seconds. Until then the server answers the computer only;
afterwards it answers your home network — not the internet. Every service still asks for your
password, and FlareSolverr, which has none, stays on the computer. (A computer with no screen, set up
from another one, is on your network from the start.)

The card then shows a **QR code** and a **six-digit code**. Each code works once, for ten minutes;
`New pairing code` gives another.

## Whose phone or TV it is

The card asks `Who is this phone or TV for?`, and a new code appears for whoever you choose:

- **`You`** — the usual answer. Your phone and TV sign in as a user of yours with every library, who
  cannot change the media servers' settings, so a lost phone never carries your administrator account.
- **Someone under [People](/documentation/arr-stack/people)** — the device signs in as them, to what is
  theirs, and nothing else.
- **`You, as the administrator`**, with your name — your own login, which can change the media
  servers' settings.

## On your phone

Either:

- **Scan it.** Point the phone's camera app at the QR code and tap `Open in Mediagg`. Mediagg opens
  with the code already filled in.
- **Type it.** In Mediagg, open `Media servers` in the Library and press `Add a server`. The first
  choice is `Mediagg Arr Stack` — `Everything your stack installed, added in one go`.

Mediagg looks for the server on your network by itself (`Looking for it on your network…`) and fills
in the `Computer address`. Type the `Code` and press `Add everything`.

## On your TV

In Mediagg, open `Add` and choose `Mediagg Arr Stack`. It finds the computer by itself; type the code
with the remote and confirm.

## What you get

- **Your media servers** — Jellyfin, Emby, Navidrome, Audiobookshelf — join `Media servers`, signed in.
  Each phone or TV gets **a sign-in of its own** to Jellyfin, Emby and Audiobookshelf, under its own
  name, rather than your password; you can see them in those servers' lists of devices.
- **Plex** asks you to sign in with your plex.tv account: its sign-in opens next, with the address
  already filled in.
- **Sonarr, Radarr, Lidarr and the rest** appear under `Mediarr` in `Media servers`, already connected.

When it is done Mediagg says `Added everything from` and your computer's name. If one service could not be
added, it says which, and why; the others are kept.

## Paired

The first code a phone or TV takes **pairs** it: the server gives it a pairing token, which Mediagg
keeps in the device's secure storage. With it, Mediagg keeps up by itself:

- **When the computer's address changes** — routers sometimes hand out a new one — Mediagg looks for the
  server on your network the next time it starts, recognises it, and moves every service to the new
  address.
- **When you install a service later**, or reinstall one with new keys, Mediagg picks it up. It checks
  at most twice a day.

`Paired devices`, under `Devices`, lists each one — whose it is, and when it paired — with `Unpair`:
its token stops working and the sign-ins made for it end, so it needs a new pairing code.
`Unpair all phones and TVs` does that to every one.

To stop the address changing at all, reserve the computer's address in your router.

## If it does not work

- `No stack answered on this network.` — the phone is on another Wi-Fi, or the server has not been
  opened to your home network. Type the address the `Devices` card shows, or press `Look again`.
- `That code was not accepted.` — it was mistyped, used already or more than ten minutes old. Press
  `New pairing code` on the dashboard.
- `This stack is newer than this version of Mediagg.` — update Mediagg, then try again.
