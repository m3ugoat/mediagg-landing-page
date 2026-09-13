---
title: Lyrics
summary: Reading lyrics from the file's own tags, from the web, or both — timed where they exist.
platforms: android, ios
order: 50
---

When a song is playing, a `Lyrics` chip appears under the artwork if there are any to show. It
behaves exactly as a transcript does: **timed lyrics follow the music**, the current line is the
only one at full strength, and tapping a line jumps to it.

## Where they come from

Two places. Your files can carry them — either as a `.lrc` file sitting beside the track, or as a
tag inside the track itself — and **LrcLib**, a community lyrics database, can be asked online.

`Where to look`, under `Playback` in Settings, decides which is tried:

| Choice | What the app says about it |
|---|---|
| `The file, then LrcLib` | `Timed words win over untimed ones, whichever is asked first` — the default |
| `LrcLib, then the file` | `Timed words win over untimed ones, whichever is asked first` |
| `Only the file` | `Never asks anyone what is playing` |
| `Only LrcLib` | `Ignores what a file carries` |

## Timed beats untimed

The line the two mixed options share is worth understanding. A tag inside a file holds plain text; a `.lrc` file and most LrcLib
entries hold timings. So under `The file, then LrcLib`, a plain-text tag in your file does **not**
stop Mediagg finding a timed version online — the timed one wins even though the file was asked
first.

## Privacy

`Only the file` is the setting for not talking to anyone. Asking LrcLib means sending the track,
artist, album and length of what is playing, so that it can find the right song — that is what
`Never asks anyone what is playing` is saying.

## What gets lyrics

**Music only.** Podcast episodes are never looked up; they have transcripts instead.

Lyrics inside a file are only read where the file is actually on your device. A track that lives
only on a media server has no local file to read, so only LrcLib can answer for it.

## Radio

When a station announces the track it is playing, Mediagg can fetch lyrics for that track — but only
online, and only if your setting includes LrcLib. There is no file to read on a live stream.
