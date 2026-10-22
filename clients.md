# Clients

**Scope:** the screens — the web client
that is built into the server, the official
apps, and third-party players — and why the
client, not the server, is usually the
difference between direct play and a
transcode. App behaviour beyond the web
client is documented-only in this guide;
the bench had no television or phone.

## The one you already have

The server hosts the **web client** itself:
open `http://<server>:8931/web/` (the lab's
server answered its root address with a
redirect there) and you are looking at the
library in any modern browser — playback,
administration, everything. Nothing to
install, and the reference against which
every other client is judged: when an app
misbehaves, try the web client, because it
separates "the server can't" from "this
app won't."

Its one structural limit is the browser's:
a browser tab decodes only what browsers
decode (H.264 almost everywhere; newer
codecs vary by browser and platform), so
the web client is the most likely of all
clients to be handed a transcode.

## The official apps

Jellyfin publishes its own clients for the
usual screens — Android and iOS phones and
tablets, Android TV/Google TV, Apple TV,
Roku, Amazon Fire TV, LG and Samsung smart
TVs, desktop players (Jellyfin Media
Player), and game consoles via their
browsers or apps. They share a shape: you
give the app your server's address and
sign in with your account, and it presents
*your* libraries under *your* policy
(chapter 6's fence applies identically —
the guest account sees its three items in
every client, because the fence is the
server's, not the app's).

Discovery deserves its one honest line:
on the home network, apps can often *find*
the server by themselves (it announces on
UDP port 7359, and `/System/Info/Public`
— transcript t02 — is how a found server
introduces itself). When discovery fails,
typing the address, port included, is not
a workaround; it is the mechanism working
as designed.

## Third-party players

Because the server speaks a public API
(the same one this guide's lab drove with
curl), other people's players connect to
it too — Infuse on Apple platforms and
Kodi with a Jellyfin add-on are the
best-known. Their value is decoding: a
player that natively decodes more formats
turns would-be transcodes into direct
plays. Their caveat is the mirror image:
features like watched-state sync and the
policy fence depend on the add-on's
manners, and when one misbehaves, the
web-client test above is how you find out
whose fault it is.

## Choosing, in one paragraph

Start with the web client to prove the
server. Put the official app on each
television and phone — it is the path the
project tests first. Reach for a
third-party player when a specific screen
keeps forcing transcodes its hardware
shouldn't need. And when any client
stutters, check what the server decided
(Dashboard → Activity, or the playback
reporting) before blaming the network:
chapter 7's three outcomes mean the fix is
as often "a client that can take the file"
as it is "a faster server."
