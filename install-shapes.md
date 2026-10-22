# Install Shapes

**Scope:** the ways Jellyfin gets onto a
machine — official packages, a container,
and the portable build this guide's lab
used — and the four directories that matter
whichever shape you choose.

## One server, several wrappers

Jellyfin is a single .NET program with a
web client bundled beside it. The project
(Jellyfin's own site, jellyfin.org) offers
it in the shapes home servers usually come
in. The differences are packaging, not
product: every shape below is the same
server, the same database, the same API.

| Shape | What you get | Fits when |
|---|---|---|
| Official package (Debian/Ubuntu repo, RPM, Windows and macOS installers) | A system service, managed like other services | The server is a general-purpose machine you administer normally |
| Container image (`jellyfin/jellyfin`) | The server in Docker, with `/config`, `/cache`, `/media` as volumes | You already run containers, or want the server fenced off from the host |
| Portable archive (per-OS tarball/zip from the project's repository) | A folder you unpack and run | Testing, odd hardware, or — like this guide's lab — proving things without installing anything |
| Appliance images and NAS packages | Community builds for specific boxes | Your NAS or single-board computer has a store; read its notes, versions lag |

Two honest notes. First, the Windows and
macOS shapes exist and are first-class for
the *server* — this guide's lab ran on
Linux because the bench is Linux, and the
chapters flag where an instruction is
Linux-shaped. Second, ffmpeg: transcoding
runs through it, and official packages pull
in the project's own build (`jellyfin-ffmpeg`).
The portable archive expects an ffmpeg on
your PATH or the `--ffmpeg` flag — the lab
pointed it at the system ffmpeg 8.1.2, and
the server's log confirmed the adoption:
`Found ffmpeg version 8.1.2` and, later,
`FFmpeg: /usr/bin/ffmpeg`.

## The four directories

However it is packaged, the server keeps
four places, and knowing them is worth more
than knowing the installer:

| Directory (flag) | Holds | If it vanishes |
|---|---|---|
| Data (`-d`) | The database (`data/jellyfin.db`), metadata, playlists — the library's whole memory | You re-scan from scratch and lose watched state, users' settings, and hand-fixed matches |
| Config (`-c`) | `system.xml`, `network.xml`, encoding and logging settings | The server reverts to defaults (including its port — chapter 3) |
| Cache (`-C`) | Transcode scratch files, image caches | Nothing precious; it rebuilds |
| Logs (`-l`) | The server's diary, one file a day | You lose the evidence chapter 10 reads |

And a fifth place that is *not* the
server's: **your media folders**, which it
reads and (unless you grant it) never
writes. Keep those two ideas separate —
server state versus media — and chapter
9's backup advice will read as obvious.

In the lab, all four lived under one
throwaway directory so the whole server
could be deleted with one `rm -rf`; a real
install spreads them across the usual
system paths (`/var/lib/jellyfin` and
friends on Debian/Ubuntu) or a container's
volumes. Same files, same jobs.

Check, on any running server: ask it who
it is. `GET /System/Info/Public` answers
without a login — the lab's reply is
transcript t02 — and names the version,
the server's chosen name, and whether the
setup wizard has been completed. It is the
first thing chapter 10 reaches for, too.
