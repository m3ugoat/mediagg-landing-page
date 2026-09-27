---
title: Reporting a problem
summary: Report an issue from Settings, hand over a crash log, and what to include so a problem can be found.
platforms: android, ios
order: 60
---

Most reports that go nowhere are missing the same few things. These are what make a problem
reproducible — and the app fills in some of them for you.

## Report an issue

In Settings, under `Diagnostics`, `Report an issue` is
**`On GitHub, with this device's details filled in`**. It opens a new issue on GitHub in your
browser, already laid out with three headings to answer — `What happened`,
`What you expected to happen` and `Steps to reproduce` — and, below a line, which build of Mediagg
this is and what it is running on. If the app has crashed, the most recent crash is named there too,
with when it happened.

**Nothing is sent until you send it.** The issue is a page in your browser; you read it, write the
rest, and submit it yourself — GitHub asks you to be signed in. Edit or delete anything in it first
if you would rather not share it.

## Crash logs

Mediagg has no crash reporter. When it crashes, the report is written to a file **on the device and
nowhere else**, and `Crash logs`, beside `Report an issue`, is where you find it. The row says how
many there are — `None recorded`, or `2 recorded on this device`.

Each crash is listed by when it happened, with what went wrong and the top of the trace — enough to
tell which one you just hit. `Copy this one` copies
`The whole report, including which build it came from`, ready to paste into the issue. There is also
`Copy all of them`, and `Forget them` — `Deletes every report below`.

With nothing recorded, the screen says `Nothing has crashed on this device since Mediagg was
installed. If something does, it will be kept here — on the device, and nowhere else.`

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

- The Mediagg version and your Android or iOS version — already there if you started from
  `Report an issue`; otherwise the version is under `About Mediagg` in Settings
- Your phone's make and model
- The crash log, if it crashed — pasted from `Copy this one`
- Any relevant settings you have changed from their defaults

> **Never include a password or a token.** The name of the server software and its version are
> useful; your credentials are not, and no fault needs them.
