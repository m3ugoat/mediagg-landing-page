---
title: Automatic downloads
summary: Fetching new episodes without being asked, and the conditions that hold it back.
platforms: android, ios
order: 20
---

`Download new episodes automatically`, under `Downloads` in Settings, in the group headed
`Automatically`, lets Mediagg fetch what arrives so it is waiting for you. **The rest of the group is hidden while it is off**, because a
screen of controls that do nothing is how a setting comes to look broken.

## It is not all-or-nothing

The switch's own line says so: **`Only feeds that have it switched on, and only what their filters
allow`**.

This is a permission, not a command: nothing is fetched until it is on. **Every podcast you subscribe
to takes part**, and none has a filter set, so once it is on, new episodes of all of them are
fetched — up to the limit below. Station playlists, streams and anything else with no file to fetch
never take part.

## The conditions

| Setting | What its line says |
|---|---|
| `Include the queue` | `Fetch what you have queued, not only what arrived unheard` |
| `Download on battery` | `Off means it waits until you are charging` |
| `Download on mobile data` | `Off means it waits for Wi-Fi` |

The last two are why downloads often appear to do nothing during the day and then all arrive at
once. Nothing is wrong — the conditions have not been met yet.

`Include the queue` is worth turning on if you queue things from your back catalogue rather than
only listening to what has just arrived.

## How many to keep

`Keep at most` is the ceiling: `As many as fit`, `5 episodes`, `10 episodes`, `20 episodes`,
`50 episodes` or `100 episodes`.

**Once the ceiling is reached, nothing new is fetched until something goes.** What counts towards it
is what Mediagg downloaded — the files in a folder you added count only if cleanup is allowed to
delete them. What goes is the next
setting — see [Making room](/documentation/downloads/making-room). With that set to `Nothing`, the
ceiling is a hard stop.

## Nothing is downloading

Work down the list: the master switch, then battery, then mobile data, then whether `Keep at most`
is already reached. See
[Downloads will not start](/documentation/help/downloads-do-not-start).

> **Refreshing has to happen first.** Automatic downloads act on episodes that have arrived, so if
> nothing has been checked for, there is nothing to fetch.
