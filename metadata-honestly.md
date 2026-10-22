# Metadata, Honestly

**Scope:** where the pretty library's
descriptions, posters, and groupings
actually come from — your filenames, the
tags inside your files, and the internet's
databases, in that order of reliability —
and what the server *measures* itself.

## Two different kinds of knowing

A Jellyfin item carries two sorts of
information, and keeping them apart clears
up most metadata confusion:

**Measured facts** the server gets by
probing the file itself: codec, picture
size, bitrate, duration, audio channels.
These cannot be wrong in the way a title
can — two probes of the lab's biggest
specimen, ffmpeg's and the server's,
agreed to the digit (transcripts t04 and
t08: h264, 1280×720, 3,010,332 bits/s,
6.0 seconds). Probing is local, instant,
and needs no internet.

**Identifications** — *which* film, *which*
episode, what year, whose album — come
from names and tags, matched against
metadata **providers** (in a default
install, community databases such as
TheMovieDb and TheTVDB for video, and
embedded tags first for music). A match
brings back the poster, the synopsis, the
cast list. This is the part that can be
wrong, because names are ambiguous and
databases are opinions.

## What the lab could and couldn't prove

The specimens are invented: there is no
real "Clockwork Lighthouse" for a provider
to find. So this guide verifies the local
half completely and says plainly that the
provider half is **documented-only**:

- From **filenames**: both films filed
  under their exact titles with the years
  from their parentheses; both episodes
  numbered from their `SxxEyy` names.
- From **embedded tags**: the album
  assembled itself — artist "The Paper
  Boats", album "Harbour Lights", tracks
  in order — out of what was written
  inside the FLAC files. Music is the one
  library where the file, not the folder,
  is the authority.
- From **providers**: nothing was fetched,
  because there was nothing true to fetch.
  For real films the flow is: the name and
  year nominate a candidate, the provider
  confirms and decorates it. When it
  nominates wrong — a remake's year in
  another film's name — the fix is the
  year in the filename first, and the
  Dashboard's "Identify" search second,
  where you pick the right entry by hand
  and the server remembers your pick in
  its database (not in the file).

## The honest rules of thumb

1. **Names are the contract.** `Title
   (Year)` for films, show folders and
   `SxxEyy` for episodes, tags tended for
   music. Chapter 4's shapes get the
   overwhelming majority of real libraries
   filed without human help.
2. **A wrong match is a naming problem
   until proven otherwise.** Fix the name,
   rescan, and only then reach for manual
   identification.
3. **Your edits live in the database.**
   Posters you choose, matches you correct,
   names you override — all are server
   state (chapter 9's backup), not edits
   to your media files. Lose the database
   and you lose the corrections, not the
   films.
4. **Language is a setting, not an
   accident.** The wizard's culture choice
   follows you into odd corners: under the
   lab's en-GB, a season is labelled
   **"Series 1"** in listings (transcript
   t07) — correct British usage, startling
   if you go hunting for a thing called
   "Season 1" that your server insists it
   doesn't have.
