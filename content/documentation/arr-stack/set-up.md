---
title: Setting it up
summary: Three questions, one Install button, and the one thing left to you.
order: 20
---

The setup link opens `Set up your media server`. It asks three things.

## What do you want?

| Choice | What it adds |
|---|---|
| `Films` | Radarr finds them, qBittorrent fetches them |
| `Series` | Sonarr follows them and fetches each new episode |
| `Subtitles` | Bazarr adds them to what you have |
| `Requests from family` | Seerr lets people ask, and you approve |

Jellyfin, which plays it all on your phone, TV and computer, always comes with it. Each choice shows
how much it adds to the download.

## Where your films and series go

The folder you picked when you installed, shown for you to check. Under it the stack makes
`media/movies`, `media/tv` and `torrents`. To use another folder, run the install command again
before you press Install.

The page also checks the drive: how much space is free, and whether it can **link** files. A drive
formatted as exFAT, or a network drive, cannot — each finished download is then copied into your
library and takes its space twice. Everything still works.

## One login for everything

A name and a password. **The same login opens the stack's page and every service in it** — Jellyfin,
Sonarr, Radarr, Prowlarr, qBittorrent and Bazarr; Seerr signs in through Jellyfin. Write them down.

## Install

Press `Install`. A progress bar shows how far it has got, with real download sizes, and `Details`
lists every step. You can close the page — it carries on — and come back.

When it is done, `Your stack` shows a tile for each service with `Open`, and `Connections` shows
every link the stack made between them, each with a ✓.

## One thing left: choose the sites to search

Sonarr and Radarr find films and series through sites — indexers — that you add to **Prowlarr**.
Which sites to use is your decision, and depends on where you are and what you have the right to
download, so the stack does not choose any for you.

Press `Open Prowlarr`, then **Indexers → Add Indexer**. Prowlarr passes each one to Sonarr and Radarr
by itself.

Next: [Your phone and TV](/documentation/arr-stack/phone-and-tv).
