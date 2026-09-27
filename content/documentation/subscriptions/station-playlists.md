---
title: Station playlists
summary: What a subscribed playlist is, how it behaves in your library, and where they come from.
platforms: android, ios
order: 30
---

A **station playlist** is a list of live streams — radio or TV — that lives at an address somewhere
and is re-read rather than downloaded once. Subscribing to one puts every station in it into your
library as something you can play.

They behave differently from a podcast in one way that matters: **a station has no episodes**. There
is nothing to download and nothing to keep; there is whatever is being broadcast when you press play.

## Where they come from

`Add from providers`, on the `Add subscription` screen, is where you browse playlists kept somewhere
else. A provider is somewhere playlists are kept — you open it, look through its folders and
subscribe to the ones you want.

There are two, and both are yours to point at — neither has anything in it until you do:

- **[Your own catalogue](/documentation/subscriptions/your-own-catalogue)** — any public Github
  directory of m3u playlists
- **[m3ugoat](/documentation/subscriptions/m3ugoat)** — a playlist server you run yourself

## By address

If you already have the address of one playlist, `Add a playlist by address` —
`An m3u of stations, kept up to date` — takes it directly. It opens `Add a playlist of stations`,
which says what will happen: `It is kept as a subscription, and shows under Providers.` It asks for
a `Playlist address` and a `Name (optional)`, and `Subscribe` adds it.

A single station is `Add a stream by address` instead — see
[Adding by address](/documentation/subscriptions/add-by-address).

## In the library

Subscribed playlists are filed under `Subscriptions`, on the `Providers` chip — kept apart from
podcasts so a station list does not sit in a grid of show artwork with nothing to show.

The folder a playlist came out of becomes part of its name. A repository that holds `countries/uk`,
`categories/uk` and `languages/uk` would otherwise give you three library rows all called the same
thing.

> **The playlist is re-read, not copied.** When the list at the other end changes, your subscription
> follows it. Stations that were removed go, and new ones arrive, which is the point of subscribing
> to a list rather than importing it once.
