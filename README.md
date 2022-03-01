## tessen

`tessen` is a bash script that can autotype and copy data from
[password-store](https://git.zx2c4.com/password-store/) and
[gopass](https://github.com/gopasspw/gopass) files. A wayland native dmenu is required to use tessen
and the following dmenu backends are recognized

- [rofi](https://github.com/lbonn/rofi)
- [fuzzel](https://codeberg.org/dnkl/fuzzel)
- [bemenu](https://github.com/Cloudef/bemenu)
- [wofi](https://hg.sr.ht/~scoopta/wofi)

If you want to use another wayland native dmenu backend not mentioned here, please open an
[issue](https://github.com/ayushnix/tessen/issues) or [raise a
PR](https://github.com/ayushnix/tessen/pulls).

`tessen` is written to work only on wayland wlroots compositors such as [sway](https://swaywm.org/).
If you'd rather use [fzf](https://github.com/junegunn/fzf) to copy your password-store data on both
xorg/x11 and wayland, check out [pass-tessen](https://github.com/ayushnix/pass-tessen).

### Why use `tessen`?

- `tessen` can autotype or copy (or do both at the same time!) your password store and gopass data
  including all of your key-value pair data

  From what I've observed, most scripts out there do not autotype and copy all of your key-value
  pair data. They also do not offer choices about autotyping or copying data with the same
  flexibility as `tessen` does.

  Although [rofi-pass](https://github.com/carnager/rofi-pass) is a good alternative, it only works
  on xorg/x11. `tessen` is made to work on wayland.

- if you're using a web browser extension to access your passwords, you may wanna read
  [this](https://cmpxchg8b.com/passmgrs.html) article

- `tessen` does not use any external programs unless they are absolutely necessary. This means that
  `tessen` doesn't need programs like `sed`, `awk`, `tr`, `cut`, `find`, `sort`, `head`, `tail`.
  This ensures that `tessen` isn't dependent on the subtle differences between GNU, BSD, and busybox
  coreutils.

- the code is linted using [shellcheck](https://github.com/koalaman/shellcheck) and formatted using
  [shfmt](https://github.com/mvdan/sh). I've also tried to ensure that `tessen` doesn't leak any
  sensitive data. Please raise an issue or a pull request if you can make tessen more minimalistic
  or secure.

## Installation

### Dependencies

- [bash](https://www.gnu.org/software/bash/)
- at least one pass backend is needed - either [pass](https://git.zx2c4.com/password-store/) or
  [gopass](https://github.com/gopasspw/gopass)
- a wayland native dmenu backend such as [rofi](https://github.com/lbonn/rofi),
  [bemenu](https://github.com/Cloudef/bemenu), [fuzzel](https://codeberg.org/dnkl/fuzzel), or
  [wofi](https://hg.sr.ht/~scoopta/wofi)
- [wtype](https://github.com/atx/wtype) (optional, if you want to auto-type data)
- [wl-clipboard](https://github.com/bugaevc/wl-clipboard) (optional, if you want to copy data)
- [libnotify](https://gitlab.gnome.org/GNOME/libnotify) (optional, to send notifications about
  copied data and the timeout period after which the clipboard will be cleared)
- [pass-otp](https://github.com/tadfisher/pass-otp) (optional, to generate TOTP/HOTP)
- [xdg-utils](https://www.freedesktop.org/wiki/Software/xdg-utils/) (optional, to open URLs)
- [scdoc](https://git.sr.ht/~sircmpwn/scdoc) (optional, to build the man page)

### Arch Linux

`tessen` is available in the [Arch User Repository](https://aur.archlinux.org/packages/tessen/).

### Git Release

```
git clone https://github.com/ayushnix/tessen.git
cd tessen
sudo make install
```

You can also do `doas make install` if you're using [doas](https://github.com/Duncaen/OpenDoas) on
Linux, which you probably should.

### Stable Release

```
curl -LO https://github.com/ayushnix/tessen/releases/download/v2.0.1/tessen-2.0.1.tar.gz
tar xvzf tessen-2.0.1.tar.gz
cd tessen-2.0.1/
sudo make install
```

or, you know, `doas make install`.

### Optional Steps and Minimal Installation

There's an optional patch provided in the repository called `explicit_path.patch` which can be used
to change the shebang from `#!/usr/bin/env bash` to `#!/bin/bash`. It also exports `$PATH` to

```
/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
```

to prevent execution of arbitrary binaries not owned by the root user. If you want to apply this
patch, execute

```
patch -i explicit_path.patch tessen
```

before executing `sudo make install`. This patch should make `tessen` work fine on almost all Linux
distributions except perhaps NixOS and GuixSD.

If you don't want to build the man pages or install the shell completion files, you can use

```
sudo make minimal
```

to install the tessen script and nothing else. The man pages can be installed if needed using `sudo
make man`, the bash completion file can be installed using `sudo make bashcomp`, and the fish
completion file can be installed using `sudo make fishcomp`.

## Features

- autotype or copy (or both at the same time!) data, including all valid key-value pairs, in pass
  and gopass
- generate TOTP/HOTP
- open URLs
- use custom values for `user`, `password`, `url`, `autotype` keys
- use custom autotype operations
- use custom delay time for autotype

Please read the [man page](https://github.com/ayushnix/tessen/blob/master/man/tessen.1.scd) for more
information.

## Caveats :warning:

The reason why `tessen` offers flexibility between autotyping and copying data is because autotyping
may not always work accurately. There can be several reasons for this.

One of the reasons when autotype doesn't work is when a web page doesn't follow the standard
expectation of having a username and password text field one after the other and links are inserted
between them. A good example is the login popup offered by Discourse. In such cases, autotyping can
make a real mess. This is why `tessen` also provides an option to define custom autotype operations.

`tessen` uses [wtype](https://github.com/atx/wtype/) for autotyping and it seems to work fine on
Firefox. You'll need at least version [v0.4](https://github.com/atx/wtype/releases/tag/v0.4), or
later, of wtype for autotyping to work on Chromium. I haven't tested any other web browsers.

It seems like `wtype` uses the
[virtual-keyboard-unstable-v1](https://wayland.app/protocols/virtual-keyboard-unstable-v1) protocol
to emulate a virtual keyboard and [KDE
supports](https://invent.kde.org/plasma/kwin/-/issues/74#note_369803) the
[input-method-unstable-v2](https://wayland.app/protocols/input-method-unstable-v1) protocol. GNOME
seems to be doing its own thing with [libie](https://gitlab.gnome.org/GNOME/mutter/-/issues/1974).
There's also [ydotool](https://github.com/ReimuNotMoe/ydotool) which requires that users access
`/dev/uinput`, which is restricted to the root user.

I don't like this sort of fragmentation myself but if `tessen` ends up working on wlroots based
compositors and on KDE, I'd be satisfied with that. It looks like `wtype` [doesn't
use](https://github.com/atx/wtype/issues/5) the `input-method` protocol yet which restricts
autotyping to wlroots based compositors for now. While using `/dev/uinput` sounds like an attractive
option, I won't add support for it due to security concerns.

## What does `tessen` mean?

[Here](https://en.wikipedia.org/wiki/Japanese_war_fan) you go.

## Why did you choose this weird name?

Because obvious names like pass-fzf and pass-clip are already taken by other projects? Also, for
some reason, the way how bemenu and fuzzel's UI instantly opens up and displays relevant information
reminded me of Japanese hand fans. I guess I was thinking of some anime while coming up with this
name.

## Contributions

Please see [this](https://github.com/ayushnix/tessen/blob/master/CONTRIBUTING.md) file.

## Features that WON'T be implemented

- xorg/x11 support, use [rofi-pass](https://github.com/carnager/rofi-pass) or fork this repo and
  implement it yourself
- using [ydotool](https://github.com/ReimuNotMoe/ydotool), because it needs root access
- adding, editing, or removing existing password store data
- cache for storing frequently used password store selection data
- importing passwords or exporting them

## Donate

If you feel that this project helped you transition to wayland, please consider supporting me by
buying me a coffee :coffee:

<a href='https://www.buymeacoffee.com/ayushnix' target='_blank' rel="noopener"><img height='36' style='border:0px;height:36px;' src='https://cdn.buymeacoffee.com/buttons/default-blue.png' border='0' alt='Buy Me a Coffee at buymeacoffee.com' /></a>
<a href='https://ko-fi.com/O5O64SQ4C' target='_blank' rel="noopener"><img height='36' style='border:0px;height:36px;' src='https://cdn.ko-fi.com/cdn/kofi1.png?v=2' border='0' alt='Buy Me a Coffee at ko-fi.com' /></a>

If you're in India, you can also use UPI for donations. My UPI address is `ayushnix@ybl`.
