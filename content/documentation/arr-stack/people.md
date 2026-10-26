---
title: People
summary: A login of their own for everyone in the house, with the libraries you choose — and their devices let in as them.
order: 32
---

Everyone in your household can have their own login in **Jellyfin, Emby, Navidrome and
Audiobookshelf** — their own favourites, progress and history — and see only the libraries you choose.
Nobody types a password on a phone or a TV.

## Adding someone

On the dashboard, open `People`, and under `Add someone`:

- **`Name`** — the server makes their login from it (`Sam O'Neill` → `samoneill`) and a password for
  them.
- **`Can change the media servers' settings (an administrator)`** — leave it off for most people.
- **`Their own user in`** — tick each server they should have. Under each,
  `All libraries, and any made later`, or untick it and choose: `Films` but not `Series` for a child,
  one music library and not another.
- **`Maximum age rating`**, with Jellyfin — `No limit`, or `U — all ages`, `PG — 8 and over`,
  `12 — 12 and over`, `15 — 15 and over` or `18 — adults`. In Jellyfin they see only films and series
  rated for that age or younger; with a limit, anything with no rating is hidden too.
- **`Also on their devices`** — Sonarr, Radarr, Lidarr, Prowlarr, qBittorrent, Seerr, Bazarr
  and Plex. These have no users of their own: a device given one has its API key, and can change
  anything there. Leave them out for children and guests. **Seerr is the exception** — they ask as
  themselves, and you choose `Their requests wait for my approval` or
  `Their requests are approved automatically` — waiting, to start with. Waiting ones are under `Requests` on the dashboard, as
  `Pending approval`.

Press `Add`. The server makes their users, with the libraries you chose.

## Letting their device in

Under `Devices`, choose them in `Who is this device for?` — a new code appears for them — and use
it as usual. Their device is given only what is theirs, signed in as them: their Jellyfin or Emby,
their Navidrome and Audiobookshelf, and the services you ticked.

## Changing, and removing

Each person has, under their name:

- **What they have** — each service, with the user they are in it.
- **Their devices**, each with `Unpair`.
- **`Their password`** — shown, for their own use of each server's page.
  `Give … a new password` changes it in every server at once; their devices keep their own
  sign-ins.
- **`Edit name and access`** — their name, administrator or not, their servers, libraries, age rating
  and requests. A server taken away deletes their user there and ends their devices' sign-ins to it.
- **`Remove person`** — their users are deleted, with their favourites, progress and history, and
  their devices are signed out. Your films and series stay.

**`You`** are always first in the list: the server's own login, with everything. Your devices
sign in as a user of yours that has every library but cannot change the media servers' settings, so a
lost phone never carries your administrator account.

> **Plex** has no users of its own on the server — its people are plex.tv accounts — so it is not in
> `Their own user in`. Everyone signs in to Plex with their own plex.tv account.
