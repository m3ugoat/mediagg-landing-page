---
title: Mixes
summary: The Mix row, how it is offered, in what order, and what each tile plays.
platforms: android, ios
order: 40
---

A **mix** is something to play built from a server's own suggestions. The `Mix` row is the first
thing on the `Activity` chip of the `Media servers` screen, and it appears on Home too.

Tapping a tile builds the mix and starts it — the tile says `Starting…` while it does.

## How the row is offered

`How the row is offered`, under `Mix` in Settings, has two answers:

| Choice | What it does |
|---|---|
| `All servers combined` | `A tile for each kind of mix, played from whichever server can` |
| `One tile per server` | `A tile for each server, playing what the setting below says` |

The first is the default. It asks "what would you like?" — the second asks "from where?".

## The kinds of mix

Under `All servers combined`, there is a tile per kind: `Book mix`, `Track mix`, `Artist mix`,
`Album mix`, `Movie mix` and `Show mix`.

`The order of the row` lets you drag them into the order you want. There are no checkboxes, because
**`A kind is hidden anyway when no server can build it`** — a music server contributes no film mix,
so no film tile appears, and nothing needs switching off.

`Book mix` leads by default, and it is the only kind that **resumes** rather than starting fresh.

## What a server's mix plays

Under `One tile per server`, the tile *is* the choice of where, so a second question appears —
`What a server's mix plays`:

| Choice | What it does |
|---|---|
| `Tracks` | `Whatever the server suggests right now, played as it came` |
| `An artist` | `One artist, and what the server says goes with them` |
| `An album` | `One record, played through in its own order` |

This row is hidden under `All servers combined`, where the tile already says what it plays.

## Elsewhere

An artist's own page has an `Artist mix` button, whatever these settings say.

> **Which servers a mix may reach is the same choice as the merged library.** A mix draws only from
> the servers you have ticked under `Show servers` — see
> [One library, several servers](/documentation/media-servers/one-library-many-servers).
