---
title: Adding by address
summary: Pasting an address you already have, and how Mediagg works out what is at the other end.
platforms: android, ios
order: 20
---

If you already have an address, three rows on the `Add subscription` screen take one directly:

| Row | What it is for |
|---|---|
| `Add a podcast by address` | `An RSS address you already have` |
| `Add a playlist by address` | `An m3u of stations, kept up to date` |
| `Add a stream by address` | `One station, or anything else that plays live` |

Each fills its field from your clipboard if there is an address on it, so in most cases there is
nothing to type. Pasting a podcast's address into `Search every directory` works too — an address is
not a search term, so it is opened as a feed rather than looked up.

## A podcast

`Add a podcast by address` opens `Add a feed`, with one `Feed address` field. Press `Add` and
Mediagg fetches the feed, subscribes, and opens the show.

## It asks the server, not the spelling

Addresses do not reliably say what they point at. A podcast feed does not have to end in `.xml`, a
playlist does not have to end in `.m3u`, and a live stream often ends in nothing at all.

So **`Add a stream by address` fetches the address and looks at what comes back** rather than
guessing from how it is written. If what is there is not a single stream, it says so and offers the
flow it belongs in, with the address already filled in:

- `That address lists several things. Import it as a playlist instead?`
- `That address is a podcast. Add it as a subscription instead?`

A stream that is added starts playing straight away, because bringing one in is asking to hear it.

It also means a working address is never turned away for having the wrong shape, and a broken one
fails with the server's own answer rather than a guess.

## What a redirect does

Feeds move. If the address you have redirects somewhere else, Mediagg follows it every time it
checks, so the subscription keeps working after the publisher has moved on — and it stays filed
under the address you gave it, rather than turning into a second copy of the same show.

> **A refusal is reported as the server's answer.** An address that needs a sign-in fails with what
> the server said — `The server answered 401.` — rather than being called unreadable. An address
> where something answered but was not a feed says `That address is not a feed we can read.`
