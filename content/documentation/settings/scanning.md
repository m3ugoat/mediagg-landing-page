---
title: Scanning
summary: Which kinds of audio and which folders on the device end up in your library.
platforms: android
order: 60
---

Your phone is full of audio that is not music. Ringtones, alarms and the short sounds apps install
are all files, and none of them belongs in a library you browse.

`Scanning`, under `Local media` in Settings, is **`Which kinds of audio and which folders end up in
your library`**.

## Kinds of audio

Six kinds can be skipped, each with a line saying what it means:

| Kind | What it is |
|---|---|
| `Ringtones` | `What the phone rings with` |
| `Notification sounds` | `The short sounds apps install` |
| `Alarm sounds` | `What wakes you up` |
| `Voice recordings` | `Voice memos and call recordings` |
| `Audiobooks` | `Books the device has tagged as such` |
| `Podcast files` | `Episodes downloaded by another app` |

The last two are the interesting ones. **Audiobooks and podcast files are skipped by default**
because they are usually another app's business — but if your audiobooks live on the device and you
want them here, this is where to let them in.

## Folders

Under `Folders`, Mediagg lists every folder it has actually found media in, with a count —
`12 tracks · 3 videos`. Turn one off to leave it out.

The device's top level appears as `Storage root`.

Until a scan has run there is nothing to list, and the screen says so:
`Nothing has been found on this device yet.`

## Permission

Mediagg has to be allowed to read the device's media before it can find any:
`Mediagg needs permission to list the music on this device.` The same is asked separately for video.

Without it, `Local media` will be empty however the settings on this screen are set.

## After changing something

Changes apply to the next scan. Where a list is already empty, `Nothing found on this device yet.
Scan to look again.` offers the scan directly.
