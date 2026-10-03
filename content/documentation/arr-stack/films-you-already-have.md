---
title: Films and series you already have
summary: Coming from an old Jellyfin, or a drive of films? Use them where they are — nothing is moved.
order: 35
---

If you already have films or series — in an old Jellyfin's folders, on a drive — the stack uses them
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

When the install command asks which drive or folder the stack may use, give the one your media is in —
`/mnt/nvme/files`, say. Then in the wizard, under `Your media`, give each kind's folder: `Films`
`/mnt/nvme/files/movies`, `Series` `/mnt/nvme/files/tv`, and so on — with `+ another` for a kind in
several folders, and your old downloads folder for `Downloads`. Leave a kind empty and the stack makes a
new folder for it.

## When the stack is already set up

At the bottom of the stack's page, open `Your media`, choose the kind, give the `Folder`, and press
`Add`. A folder that is not there yet is made.

## What happens to each folder

- **Jellyfin** adds it to its `Films` or `Series` library, beside the stack's own folder — and from
  there it is in Mediagg.
- **Radarr or Sonarr** looks up each film or series in it. A name with its year, `Inception (2010)`,
  or with an id, `Inception (2010) [tmdbid-27205]`, matches surely; anything less certain is left for
  you rather than guessed. The progress card says how many were recognised and names the rest —
  finish those in Radarr → Movies → Library Import, or Sonarr → Series → Library Import.
- **Films** come in as already had, so nothing is searched for. **Series** follow new episodes.
- **Bazarr**, if you have it, can add subtitles to them.

`Repair everything` looks at the folder again and adds anything new, without adding anything twice.

## Stopping

`Stop using` takes the folder's films or series out of Jellyfin and Radarr or Sonarr. **The files stay
where they are**, as they were before.

If a folder is on a drive that is unplugged, the stack's page says so, and the services that use it stop
until it is back — plug it in and press `Repair everything`, or stop using it.

## What does not come across

Your old Jellyfin's **watch history, played marks and users**. The files come across; this Jellyfin
starts fresh.

In Mediagg, forget the old server so it does not show twice: `Media servers` → `Manage servers` → its
menu → `Forget this server`. Then let your phone and TV in to the stack, as in
[Your phone and TV](/documentation/arr-stack/phone-and-tv).
