---
title: Local media
summary: The music and video on your device, and the seven ways of cutting it.
platforms: android, ios
order: 30
---

`Local media` is what is on the device itself, rather than anything fetched from a feed or a server.

**It is one section with chips rather than several sections**, because songs, videos and folders are
the same question — what is on this device — asked different ways.

## The chips

`Songs` and `Videos` lead, because they are what the section is. The five after them are ways of
cutting the first:

| Chip | What it shows |
|---|---|
| `Songs` | Every track |
| `Videos` | Every video |
| `Albums` | A grid of sleeves; open one for its tracks |
| `Artists` | Grouped by the artist tag |
| `Genres` | Grouped by the genre tag |
| `Years` | Grouped by year |
| `Folders` | Where the files actually are |

`Albums`, `Artists`, `Genres` and `Years` are built from the tags inside your files. **`Folders`
ignores the tags entirely** and shows the real shape of your storage, which is the one to reach for
when a file's tags are wrong or missing.

## Folders

`Folders` is a tree you walk one level at a time, each row a directory with a count of what is
beneath it.

**It is worked out from the files themselves, not from a list you maintain.** Every track and video
already knows where it came from, so the folder structure is read from that — nothing to set up, and
nothing to keep in step.

This also means it can only ever show you folders Mediagg was allowed to read. A folder that
produced no files is not in the tree at all.

## Where the files come from

This is the one part that works differently on each device.

**On Android**, the phone keeps a media library of its own, and Mediagg reads it. Your music and
video are simply there. `Scan for media` in the toolbar looks again, and which kinds of audio and
which folders are included is yours to set — see [Scanning](/documentation/settings/scanning).

You can add a folder as well, with `Add a local folder` on the `Add subscription` screen — useful
for anything the phone's own library does not cover.

**On iOS**, there is no device-wide music library to read, so **local media is the folders you
choose**. `Add a folder` in the toolbar opens the Files app; pick a folder and everything in it
fills the chips above. Choosing it *is* the permission — there is no separate grant to give.

`Scan for media` re-walks the folders you picked, to catch anything added since.

## Permission

On Android, Mediagg has to be allowed to read the device's media before it can find any:
`Mediagg needs permission to list the music on this device.`, with an `Allow access` button. Video
is asked for separately.

## Playing a whole chip

`Play all` and `Shuffle all` are in the toolbar.

> **Where a chip lists groupings rather than files** — albums, artists, genres, years and folders —
> you open one first. Shuffling every track on the device from a screen of sleeves is not what the
> button would mean there.
