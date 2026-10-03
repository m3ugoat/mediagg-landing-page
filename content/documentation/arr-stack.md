---
title: Mediagg Arr Stack
summary: A home media server on your Mac or Linux computer, set up for you, and handed to Mediagg with one code.
icon: computer
order: 45
---

**Mediagg Arr Stack** turns a Mac or a Linux computer — a Raspberry Pi, a mini PC, a NAS — into a home media server. One command installs it, three questions
in your browser set it up, and one code hands the whole thing to Mediagg on your phone and TV.

It installs a handful of free programs, sets each one up and connects them to each other — the part
that usually means eight web pages and a dozen keys copied from one to another:

| Service | What it does |
|---|---|
| `Jellyfin` | Plays your films and series, on every screen |
| `Sonarr` | Finds and fetches series |
| `Radarr` | Finds and fetches films |
| `Prowlarr` | Keeps the list of sites Sonarr and Radarr search |
| `FlareSolverr` | Gets Prowlarr past sites that check for a browser |
| `qBittorrent` | Downloads |
| `Seerr` | Lets your family ask for films and series |
| `Bazarr` | Fetches subtitles |

Only what your answers need is installed: Jellyfin always, the rest when you ask for films, series,
subtitles or requests from family. Each runs in its own container in **Docker**, so none of
it is mixed into your system, and all of it can be removed again in one go.

## What you need

- **A Mac**, Apple silicon or Intel, on a macOS release Docker Desktop supports — the current one and
  the two before it. The installer adds Docker Desktop if it is not there.
- **Or a 64-bit Linux computer** — Debian, Ubuntu, Raspberry Pi OS (64-bit), Fedora and the like, on
  Intel/AMD or ARM. A Raspberry Pi 4 or 5 with 4 GB or more is enough. The installer adds Docker if it
  is not there.
- **Space.** About 1.4 GB to download and 4 GB on disk for every service, plus your films and series.
  An external drive is fine.
- **Your phone or TV on the same network** as the computer.

Everything in the stack is free and open source, and so is Docker on Linux. Docker Desktop, on a Mac, is free for personal use, education
and small businesses.

> **Windows is on the way.** For now the stack installs on macOS and Linux. Mediagg itself connects
> to a stack from Android and iOS.
