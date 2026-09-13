---
title: Checking for new episodes
summary: How often subscriptions are checked, what happens on mobile data, and refreshing by hand.
platforms: android, ios
order: 80
---

A subscription is only a subscription because Mediagg goes back and asks whether anything new has
appeared. How often it does that is under `Refreshing` in Settings.

## How often

`Check for new episodes` offers `Never`, `Every hour`, and then longer intervals up to a day.
**The default is every 12 hours**, which suits most podcasts: a show that publishes weekly gains
nothing from being asked hourly.

`Never` stops the automatic check entirely. Your subscriptions still refresh when you ask them to.

## On mobile data

`Refresh on mobile data` is the second row, and its own subtitle says what off means:
**`Off means feeds are only checked on Wi-Fi`**.

Refreshing is cheap — it fetches the feed, not the episodes — but with a large library it is not
nothing, and downloading has its own separate setting. See
[Automatic downloads](/documentation/downloads/automatic-downloads).

## By hand

Pull down on a list to refresh it. A single subscription can be refreshed from its own page.

## What a refresh actually does

It fetches each feed and compares what is there with what you already have. Episodes that are new to
you arrive marked as new, which is what the `New` chip under Subscriptions lists and what the
**What is new** shelf on Home shows.

> **A refresh does not download anything by itself.** Finding an episode and fetching its audio are
> two different things, and the second one is off unless you turn it on.

## When a refresh fails

A feed that has moved is followed automatically. A feed that answers with an error keeps the
episodes you already have — nothing is removed because a server was briefly unreachable. See
[A subscription will not refresh](/documentation/help/a-feed-will-not-refresh).
