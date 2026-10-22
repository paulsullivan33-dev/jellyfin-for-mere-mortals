# Writing Criteria

Every guide in this repo is written to the same
standard. If you're adding or editing a guide —
human or AI — hold it to these.

1. **Plain words, real ideas.** Simple language,
   never dumbed-down concepts. Explain jargon on
   first use; collect terms in the glossary.
2. **No hype.** No marketing adjectives, no
   "revolutionary," no promises about what
   something will do for the reader.
3. **Honest about limits.** Say what the thing
   *can't* do. State uncertainty instead of
   smoothing it over. Validation notes include
   what remains unverified.
4. **No invented numbers.** Benchmarks, defaults,
   and specs are either measured or qualified with
   "depends on your setup." If it wasn't tested,
   say so.
5. **Checkable.** Commands are meant to be run,
   with "Check:" blocks showing what success looks
   like. Sources are linked, not asserted.
6. **Respect the reader's setup.** Call out
   Windows/Mac/Linux differences. Don't assume a
   GPU, a budget, or prior experience.
7. **Safety isn't skipped.** Real risks get
   stated plainly, not buried.
8. **Scoped.** Each guide says what it covers and
   points elsewhere for the rest. No guide
   pretends to be the whole subject.
9. **Structure over prose.** Tables, before/after
   examples, symptom → fix. Scannable beats essay.

## Verification notes for this guide

Standard 3 and 4 applied to this guide,
specifically. The subject is software and the
lab ran it for real: the official **Jellyfin
12.2.0** portable build for linux-amd64
(`jellyfin_12.2-amd64.tar.xz` from
repo.jellyfin.org, Jellyfin's own distribution
point, which redirects to the project's
mirrors; SHA-256 as downloaded,
cfa4a6afb24dac543cf73419305772937f96df8f537f2bd221587e224875c4b7),
extracted — not installed — into the build
directory and run headless, unprivileged,
with data, config, cache and logs all inside
that directory, and `--ffmpeg` pointed at the
system ffmpeg 8.1.2 (the portable build ships
no ffmpeg; the server's log confirms the
adoption, t12). The server ran on 2 CPU
cores with no GPU. Working transcripts are
kept with the guide (`jellyfin-lab/transcripts/`,
t00–t12).

**The lab's path, in order** — including the
false starts, because the chapters teach from
them:

- First run bound the default port 8096
  despite a pre-seeded `network.xml`: the
  seed used the retired field name
  `HttpServerPortNumber`. The file the
  server wrote for itself uses
  `InternalHttpPort`/`PublicHttpPort` in
  12.2. Editing those, stopped, and
  restarting bound **8931**, confirmed by
  `ss` and by `/System/Info/Public` (t01).
- `/System/Info/Public` before the wizard:
  version 12.2.0, hostname as server name,
  `StartupWizardCompleted: false` (t02).
- The wizard was completed through its API
  (t03): configuration POST (name "Mere
  Mortals Lab", en-GB — which later made a
  season display as "Series 1"), remote
  access POST, complete POST. The first-user
  step is a 12.2 behaviour worth the ink:
  the admin **root** pre-exists
  (`GET /Startup/FirstUser` → `{"Name":
  "root"}`); POSTing a different name
  returned 404; POSTing "root" with a
  password returned 204. After completion,
  `/Startup/*` answers 401 without an admin
  token (checked).
- Libraries were created via the API after
  reading the server's own OpenAPI document
  (`/api-docs/openapi.json`, served live):
  name/type/paths are query parameters, the
  body is options only; the everything-in-
  the-body attempt returned 400 (t06).
  Movies, Music, Series, each over its own
  folder, `refreshLibrary=true`.
- The specimen library (five files,
  `examples/specimen-library.sh`) scanned
  to a settled **12 items** (t07): two
  films titled and yeared from their
  filenames; an album assembled from the
  FLAC files' embedded tags (artist, album,
  track numbers 1 and 2 — read back out of
  the server's database); a series, a
  season, and two episodes numbered from
  their names (see the scan note below).
- Probing cross-check: the server's record
  of the largest specimen (h264, 1280×720,
  3,010,332 b/s, 6.0 s) agrees with
  ffprobe's independent reading (t04, t08).
- Users: a second account ("guest") was
  created via the API and its policy edited
  (read from the user object, posted back)
  to `EnableAllFolders: false` with only
  the Movies library enabled. The guest's
  own recursive listing fell from **12
  items to 3** (t10). The admin's view was
  unchanged.
- Playback, all three modes, one specimen
  (t11): direct play downloaded
  **2,317,873 bytes, the file's exact
  size**; a bitrate-capped request produced
  an ffmpeg run with `-codec:v:0 copy` —
  audio re-encoded to 48 kb/s, video
  untouched (download 2,298,542 bytes,
  probed: still 1280×720 at 3,010 kb/s); a
  PlaybackInfo request under a 300,000 b/s,
  426 px device profile returned a
  transcoding URL self-labelled
  `TranscodeReasons=ContainerBitrateExceedsLimit`,
  an HLS playlist advertising 426×240, and
  segment 0 probed at **426×238 h264**,
  with libx264 and the scale filter in the
  server's ffmpeg line.

**The scan note (an operator error, kept).**
Episode numbering initially appeared broken:
both episodes sat in `jellyfin.db` with
empty IndexNumber/ParentIndexNumber while
their Series and Season existed. The cause
was not naming. The server log showed every
scan cancelled at 1–2 minutes ("Scan Media
Library" Cancelled) — each new refresh
request cancels the running scan, and the
realtime monitor queued more; episode
linking happens in a phase the cancelled
scans never reached. One uninterrupted scan
later, the same query returned S1 E1 and
S1 E2 for the two different filename shapes
(t09). Chapter 4 teaches the patience; the
interim "orphan episodes" reading is
recorded here so nobody has to re-derive it.

**Capture hygiene (declared trims):** the
lab admin's access token appears in
transcripts only as "<32 hex chars —
redacted>" and in URLs as `ApiKey=<redacted>`;
it protects a throwaway server in a build
directory that no longer exists. The wizard
passwords are printed in t03/t05 because
they are lab-only teaching credentials,
created for this guide and destroyed with
the lab; they secure nothing else. Chapter
quotations of JSON are trimmed with
ellipses inside the braces; the startup-log
excerpts (t12) are the server's lines,
complete at the line level. No output was
otherwise edited, reordered, or cleaned up;
the builder's two `sed` rescues (port
fields) and one shell bug (a `-d @~/...`
path that curl could not read, which made
two policy POSTs silently not happen) are
recorded in t01 and were caught precisely
because the guest's view was re-measured
after each attempt.

**Build-machine weather, stated once:** the
sandbox's outbound network reached
Jellyfin's repository and mirrors without
incident. The metadata providers were never
consulted — the specimens are invented, so
there was nothing true to fetch, and no
artwork or synopsis in this guide is real.
Server clocks in the logs are the sandbox's
(UTC, 2026-10-22).

**Documented-only (not run), and why:**

- *Hardware transcoding* (Quick Sync,
  NVENC, VAAPI, VideoToolbox): no GPU or
  media engine exists on the build bench.
  The server enumerated encoder and
  hwaccel *names* from the adopted ffmpeg
  (t12) and warned which were unavailable;
  nothing with a chip was enabled or
  measured. Chapter 7 presents the rule
  (direct play scales, CPU transcodes are
  the budget) without a benchmark.
- *Television, phone, and desktop apps:*
  no devices were available to the build.
  The web client was exercised only as far
  as proving it is served (the root address
  redirects to it, HTTP 302). App shapes,
  discovery, and third-party players are
  described from the project's
  documentation (jellyfin.org/docs).
- *Metadata providers' identification and
  artwork for real media:* impossible to
  test honestly against invented titles —
  and testing it against real films would
  have meant putting someone else's
  catalogue in the lab. The local half
  (names, tags, probing) is verified; the
  provider flow in chapter 5 is the
  documented one.
- *Remote access from outside a network,*
  HTTPS configuration, reverse proxies,
  UPnP: the lab lived on loopback by
  design. Chapter 6 states the shapes and
  the risks from the documentation and
  defers the mechanics to the networking
  guides.
- *Live TV/DVR, and the books, photos and
  music-video library types:* no tuner,
  and scope. The three proven types are
  movies, tvshows, music.
- *Parental controls, access schedules,
  download/delete permissions:* listed
  from the policy the lab did read (t10's
  policy object) but not exercised per
  setting.
- *Restore from backup:* chapter 9's
  backup is measured fact (the state, its
  place, its size); the restore procedure
  is the documented one and the chapter
  says, in its own text, that it was not
  performed and should be rehearsed by
  the reader on a throwaway instance.
- *The locked-out-admin recovery:*
  described by its shape in chapter 10
  from the project's documentation; not
  performed on the lab (the lab's admin
  was never lost).

Specimen discipline, for the record: the
films, the band, the album, and the
harbour show are invented; every file was
generated on the bench by ffmpeg from test
sources and sine tones; no real media,
real artwork, or any person's library was
used, copied, or described. No command in
this guide was aimed at any system outside
the lab directory and its one server
process.
