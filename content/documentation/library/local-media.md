---
title: Local media
summary: The music and video on your device, and the chips that cut it different ways.
platforms: android, ios
order: 30
---

`Local media` is what is on the device itself, rather than anything fetched from a feed or a server.

**It is one section with chips rather than several sections**, because songs, videos, books and
folders are the same question — what is on this device — asked different ways.

## The chips

`Songs`, `Videos` and `Audiobooks` lead, because they are what the section holds. The ones after
them are ways of cutting the first — where the files are, then what their tags say:

| Chip | What it shows |
|---|---|
| `Songs` | Every track |
| `Videos` | Every video |
| `Audiobooks` | A cover per book, however many files it is — see [Audiobooks on your device](/documentation/library/audiobooks) |
| `Folders` | Every folder holding something, by name |
| `Filesystem` | The device's storage, walked one level at a time — Android only |
| `Albums` | A grid of sleeves; open one for its tracks |
| `Artists` | Grouped by the artist tag |
| `Genres` | Grouped by the genre tag |
| `Years` | Grouped by year |

`Albums`, `Artists`, `Genres` and `Years` are built from the tags inside your files. **`Folders`
and `Filesystem` ignore the tags entirely** and show where the files actually are, which is what to
reach for when a file's tags are wrong or missing.

Each chip has its own sort, from `As listed`, `Name`, `Date added`, `Length` and `Size` — only the
ones its rows can answer — and remembers it separately. `Audiobooks` also has a filter beside the
sort — `All`, `New`, `In progress` and `Finished`.

## Folders and Filesystem

`Folders` is the quick way to a folder you already know: a flat list of every one that holds
something, by name. Open one and you are in the same place the tree would have walked you to.

`Filesystem` is the tree itself. Each row is a directory, `..` takes you up a level, and a trail
under the chips says where you are. A folder you added yourself is a starting point of its own
here, beside the device's own storage.

**It is worked out from the files themselves, not from a list you maintain.** Every track and video
already knows where it came from, so the folder structure is read from that — nothing to set up, and
nothing to keep in step.

This also means it can only ever show you folders Mediagg was allowed to read. A folder that
produced no files is not there at all.

## Where the files come from

This is the one part that works differently on each device.

**On Android**, the phone keeps a media library of its own, and Mediagg reads it. Your music and
video are simply there. `Scan for media` in the toolbar looks again, and which kinds of audio and
which folders are included is yours to set — see [Scanning](/documentation/settings/scanning).

You can add a folder as well, with `Add a local folder` on the `Add subscription` screen — useful
for anything the phone's own library does not cover.

**On iOS**, there is no device-wide music library to read, so **local media is the folders you
choose**. `Add a folder` in the toolbar opens the Files app; pick a folder and everything in it
fills the chips above — the folder itself is listed under `Folders`, as there is no `Filesystem` chip
on iOS. Choosing it *is* the permission — there is no separate grant to give.

`Scan for media` re-walks the folders you picked, to catch anything added since.

## Permission

On Android, Mediagg has to be allowed to read the device's media before it can find any:
`Mediagg needs permission to list the music on this device.`, with an `Allow access` button. Video
is asked for separately — `Mediagg needs permission to list the video on this device.` — and where
only one of the two was allowed, the folder chips say which half they are missing, for instance
`Video is not shown here: Mediagg has not been allowed to read this device's video.`

## Playing a whole chip

`Play all` and `Shuffle all` are in the toolbar.

> **Where a chip lists groupings rather than files** — books, albums, artists, genres, years and folders —
> you open one first. Shuffling every track on the device from a screen of sleeves is not what the
> button would mean there.
