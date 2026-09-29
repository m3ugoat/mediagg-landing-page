---
title: Audiobooks on your device
summary: How Mediagg finds the books on your phone, how to add a folder of them, and how a book is laid out.
platforms: android, ios
order: 35
---

`Audiobooks` is a chip of its own in [Local media](/documentation/library/local-media), beside
`Songs` and `Videos`. **Each book is one cover, however many files it is** — a book of fifty MP3s
and a book in a single `.m4b` both appear once.

## How a book is found

Nothing has to be tagged. A book is found by where it is kept:

- **Anything in a folder called `Audiobooks`.** Every folder inside it is one book.
- **Any `.m4b` file.** On its own it is a book by itself.
- **Anything the phone itself has marked as an audiobook.**
- **Anything in a folder you have added as a folder of books** — see below.

**The files of a book are its chapters, played in order**, and disc folders such as `CD1` and `CD2`
stay part of the book they are in.

An empty chip says the same: `No audiobooks yet. Add the folder your books are in — each folder
inside it is one book — or keep them in a folder called Audiobooks.`

## Adding a folder of books

Books kept somewhere else — a folder called `My Books`, say — are added with the plus in the
toolbar, `Add an audiobooks folder`. **Choose the folder your books are in, not a book**: every
folder inside it becomes one book.

The first time, Mediagg explains that rule before the folder picker opens, under `Adding audiobooks`.
Tick `Don't show this again` and the plus goes straight to the picker from then on.

A folder called `Audiobooks` never needs adding. It is read wherever it is.

## Finding a book

The chip sorts like every other — `As listed`, `Name`, `Date added`, `Length` and `Size` — and has a
filter beside the sort, for how far through each book you are:

| Filter | Shows |
|---|---|
| `All` | Every book |
| `New` | Books you have not started |
| `In progress` | Books you are part-way through |
| `Finished` | Books you have listened to the end of |

Both are remembered. **The covers say the same at a glance**: a bar along the bottom of a book you
are part-way through, and a tick on one you have finished.

## A book's own screen

Open a book and it lists its **chapters**, not its files. Each row is numbered, named, and shows
where in the whole book it starts; **tap one to play the book from there**. The chapter playing now
is marked, and the mark moves as the book does.

A book whose files carry no chapter marks of their own lists each file as a chapter, under its own
name — so every book reads the same way, whatever it was cut into.

The line under the title says what the book holds: `50 chapters · 3 parts` for three files holding
fifty chapters between them, or simply the chapters where the files and the chapters are one and the
same.

`Resume` appears in place of `Play` once you have started a book, and carries on from where you got
to — in whichever file that was.

**A book's chapters are kept once they have been read**, so a book opens on its chapter list straight
away, the next time and after the app has been closed.

## Books and your songs

Books are kept out of `Songs`, so a thirty-hour book does not turn up among your music. On Android,
`Audiobooks in Songs` in [Scanning](/documentation/settings/scanning) lists them there as well —
`They are always under Audiobooks; this lists them among your songs too`.

For what the player does with a book — the whole-book position bar, chapter-by-chapter skipping,
bookmarks and a speed of its own — see
[Listening to a book](/documentation/playback/listening-to-a-book).
