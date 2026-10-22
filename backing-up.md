# Backing Up the Server

**Scope:** what to copy so that a dead
disk is an afternoon, not a bereavement —
the server's state (small, precious) versus
your media (large, and only you can
protect it) — with the lab's own footprint
as the worked example.

## The two piles

Everything about a Jellyfin installation
sits in one of two piles, and they back up
completely differently:

**Server state** — the data and config
directories of chapter 2. The database
(`data/jellyfin.db`), the config files,
the metadata and artwork the server
collected, your users, your watched state,
your hand-corrected matches (chapter 5:
your edits live here, not in the files).
In the lab — three libraries, a dozen
items — that whole pile measured:

```
data    5.1 MB
config   24 KB
```

A real household's is bigger — artwork and
metadata grow with the library — but it
stays the small pile. **This is the backup
that matters most and costs least.**

**Your media** — the films, music, and
series themselves. Jellyfin cannot back
these up for you and does not pretend to:
its database is a catalogue of files it
expects to find. If the media disk dies,
the catalogue survives as a precise list
of what you lost. Protect the media the
way you protect any large, irreplaceable
pile of files — redundant copies, per the
Backups guide in this series.

## How, concretely

1. **Stop the server**, or accept a
   database copied mid-write. The database
   is SQLite (the lab read it directly,
   transcript t09); a copy taken while the server
   runs usually works and occasionally
   doesn't, which is a poor trade for the
   ten seconds a stop takes.
2. Copy the **data** and **config**
   directories somewhere that is not the
   same disk. Cache and logs can be left
   behind — both rebuild, and the transcode
   cache in the lab (2.5 MB of it) is pure
   scratch.
3. Restart and check: the public info
   endpoint answers with your server name,
   and a sign-in shows your libraries and
   watched state.

The data directory also contains a
`SQLiteBackups` folder — the server's own
snapshot slot. In the lab it is **empty**:
the slot exists whether or not anything
has ever filled it, which is the whole
backup lesson in miniature. Your own copy,
taken on purpose, is the plan; anything
the server keeps for itself is a bonus
you have not verified until you've looked.

## What a restore looks like

Install or unpack the server afresh, put
the backed-up data and config where the
new instance expects them (chapter 2's
four directories), start it. The media
must be at the **same paths** the database
remembers — restore to the same folder
layout, or expect a library of posters
pointing at nothing until a rescan in the
new location rebuilds the links. Watched
state, users, and corrections return with
the database because they *are* the
database.

One honest limit, stated rather than
discovered: this guide **did not perform**
a restore. The backup above is verified —
the state is what and where the chapters
say it is, measured — and the restore path
is the project's documented one. Prove it
on your own setup once, with a throwaway
instance, before you need it for real; a
backup whose restore is untested is a
hope, not a backup. (That sentence is
this series' standing rule, and it applies
to this guide's author too.)
