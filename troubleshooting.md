# Troubleshooting

**Scope:** the failures this guide actually
met, in the order you'd meet them, then the
classics it knows by report — each as
symptom → cause → fix, with the lab's
transcripts as the evidence.

## The server answers on the wrong port

*Symptom:* you set a port; the server is
on 8096 anyway. *Cause, two flavours:*
you edited `network.xml` while the server
was running (it reads the file at startup,
and may rewrite it on exit), or — the
lab's own, transcript t01 — you edited a
**field name the current version no longer
uses** (`HttpServerPortNumber` for 12.2's
`InternalHttpPort`/`PublicHttpPort`), and
the server silently ignored it. *Fix:*
stop the server, check the field names in
the file the server itself last wrote, and
confirm afterwards with `ss -tlnp` and
`/System/Info/Public`'s `LocalAddress`.

## A new library looks half-scanned

*Symptom:* shows exist but episodes have
no numbers; the album is there but tracks
aren't; everything is *almost* filed.
*Cause:* the scan didn't finish — and the
commonest reason is that somebody (the
lab's operator, repeatedly) pressed "scan"
again, which **cancels the scan in
progress** (transcript t09; the log's
`"Scan Media Library" Cancelled` lines are
the confession). *Fix:* start one scan,
wait for Dashboard → Scheduled Tasks to
say *completed*, then judge the results.
Large first scans of real libraries are
measured in tens of minutes, not seconds.

## A film files itself as the wrong film

*Symptom:* the poster and synopsis belong
to another movie — usually a remake, a
sequel, or a same-titled stranger.
*Cause:* the name nominated the wrong
candidate (chapter 5). *Fix:* in order —
add or correct the `(Year)` in the
filename and rescan; if it persists, use
the item's **Identify** in the Dashboard
and pick the right entry by hand. The
server remembers the correction in its
database.

## One user can't see a library

*Symptom:* a library exists for you and
not for them. *Cause:* almost always the
policy working as designed — chapter 6's
fence hides libraries entirely rather than
locking them, so "missing" *is* the
symptom of "not permitted." *Fix:* the
admin checks that user's enabled folders
before suspecting the scan. And the mirror
image: a user who sees *everything*
probably has a policy nobody set — new
accounts start out seeing all libraries.

## Playback stutters on one screen only

*Symptom:* the same film flies on the
laptop and buffers on the TV. *Cause:*
that client is being handed a transcode
(chapter 7) — its profile can't take the
file — and the server's CPU is the
bottleneck. *Confirm:* the server's own
record of the decision (the PlaybackInfo
transcoding URL names its reason;
Dashboard activity shows Transcode versus
Direct Play). *Fixes, cheapest first:* a
client on that screen that can decode the
file; the file re-shaped into a common
form (H.264/AAC) once, by you, instead of
nightly by the server; hardware
transcoding if your setup has the chip
(documented-only here, chapter 7).

## The API says 400 or 401 and the web works

*Symptom (scripting):* your curl is
refused while the browser sails in. The
lab met both (transcripts t05, t06): a
`400` from signing in with the legacy
`X-Emby-Authorization` header spelling on
12.2 — the full `Authorization:
MediaBrowser Client=…, Device=…,
DeviceId=…, Version=…, Token=…` header is
the reliable form — and a `400` from
creating a library with the parameters in
the JSON body when this endpoint wants
them in the **query string**. *Fix for
both:* read the server's own OpenAPI
document at `/api-docs/openapi.json`; it
is the contract, generated from the code
you're actually running.

## The only admin is locked out

*Symptom:* nobody can administer the
server. *Cause:* a forgotten password on
the sole admin account. *Shape of the
fix (documented, not run in the lab):*
with the server stopped, the account can
be reset by editing the server's database,
or the setup door re-opened by the
project's documented recovery steps —
fiddly either way, which is why chapter 6
advises a spare admin account from day
one. Prevention is one minute; the cure
is an afternoon with a database browser.
