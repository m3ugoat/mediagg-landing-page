---
title: Automatic downloads
summary: Fetching new episodes without being asked, and the conditions that hold it back.
platforms: android, ios
order: 20
---

`Download new episodes automatically`, under `Downloads` in Settings, lets Mediagg fetch what
arrives so it is waiting for you. **The rest of the group is hidden while it is off**, because a
screen of controls that do nothing is how a setting comes to look broken.

## It is not all-or-nothing

The switch's own line says so: **`Only feeds that have it switched on, and only what their filters
allow`**.

This is a permission, not a command. Turning it on here lets automatic downloading happen; **which
subscriptions take part is set on each subscription**. A library of forty shows does not start
downloading all forty.

## The conditions

| Setting | What off means |
|---|---|
| `Include the queue` | `Fetch what you have queued, not only what arrived unheard` |
| `Download on battery` | `Off means it waits until you are charging` |
| `Download on mobile data` | `Off means it waits for Wi-Fi` |

The last two are why downloads often appear to do nothing during the day and then all arrive at
once. Nothing is wrong — the conditions have not been met yet.

`Include the queue` is worth turning on if you queue things from your back catalogue rather than
only listening to what has just arrived.

## How many to keep

`Keep at most` is the ceiling: `5 episodes`, `10`, `20`, `50`, `100`, or `As many as fit`.

**Once the ceiling is reached, nothing new is fetched until something goes.** What goes is the next
setting — see [Making room](/documentation/downloads/making-room). With that set to `Nothing`, the
ceiling is a hard stop.

## Nothing is downloading

Work down the list: the master switch, then the subscription's own setting, then battery, then
mobile data, then whether `Keep at most` is already reached. See
[Downloads will not start](/documentation/help/downloads-do-not-start).

> **Refreshing has to happen first.** Automatic downloads act on episodes that have arrived, so if
> nothing has been checked for, there is nothing to fetch.
