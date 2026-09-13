---
title: Synchronisation
summary: Keeping podcast subscriptions and positions in step with your other devices.
platforms: android, ios
order: 30
---

`Synchronisation provider`, in Settings, is **`Keep subscriptions and positions in step with your
other devices`**. Two services are supported.

| Service | What it is |
|---|---|
| `gpodder.net` | `The open podcast subscription service` |
| `Nextcloud` | `GPodder Sync on your own Nextcloud` |

## Connecting gpodder.net

`Connect a gpodder.net account` asks for a `Username` and `Password`. There is also
`Address, if you run your own` — **leave it blank for the hosted service** at gpodder.net.

> **`gpodder.net has no app passwords, so this stores the account's own password on this device.`**
> It appears in your device list there, where you can remove it.

## Connecting Nextcloud

`Connect a Nextcloud` asks for `Your Nextcloud's address`, a `Username` and an `App password`.

**The GPodder Sync app has to be installed on your Nextcloud first.** Make an app password under
Settings, Security — `it can be revoked there without changing your real password, and this app
cannot use it to sign in to the web interface`.

Nothing is stored until the credentials have been tried, and a failure leaves everything you typed
in place.

## When it runs

Four moments, without you asking:

- **Shortly after anything happens** — following a show, letting one go, finishing an episode.
  Changes are bundled, so marking six episodes played is one sync rather than six.
- **After every feed refresh.**
- **Every six hours** regardless.
- **Immediately** when you pull to refresh, or press `Sync now`.

`Sync now` sits at the bottom of the Synchronisation screen once something is connected:
`Bring subscriptions and positions up to date`. It answers `Up to date.` when there was nothing to do.

Only the six-hourly repeat waits for Wi-Fi; anything you asked for happens straight away.

## What is synced

**Which podcasts you follow, and how far into each episode you got.** That is all, and the limits
are deliberate:

- **Podcasts only.** Station playlists, media servers, scanned folders and playlists take no part —
  neither service has anywhere to put them.
- **Not favourites and not the queue.** Neither service carries either.
- **Your renames stay yours.** Sync sends the publisher's title, never the name you gave a show.

> **Sync can never un-hear an episode.** A stale position arriving from another device cannot reset
> something you finished or drag you back to the start. Where two devices disagree, the newer answer
> wins.

The first run pushes all your subscriptions, plus a completed play for your five hundred most
recently played episodes, each with its own date.

## Disconnecting

Tap a connected row. `It stops syncing and what is stored for your account is forgotten. Your
subscriptions and positions stay exactly as they are, here and there.`

> **A password changed elsewhere goes quiet rather than warning you.** If a device has stopped
> keeping up, open this screen and press `Sync now` — the failure is reported there.
