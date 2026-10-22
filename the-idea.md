# The Idea

**Scope:** what Jellyfin is — a server you
run, holding media you own, streaming it to
your own screens — and the three jobs it
does that a folder of files doesn't.

## The problem it answers

You have films, music, and series as files
on a disk somewhere. Playing them is easy
on the computer they live on and awkward
everywhere else: the television can't see
the folder, the tablet needs a copy, two
people can't keep separate "where was I up
to" lists, and nobody remembers which of
the three copies of a concert is the good
one.

The commercial answer rents the problem
away: a streaming service holds the library
and every screen just logs in. The price is
that the library is theirs — titles come
and go, and your own rips, recordings, and
odd files have no place in it at all.

**Jellyfin is the self-hosted answer.** One
program, running on a machine you control,
that knows where your media files are,
works out what each one is, and serves it
— as a tidy library with posters and
"continue watching" — to browsers, phones,
tablets, and televisions on your network.
It is free and open-source software (the
GNU GPL), it has no accounts with any
company, no subscription, and nothing to
phone home to. Your server is found by
your apps because you tell them its
address, not because a service introduces
you.

## The three jobs

Everything Jellyfin does is one of these:

1. **The librarian.** It scans folders you
   name, probes every file (codec,
   resolution, length — chapter 5), reads
   names and tags, and organises the pile
   into movies, shows with seasons, albums
   with tracks. This organisation is a
   *database about* your files. The files
   themselves stay exactly where they were.
2. **The projectionist.** When someone
   presses play, it decides how that file
   can reach that screen: sent untouched,
   adjusted, or re-encoded on the fly —
   transcoding, chapter 7. This is the job
   with a hardware cost, and the one most
   often misunderstood.
3. **The usher.** It knows who is who.
   Each person gets their own account,
   their own watched/unwatched, their own
   view of which libraries exist at all
   (chapter 6, proven in the lab: fencing a
   guest account into one library took its
   world from twelve items to three).

## What it is not

- **Not a source of media.** Jellyfin ships
  with nothing to watch. It organises files
  you already have; where they come from is
  your business and your local law's.
- **Not a backup.** The library database is
  a card catalogue, not a copy. If the disk
  of films dies, Jellyfin's tidy posters
  point at nothing. Chapter 9 covers what
  actually needs backing up (the server's
  data — small) versus what it can't save
  (your media — on you).
- **Not a cloud.** If the machine is off,
  the library is off. If you want it from
  outside the house, *you* arrange that
  (chapter 6 is honest about the options
  and the risks).

## The lab in one paragraph

This guide's claims were tested against
the real server: the official portable
build of **Jellyfin 12.2.0**, run headless
on a spare machine, serving a specimen
library of five tiny generated files —
two "films" that are test patterns, an
"album" of sine tones, two "episodes" of a
show that doesn't exist. Tiny files, real
behaviour: every scan, name parse, probe,
policy, and transcode in these chapters
happened to them, and the transcripts in
`jellyfin-lab/transcripts/` are the
captures. What the bench couldn't do — a
graphics chip to transcode with, a
television to play on — is labelled
documented-only wherever it appears, and
`criteria.md` keeps the full ledger.
