---
title: Backup
summary: Taking a copy of your library and your server list, and bringing one over.
platforms: android, ios
order: 40
---

`Database and servers`, under `Backup and sync` in Settings, is
**`Take a copy of your library, or bring one over from another device`**.

There are two files, deliberately, and they carry different things.

## The database

`Database export` — `Transfer subscriptions, play state and queue to Mediagg on another device` —
writes all three to a single file, named for the day it was made. It is the whole library in one piece — a straight copy, taken consistently, so it
restores as exactly what you had.

`Database import` reads one back: `Import Mediagg database from another device`.

> **Importing replaces everything.** `Importing a database will replace all of your current
> subscriptions and playing history. You should export your current database as a backup.` Mediagg
> asks before it does it, with `Replace` to go ahead.

Once the file has been read and checked, a second question, `Ready to restore`, asks before anything
is actually replaced. On Android it offers `Restore and restart`, and the app starts again on the
restored library. On an iPhone it offers `Restore`, and you then close Mediagg and open it again —
`Your library has been restored` says so.

A backup from a newer version of the app is refused rather than half-read:
`That backup was made by a newer version of Mediagg. Update the app and try again.` A file that is
not a Mediagg database is refused too: `That file is not a Mediagg database.`

## Doing it on a schedule

On Android, `Automatic database export` appears as a switch —
`Create a backup of the Mediagg database every 3 days. Only keep the 5 most recent backups.` An
iPhone does not let an app keep writing to a folder you picked days ago, so the switch is not shown
there.

**The folder is the switch.** Turning it on asks where backups should go; turning it off forgets the
folder. If an automatic backup fails, a line on this screen says why — it starts
`The last automatic backup did not happen:`.

## Your servers are separate

> **`Servers are not part of the database backup. Export them separately. Passwords and tokens are
> never written to the file, so a restored server asks you to sign in again.`**

- `Export servers` — `Write every remembered server to a file`
- `Import servers` — `Read servers from a file exported here or by the old app`

**Every kind of server is in it** — Subsonic, Jellyfin, Emby, Plex, Audiobookshelf, Kodi, WebDAV,
and SMB shares on Android — with its address and username.

That second one is literal: the file the old Mediagg wrote is still read, alongside the current
format. A server for a kind this build does not carry is skipped rather than rejecting the whole
file.

When it has finished: `One server is back. Sign in to it to start using it.`, or however many there
were — which is the consequence of the passwords never being written down.

## Moving to a new phone

1. On the old device, `Database export`, then `Export servers`.
2. Move both files across.
3. On the new device, `Database import`, then `Import servers`.
4. Sign in to each server again.

Podcast subscriptions and positions can also be kept in step continuously rather than moved in one
go — see [Synchronisation](/documentation/settings/synchronisation).

## Synchronisation

`Synchronisation`, beside `Database and servers`, is the other way a library reaches another device:
an account that keeps your subscriptions and positions in step as you go, rather than a copy taken
once. See [Synchronisation](/documentation/settings/synchronisation).
