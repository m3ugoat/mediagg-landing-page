---
title: Using it day to day
summary: Adding films and series, the stack's page, updates, keeping the Mac awake and the password.
order: 40
---

## Adding a film or a series

- **The easy way:** open Seerr, search, and press Request. Family members can do the same, and you
  approve.
- **The direct way:** open Radarr (films) or Sonarr (series), search, and press Add.

Either way it is downloaded, moved into your library, and appears in Jellyfin and Mediagg by itself.
It needs sites in Prowlarr first — see
[Setting it up](/documentation/arr-stack/set-up).

## The stack's page

Open it from the Mac at the address the install command printed — `http://localhost:7979` — and
sign in with your stack's login.

- **A tile per service**, with `Open`, `Reinstall` and `Remove` — `Remove, keep its settings` or
  `Remove and delete its settings`. A service you did not choose at first has `Install` on its tile;
  paired phones and TVs pick it up by themselves.
- **Connections**, every link between the services, each tested as the page opens.
- **`Repair everything`** starts anything that stopped, sets each service up again and remakes every
  connection — without resetting anything that already works. It is the answer to most problems.

## Updates

When a new version is out, the page says so — `Mediagg Arr Stack 0.5.0 is out` — with an
`Update to 0.5.0` button. Updating restarts the page; the services keep running and nothing you have
changes. If the new version runs newer, tested versions of the services, an `Updates for` card follows,
naming them, with `Update services`. Each restarts, and its settings stay.

Running the install command again does the same.

## Keep this Mac awake

A sleeping Mac serves nothing: your phone and TV cannot play, and downloads stop. Under `This Mac`,
`Keep this Mac awake` stops the Mac going to sleep by itself — the screen still turns off, so it costs
little. Turn it off whenever you like.

It cannot stop everything: on battery the Mac may still sleep to save power, and closing a laptop's
lid sleeps it unless it is plugged in with a display attached.

When the Mac restarts, Docker Desktop and every service start again by themselves once you sign in.

## Change the password

`Change the password` changes it for the stack's page and every service at once. Paired phones and
TVs pick it up by themselves.

Forgotten it? It is in `MediaggStack/manager/state.json` in your home folder, which only your Mac
account can read. That file also holds every service's API key.

## Watching away from home

Not yet. The stack is reachable on your home network only; remote access is planned.
