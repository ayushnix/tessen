## tessen

`tessen` is a bash script that can use any wayland native dmenu-like backend as an interface for
auto-typing and copying [password-store](https://git.zx2c4.com/password-store/) data. The list of
backends known to work with `tessen` are

- [bemenu](https://github.com/Cloudef/bemenu)
- [fuzzel](https://codeberg.org/dnkl/fuzzel)
- [rofi](https://github.com/lbonn/rofi)
- [wofi](https://hg.sr.ht/~scoopta/wofi)

`tessen` is written to work only on wayland compositors such as [sway](https://swaywm.org/). If
you'd rather use [fzf](https://github.com/junegunn/fzf) to copy your password-store data on both
xorg/x11 and wayland, check out [pass-tessen](https://github.com/ayushnix/pass-tessen).

### Why use `tessen`?

- `tessen` can autotype or copy (or do both at the same time!) your password store data including
  all of your key-value pair data

  From what I've observed as of this commit, most scripts out there do not autotype and copy all of
  your key-value pair data. They also do not offer choices about autotyping or copying data with the
  same flexibility as `tessen` does.

  Although [rofi-pass](https://github.com/carnager/rofi-pass) is a good alternative, it only works
  on xorg/x11. `tessen` is made to work on wayland.

- `tessen` does not use any external programs unless they are needed. This means that `tessen`
  doesn't need programs like `sed`, `awk`, `tr`, `cut`, `find`, `sort`, `head`, `tail`. This ensures
  that `tessen` isn't dependent on the subtle differences between GNU, BSD, and busybox coreutils.

- the code is linted using [shellcheck](https://github.com/koalaman/shellcheck) and formatted using
  [shfmt](https://github.com/mvdan/sh). I've also tried to ensure that `tessen` doesn't leak any
  sensitive data. Please raise an issue or a pull request if you can make tessen more minimalistic
  or secure.

## Installation

### Dependencies

- [bash](https://www.gnu.org/software/bash/)
- [pass](https://git.zx2c4.com/password-store/)
- a wayland native dmenu-like backend such as [bemenu](https://github.com/Cloudef/bemenu),
  [fuzzel](https://codeberg.org/dnkl/fuzzel), [rofi](https://github.com/lbonn/rofi),
  [wofi](https://hg.sr.ht/~scoopta/wofi)
- [wtype](https://github.com/atx/wtype) (optional, if you want to auto-type data)
- [wl-clipboard](https://github.com/bugaevc/wl-clipboard) or
  [wl-clipboard-rs](https://github.com/YaLTeR/wl-clipboard-rs) (optional, if you want to copy data)
- [libnotify](https://gitlab.gnome.org/GNOME/libnotify) (optional, to send notifications about
  copied data)
- [pass-otp](https://github.com/tadfisher/pass-otp) (optional, to generate OTP)
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

You can also do `doas make install` if you're using [doas](https://github.com/Duncaen/OpenDoas),
which you probably should.

### Stable Release

```
wget https://github.com/ayushnix/tessen/releases/download/v1.3.0/tessen-1.3.0.tar.gz
tar xvzf tessen-1.3.0.tar.gz
cd tessen-1.3.0
sudo make install
```

or, you know, `doas make install`.

## Features

- autotype or copy (or both at the same time!) data, including all valid key-value pairs, in pass
- generate OTPs using pass-otp
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
between them. A good example is Discourse forums. In such cases, autotyping can make a real mess.
This is why `tessen` also provides an option to define custom autotype operations.

I haven't been able to make autotyping work on Chromium on Wayland using
[v0.3](https://github.com/atx/wtype/releases/tag/v0.3) of `wtype`. However, it works fine on
Firefox. This issue might've been fixed in
[this](https://github.com/atx/wtype/commit/a81540b7d4920566ad271236ca88befc0002b462) commit but the
author hasn't released a new version yet.

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
