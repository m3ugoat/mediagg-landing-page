<p align="center">
  <img src="public/screens/01-home.webp" width="200" alt="The Mbogi Music home screen">
</p>

<h1 align="center">Mbogi Music — landing page</h1>

<p align="center">
  <a href="https://mbogimusic.com">mbogimusic.com</a>
</p>

The marketing site for Mbogi Music, an Android app that plays the music, podcasts, radio and video
on your phone, on your own media server, and across the web — and casts any of it to Chromecast or
DLNA. Free, no account required.

**This repository holds the website, not the app.** The app is not open source and its source is not
here. Builds are published as APKs at
[laurentjuma/mbogi-music-releases](https://github.com/laurentjuma/mbogi-music-releases/releases/latest);
there is no Play Store or App Store listing.

## What is here

| Path | |
|---|---|
| `public/` | The site. Three pages — home, privacy, 404 — plus the screenshots. This is what gets deployed. |
| `public/screens/` | Eleven screenshots at 640px, with 1080px twins in `large/` for the enlarged view. |
| `docs/` | Design sources: After Effects projects, Adobe XD files, marketing renders. Not part of the site. |
| `legacy/` | The retired Jekyll and webpack toolchain. Kept for reference, never built. |
| `_images/`, `icon.png` | Artwork inherited from the original template. Unused by the current pages. |

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
neither. `public/CNAME` claims `mbogimusic.com`, and because it travels in the artifact, every deploy
reasserts the custom domain.

`netlify.toml` is still present and still correct. Netlify was the original host and publishes the
same `public/` directory with no build command, so it remains a working fallback — but DNS points at
GitHub Pages, so only one of the two is actually serving the domain at any time.

## Credits

Built from [Mobile App Landing Page Template](https://github.com/sandoche/Mobile-app-landingpage-template)
by [Sandoche ADITTANE](https://github.com/sandoche), MIT licensed — see [LICENSE](LICENSE). The
template's Jekyll structure has since been retired to `legacy/` and the three pages rewritten, but
the licence and attribution stand.
