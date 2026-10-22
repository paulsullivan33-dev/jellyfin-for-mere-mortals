# Users and Access

**Scope:** accounts — one per person, never
shared — what an administrator is, per-user
library access proven in the lab, and the
honest shape of reaching your server from
outside the house.

## Why accounts at all

A household server with one shared login
has one shared memory: everyone's
half-watched films in one list, one
person's finished series un-watching
itself for the next. Jellyfin accounts are
free and unlimited because they are just
rows in your own database. One per person
buys each of them their own watched state,
their own "continue watching," their own
parental limits — and lets the usher do
its third job from chapter 1.

## Administrators, and the fence

The first account (chapter 3's **root**) is
an **administrator**: it can change
settings, manage libraries, and create
other accounts. Ordinary accounts cannot,
and the difference is total — an ordinary
account that guesses its way to the
Dashboard is simply refused.

What an admin can set per user, in the
Dashboard under Users, or through the
user's **policy** via the API:

- Which **libraries** the user may see at
  all.
- Playback permissions: whether the user
  may trigger transcoding, download files,
  delete items (an admin-only power worth
  leaving off everywhere else), and more.
- Parental controls: a maximum rating,
  blocked tags, access schedules. (Listed
  from the Dashboard; the lab did not
  exercise them and says so.)

## The lab's fence, measured

Transcript t10 is the whole argument. A new
account, **guest**, began life seeing the
entire library — 12 items: films, album,
episodes, all of it. The admin then set
two fields in its policy — "all folders"
off, and the enabled folders list holding
only the Movies library's ID. Signed in as
guest again, the same recursive listing
returned **3 items**: the two movies and
their folder. Music and the series were
not locked, greyed, or marked forbidden.
To that account, they *do not exist*.

That absence is the correct mental model
for all of Jellyfin's access control: it is
not a lock on a door everyone can see; it
is a smaller house. Build accounts
accordingly — a children's account that
cannot see the grown-ups' library is
stronger than one that can see and merely
not play.

Practical hygiene that costs nothing:
strong passwords on every account (the
login page is a real login page), admin
rights for exactly one or two accounts,
and a spare admin — because the *only*
admin forgetting its password is a
database-editing afternoon (chapter 10).

## Reaching it from outside

The wizard's remote-access switch decides
whether the server answers addresses from
beyond your LAN at all. Turning it on is
one click; reaching it is the networking
you arrange yourself — a forwarded port, a
reverse proxy with HTTPS, or a private
tunnel/VPN of the sort the networking
guides in this series cover. The lab ran
on one machine's loopback and **did not
exercise remote access**; what follows is
the project's documented shape, stated
plainly:

- The server itself does not encrypt
  traffic unless you configure its HTTPS
  (with a certificate you supply) — the
  common pattern is a proxy in front doing
  that job.
- Automatic port mapping (the wizard's
  second switch, declined in the lab) asks
  your router to open the door by itself.
  Convenient; also a door you did not
  consciously open. Most careful setups
  leave it off and forward deliberately.
- An account password is the only thing
  standing between the internet and your
  library on an open port. That is the
  real argument for the strong passwords
  above, and for preferring a tunnel.
