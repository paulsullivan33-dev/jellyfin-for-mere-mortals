# Transcoding in Plain Terms

**Scope:** the projectionist's job from
chapter 1 — why a file sometimes cannot
simply be sent, the three ways playback
actually happens (all three measured in
the lab), and the hardware caveat that
decides how much of it your server can do.

## Why "just send the file" fails

A client — a television, a phone, a
browser tab — can only play what it can
decode, in a container it understands, at
a bitrate its connection can carry. Your
file might be none of those on a given
screen: an exotic codec, a 4K picture for
a 720p panel on hotel Wi-Fi, a container
the TV has never heard of. Somebody has to
reconcile file and screen. That somebody
is the server, and the reconciling is
**transcoding**: decoding the file and
re-encoding it, live, into something the
client in front of it can take.

## The three outcomes, measured

Chapter 1 promised three flavours;
transcript t11 has all three, against the
same 6-second, 3 Mb/s specimen:

1. **Direct play.** The client can take
   the file exactly as it sits. The server
   is a file server; the lab's download
   was 2,317,873 bytes — the file's own
   size, to the byte. Cost to the server:
   nearly nothing. This is the outcome to
   arrange your library for.
2. **Remux / partial transcode.** Most of
   the file is fine; one stream isn't.
   Asked for a smaller bitrate, the server
   **copied the video untouched** and
   re-encoded only the audio down to
   48 kb/s — its ffmpeg line says so
   outright: `-codec:v:0 copy`. Cheap, and
   a useful corrective to the idea that
   "transcoding" is all-or-nothing: it is
   decided **per stream**.
3. **Full transcode.** Asked the way a
   small client asks — through PlaybackInfo,
   with a profile capping it at 300,000
   bits/s and 426 pixels wide — the server
   re-encoded for real: 1280×720 in,
   426×238 out, libx264 doing the work,
   and the server stating its reason in the
   URL it issued: `TranscodeReasons=
   ContainerBitrateExceedsLimit`. Cost:
   an actual re-encode of every frame.

Notice who decided: in each case the
**client's declared abilities** (its
device profile) drove the choice. That is
why the same film plays instantly on one
screen and stutters on another, and why
chapter 8's client choice matters.

## The hardware caveat

A full transcode is video editing at
playback speed. Done in **software**
(CPU), a modest server handles one or two
streams and feels it; the lab's bench —
two CPU cores, no graphics hardware —
transcoded a 6-second clip without drama
and would not be your choice for a
household's Saturday night. Done in
**hardware** — a GPU or media engine doing
the decode/encode (Intel Quick Sync,
NVIDIA NVENC, AMD, Apple/VideoToolbox,
VAAPI on Linux) — the same work becomes
nearly free, several streams deep.

What this guide can and cannot say about
that: the server enumerates what your
ffmpeg *offers* — its startup log listed
every encoder name from `libsvtav1` to
`h264_vaapi`, and six hardware-acceleration
types by name (transcript t12) — but an
encoder's name in a list is not hardware
on your desk, and the bench had none to
enable; the same log's warnings say which
of the named tricks are *not available*
here.
**Hardware transcoding is documented-only
in this guide**: it is enabled in the
Dashboard under Playback → Transcoding,
it requires the server to reach the
device (a container must be passed the
GPU), and whether *your* chip does *your*
codec at *your* resolution is a property
of your setup that no guide can measure
for you. The honest planning rule stands
without it:

- Keep files in widely-decodable shapes
  (H.264 video, AAC audio, MP4/MKV) and
  most playback is direct.
- Budget CPU transcoding for the odd
  screen, not the whole house.
- If your household regularly needs
  several simultaneous re-encodes, that —
  not disk, not RAM — is what chooses
  your server hardware.
