---
title: A server will not sign in
summary: Addresses, certificates, accounts that see nothing, and the one server that signs in elsewhere.
platforms: android, ios
order: 40
---

Mediagg names the reason a sign-in failed. Each one points somewhere different.

## `That username or password was not accepted.`

The credentials are wrong for that server. Worth knowing before you retype them:

**Plex is the exception.** `Your plex.tv account, not a user on the server: signing in goes to
plex.tv for a token.` If you are entering a username you created on the server itself, it will not
work however carefully you type it — Plex wants the account you use at plex.tv, even when the server
is in the same room.

## `Signed in, but this account is not allowed to see that.`

The sign-in worked. The account simply has no access to that library. Fix it on the server, in its
own user permissions — there is nothing to change in Mediagg.

## `Could not reach the server. Check the address and that you are on the right network.`

Nothing answered. In order of likelihood:

- **A local address away from home.** `192.168.…` only resolves on your own network.
- **The port is missing.** Jellyfin and Emby usually want `:8096`, Plex `:32400`.
- **The machine is asleep.**

## `The connection is not secure, so it was refused.`

The certificate could not be trusted — usually a self-signed one, or a `https` address whose
certificate has expired. A plain `http` address on your own network is normally accepted; a
half-configured `https` one is not.

## `The server did not answer in time.`

It is reachable but slow. Large libraries on modest hardware do this on a first sign-in. Try again
before changing anything.

## `Nothing is at that address.`

Something answered, but not that server. Check for a stray path on the end of the address — most of
these want the root, not a page inside the web interface.

## It worked yesterday and not today

That is a lapsed session rather than a wrong password. Playback says so plainly:
`Signing in to <server> has stopped working — the password may have changed, or the session may
have been ended on the server.` Sign in to it again under `Media servers`.

When a server that was unreachable comes back, Mediagg says `One server is back. Sign in to it to
start using it.`
