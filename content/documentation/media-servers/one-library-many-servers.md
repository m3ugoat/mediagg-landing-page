---
title: One library, several servers
summary: Reading more than one server as a single library, and telling the rows apart.
platforms: android, ios
order: 30
---

If you are signed in to more than one server, you can read them as one library rather than switching
between them.

## Choosing

**There is no merge switch.** The server name in the bar of the `Media servers` screen is a control
— tap it and `Show servers` opens, with a tick per server you are signed in to. Tick the ones you
want and press `Apply`.

- **One server ticked** — that server, on its own.
- **Several ticked** — one library made of those.
- **All ticked** — stored as "all servers", which means **a server you sign in to later joins
  automatically** rather than being left out of a list you made before it existed.

Your choice is remembered, and it also decides which servers the Mix row on Home may draw from.

## Telling the rows apart

In a merged library every row and cover carries **the logo of the server it came from** — the actual
Subsonic, Jellyfin, Audiobookshelf, Plex or Emby mark, in its own colours. Tinting them to the theme
would throw away the one thing that makes a merged list scannable.

List rows carry the server's name alongside the mark.

On a single server no marks are drawn, because every row came from it and marking each would be
noise.

## A server that is signed out

Its mark is drawn faded rather than replaced by a warning icon — **so the row still says which
server it is**. Sign in again and it comes back to full strength.

When a server that had been unreachable returns, Mediagg says
`One server is back. Sign in to it to start using it.`

## Managing the list

`Manage servers` sits alongside the ticks in the same sheet, and on a single-server setup it is in
the bar instead.
