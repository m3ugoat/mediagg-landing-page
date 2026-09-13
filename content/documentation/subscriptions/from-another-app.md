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

## What happens next

Whatever arrives, it goes through the same check as anything typed in by hand — see
[Adding by address](/documentation/subscriptions/add-by-address). Mediagg works out whether it is a
podcast, a playlist or a single stream, and takes you to the right place to add it.
