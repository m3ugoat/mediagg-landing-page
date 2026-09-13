---
title: A subscription will not refresh
summary: Moved feeds, sign-ins that have lapsed, and the setting that stops checks on mobile data.
platforms: android, ios
order: 20
---

## First, check the setting

`Refresh on mobile data` is off by default, and its own line says what that means:
**`Off means feeds are only checked on Wi-Fi`**. If nothing has refreshed while you have been out,
that is the likeliest reason and not a fault.

`Check for new episodes` set to `Never` stops the automatic check entirely. Both are under
`Refreshing` in Settings.

## `The feed could not be fetched.`

The address did not answer at all. Podcasts go down like any other website — if this is the only
subscription affected, wait and try again.

A feed that has permanently moved is followed automatically, so you do not have to re-add anything
because a publisher changed host.

## `That address is not a feed we can read.`

Something answered, but it was not a podcast feed. This happens when a show has been taken down and
its address now serves a holding page, or when the address was never a feed in the first place.

## `That podcast could not be opened. Its feed did not answer.`

Seen when adding rather than refreshing. The directory still lists the show, but the feed behind the
listing is gone — which is the usual way a podcast ends, since nobody removes their entry from a
directory afterwards.

## Nothing new is arriving, but nothing has failed

**A refresh that succeeds and finds nothing looks identical to no refresh at all.** Check the show's
own page: if its most recent episode matches what the publisher has put out, the subscription is
working and the show simply has not published.

> **Nothing is removed because a server was briefly unreachable.** A failed refresh leaves the
> episodes you already have exactly where they were.
