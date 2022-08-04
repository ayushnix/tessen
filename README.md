## tessen

[![sourcehut](https://img.shields.io/badge/repository-sourcehut-lightgrey.svg?logo=data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZlcnNpb249IjEuMSINCiAgICB3aWR0aD0iMTI4IiBoZWlnaHQ9IjEyOCI+DQogIDxkZWZzPg0KICAgIDxmaWx0ZXIgaWQ9InNoYWRvdyIgeD0iLTEwJSIgeT0iLTEwJSIgd2lkdGg9IjEyNSUiIGhlaWdodD0iMTI1JSI+DQogICAgICA8ZmVEcm9wU2hhZG93IGR4PSIwIiBkeT0iMCIgc3RkRGV2aWF0aW9uPSIxLjUiDQogICAgICAgIGZsb29kLWNvbG9yPSJibGFjayIgLz4NCiAgICA8L2ZpbHRlcj4NCiAgICA8ZmlsdGVyIGlkPSJ0ZXh0LXNoYWRvdyIgeD0iLTEwJSIgeT0iLTEwJSIgd2lkdGg9IjEyNSUiIGhlaWdodD0iMTI1JSI+DQogICAgICA8ZmVEcm9wU2hhZG93IGR4PSIwIiBkeT0iMCIgc3RkRGV2aWF0aW9uPSIxLjUiDQogICAgICAgIGZsb29kLWNvbG9yPSIjQUFBIiAvPg0KICAgIDwvZmlsdGVyPg0KICA8L2RlZnM+DQogIDxjaXJjbGUgY3g9IjUwJSIgY3k9IjUwJSIgcj0iMzglIiBzdHJva2U9IndoaXRlIiBzdHJva2Utd2lkdGg9IjQlIg0KICAgIGZpbGw9Im5vbmUiIGZpbHRlcj0idXJsKCNzaGFkb3cpIiAvPg0KICA8Y2lyY2xlIGN4PSI1MCUiIGN5PSI1MCUiIHI9IjM4JSIgc3Ryb2tlPSJ3aGl0ZSIgc3Ryb2tlLXdpZHRoPSI0JSINCiAgICBmaWxsPSJub25lIiBmaWx0ZXI9InVybCgjc2hhZG93KSIgLz4NCjwvc3ZnPg0KCg==)](https://sr.ht/~ayushnix/tessen) [![Codeberg mirror](https://img.shields.io/badge/mirror-Codeberg-blue.svg?logo=codeberg)](https://codeberg.org/ayushnix/tessen) [![GitHub mirror](https://img.shields.io/badge/mirror-GitHub-black.svg?logo=github)](https://github.com/ayushnix/tessen)

`tessen` is a bash script that can autotype and copy data from [password-store][1] and [gopass][2]
files. A wayland native dmenu is required to use tessen and the following dmenu backends are
recognized

- [rofi][3]
- [fuzzel][4]
- [tofi][15]
- [bemenu][5]
- [wofi][6]

If you want to add another Wayland native dmenu not mentioned above, please see the
[CONTRIBUTING.md][7] file for information about how to contribute to `tessen`.

`tessen` is written to work only on wayland wlroots compositors such as [sway][8]. If you'd rather
use a fuzzy data selection program like [fzf][9] to copy your password-store data on both Xorg/X11
and Wayland, check out [pass-tessen][10].

### Why use `tessen`?

- `tessen` can autotype or copy (or do both at the same time!) your password store and gopass data
  including all of your key-value pair data

  From what I've observed, most scripts out there do not autotype and copy all of your key-value
  pair data. They also do not offer choices about autotyping or copying data with the same
  flexibility as `tessen` does.

  Although [rofi-pass][11] is a good alternative, it only works on Xorg/X11. `tessen` is made to
  work on Wayland.

- if you're using a web browser extension to access your passwords, you may wanna read an [article
  by Tavis Ormandy on Password Managers][12]

- `tessen` does not use any external programs unless absolutely necessary. This means that `tessen`
  doesn't need programs like `sed`, `awk`, `tr`, `cut`, `find`, `sort`, `head`, `tail` (although
  password-store needs them).

- the code is linted using [shellcheck][13] and formatted using [shfmt][14]. I've also tried to
  ensure that `tessen` doesn't leak any sensitive data. Please raise an issue or a pull request if
  you can make tessen more minimalistic or secure.

## Installation

### Dependencies

- [bash][16]

- at least one pass backend is needed - either [password-store][1] or [gopass][2]

- at least one Wayland native dmenu backend - [rofi][3], [fuzzel][4], [tofi][15], [bemenu][5], or
  [wofi][6]

- at least one (or both if needed) action backend - [wtype][17] or [wl-clipboard][18]

- [libnotify][19] (optional, to send notifications about copied data and the timeout period after
  which the clipboard will be cleared)

- [pass-otp][20] (optional, to generate TOTP/HOTP when using `pass`)

- [xdg-utils][21] (optional, to open URLs in the default web browser)

- [scdoc][22] (optional, to build the man page)

### Arch Linux

`tessen` is available in the [Arch User Repository][23].

### GNU Guix

`tessen` is available in the [official GNU Guix repository][24].

### Git Release

```
git clone https://git.sr.ht/~ayushnix/tessen
cd tessen
sudo make install
```

You can also do `doas make install` if you're using [doas][25] on Linux, which you probably should.

### Stable Release

```
curl -LO https://git.sr.ht/~ayushnix/tessen/refs/download/v2.1.2/tessen-2.1.2.tar.gz
tar xvzf tessen-2.1.2.tar.gz
cd tessen-2.1.2/
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

Please read the [man page][26] for more information.

## Caveats

The reason why `tessen` offers flexibility between autotyping and copying data is because autotyping
may not always work accurately. There can be several reasons for this.

One of the reasons when autotype doesn't work is when a web page doesn't follow the standard
expectation of having a username and password text field one after the other and links are inserted
between them. A good example is the login popup offered by Discourse. In such cases, autotyping can
make a real mess. This is why `tessen` also provides an option to define custom autotype operations.

`tessen` uses [wtype][17] for autotyping and it seems to work fine on Firefox. You'll need at least
version [v0.4][27], or later, of wtype for autotyping to work on Chromium although I've experienced
issues on some websites when autotyping on Chromium using `wtype`. I haven't tested any other web
browsers.

It also seems like autotyping on Wayland is in somewhat of a mess right now. An issue tracker on the
the wayland-protocols repository by Roman Gilg titled [Input Method Hub][28] presents an overview on
the state of things. As of [version 1.7 of sway][8], the `input-method-unstable-v2.xml` protocol and
the `virtual-keyboard-unstable-v1.xml` protocol (which is what `wtype` implements) are supported.
There's [ydotool][30] but it requires root access to access `/dev/uinput`, which makes it
unattractive.

## What does `tessen` mean?

[Here you go.][31]

## Why did you choose this weird name?

Because obvious names like pass-fzf and pass-clip are already taken by other projects? Also, for
some reason, the way how bemenu and fuzzel's UI instantly opens up and displays relevant information
reminded me of Japanese hand fans. I guess I was thinking of some anime while coming up with this
name.

## Contributions

Please see the [CONTRIBUTING.md file.][7]

## Features that WILL NOT be implemented

- Xorg/X11 support

  either use [rofi-pass][11] or fork this repository and implement it yourself

- using [ydotool][30], because it needs root access

- adding, editing, or removing existing password store data

- cache for storing frequently used password store selection data

- importing passwords or exporting them

## Donate

If you feel that this project helped you transition to Wayland, please consider supporting me by
buying me a coffee.

<a href='https://ko-fi.com/O5O64SQ4C' target='_blank' rel='noopener'><img height='36' style='border: 0;' src='https://cdn.ko-fi.com/cdn/kofi5.png?v=3' alt='Buy Me a Coffee at https://ko-fi.com/O5O64SQ4C'></a>
<a href='https://www.buymeacoffee.com/ayushnix' target='_blank' rel='noopener'><img height='36' style='border: 0;' src='https://cdn.buymeacoffee.com/buttons/default-blue.png' alt='Buy Me a Coffee at https://www.buymeacoffee.com/ayushnix'></a>

If you're in India, you can also use UPI for donations. My UPI address is `ayushnix@ybl`.
Alternatively, scan this QR code in a UPI application.

<img alt="ayushnix@ybl - ayushnix UPI address" src="https://git.sr.ht/~ayushnix/tessen/blob/master/ayushnix-upi.png" width="128" height="128">

[1]: https://git.zx2c4.com/password-store/
[2]: https://github.com/gopasspw/gopass
[3]: https://github.com/lbonn/rofi
[4]: https://codeberg.org/dnkl/fuzzel
[5]: https://github.com/Cloudef/bemenu
[6]: https://hg.sr.ht/~scoopta/wofi
[7]: https://git.sr.ht/~ayushnix/tessen/tree/master/item/CONTRIBUTING.md
[8]: https://swaywm.org/
[9]: https://github.com/junegunn/fzf
[10]: https://sr.ht/~ayushnix/pass-tessen
[11]: https://github.com/carnager/rofi-pass
[12]: https://cmpxchg8b.com/passmgrs.html
[13]: https://github.com/koalaman/shellcheck
[14]: https://github.com/mvdan/sh
[15]: https://github.com/philj56/tofi
[16]: https://www.gnu.org/software/bash/
[17]: https://github.com/atx/wtype
[18]: https://github.com/bugaevc/wl-clipboard
[19]: https://gitlab.gnome.org/GNOME/libnotify
[20]: https://github.com/tadfisher/pass-otp
[21]: https://www.freedesktop.org/wiki/Software/xdg-utils/
[22]: https://git.sr.ht/~sircmpwn/scdoc
[23]: https://aur.archlinux.org/packages/tessen/
[24]: https://guix.gnu.org/en/packages/tessen-2.1.0/
[25]: https://github.com/Duncaen/OpenDoas
[26]: https://git.sr.ht/~ayushnix/tessen/tree/master/item/man/tessen.1.scd
[27]: https://github.com/atx/wtype/releases/tag/v0.4
[28]: https://gitlab.freedesktop.org/wayland/wayland-protocols/-/issues/39
[29]: https://github.com/swaywm/sway/releases/tag/1.7
[30]: https://github.com/ReimuNotMoe/ydotool
[31]: https://en.wikipedia.org/wiki/Japanese_war_fan
