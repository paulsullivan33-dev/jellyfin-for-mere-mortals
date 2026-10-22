# Jellyfin for Mere Mortals

Every screen in the house wants the films,
music, and series that live as files on one
computer — and a folder listing is not a
library. **Jellyfin** is the free,
open-source server that closes that gap:
you run it on your own machine, over your
own media, and it files, decorates, and
streams everything to your browsers,
phones, and televisions — no subscription,
no company account, no library that can be
"removed from the service" because the
service is yours. This guide explains how
it works, in plain terms: the naming rules
that decide whether your files file
themselves, what a user account really
fences off, transcoding without the magic
(including the part your hardware decides),
and what to back up so a dead disk is an
afternoon rather than a bereavement.

The lab is the real server run small: the
official portable build of **Jellyfin
12.2.0**, headless, on a nonstandard port,
serving a specimen library of five tiny
generated files — test-pattern "films," a
sine-tone "album," two episodes of a show
that doesn't exist. Everything that could
be proven on them was: the setup wizard
completed through its API, three library
types scanned and organised them, a second
user was fenced into a single library
(its world shrinking from twelve items to
three), and playback was captured all
three ways it can happen — the file
untouched, one stream fixed, and a genuine
re-encode at a smaller size. The lab also
failed informatively twice — a port edit
the current version silently ignores, and
a scan the operator kept cancelling — and
both failures are chapters here, because
both will happen to you. What the bench
couldn't do — hardware transcoding, a
television, providers' artwork for real
films — is labelled documented-only
wherever it appears; `criteria.md` keeps
the full ledger.

## What this guide covers

- [**The idea**](the-idea.md) — your
  library, your server: the librarian, the
  projectionist, the usher; what it is not
- [**Install shapes**](install-shapes.md) —
  packages, containers, the portable build,
  and the four directories that matter
- [**First setup**](first-setup.md) — the
  wizard in browser and API, the admin
  12.2 pre-creates, and the silent port
- [**Libraries and naming**](libraries-and-naming.md) —
  folder shapes that file themselves,
  `SxxEyy`, and the scan you must leave
  alone
- [**Metadata, honestly**](metadata-honestly.md) —
  probed facts versus provider opinions,
  tags for music, and the en-GB "Series 1"
- [**Users and access**](users-and-access.md) —
  one account per person, the fence
  measured, and reaching the server from
  outside, honestly
- [**Transcoding in plain terms**](transcoding.md) —
  direct play, the per-stream fix, the full
  re-encode, and the hardware caveat
- [**Clients**](clients.md) — the web
  client you already have, the official
  apps, third-party players, and choosing
- [**Backing up the server**](backing-up.md) —
  the small precious pile versus your
  media, and what a restore demands
- [**Troubleshooting**](troubleshooting.md) —
  the wrong port, the half-scan, the wrong
  film, the invisible library, the 400s
- [**Limits and neighbours**](limits-and-neighbours.md) —
  what it won't do, and Plex, Emby, a
  subscription, and a shared folder
  compared
- [**Glossary**](glossary.md) — the terms,
  collected in one place

## What it doesn't cover

Where media comes from (your files are
your business, and your local law's), the
live-TV and DVR features, the book and
photo library types, plug-ins, and
running Jellyfin as a public service for
other people. Reverse proxies, tunnels,
and port forwarding get their honest
shape in chapter 6 but their full
treatment in this series' networking
guides. Hardware transcoding is explained
and bounded, not benchmarked — no
suitable chip was on the bench.

## How to use this guide

Read chapter 1 for the model and chapter
4 before organising a single real folder —
naming is the cheapest labour in the whole
project and the most-skipped. Chapters 2
and 3 get a server running; chapter 5
before you blame a match; chapters 6 and
7 before the first family movie night,
because accounts and transcoding are the
two surprises. The transcripts the chapters
quote live in `jellyfin-lab/transcripts/`;
the specimen library's generator is
`examples/specimen-library.sh`, and the
lab's own notes are `examples/lab-notes.txt`.
