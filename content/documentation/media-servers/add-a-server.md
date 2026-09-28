---
title: Adding a server
summary: The five kinds of server, what each sign-in asks for, and the one that is different.
platforms: android, ios
order: 10
---

Mediagg is a client for five kinds of media server. **Your library stays where it is** — nothing is
copied to the phone unless you download it — and Mediagg reports your progress back, so the server
and your other players stay in step.

Open `Add a server` from `Get started`, or press `Add a server` in the bar of `Media servers` in
the Library. `Choose a provider` lists the five kinds, each with a line saying which server software
it means, and picking one opens its sign-in: an `Address`, a `Name (optional)`, a `Username` and a
`Password`.

## The five

| Server | What the sign-in wants | A typical address |
|---|---|---|
| `Subsonic` | Your account on the server — Navidrome, Airsonic, Gonic and the rest speak this | `https://music.example.com` |
| `Jellyfin` | Your Jellyfin user on this server | `http://192.168.1.10:8096` |
| `Audiobookshelf` | Your Audiobookshelf user on this server | `https://books.example.com` |
| `Emby` | Your Emby user on this server | `http://192.168.1.10:8096` |
| `Plex` | Your plex.tv account, not a user on the server | `http://192.168.1.10:32400` |

**Plex is the one that works differently.** Signing in goes to plex.tv for a token rather than
checking a username and password against the server, so the account you need is the one you use at
plex.tv, even when the server is sitting in the same room.

`Subsonic` is a protocol rather than one program. If your server says it is Subsonic-compatible —
Navidrome, Airsonic, Gonic and others — choose `Subsonic`.

> **No server yet?** The Navidrome, Jellyfin and Audiobookshelf projects run public demo servers —
> see [Trying a demo server](/documentation/media-servers/try-a-demo-server) for their sign-ins.

## Jellyfin: signing in with a code

A Jellyfin server can be signed in to without typing a password on the phone. Once an address is
in, the form offers `Sign in with a code instead` — `Shows a code to enter in Jellyfin on a device
you are already signed in on.`

Mediagg asks the server for a code and shows it: `Open Jellyfin on a device you are already signed
in on, find Quick Connect, and enter this code.` It signs in the moment the code is accepted.

- `This server does not offer signing in with a code. Use a password instead.` — Quick Connect is
  switched off on that server.
- `Nobody entered the code in time, so the server has forgotten it. Ask for a new one.` — press
  `Ask for a new code`.

`Use a password instead` goes back to the form with everything you had typed still there.

## More than one

You can add several servers, including several of the same kind. Each is its own entry in
`Manage servers`, with its own sign-in, and its menu offers `Sign in` or `Sign out` and
`Forget this server`.

If you would rather see one library than several, they can be merged — see
[One library, several servers](/documentation/media-servers/one-library-many-servers).

## Addresses

A local address is fine, and is what most people use. Include the port if the server runs on one —
`8096` for Jellyfin and Emby, `32400` for Plex are the usual defaults.

> **If a sign-in is refused, the address is usually right and something else is wrong.** See
> [A server will not sign in](/documentation/help/a-server-will-not-sign-in).

## What Mediagg sends back

Where you got to in something is reported to the server as you listen, so finishing an episode on
your phone leaves it finished everywhere. Marking a favourite is sent back too, where the server
keeps such a thing.
