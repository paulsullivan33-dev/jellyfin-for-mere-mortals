# First Setup

**Scope:** the first fifteen minutes — the
setup wizard in a browser, the same wizard
through its API (which is how the lab did
it), the administrator account 12.2 hands
you, and the port change that taught us
how this server keeps its settings.

## The wizard

Start a fresh server and open its page —
`http://<server>:8096` at first run. The
wizard asks, in order, for:

1. A **server name** and the language and
   country for metadata (what language
   descriptions should be in, which
   release dates and ratings to prefer).
2. The **first administrator**: a name and
   a password.
3. Libraries — chapter 4's subject; the
   wizard will happily finish with none.
4. **Remote access**: whether the server
   may be reached from outside the local
   network, and whether it may ask the
   router to open a port for it
   (automatic port mapping, UPnP). The
   lab said yes to the first and no to
   the second, and chapter 6 explains
   why that pairing is the cautious one.

Then it closes behind you. Verified in
the lab: after completion, the wizard's
own endpoints answer `401` to a caller
without an administrator token. A one-time
door should lock; this one does.

## A surprise in 12.2: the admin pre-exists

Version 12.2's first user is not created
by the wizard — it is *revealed* by it.
Asking the API who the first user will be
returned `{"Name":"root"}` before we set
anything, and posting a different name
(`keeper`) was answered `404`. Posting
the name that exists — setting **root**'s
password — succeeded. In the browser
wizard the same fact appears as the name
already filled in. Keep the name or change
it later in the Dashboard; what matters is
that the password you set in this step is
the only key to the whole library until
you make more accounts (chapter 6), so
make it a real one.

The lab drove the whole wizard with five
API calls (transcript t03), which is worth
knowing even if you use the browser: the
server is fully scriptable, and everything
the web client does, a script can do.

## The port, and a lesson in silent failure

8096 is the default port (8920 for HTTPS,
off until configured). The lab wanted
8931. Jellyfin's port lives in
`network.xml` in the config directory,
changed in the Dashboard under Networking
or by editing the file **with the server
stopped** — and here the lab earned
transcript t01 the hard way. The field
name from older versions,

```
<HttpServerPortNumber>8931</HttpServerPortNumber>
```

was placed in the file before first run,
and the server came up on 8096 anyway,
without a word of complaint. Its own
written config showed the current names —
`InternalHttpPort`, `PublicHttpPort` —
with the old line preserved beside them,
inert. Editing the *current* fields and
restarting put the server on 8931, where
`/System/Info/Public` confirmed it in its
`LocalAddress`.

Two general rules fall out of that small
embarrassment, and they apply far beyond
ports: a setting file is read at startup,
not watched; and a field the program no
longer knows fails **silently** — so when
a config change "does nothing," suspect
the field name before suspecting the
program.

Check, after any first setup: the public
info endpoint should show your server
name and `"StartupWizardCompleted":true`,
and the web client should offer a login,
not a wizard. Both are in transcripts t01
and t02.
