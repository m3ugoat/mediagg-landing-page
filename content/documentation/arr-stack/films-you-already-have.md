---
title: Films and series you already have
summary: Coming from an old Jellyfin, or a drive of films? Use them where they are — nothing is moved.
order: 35
---

If you already have films or series — in an old Jellyfin's folders, on a drive — the server uses them
**where they are**. Nothing is moved, copied, renamed or deleted. It points Jellyfin at the folder, and
Radarr and Sonarr too, so nothing you have is downloaded again.

## Find the folder

In your old Jellyfin, open **Dashboard → Libraries**: each library shows the folder it reads. Your films
and series are there. Jellyfin's own settings folder holds only its database, not the films.

Give the folder that holds **a folder for each film or series**, named the way Jellyfin names them:

```
Films/
  Inception (2010)/Inception (2010).mkv
  The Matrix (1999)/The Matrix (1999).mkv
Series/
  Breaking Bad/Season 01/Breaking Bad - S01E01 - Pilot.mkv
```

To copy a folder's path: on a Mac, select it in Finder and press ⌥⌘C; on Linux, `cd` into it in a
terminal and run `pwd`.

## While setting up

When the install command asks which drive or folder the server may use, give the one your media is in —
`/mnt/nvme/files`, say. Setting up does not ask about the folders inside it: the server makes its own
beside them — `movies`, `tv`, `music` and the rest, or `movies-2` where `movies` is taken — and new
films, episodes and albums go into those. Your own folders are added once it is set up.

## Adding a folder

On the dashboard, open `Media folders`. Under `Add a folder`, choose what it holds — `Films`,
`Series`, `Music`, `Audiobooks` or `Podcasts` — give the `Folder`, which suggests the folders there as
you type, and press `Add`. Add as many as you like, of each kind.

`Media folders` lists every kind with its folders: the server's own first — `Radarr saves here`, say,
or `new ones go here` — then the ones you added.

## What happens to each folder

- **Jellyfin** — or Emby, or Plex — adds it to its `Films` or `Series` library, beside the server's own
  folder, and from there it is in Mediagg. **Navidrome** plays a music folder, and **Audiobookshelf**
  an audiobooks or podcasts one.
- **Radarr or Sonarr** looks up each film or series in it. A name with its year, `Inception (2010)`,
  or with an id, `Inception (2010) [tmdbid-27205]`, matches surely; anything less certain is left for
  you rather than guessed. The progress card says how many were recognised and names the rest —
  finish those in Radarr → Movies → Library Import, or Sonarr → Series → Library Import.
- **A folder you add is played as it is.** Radarr and Sonarr know what is in it, so nothing there is
  downloaded again, but they never look for anything missing there or download into it — new films
  and episodes go into the server's own folder. A music folder is played by Navidrome and not given
  to Lidarr at all.
- **Bazarr**, if you have it, can add subtitles to them.

`Repair everything`, under `Settings`, looks at the folder again and adds anything new, without adding
anything twice.

## Stopping

`Stop using`, beside the folder, takes its films or series out of the library. **The files stay where
they are**, as they were before.

If a folder is on a drive that is unplugged, the dashboard says
`A folder of your films or series is not there`, and the services that use it stop until it is
back — plug it in and press `Repair everything`, or stop using it.

## What does not come across

Your old Jellyfin's **watch history, played marks and users**. The files come across; this Jellyfin
starts fresh.

In Mediagg, forget the old server so it does not show twice: `Media servers` → `Manage servers` → its
menu → `Forget this server`. Then pair your devices with the server, as in
[Your devices](/documentation/arr-stack/phone-and-tv).
