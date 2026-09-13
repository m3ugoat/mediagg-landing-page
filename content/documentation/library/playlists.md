---
title: Playlists
summary: Making one, importing one, adding things to it, and keeping one at the top.
platforms: android, ios
order: 40
---

The `Playlists` section holds playlists that live on this device. Tap `Import a playlist` in the bar
and you are offered three ways to get one:

| Choice | What it does |
|---|---|
| `New playlist` | `Empty, to add episodes to` |
| `Import a playlist` | `From an M3U file or address` |
| `Add a stream` | `One station, or anything else that plays live` |

## Importing

`Import a playlist` takes either a `Playlist address` or a file from the device — one dialog, both
routes. A `Name (optional)` field lets you call it something of your own; leave it blank and the
playlist's own name is used.

## Adding something to a playlist

From any episode or track, `Add to playlist` opens a sheet listing where it can go.

`On this device` lists your own playlists. **If you are signed in to a media server that keeps
playlists, that server gets a section too**, headed with the account's name, and you can tick
several at once across all of them. `New playlist…` at the top makes one without leaving the sheet.

Where a playlist can hold more than music, its entries are counted as `items` rather than tracks —
a Jellyfin or Emby playlist routinely holds films.

## Making one on a server

`New playlist` asks for a `Name` and, where you are signed in somewhere, where it should live:
`This device` or one of your servers. A server that keeps descriptions offers a `Description` field;
one that does not, does not.

## Pinning

Long-press a playlist and `Pin to the top` keeps it `Kept above the rest, whatever the sort`.

Pinned playlists sort as a group above the others and keep their own order within that group, so
reversing the sort reverses both halves rather than scattering them. A pinned row carries a pin
mark. `Unpin` puts it back.

The same menu offers `Edit playlist` — `Its name and its cover` — and `Delete playlist`.

> **Deleting a playlist deletes the list, not the media.** `The playlist and its entries go. The
> media they point at is untouched.`
