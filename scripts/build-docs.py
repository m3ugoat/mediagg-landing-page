#!/usr/bin/env python3
"""Render content/documentation/*.md into public/documentation/.

Why this exists, and why it is not a static-site generator: this repository has no build step and
nothing to install, and both the README and netlify.toml say so. That stays true. What ships is
still plain HTML under public/ -- this script only writes it, and its output is committed, so the
Pages workflow is untouched and a clone needs nothing but a browser.

It is deliberately stdlib-only. No pip, no venv, no lockfile. python3 is already the documented way
to preview this site locally, so this adds a command rather than a dependency.

    python3 scripts/build-docs.py            # write public/documentation/
    python3 scripts/build-docs.py --check    # fail if the committed output is stale

The Markdown it understands is a deliberately small subset -- headings, paragraphs, bold, italic,
inline code, links, lists, tables, blockquotes and fenced code. Anything else is a hard error rather
than a silent passthrough, because a generator that quietly emits what it did not understand is how
a docs build starts shipping broken markup nobody notices.
"""

from __future__ import annotations

import argparse
import filecmp
import html
import re
import shutil
import sys
import tempfile
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
CONTENT = ROOT / "content" / "documentation"
SHELL = ROOT / "content" / "_shell.html"
OUT = ROOT / "public" / "documentation"

# The route everything hangs off. Kept in one place because it appears in every breadcrumb, every
# sidebar link and the canonical URL.
BASE = "/documentation"
SITE = "https://mediagg.app"

# Platform keys to the label shown on the badge. Framed as what a page *is* for, never as what it is
# not: the site README forbids describing the app by what it lacks, and that applies here too.
PLATFORMS = {"android": "Android", "ios": "iOS"}

# One line icon per section, drawn on the hub cards. 24x24, stroke-only, currentColor, so they take
# the card's own colour and need no asset files.
ICONS = {
    "home": "M3 11.4 12 4l9 7.4M5.6 9.9V20h12.8V9.9",
    "rss": "M5 19a1 1 0 1 0 .01 0M4 11a9 9 0 0 1 9 9M4 4a16 16 0 0 1 16 16",
    "library": "M4 5h4v15H4zM10 5h4v15h-4zM16.4 5.9l3.6.9-3.4 14-3.6-.9z",
    "server": "M4 5h16v6H4zM4 13h16v6H4zM7.5 8h.01M7.5 16h.01",
    "play": "M12 3a9 9 0 1 0 .01 0M10 8.5l6 3.5-6 3.5z",
    "download": "M12 4v10m0 0 4-4m-4 4-4-4M4 18v2h16v-2",
    "settings": "M4 7h10M18 7h2M4 17h4M12 17h8M16 4.8v4.4M8 14.8v4.4",
    "aid": "M12 3a9 9 0 1 0 .01 0M9.6 9.3a2.5 2.5 0 1 1 2.9 3.3c-.6.2-.9.7-.9 1.4M12 16.9h.01",
}

BADGE_ORDER = ["android", "ios"]


class DocError(Exception):
    """A source file the generator will not guess about."""


# --------------------------------------------------------------------------------------------
# Front matter
# --------------------------------------------------------------------------------------------

def split_front_matter(text: str, where: Path) -> tuple[dict[str, str], str]:
    if not text.startswith("---\n"):
        raise DocError(f"{where}: every page needs a front-matter block opening with '---'")
    end = text.find("\n---\n", 3)
    if end == -1:
        raise DocError(f"{where}: front matter is never closed with '---'")
    meta: dict[str, str] = {}
    for lineno, line in enumerate(text[4:end].split("\n"), start=2):
        if not line.strip():
            continue
        if ":" not in line:
            raise DocError(f"{where}:{lineno}: front matter wants 'key: value', got {line!r}")
        key, value = line.split(":", 1)
        meta[key.strip()] = value.strip()
    return meta, text[end + 5:]


# --------------------------------------------------------------------------------------------
# The page tree, derived from the directory layout
# --------------------------------------------------------------------------------------------

class Page:
    def __init__(self, path: Path):
        self.source = path
        raw = path.read_text(encoding="utf-8")
        self.meta, self.body = split_front_matter(raw, path)

        rel = path.relative_to(CONTENT)
        # index.md is the hub; section.md is a section index; section/leaf.md is a leaf. The parent
        # is the directory, never a front-matter field -- a field could disagree with the path, and
        # then one of the two would be wrong with nothing to say which.
        if rel.name == "index.md":
            self.slug = ""
            self.parent = None
        else:
            self.slug = str(rel.with_suffix("")).replace("\\", "/")
            self.parent = str(rel.parent).replace("\\", "/") if str(rel.parent) != "." else None

        for required in ("title", "summary"):
            if required not in self.meta:
                raise DocError(f"{path}: front matter is missing '{required}'")

        try:
            self.order = int(self.meta.get("order", "999"))
        except ValueError as exc:
            raise DocError(f"{path}: 'order' must be a whole number") from exc

        self.title = self.meta["title"]
        self.summary = self.meta["summary"]
        self.description = self.meta.get("description", self.summary)
        self.icon = self.meta.get("icon", "")
        if self.icon and self.icon not in ICONS:
            raise DocError(f"{path}: unknown icon {self.icon!r}; have {sorted(ICONS)}")

        self.platforms = [p.strip() for p in self.meta.get("platforms", "").split(",") if p.strip()]
        for p in self.platforms:
            if p not in PLATFORMS:
                raise DocError(f"{path}: unknown platform {p!r}; have {sorted(PLATFORMS)}")

        self.stub = self.meta.get("stub", "").lower() in ("true", "yes", "1")
        self.children: list[Page] = []

    @property
    def url(self) -> str:
        return f"{BASE}/{self.slug}" if self.slug else BASE

    @property
    def out_path(self) -> Path:
        return (OUT / self.slug / "index.html") if self.slug else (OUT / "index.html")

    @property
    def is_hub(self) -> bool:
        return self.slug == ""

    @property
    def is_section(self) -> bool:
        return self.parent is None and not self.is_hub


def load_pages() -> tuple[Page, list[Page]]:
    if not CONTENT.is_dir():
        raise DocError(f"no sources at {CONTENT}")
    pages = [Page(p) for p in sorted(CONTENT.rglob("*.md"))]
    by_slug = {p.slug: p for p in pages}

    if "" not in by_slug:
        raise DocError(f"{CONTENT}/index.md is missing -- it is the hub page")

    for page in pages:
        if page.parent is not None:
            if page.parent not in by_slug:
                raise DocError(f"{page.source}: sits under '{page.parent}', which has no page")
            by_slug[page.parent].children.append(page)

    for page in pages:
        page.children.sort(key=lambda c: (c.order, c.title))

    sections = sorted((p for p in pages if p.is_section), key=lambda p: (p.order, p.title))
    for section in sections:
        if not section.icon:
            raise DocError(f"{section.source}: a section index needs an 'icon'")
    return by_slug[""], sections


# --------------------------------------------------------------------------------------------
# Markdown -- the small subset, and a hard error on anything else
# --------------------------------------------------------------------------------------------

INLINE_CODE = re.compile(r"`([^`]+)`")
BOLD = re.compile(r"\*\*([^*]+)\*\*")
ITALIC = re.compile(r"(?<!\*)\*([^*]+)\*(?!\*)")
LINK = re.compile(r"\[([^\]]+)\]\(([^)\s]+)\)")
IMAGE = re.compile(r"!\[")

_PLACEHOLDER = "\x00{}\x00"


def inline(text: str, where: str) -> str:
    """Escape, then put back the handful of marks we allow.

    Inline code is lifted out first and restored last, so that a ** or a [ inside backticks is left
    exactly as it was typed rather than being read as markup.
    """
    codes: list[str] = []

    def stash(match: re.Match[str]) -> str:
        codes.append(match.group(1))
        return _PLACEHOLDER.format(len(codes) - 1)

    # Code is lifted out FIRST, so the checks below only see prose. Backticks quote the app's own
    # wording verbatim, and a message that genuinely contains a < or an * must survive being quoted.
    text = INLINE_CODE.sub(stash, text)

    if IMAGE.search(text):
        raise DocError(f"{where}: images are not supported (no screenshots ship yet)")
    if re.search(r"<[a-zA-Z/!]", text):
        raise DocError(f"{where}: raw HTML is not allowed in sources")
    if "__" in text or re.search(r"(?<!\w)_[^_]+_(?!\w)", text):
        raise DocError(f"{where}: use * for emphasis, not _")
    text = html.escape(text, quote=False)
    text = LINK.sub(
        lambda m: f'<a href="{html.escape(m.group(2), quote=True)}">{m.group(1)}</a>', text
    )
    text = BOLD.sub(r"<strong>\1</strong>", text)
    text = ITALIC.sub(r"<em>\1</em>", text)

    if "*" in text or "]" in text and "[" in text:
        leftover = [c for c in ("*",) if c in text]
        if leftover:
            raise DocError(f"{where}: an unpaired '*' -- escape it or close it")

    for i, code in enumerate(codes):
        text = text.replace(
            _PLACEHOLDER.format(i), f"<code>{html.escape(code, quote=False)}</code>"
        )
    return text


def render(body: str, where: Path) -> str:
    lines = body.split("\n")
    out: list[str] = []
    i = 0
    n = len(lines)

    def loc(idx: int) -> str:
        return f"{where}:~{idx + 1}"

    while i < n:
        line = lines[i]
        stripped = line.strip()

        if not stripped:
            i += 1
            continue

        if line.startswith("    ") and not line.startswith("     "):
            raise DocError(f"{loc(i)}: indented code blocks are not supported -- use ``` fences")

        # Fenced code
        if stripped.startswith("```"):
            lang = stripped[3:].strip()
            i += 1
            buf: list[str] = []
            while i < n and not lines[i].strip().startswith("```"):
                buf.append(lines[i])
                i += 1
            if i >= n:
                raise DocError(f"{loc(i)}: a ``` fence is never closed")
            i += 1
            cls = f' class="language-{html.escape(lang, quote=True)}"' if lang else ""
            out.append(
                f"<pre><code{cls}>{html.escape(chr(10).join(buf), quote=False)}</code></pre>"
            )
            continue

        # Headings. Only h2 and h3 -- the h1 is the page title, written by the shell.
        if stripped.startswith("#"):
            level = len(stripped) - len(stripped.lstrip("#"))
            rest = stripped[level:].strip()
            if level == 1:
                raise DocError(f"{loc(i)}: the h1 comes from the 'title' front matter, not the body")
            if level > 3:
                raise DocError(f"{loc(i)}: only ## and ### are supported -- the page is too deep")
            if not rest:
                raise DocError(f"{loc(i)}: an empty heading")
            slug = re.sub(r"[^a-z0-9]+", "-", rest.lower()).strip("-")
            out.append(f'<h{level} id="{slug}">{inline(rest, loc(i))}</h{level}>')
            i += 1
            continue

        # Callout: a blockquote becomes the site's existing .note box.
        if stripped.startswith(">"):
            buf = []
            while i < n and lines[i].strip().startswith(">"):
                buf.append(lines[i].strip()[1:].strip())
                i += 1
            paras = "\n".join(buf).split("\n\n")
            inner = "".join(
                f"<p>{inline(' '.join(p.split()), loc(i))}</p>" for p in paras if p.strip()
            )
            out.append(f'<div class="note">{inner}</div>')
            continue

        # Table
        if stripped.startswith("|"):
            buf = []
            while i < n and lines[i].strip().startswith("|"):
                buf.append(lines[i].strip())
                i += 1
            if len(buf) < 3:
                raise DocError(f"{loc(i)}: a table needs a header, a ---- rule and a row")
            if not re.fullmatch(r"\|[\s:|-]+\|", buf[1]):
                raise DocError(f"{loc(i)}: the second line of a table must be the ---- rule")

            def cells(row: str) -> list[str]:
                return [c.strip() for c in row.strip().strip("|").split("|")]

            head = "".join(f"<th>{inline(c, loc(i))}</th>" for c in cells(buf[0]))
            rows = "".join(
                "<tr>" + "".join(f"<td>{inline(c, loc(i))}</td>" for c in cells(r)) + "</tr>"
                for r in buf[2:]
            )
            out.append(
                f'<div class="tablewrap"><table><thead><tr>{head}</tr></thead>'
                f"<tbody>{rows}</tbody></table></div>"
            )
            continue

        # Lists. Ordered lists become the site's numbered .steps treatment.
        bullet = re.match(r"^([-*])\s+(.*)$", stripped)
        number = re.match(r"^(\d+)\.\s+(.*)$", stripped)
        if bullet or number:
            ordered = number is not None
            pattern = re.compile(r"^\d+\.\s+(.*)$" if ordered else r"^[-*]\s+(.*)$")
            raws: list[str] = []
            while i < n and lines[i].strip():
                indented = lines[i].startswith(" ")
                m = pattern.match(lines[i].strip())
                if indented and raws and not m:
                    # A wrapped line, not a nested list: sources are hard-wrapped at 100 columns and
                    # a long bullet has to go somewhere.
                    raws[-1] = f"{raws[-1]} {lines[i].strip()}"
                    i += 1
                    continue
                if indented and re.match(r"^([-*]|\d+\.)\s", lines[i].strip()):
                    raise DocError(f"{loc(i)}: nested lists are not supported")
                if not m:
                    raise DocError(f"{loc(i)}: a list that changes kind halfway through")
                raws.append(m.group(1))
                i += 1
            items = [inline(r, loc(i)) for r in raws]
            body_html = "".join(f"<li>{it}</li>" for it in items)
            out.append(
                f'<ol class="steps">{body_html}</ol>' if ordered else f"<ul>{body_html}</ul>"
            )
            continue

        # Paragraph: everything up to the next blank line, rewrapped.
        buf = []
        # A continuation line may start with a backtick -- that is inline code, not a fence -- so
        # only ``` breaks the paragraph here.
        while i < n and lines[i].strip() and not re.match(r"^\s*(#|>|\||```|[-*]\s|\d+\.\s)", lines[i]):
            buf.append(lines[i].strip())
            i += 1
        if not buf:
            raise DocError(f"{loc(i)}: the generator does not understand this line: {line!r}")
        out.append(f"<p>{inline(' '.join(buf), loc(i))}</p>")

    return "\n".join(out)


# --------------------------------------------------------------------------------------------
# Page assembly
# --------------------------------------------------------------------------------------------

def badge(page: Page) -> str:
    if not page.platforms:
        return ""
    names = [PLATFORMS[p] for p in BADGE_ORDER if p in page.platforms]
    pills = "".join(f'<span class="plat">{html.escape(n)}</span>' for n in names)
    return f'<div class="plats" aria-label="Available on {html.escape(" and ".join(names))}">{pills}</div>'


def icon_svg(name: str) -> str:
    return (
        '<svg class="ic" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.6" '
        f'stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="{ICONS[name]}"/></svg>'
    )


def sidebar(sections: list[Page], current: Page) -> str:
    out = [f'<a class="sbhome{" on" if current.is_hub else ""}" href="{BASE}">All documentation</a>']
    for section in sections:
        here = current.slug == section.slug or current.parent == section.slug
        out.append(f'<div class="sbsec{" open" if here else ""}">')
        on = " on" if current.slug == section.slug else ""
        out.append(f'<a class="sbtitle{on}" href="{section.url}">{html.escape(section.title)}</a>')
        if section.children:
            links = "".join(
                f'<li><a class="{"on" if child.slug == current.slug else ""}" '
                f'href="{child.url}">{html.escape(child.title)}</a></li>'
                for child in section.children
            )
            out.append(f"<ul>{links}</ul>")
        out.append("</div>")
    inner = "\n".join(out)
    # A <details> rather than a hidden block: below 820px the home page simply drops its nav links,
    # which is fine for a marquee and useless for documentation -- here the whole tree stays
    # reachable, just folded away.
    return (
        '<nav class="sb" aria-label="Documentation">'
        # Ships open on purpose: a closed <details> hides its own content, so a reader with no
        # JavaScript would get a blank sidebar on a wide screen. docs.js folds it on narrow ones.
        f'<details class="sbfold" open><summary>Browse the documentation</summary>'
        f'<div class="sbin">{inner}</div></details>'
        "</nav>"
    )


def cards(page: Page, sections: list[Page]) -> str:
    # The hub's children are the sections, which the tree does not record as children because their
    # parent is the directory root rather than a page.
    children = sections if page.is_hub else page.children
    if not children:
        return ""
    out = []
    for child in children:
        ic = icon_svg(child.icon) if child.icon else ""
        stub = '<span class="soon">Coming soon</span>' if child.stub else ""
        out.append(
            f'<a class="card" href="{child.url}">{ic}'
            f'<span class="ct">{html.escape(child.title)}{stub}</span>'
            f'<span class="cs">{html.escape(child.summary)}</span></a>'
        )
    return f'<div class="cards">{"".join(out)}</div>'


def crumbs(page: Page, by_slug: dict[str, Page]) -> str:
    if page.is_hub:
        return ""
    trail = [f'<a href="{BASE}">Documentation</a>']
    if page.parent:
        parent = by_slug[page.parent]
        trail.append(f'<a href="{parent.url}">{html.escape(parent.title)}</a>')
    if not page.is_hub:
        trail.append(f"<span>{html.escape(page.title)}</span>")
    return f'<nav class="crumbs" aria-label="Breadcrumb">{"<i>/</i>".join(trail)}</nav>'


def neighbours(page: Page, flat: list[Page]) -> str:
    if page.is_hub:
        return ""
    idx = flat.index(page)
    prev = flat[idx - 1] if idx > 0 else None
    nxt = flat[idx + 1] if idx + 1 < len(flat) else None
    bits = []
    if prev:
        bits.append(f'<a class="pn prev" href="{prev.url}"><b>Previous</b>{html.escape(prev.title)}</a>')
    if nxt:
        bits.append(f'<a class="pn next" href="{nxt.url}"><b>Next</b>{html.escape(nxt.title)}</a>')
    return f'<div class="pnav">{"".join(bits)}</div>' if bits else ""


def build_page(page: Page, sections: list[Page], by_slug: dict[str, Page], flat: list[Page],
               shell: str) -> str:
    parts = [
        sidebar(sections, page),
        '<article class="doc">',
        crumbs(page, by_slug),
        f"<h1>{html.escape(page.title)}</h1>",
        badge(page),
        f'<p class="sub">{html.escape(page.summary)}</p>',
    ]
    if page.stub:
        parts.append(
            '<div class="note stubnote"><p><strong>This page has not been written yet.</strong> '
            "The summary above is its whole scope for now.</p></div>"
        )
    rendered = render(page.body, page.source).strip()
    if rendered:
        parts.append(rendered)
    parts.append(cards(page, sections))
    parts.append(neighbours(page, flat))
    parts.append("</article>")

    title = "Documentation — Mediagg" if page.is_hub else f"{page.title} — Mediagg documentation"
    return (
        shell.replace("{{TITLE}}", html.escape(title, quote=True))
        .replace("{{DESCRIPTION}}", html.escape(page.description, quote=True))
        .replace("{{CANONICAL}}", SITE + page.url)
        .replace("{{DEPTH}}", "")
        .replace("{{BODY}}", "\n".join(p for p in parts if p))
    )


def flatten(sections: list[Page]) -> list[Page]:
    out: list[Page] = []
    for section in sections:
        out.append(section)
        out.extend(section.children)
    return out


def build(target: Path) -> int:
    """Render every page into `target`, replacing whatever is there.

    Rendering happens in a temporary directory and is moved into place only once every page has
    been written. A source file the generator refuses is a common enough event while writing that a
    half-deleted public/documentation/ would be a daily annoyance -- and a destructive one, since
    that directory is committed.
    """
    hub, sections = load_pages()
    pages = [hub] + flatten(sections)
    by_slug = {p.slug: p for p in pages}
    flat = flatten(sections)
    shell = SHELL.read_text(encoding="utf-8")

    with tempfile.TemporaryDirectory() as tmp:
        staging = Path(tmp) / "documentation"
        staging.mkdir(parents=True)

        for page in pages:
            dest = staging / page.out_path.relative_to(OUT)
            dest.parent.mkdir(parents=True, exist_ok=True)
            dest.write_text(build_page(page, sections, by_slug, flat, shell), encoding="utf-8")

        for asset in ("docs.css", "docs.js"):
            shutil.copyfile(ROOT / "content" / asset, staging / asset)

        if target.exists():
            shutil.rmtree(target)
        target.parent.mkdir(parents=True, exist_ok=True)
        shutil.copytree(staging, target)
    return len(pages)


def differences(a: Path, b: Path) -> list[str]:
    """Every path that differs between two trees, as a flat list."""
    out: list[str] = []
    cmp = filecmp.dircmp(a, b)

    def walk(d: filecmp.dircmp, prefix: str) -> None:
        for name in sorted(d.left_only):
            out.append(f"only in generated: {prefix}{name}")
        for name in sorted(d.right_only):
            out.append(f"only in committed: {prefix}{name}")
        for name in sorted(d.diff_files):
            out.append(f"differs: {prefix}{name}")
        for name, sub in sorted(d.subdirs.items()):
            walk(sub, f"{prefix}{name}/")

    walk(cmp, "")
    return out


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--check",
        action="store_true",
        help="generate into a temporary directory and fail if public/documentation/ is stale",
    )
    args = parser.parse_args()

    try:
        if args.check:
            with tempfile.TemporaryDirectory() as tmp:
                staging = Path(tmp) / "documentation"
                count = build(staging)
                if not OUT.exists():
                    print("public/documentation/ does not exist -- run build-docs.py", file=sys.stderr)
                    return 1
                diffs = differences(staging, OUT)
                if diffs:
                    print("public/documentation/ is stale. Run: python3 scripts/build-docs.py",
                          file=sys.stderr)
                    for d in diffs:
                        print(f"  {d}", file=sys.stderr)
                    return 1
                print(f"public/documentation/ is up to date ({count} pages)")
                return 0
        count = build(OUT)
        print(f"wrote {count} pages to public/documentation/")
        return 0
    except DocError as exc:
        print(f"error: {exc}", file=sys.stderr)
        return 1


if __name__ == "__main__":
    raise SystemExit(main())
