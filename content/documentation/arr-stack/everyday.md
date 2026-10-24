---
title: Using it day to day
summary: The dashboard, adding films and series, requests, downloads, updates, keeping the computer awake and the password.
order: 40
---

## Adding a film or a series

- **The easy way:** open Seerr, search, and press Request. Family members can do the same, and you
  approve under [Requests](#requests).
- **The direct way:** open Radarr (films) or Sonarr (series), search, and press Add.

Either way it then waits for you to choose its download — its releases in Mediagg, or Interactive
Search in Radarr or Sonarr — unless `Download automatically` is on (see [Downloads](#downloads)).
Once downloaded it is moved into your library, and appears in Jellyfin and Mediagg by itself.
It needs indexers in Prowlarr first — see
[Setting it up](/documentation/arr-stack/set-up).

## The dashboard

Open it at the address the install command printed — `http://localhost:7979` on the computer itself,
or its network address for one with no screen — and sign in with your server's name and password.

The sidebar has `Home` and `How to use`; under **Library**, `Films & Series`, `Music` and
`Audiobooks & Podcasts`; under **Server**, `Downloads`, `Requests`, `Indexers`, `Media folders`,
`People`, `Devices` and `Settings`; and `Pair a phone or TV`. The bar above every page says how the
services stand — `All 9 running`, say — and has the dashboard's address with `Copy`, `Help` and
`Sign out`.

- **`Home`** shows **Get started** until it is done — get Mediagg, pair it with this server, add
  indexers if anything fetches, then search and watch — each step ticked as you do it. No phone to
  hand? `Watch in the browser` and `Request in the browser` open your media server and Seerr now.
  At the top, under the heading, **`Stream in Mediagg Web App`** — the Mediagg app in a tab of its own,
  on this computer or any other on your network, signed in as you are here, with nothing to install.
  Below are the free space, paired devices, downloads and version; **Downloads**, how films and series
  are fetched (see [Downloads](#downloads)); and **Services by media**: each part with its switches. A switch
  that is on opens its service's own page in a new tab; one that is off has `Turn on · 150 MB`, say.
- **`How to use`** is the guide to this server: three ways in, easiest first — Mediagg, your browser,
  each service's own page — then `What happens when…` you ask for a film, follow a series, add files
  yourself or add someone; `Each service`, with what was set up for you and when you would open it;
  and `How they are connected`.

## Turning things on and off

Each part of your library has its own page, with its switches — for Films & Series `Watch`,
`New episodes`, `New films`, `Requests` and `Subtitles`; for Music `Listen`, `New albums` and
`Requests for music`. A switch that is on has `Open`, for the service behind it. Turning one on installs what it needs, and
asks first when that brings something else along. Turning one off asks too, says what goes with it,
and keeps its settings for when you turn it on again — its `•••` has
`Turn off and delete its settings`. The last place to watch or listen cannot be turned off.

Paired phones and TVs pick up what you turn on by themselves.

## Downloads

**On `Home`, how films and series are fetched:**

- **`Download automatically`** — off to start with: a request, or a new episode of a series you
  follow, waits for you to choose its download (its releases in Mediagg, or Interactive Search in
  Radarr or Sonarr), so nothing large arrives unasked. On, they download the first release that fits
  as soon as it is out.
- **`Films quality`** and **`Series quality`** — the quality profile Radarr and Sonarr fetch at:
  their own profiles, so one you add or change there is offered here.
- **`Largest film download`** and **`Largest series download`** — `No limit` to start with, or a size
  in GB. Radarr and Sonarr never take a larger release by themselves; you can still choose one in
  Interactive Search. For series a season pack counts whole.

Either way a finished download is not seeded: once it is in your library it is removed from
qBittorrent and the downloads folder, and only the library's copy is left.

**`Downloads`** in the sidebar lists what is coming in, newest first, with how far each has got and
the time left. Each one moves into your library by itself when it is done.

- **`Pause`** and **`Resume`**.
- **`Cancel and find another release`** — a bad or stuck release: what has downloaded is deleted, and
  Radarr, Sonarr or Lidarr never takes that release again but looks for a different one.
- **`Cancel request`** — you no longer want it: the download is deleted, it is no longer looked for,
  and its request is removed. For an album it is `Stop wanting this album`.
- **`Remove download`** — for one that Radarr, Sonarr and Lidarr are not waiting for; what has come
  so far is deleted.
- **`Stop seeding`**, for one still uploading to others — added in qBittorrent yourself, say. The copy
  in your library stays.

## Requests

With Requests on, `Requests` lists what has been asked for and where each one is — `Pending approval`,
`Searching`, `Downloading 40%`, `Available`. It shows yours; `Asked for by` switches to `Everyone`,
or to one person. The sidebar says how many are pending.

- **`Approve`** or **`Decline`** one that is waiting. Approved, it waits for you to choose its
  download — or, with `Download automatically` on, is looked for and downloaded by itself — then
  appears in Mediagg.
- **`Search again`** one still being looked for, or **`Cancel request`** — its download is deleted,
  it is no longer looked for, and the person who asked sees it as Cancelled in Mediagg.
- **`Remove request`** one that was declined or failed.

Whether someone's requests wait for you is set for each person under
[People](/documentation/arr-stack/people).

## Updates

When a new version is out, the dashboard says so — `Mediagg Server 0.12.0 is out` — with an
`Update to 0.12.0` button. Updating restarts the dashboard; the services keep running and nothing you
have changes. Whatever an older version did not set up is put right as the new one starts, with no
need to repair. If the new version runs newer, tested versions of the services, an `Updates for` card
follows, naming them, with `Update services`. Each restarts, and its settings stay.

It looks for a new version by itself every six hours; `Check for updates`, under `Settings`, looks
now. Running the install command again does the same as updating.

## Keep this computer awake

A sleeping computer serves nothing: your phone and TV cannot play, and downloads stop. The switch
under `Settings` — `Keep this Mac awake`, or `Keep this computer awake` on Linux — stops it going to
sleep by itself; the screen still turns off, so it costs little. Turn it off whenever you like.

It cannot stop everything: on battery it may still sleep to save power, and closing a laptop's lid
may sleep it anyway.

A computer that never sleeps, like most home servers, does not need it.

After a restart every service starts again by itself — on a Mac once you sign in, when Docker Desktop
starts; on Linux with the computer, before anyone signs in. On a Mac, **`Start with this Mac`**,
under `Settings`, turns that off: Docker Desktop is then no longer opened for it when you sign in.

## Change the password

`Change password`, under `Settings`, changes it for the dashboard and every service at once. Paired
phones and TVs pick it up by themselves.

Forgotten it? It is in `MediaggStack/manager/state.json` in your home folder, which only your
account can read. That file also holds every service's API key.

## Watching away from home

Not yet. The server is reachable on your home network only; remote access is planned.
