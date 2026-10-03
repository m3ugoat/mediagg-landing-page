---
title: People
summary: A login of their own for everyone in the house, with the libraries you choose — and their phones and TVs let in as them.
order: 32
---

Everyone in your household can have their own login in **Jellyfin, Emby, Navidrome and
Audiobookshelf** — their own favourites, progress and history — and see only the libraries you choose.
Nobody types a password on a phone or a TV.

## Adding someone

On the stack's page, under `People`, open `Add someone`:

- **`Name`** — the stack makes their login from it (`Sam O'Neill` → `samoneill`) and a password for
  them.
- **`Can change the servers' settings (an administrator)`** — leave it off for most people.
- **`Their own user in`** — tick each server they should have. Under each, `All libraries, and any made
  later`, or untick it and choose: `Films` but not `Series` for a child, one music library and not
  another.
- **`Also on their phones and TVs`** — Sonarr, Radarr, Lidarr, Prowlarr, qBittorrent, Seerr, Bazarr
  and Plex. These have no users of their own: a device given one has the stack's own key to it, and
  can change anything there. Leave them out for children and guests; give them `Seerr` and they can
  still ask for films and series.

Press `Add`. The stack makes their users, with the libraries you chose.

## Letting their phone or TV in

Under `Watch it on your phone and TV`, choose them in `Who is this phone or TV for?` — a new code
appears for them — and use it as usual. Their device is given only what is theirs, signed in as them:
their Jellyfin or Emby, their Navidrome and Audiobookshelf, and the services you ticked.

## Changing, and removing

Each person has, under their name:

- **`Their password`** — shown, for their own use of each server's page. `Give … a new password`
  changes it in every server at once; their phones and TVs keep their own sign-ins.
- **`Change`** — their name, administrator or not, their servers and libraries. A server taken away
  deletes their user there and ends their devices' sign-ins to it.
- **Their phones and TVs**, each with `Forget`.
- **`Remove`** — their users are deleted, with their favourites, progress and history, and their
  phones and TVs are signed out. Your films and series stay.

**You** are always first in the list: the stack's own login, with everything.

> **Plex** has no users of its own on the server — its people are plex.tv accounts — so it is not in
> `Their own user in`. Everyone signs in to Plex with their own plex.tv account.
