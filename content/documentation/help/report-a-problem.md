---
title: Reporting a problem
summary: What to include so a problem can be found and fixed rather than guessed at.
platforms: android, ios
order: 60
---

Most reports that go nowhere are missing the same few things. These are what make a problem
reproducible.

## Say exactly what you saw

**Quote the message.** Mediagg distinguishes between a server being unreachable, a sign-in having
lapsed, an account not being permitted, and a file that will not decode — and they look similar but
have nothing in common underneath. `The connection is not secure, so it was refused.` and
`That username or password was not accepted.` send an investigation in opposite directions.

If there was no message and something simply did not happen, say that — it is a different kind of
fault and worth knowing.

## Say what it was

- **What kind of thing** — a podcast episode, a track from the device, a live station, or something
  on a media server. These take four different paths through the app.
- **Which server**, if it was one: `Subsonic`, `Jellyfin`, `Audiobookshelf`, `Plex` or `Emby`, and
  what is actually running it. "Subsonic" covers Navidrome, Airsonic, Gonic and others, and they
  behave differently.
- **The address shape**, not the address: whether it was local like `192.168.…` or a public one, and
  whether it was `http` or `https`.

## Say what you did

The steps, in order, ending at the thing that went wrong. "It crashes sometimes" cannot be chased;
"it fails every time I open an album from Navidrome while on mobile data" can.

## Say whether it is consistent

Once, or every time? On Wi-Fi as well as mobile data? On one subscription or all of them? **A fault
that happens on one thing and not another is nearly solved already** — it is the difference that
matters.

## Include

- The Mediagg version
- Your phone and its Android or iOS version
- Any relevant settings you have changed from their defaults

> **Never include a password or a token.** The name of the server software and its version are
> useful; your credentials are not, and no fault needs them.
