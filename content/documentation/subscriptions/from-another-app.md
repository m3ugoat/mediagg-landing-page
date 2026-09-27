---
title: Opening an address from another app
summary: Sharing a link to Mediagg, and opening a playlist file with it.
platforms: android
order: 70
---

You do not have to copy an address and come back. **Mediagg offers itself wherever an address is
being handed around**, so a feed found in a browser or sent by a friend can go straight in.

## Sharing a link

Share any link to Mediagg from a browser, a messaging app or anywhere with a share sheet. Mediagg
takes the first address out of what was shared, so a message with some text around the link still
works.

## Opening a link

Tapping an `http` or `https` link offers Mediagg alongside your browser.

**No filtering is done by how the address is spelled.** Mediagg accepts anything of that shape and
then asks the server what is actually there — which is the only workable rule, because most radio
stations carry no file extension at all and `.m3u8` is the commonest way to write a single live
stream. Turning addresses away by their suffix would turn away most of what the app exists to play.

## Opening a playlist file

An `.m3u` or `.pls` file opened from a file manager or from your downloads offers Mediagg too. These
are matched by their type rather than their extension, because that is what a file manager actually
passes along.

## Where it goes

Before anything opens, Mediagg asks `Add this link`, with the address underneath, because the same
address can honestly be either of two things and only you know which you meant:

| Choice | What the app says about it |
|---|---|
| `Subscriptions` | `Keep it up to date — a podcast, a list of stations, a stream` |
| `Playlists` | `Take what is in it now, as a playlist of your own` |

`Playlists` opens the Playlists section with its import dialog already holding the address.

`Subscriptions` puts up `Looking at that address` while Mediagg asks what is there, then takes you to
the right place: a podcast opens and is subscribed to, a list of stations opens the dialog that
subscribes to it, and a single stream opens `Add a stream`. It is the same check as a stream typed in
by hand — see [Adding by address](/documentation/subscriptions/add-by-address).

Dismissing the question drops the link, and nothing is added.
