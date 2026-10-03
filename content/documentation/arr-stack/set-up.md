---
title: Setting it up
summary: Three questions, one Install button, and the one thing left to you.
order: 20
---

The setup link opens `Set up your media server`. It asks three things.

## What do you want?

Two kinds of choice. **Where you watch and listen** — at least one:

| Choice | What it is |
|---|---|
| `Jellyfin` | Plays your films and series on every screen. Free and open, nothing to sign up for |
| `Emby` | The same, with paid extras if you want them |
| `Plex` | The same, with a free plex.tv account you sign in to once |
| `Music` | Navidrome plays your music library |
| `Audiobooks and podcasts` | Audiobookshelf plays them and remembers where you were |

For films and series one of Jellyfin, Emby and Plex is plenty: each keeps its own library of the same
files, and Mediagg plays from every one.

**What finds and fetches more** — all optional; leave them out to serve only what you have:

| Choice | What it adds |
|---|---|
| `Films` | Radarr finds them, qBittorrent fetches them |
| `Series` | Sonarr follows them and fetches each new episode |
| `Albums` | Lidarr finds the music you follow, qBittorrent fetches it |
| `Subtitles` | Bazarr adds them to your films and series |
| `Requests from family` | Seerr lets people ask for films and series, and you approve |

Each choice shows how much it adds to the download. Requests need a video server and Films or Series;
subtitles need Films or Series — the page says so if one is missing.

## Your media

For each kind — `Films`, `Series`, `Music`, `Audiobooks`, `Podcasts` — the folder it is in, and
where `Downloads` go. Everything is inside the folder you chose when you installed.

- **A folder that is there** is used as it is: nothing is moved, and what is in your films and series
  folders is added to Radarr and Sonarr where it is.
- **A folder that is not there yet** is made.
- **Left empty**, the stack makes a new folder for it — never one already there: if `music` is taken,
  it makes `music-2`. The page says which, under the box.
- **`+ another`** adds more folders of the same kind, each a library of its own — music spread over
  several folders, say.

Someone with no library leaves every box empty and gets a new folder for each.

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

## Plex: one sign-in

Plex belongs to a plex.tv account, so after installing it the stack's page shows `Sign Plex in to your
plex.tv account`. Press `Sign in to Plex`: a short code appears. Open **plex.tv/link** on any computer
or phone, sign in, and enter the code. The stack claims Plex for your account, makes its Films and
Series libraries and connects Seerr — your plex.tv password is never typed into the stack.

Next: [Your phone and TV](/documentation/arr-stack/phone-and-tv).
