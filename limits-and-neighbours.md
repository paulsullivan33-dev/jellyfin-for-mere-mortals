# Limits and Neighbours

**Scope:** what Jellyfin won't do, said
plainly, and the neighbouring answers to
the same problem — a rented library, a
rival server, and a shared folder — with
what each trades.

## The limits, without varnish

- **It brings no media and no metadata
  magic.** The library is your files and
  what can be known about them. Invented
  or obscure titles get filenames and
  probing, not posters from the sky —
  the lab's specimens are the proof, filed
  tidily and entirely undecorated.
- **Transcoding is bounded by iron.**
  Chapter 7's caveat is the product's
  real ceiling: direct play scales to a
  houseful; simultaneous full transcodes
  scale to your CPU or your GPU, whichever
  you bought. No setting repeals this.
- **It is one machine's library.** The
  server is a single program with a
  single database. There is no official
  multi-server cluster, no shared watched
  state across two households' servers;
  one household, one server, is the shape.
- **Live TV and DVR exist but are a
  second hobby.** Jellyfin can front a
  tuner (HDHomeRun and friends) and
  record; this guide did not run a tuner
  and does not teach it. Neither did it
  exercise the book, photo, or music-video
  library types — the three it proves are
  movies, shows, and music.
- **Your availability is its
  availability.** Off, asleep, or
  mid-reboot, the library doesn't exist.
  A streaming service's one genuine
  advantage is that it is never *your*
  outage.
- **Backups are yours.** Chapter 9. The
  server's database is small and precious
  and entirely your responsibility.

## The neighbours

**A streaming subscription** rents you a
vast, shifting library with zero
administration and zero ownership: nothing
to name, nothing to back up, nothing that
is yours. It and Jellyfin answer different
questions — most households that run
Jellyfin still rent something. The trade
is admin time and hardware for permanence
and control of the things you own.

**Plex** is the nearest neighbour: the
same shape — your server, your media, its
clients — but a commercial product with a
company account in the middle, a paid tier
(Plex Pass) gating features Jellyfin
includes (hardware transcoding among
them), and polish that shows. People
choose it for the apps and the remote
access made easy; people leave it over
the account, the cost, and the direction.
**Emby** — Jellyfin's own ancestor, from
which it forked in 2018 — is the same
story in a smaller shop: commercial,
tiered, capable. Neither was run for this
guide; this paragraph is orientation, not
review.

**A shared folder and a player** (SMB/NFS
plus VLC or Kodi opening files directly)
is the zero-server answer, and for one
person and one screen it is honestly
enough. What you give up is everything in
chapter 1: no watched state that follows
you, no per-user fences, no transcoding
for the weak screen, no library but a
directory listing. Jellyfin earns its
keep exactly where that list starts to
matter.

**Kodi** sits between: a superb player
with its own library, on one screen at a
time. It can also be a Jellyfin *client*
(chapter 8), which is many households'
final shape — Jellyfin as the librarian
and usher, Kodi as the projectionist the
television already loves.
