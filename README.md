<p align="center">
  <img src="public/screens/01-home.webp" width="200" alt="The Mediagg home screen">
</p>

<h1 align="center">Mediagg — landing page</h1>

<p align="center">
  <a href="https://mediagg.app">mediagg.app</a>
</p>

The marketing site for Mediagg, an app that plays the music, podcasts and video on your phone, on
your own media server, and across the web — and casts any of it to Chromecast or DLNA. Free to use.

**Android is what ships.** The app is a Compose Multiplatform codebase and an iOS build is being
worked towards, which the site says in those words and with no date. `IOS.md` in the app repository
is explicit that no iOS target exists yet, so anything firmer here would be the site promising what
the code does not.

**This repository holds the website, not the app.** The app is not open source and its source is not
here. The site no longer links APK downloads: it says the app is coming soon to Google Play, and
carries no install link until that listing exists.

## What is here

| Path | |
|---|---|
| `public/` | The site. Home, privacy, `m3ugoat/`, 404, three `deeplink/` landing pages Android falls back to when the app is not installed, and two redirect stubs at `/full` and `/personal` — plus the screenshots and icons. This is what gets deployed. |
| `public/screens/` | The carousel screenshots at 640px, with 1080px twins in `large/` for the enlarged view, plus `hero-choose-style.webp` — the one in the phone at the top of the home page, which is not part of the carousel and so has no twin. **See the warning below before trusting any of them.** |
| `public/icons/` | `mediagg.png`, the launcher icon, and `og.png` for link previews. `mediagg-personal.png` is the retired Personal edition's icon, kept but no longer used by any page. |
| `docs/` | Design sources: After Effects projects, Adobe XD files, marketing renders. Not part of the site. |
| `legacy/` | The retired Jekyll and webpack toolchain. Kept for reference, never built. |
| `_images/`, `icon.png` | Artwork inherited from the original template. Unused by the current pages. |

### One app, and what the site may say about it

The site used to sell two editions, Mediagg and Mediagg Personal, on two pages that pointed at each
other. **There is one Mediagg now** — the build the app repository calls `freePlayFull` — and the
site describes that and nothing else. `/full` and `/personal` are redirect stubs to `/`: the URLs
were linked from the home page for months, so retiring them with `noindex` and a redirect beats a
404.

Two rules follow from what that build actually is, and both are easy to break by writing nice copy:

- **Only claim what is in it.** It has no Explore screen, no radio or TV directory and no station
  search — those live in the unpublished Xtended build. It does have the podcast charts by country
  and category, reached from Add feed. Media servers, local media, playlists, podcasts, video,
  downloads and casting are all in.
- **Android Auto and Wear OS are no longer claimed.** The playback service is a
  `MediaLibraryService`, which is what both browse against, but the browse tree it exposes is still
  empty — filling it is Phase 6 in the rewrite. The card that claimed them has been replaced with
  the providers one, which is built.
- **Never describe it by what it lacks.** No "no ads", no "no tracking", no "no analytics" — not as a
  boast, not in a marquee, not in a stat. The absence of advertising is not being sold, and a
  promise made here is one the app has to keep for good. The privacy policy is the exception, and
  only because it must be accurate: it names Crashlytics, which is genuinely in the build, and is
  silent about advertising rather than boasting of its absence.

### ⚠ Every screenshot on the site is from the wrong build

The eleven carousel shots and the hero were all captured from an Xtended build, and it shows: the
bottom navigation has an **Explore** tab, the search results are full of radio stations, and one
whole slide is the Explore screen itself. The two worst — station search and Explore — have been
removed from the carousel; the rest are still there and still wrong in the navigation bar.

**They are being replaced.** Drop the new files into `public/screens/` at 640px wide with 1080px
twins under the same names in `public/screens/large/`, replace `hero-choose-style.webp`, then add or
remove `<figure class="shot">` blocks in `public/index.html` to match — the carousel counts its own
slides, so the dots, arrows and enlarged view need no other change. There is a comment above the
rail saying the same thing.

**Do not deploy until that is done.**

## The m3ugoat page

`/m3ugoat` explains the playlist server the app can subscribe to, and how to add one. Its content is
taken from the provider itself — `providers/m3ugoat/` in the app repository — rather than written
around it, including the reason the app reads that server's API instead of its export link: an m3u
file cannot say which channels are hidden or what order they go in, and an export token is rotatable.

If that provider's `ABOUT` text, its sign-in note or its prompts change, this page should follow.

## Running it

There is no build step and nothing to install. The pages are plain HTML with their CSS inline, and
the only assets are the screenshots, so any static file server will do:

```
python3 -m http.server -d public 8000
```

Then open http://localhost:8000.

Opening `public/index.html` directly in a browser mostly works, but the pages use root-relative paths
(`/screens/…`, `/privacy`), so the screenshots and the privacy link will not resolve over `file://`.
Serve the directory instead.

## How it deploys

Pushes to `master` that touch `public/**` publish to GitHub Pages through
[`.github/workflows/pages.yml`](.github/workflows/pages.yml). Editing this README or the design
sources in `docs/` does not spend a deploy; the workflow can also be run by hand from the Actions
tab.

The workflow uploads `public/` as a Pages artifact rather than using the "deploy from a branch"
setting, because a branch deploy can only serve the repository root or `/docs`, and the site is in
neither. `public/CNAME` claims `mediagg.app`, and because it travels in the artifact, every deploy
reasserts the custom domain.

`.app` is HSTS-preloaded at the registry level, so the site is HTTPS-only whether it wants to be or
not: there is no HTTP fallback, and a browser that cannot validate the certificate shows an
interstitial the visitor cannot click through.

`netlify.toml` is still present and still correct. Netlify was the original host and publishes the
same `public/` directory with no build command, so it remains a working fallback — but DNS points at
GitHub Pages, so only one of the two is actually serving the domain at any time.

## Credits

Built from [Mobile App Landing Page Template](https://github.com/sandoche/Mobile-app-landingpage-template)
by [Sandoche ADITTANE](https://github.com/sandoche), MIT licensed — see [LICENSE](LICENSE). The
template's Jekyll structure has since been retired to `legacy/` and the pages rewritten, but the
licence and attribution stand.

This repository is a fork of the Mbogi Music site, which is a separate app on a separate account and
is not affected by anything here.
