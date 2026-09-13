---
title: Chapters, notes and transcripts
summary: What an episode carries besides its audio, and how to read it while it plays.
platforms: android, ios
order: 40
---

Open the player and, under the artwork, there is a row of chips: `Chapters`, `Transcript` and
`Notes`. **A chip only appears when there is something behind it**, so the row tells you what this
particular episode carries. Tapping the lit chip again returns you to the cover.

## Chapters

Chapters are listed with their start times. Tap one to jump to it. The current chapter is
highlighted, and the list scrolls it back into view as the episode moves on — unless you are
scrolling it yourself, in which case it leaves you alone.

The current chapter's title also appears under the track name in the player, and tapping that opens
the list.

> **Chapters are gathered from up to three places at once** — the feed's own chapter tags, a chapter
> document the feed links to, and tags inside the media file itself. They are merged rather than
> ranked, so a fuller account from one source fills the gaps in another.

## Transcripts

Three formats are read: **WebVTT**, **SubRip** and **Podcast Index JSON**. Where an episode offers
more than one, Mediagg prefers the JSON, because it is the only one that names who is speaking.

A transcript with timings **follows the audio**. The current line is the only one at full strength
and the list keeps it just above the middle of the screen. Touch the list and the following stops
until your finger has been still for a moment, so you can read ahead without fighting it. **Tap any
line to jump to that point.**

Where speakers are named, the name is shown only when the speaker changes.

A transcript with no timings is shown as a plain block of text to read at your own pace.

## Notes

`Notes` is the publisher's own episode description, as the feed carried it — links included and
working.

**It is not a web page.** There is no browser engine behind it, nothing runs, and nothing is
fetched, so opening the notes cannot load anything or call home.

For a song or a track from a media server there are no notes; you get a table of facts about the
track instead. An episode with neither says so: `Nothing was written about this one.`

> **A broken transcript costs you the transcript and nothing else.** If one will not parse, the
> episode plays exactly as it would have.
