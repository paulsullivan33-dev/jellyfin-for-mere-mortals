# Libraries and Naming

**Scope:** what a library is, the shapes
the server understands, and the naming
rules that decide whether your files file
themselves — proven against the lab's
specimens, including the scan that looked
broken and wasn't.

## A library is a folder plus a promise

A **library** in Jellyfin is a folder on
disk and a declared type: *this folder is
movies*, *this one is shows*, *this one is
music*. The type is a promise about the
folder's shape, and the scanner holds you
to it. In the lab (transcript t06), three
libraries were created over three folders —
Movies (`movies`), Music (`music`), Series
(`tvshows`) — and each specimen was
recognised according to its library's
rules.

Create them in the Dashboard (Settings →
Libraries → Add) or through the API; know
that the API takes the name, type, and
paths as query parameters and options as
the body — the lab's everything-in-the-body
first attempt earned a blunt `400`, and the
server's own OpenAPI document, served live
at `/api-docs/openapi.json`, is what
settled the argument. A server that
documents itself is a server you can
script against with confidence.

## The shapes that file themselves

**Movies** — one folder, files loose in it,
each named:

```
Title (Year).ext
```

The year in parentheses is the single most
valuable character string in this whole
guide. The lab's `The Clockwork Lighthouse
(2021).mp4` was filed under exactly that
title with year 2021 (transcript t07) —
read from the name, since the file carries
no year inside it.

**Shows** — a folder per show, a folder per
season, files named with their numbers:

```
Show Name/
  Season 01/
    Show Name S01E01 - Episode Title.ext
    Show Name - S01E02 - Episode Title.ext
```

Both of the lab's episode spellings —
with and without the dash before `S01E02` —
parsed to season 1, episodes 1 and 2
(transcript t09). What the parser wants is
the `SxxEyy` block and the folder shape
around it; it is forgiving about the rest.

**Music** — a folder per album, files
named `NN - Title.ext` — but music is the
exception that proves chapter 5's point:
the lab's tracks were filed by the tags
*inside* the FLAC files (artist, album,
track numbers), which the filenames merely
agreed with. For music, tags rule; names
are the fallback.

## Scans: phases, and patience

Pressing "scan" starts more than a walk
over the folders. Files are probed, items
created, then post-scan phases link
episodes into seasons and shows, fetch
metadata, and tidy up. Two practical
consequences, both learned live:

- A fresh library can look *half-linked*
  for a while — the lab's episodes sat
  numberless in the database while their
  Series and Season already existed —
  because the linking happens in a later
  phase than the listing you are staring
  at.
- **A new scan cancels the one running.**
  The lab proved this against itself:
  repeated "scan now" requests, each
  cancelling its predecessor in the
  one-to-two-minute range, kept the library
  in the half-linked state for half an
  hour (transcript t09). One scan, left
  alone to finish, numbered both episodes
  correctly.

Check, after adding a library: Dashboard →
Scheduled Tasks shows "Scan Media Library"
completed, not cancelled — and only then
judge what the scanner made of your names.
Chapter 10 returns to this.
