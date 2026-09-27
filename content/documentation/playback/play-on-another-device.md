---
title: Playing on another device
summary: Sending what is playing to a speaker, a television or another player in the house.
platforms: android, ios
order: 60
---

## On Android

The cast control sits in the top bar. **It is always there**, rather than appearing and disappearing
as devices come and go — a control that vanishes is a control you cannot learn.

Tapping it opens `Play on`. While it is still looking you get `Looking for devices…`, and then a row
per device, each labelled with how it is reached:

- **`Chromecast`** — Chromecast, Google TV, and speakers that speak it
- **`DLNA`** — the UPnP renderers built into most televisions and network receivers

> **The same television often appears twice, once under each label.** That is not a mistake and the
> two are not equivalent — they are genuinely different routes to the same box, and one may work
> where the other does not. Try the other if the first disappoints.

Picking a device disconnects any other. When something is connected, a `Stop casting` row appears at
the bottom of the sheet.

## On iOS

iOS uses **AirPlay**, through Apple's own picker — so what you see is the system sheet rather than a
list Mediagg drew. The AirPlay button is on the full player, first in the row with the speed and
the sleep timer.

**The AirPlay button hides itself when no receiver is in range.** That is Apple's behaviour rather
than the app's, so a blank space where you expected a button means nothing was found, not that
something is broken.

There is one thing worth knowing. When a receiver plays a video itself, the now-playing card on your
lock screen is the receiver's, without artwork or title from Mediagg. Audio is decoded on the phone
and routed onward instead, so the app's own card and artwork stay.

## Files on your phone

A receiver cannot reach inside your phone's storage. So when you cast from Android something that
only exists on the device — a download, or a track from a folder you added — **Mediagg serves it over your own
network** for the receiver to fetch. This happens on its own; there is nothing to configure and
nothing to switch on.

Anything with a public address — a podcast episode, a radio station, a media-server track — is
handed over as an address and fetched by the receiver directly.

## With the screen off

While something is cast, the phone is still working — serving files, steering the receiver, sending
it the next track — and Android may put an app to sleep a while after the screen goes off. Settings
says which way that is, under `In the background`:

- `Battery optimisation` — `On — Android may stop playing or casting a while after the screen goes off`
- or `Off — playing and casting carry on with the screen off`

Pressing the row goes to Android's own setting, which is the only place it can be changed. If a cast
stops some minutes after you put the phone down, this is the thing to turn off.
