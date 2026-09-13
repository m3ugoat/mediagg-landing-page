---
title: Adding by address
summary: Pasting an address you already have, and how Mediagg works out what is at the other end.
platforms: android, ios
order: 20
---

If you already have the address of a podcast feed, `Add a podcast by address` on the
`Add subscription` screen takes it directly. Mediagg fills the field from your clipboard if there is
an address on it, so in most cases there is nothing to type.

## It asks the server, not the spelling

Addresses do not reliably say what they point at. A podcast feed does not have to end in `.xml`, a
playlist does not have to end in `.m3u`, and a live stream often ends in nothing at all.

So **Mediagg fetches the address and looks at what comes back** rather than guessing from how it is
written. While it is doing that, the screen says `Looking at that address`. That check is what lets
one field accept several different kinds of thing without asking you to classify it first.

It also means a working address is never turned away for having the wrong shape, and a broken one
fails with the server's own answer rather than a guess.

## What a redirect does

Feeds move. If the address you have redirects somewhere else, Mediagg follows it and subscribes to
where it actually ended up, so the subscription keeps working after the publisher has moved on.

> **An address that needs a sign-in will say so.** A server answering "not authorised" is a real
> answer, not a failure to parse — you will be told the address is fine but the credentials are
> missing, rather than told the address could not be read.
