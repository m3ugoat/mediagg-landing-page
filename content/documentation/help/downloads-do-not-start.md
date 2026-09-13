---
title: Downloads will not start
summary: Battery, mobile data, and a limit that has already been reached.
platforms: android, ios
order: 50
---

If automatic downloads are not happening, **three settings under `Downloads` will stop them**, and
each one is doing its job.

## The switch itself

`Download new episodes automatically` is the master switch. Everything below it is meaningless while
it is off, and Mediagg greys the rest of the group out to say so.

## It is waiting for a charger

`Download on battery` — `Off means it waits until you are charging`.

## It is waiting for Wi-Fi

`Download on mobile data` — `Off means it waits for Wi-Fi`.

These two are the usual answer. Nothing is wrong; the conditions have not been met yet, and the
downloads will happen when they are.

## The limit is already reached

`Keep at most` caps how many downloaded episodes are held. Once that number is reached, nothing new
is fetched until something is removed — and what gets removed depends on
`When the limit is reached, delete`. If that is set to `Nothing`, the ceiling is a hard stop.

Either raise `Keep at most`, set it to `As many as fit`, or delete some downloads by hand.

## Only queued episodes are being fetched

`Include the queue` — `Fetch what you have queued, not only what arrived unheard`. With it off, only
newly arrived unplayed episodes are downloaded, so something you queued from your back catalogue is
left alone.

## A single download failed

`Download failed. Try again` is about that one file, not your settings. The host refused or the
connection dropped part-way. Retrying usually works; if one episode fails repeatedly while others
succeed, the file is the problem.

## Nothing has arrived to download

Automatic downloads act on new episodes, so they depend on refreshing happening first. If
`Refresh on mobile data` is off and you have been away from Wi-Fi, nothing has been found yet, so
nothing has been fetched. See
[A subscription will not refresh](/documentation/help/a-feed-will-not-refresh).
