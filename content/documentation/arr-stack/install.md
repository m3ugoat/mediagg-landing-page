---
title: Installing it
summary: One command in Terminal, a folder for your films, and a link to open.
order: 10
---

Open **Terminal** (in Applications → Utilities) and paste:

```
curl -fsSL https://mediagg.app/install.sh | sh
```

That is the whole install. What happens next, in order:

1. **You choose a folder for your films and series.** The ordinary macOS folder picker opens, asking
   `Where should your films and series go?` Pick a folder in your home folder or on an external drive.
   The stack will only ever see this folder and its own — not your Desktop, Documents, Dropbox or
   anything else — so macOS has nothing else to ask about.
2. **Docker Desktop is installed, if it is not already.** Your Mac asks for your password once.
3. **Docker Desktop starts**, and the stack's own page is downloaded and started inside it.
4. **Terminal prints a link** — `Open this link to set it up (it works once, for 30 minutes)` — and
   opens it in your browser.

The last lines say where everything went:

- `Your films and series go in:` the folder you picked.
- `Your password and every service's API key are kept in:` a file in `MediaggStack` in your home
  folder, readable only by your Mac account.

If your folder is on an external drive, macOS asks once whether Docker may use it. That is the folder
you just chose — say yes.

## The setup link

The link holds a one-time code, so only the person at the Mac can set the stack up. If it has expired,
run the install command again for a new one; nothing you have is lost.

Next: [Setting it up](/documentation/arr-stack/set-up).

## Running it again

The same command updates the stack when a new version is out, and repairs an install that went wrong.
It keeps your folder, your password and everything you have set up.
