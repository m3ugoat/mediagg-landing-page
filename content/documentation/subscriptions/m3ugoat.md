---
title: m3ugoat
summary: Signing in to your own m3ugoat server, and why Mediagg reads its API rather than an export link.
platforms: android, ios
order: 50
---

**m3ugoat is self-hosted** — you run it yourself, on your own computer or home server. It keeps your
IPTV playlists in one place: you add channels to it, put them in the order you want, hide the ones
you never watch, and group them into playlists.

Mediagg then signs in and reads those playlists directly, so what you subscribe to on your phone is
what you arranged on the server.

> **It is not a service anyone runs for you and there is nothing to sign up to.** If you are not
> already running one, there is nothing to add here yet — start with the server. There is more about
> what it is and what it takes to run on the [m3ugoat page](/m3ugoat).

## Adding your server

1. Open `Add from providers` on the `Add subscription` screen and choose `m3ugoat`.
2. Tap `Add an m3ugoat server`. It asks for `The server's address` — usually a local one, like `192.168.1.10:8080`.
3. Sign in if the server asks. **A server with no accounts on it needs no password**, and Mediagg checks which case it is before offering the fields. A username is only needed once the server has more than one account.
4. Open the server to see its playlists, and subscribe to the ones you want.

You can add more than one server. The provider lists every server you have added, and opening one
shows that account's playlists.

## Why not just paste the export link?

You can — m3ugoat gives every playlist a plain export link, and any player will take it.

Mediagg reads the API instead, because **a plain m3u file has nowhere to record two of the decisions
you made on the server**: which channels are hidden, and what order they go in. Reading the API keeps
both. Hidden channels are dropped and your ordering is honoured.

There is a second reason. An export link can be rotated when it has been shared too widely, and a
subscription pinned to that link would quietly fork into a second copy the day you regenerated it.
Signing in avoids that.

## Signing out

Signing in adds that phone to the server's own device list, where you can sign it out again later —
useful if you lose the device or simply stop using it.
