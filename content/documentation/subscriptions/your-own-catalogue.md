---
title: Your own catalogue
summary: Pointing Mediagg at any public Github directory of m3u playlists.
platforms: android, ios
order: 40
---

`Custom Github Directory` is a provider with nothing in it until you supply the source —
**"Any public Github directory of m3u playlists"**. If you keep your playlists in a repository, or
know of one worth browsing, this is how Mediagg reads it.

## Adding a directory

Open `Add from providers` on the `Add subscription` screen, choose `Custom Github Directory`, then
`Add a github directory`. It asks for `The directory's address`, and takes either form:

- `github.com/owner/repo` — the whole repository
- a link to a folder inside one, if only part of it is playlists

You can add more than one. The provider lists everything you have added at its top level, and any of
them can be let go of later.

## What you will see inside

**The repository's own shape is left alone.** Mediagg invents no categories and reorganises nothing:
directories are directories and m3u files are playlists, at every level, because there is no honest
way to guess the structure of somewhere it has never seen.

Open folders until you reach a playlist, then subscribe to it.

> **Github allows 60 requests an hour.** Each folder you open costs one; going back costs none. The
> allowance is per hour and frees up on its own, so a large repository is best browsed a little at a
> time.

## Naming

A subscription taken from here is named after the playlist and the folder above it, so that several
playlists with the same file name stay tellable apart in your library. You can rename it afterwards,
and clearing your rename falls back to the catalogue's own name rather than to nothing.
