---
title: Setting it up
summary: Three questions, one button, and the one thing left to you.
order: 20
---

The setup link opens the first of the questions, one to a screen. The dots at the top count them —
`01 WHERE`, `02 WHAT`, `03 ACCOUNT` — and the first is already answered: it is the folder you chose
when you installed.

## What do you want to watch and hear?

A card for each part of your library. Pick one or more:

| Card | What it is |
|---|---|
| `Films & Series` | `Watch on every screen. New episodes and films arrive by themselves.` |
| `Music` | `Your music library, streamed to every device.` Navidrome plays it |
| `Audiobooks & Podcasts` | `Listen anywhere, and pick up where you left off.` Audiobookshelf plays them |

Each card shows about how much it downloads.

**`Customise Films & Series`** opens what Films & Series comes with. It plays them with Jellyfin unless
you choose `Watch with Emby` or `Watch with Plex`, and it has four switches:

| Switch | What it does |
|---|---|
| `New episodes` | Sonarr follows a series and fetches each new episode |
| `New films` | Radarr finds a film you add, and fetches it when it is out |
| `Requests` | Seerr lets family ask for films and series, and you approve |
| `Subtitles` | Bazarr adds them to your films and series |

`New episodes`, `New films` and `Requests` are on to start with; `Subtitles` is off. Requests and
Subtitles need New episodes or New films — leave both off and the next screen says
`Also on, because what you chose needs them:` and turns them on.

For films and series one of Jellyfin, Emby and Plex is plenty: each keeps its own library of the same
files, and Mediagg plays from every one. Anything here can be turned on or off later, from the
dashboard — New albums for music among them.

Press `Continue`.

## One account for everything

A `Name` and a `Password · 10 characters or more` — `Show the password` shows it as you type. **The
same name and password open the dashboard and every service in it** — Jellyfin, Emby, Navidrome,
Audiobookshelf, Sonarr, Radarr, Lidarr, Prowlarr and Bazarr; Seerr signs in through Jellyfin, Emby or
Plex. qBittorrent has a password of its own, shown under Settings, because every device is
given it. Write them down.

Under the boxes, the page says how much your choices download and take on disk, and checks the drive:
how much space is free, and whether it can **link** files. A drive formatted as exFAT, or a network
drive, cannot — each finished download is then copied into your library and takes its space twice.
Everything still works.

Press `Set up my server`.

## Where it all goes

Inside the folder you chose, the server makes a folder for each kind — `movies`, `tv`, `music`,
`audiobooks`, `podcasts` — and `downloads`. A name already taken is never reused: if `music` is there,
it makes `music-2`. New films, episodes and albums go into these.

Films, series or music you already have are added once it is set up, under `Media folders` — see
[Films and series you already have](/documentation/arr-stack/films-you-already-have).

## Setting up

`Setting up your server.` shows each download on a line of its own, then
`Setting each one up, with your account` and
`Connecting them to each other, and testing each connection`, with how long it has taken. `Details`
lists every step. You can close the window — it carries on, and opens where it left off.

When it is done the page says `Your server is ready.`, with **Get started** — the steps left to watch
it on your devices — `Open dashboard`, and `Pair a device`.

If a step fails, it says `That did not work.` and where. `Try again` picks up where it failed;
nothing that worked is undone.

## One thing left: add indexers

New episodes, New films and New albums are found through indexers — the sites **Prowlarr** searches.
Which ones to use is your decision, and depends on where you are and what you have the right to
download, so none are added for you. Until there is one, the dashboard's `Indexers` says
`No indexers`.

Open `Indexers` and press `Add indexers`: Prowlarr opens on its Indexers page — press **Add Indexer**.
Prowlarr passes each one to Sonarr, Radarr and Lidarr by itself. Some indexers check for a browser
first; FlareSolverr gets Prowlarr past them, and is already connected.

## Plex: one claim

Plex belongs to a plex.tv account, so after installing it the dashboard shows
`Claim Plex with your plex.tv account`. Press `Claim Plex`: a short code appears. Press
`Open plex.tv/link` — or open **plex.tv/link** on any computer or phone — sign in, and enter the code.
The server claims Plex for your account, makes its Films and Series libraries and connects Seerr —
your plex.tv password is never typed into the server.

Next: [Your devices](/documentation/arr-stack/phone-and-tv).
