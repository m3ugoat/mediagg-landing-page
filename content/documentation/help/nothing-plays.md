---
title: Something will not play
summary: What Mediagg tells you when a track, an episode or a station refuses to start.
platforms: android, ios
order: 10
---

When something fails to start, **Mediagg says which of several different things went wrong** rather
than showing one generic failure. The wording is the fastest way to know what to do, so it is worth
reading before trying again.

## `Could not be reached`

Nothing answered. If a server is named — `Jellyfin did not answer. It may be off, or not on this
network.` — the usual causes are that the machine is asleep, or you are away from home and the
address is a local one.

Otherwise: `Nothing answered. Check your connection and try again.`

## `This is no longer there`

`The file this points at has gone from where the feed says it is.` The show has moved or replaced
the file. **Refreshing that subscription often finds it at its new address** — see
[Checking for new episodes](/documentation/subscriptions/refreshing).

## `The host would not send this`

The server holding the episode refused. `That is usually temporary, or the episode has been
withdrawn.` Try later, or another episode of the same show — if the rest play, the episode is the
problem rather than the subscription.

## `<server> would not let this play`

`Jellyfin would not let this play`, and so on for whichever server it was. Your sign-in has lapsed. `The password may have changed, or the session may have been ended on the
server.` Sign in again under `Media servers` and it will play. See
[A server will not sign in](/documentation/help/a-server-will-not-sign-in).

## `This will not play on this device`

`The file arrived but nothing here can play it.` The download worked; the decoding did not. Either
it is not audio at all, or it is in a format this phone has no decoder for. Nothing in Mediagg's
settings changes this — a different file or a different device will.

## `Could not be played`

The catch-all. `Something went wrong starting this. Trying again often works.` — and it usually
does.

## A station that plays and then stops

Live streams end when the station's own connection does, not when you do. Starting it again is the
only fix, and it is not a fault in the app.
