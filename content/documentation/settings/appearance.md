---
title: Appearance
summary: Light, dark and black, and the three places the colours can come from.
platforms: android, ios
order: 10
---

Appearance is the first group in Settings, under `Common`, because it is the one setting that applies
to everything in the app whatever kind of library you have.

## Theme

`Theme` offers four:

- `Follow the system` — light or dark, as your phone is set
- `Light`
- `Dark`
- `Black` — a true black rather than a dark grey, which is what an OLED screen can actually turn off

## Colours

`Colours` decides where the accent comes from, and there are three answers:

| Choice | What it does |
|---|---|
| `One colour` | Never changes |
| `From the artwork` | Follows whatever is playing |
| `From the wallpaper` | Android 12 and later |

`From the artwork` re-tints the app to match the cover of whatever is playing, so the player takes on
the colour of the record. `From the wallpaper` takes the palette your phone already built from your
home screen.

> **A choice your device cannot honour is not offered.** Where there is no wallpaper palette to read,
> that option is absent rather than present and inert — a row with one option is not a choice, and a
> row whose options do nothing is worse.

## Accent

`Accent` appears while `Colours` is set to `One colour`, and offers eight: Purple, Blue, Teal, Green,
Amber, Orange, Red and Pink.

Each is a **seed for the whole scheme** rather than a single colour painted on buttons. Picking one
regenerates every shade the app uses from it, in whichever theme you are in, so the result stays
readable in light and dark alike.

Under `From the artwork` or `From the wallpaper` the accent row is hidden, because it would be a
choice nothing could act on.
