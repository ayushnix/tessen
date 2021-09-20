## tessen

A bash script that uses either [bemenu](https://github.com/Cloudef/bemenu) or
[rofi](https://github.com/lbonn/rofi) as an interface for auto-typing and copying [password
store](https://www.passwordstore.org/) data.

`tessen` is written to work only on Wayland.

If you'd rather use [fzf](https://github.com/junegunn/fzf) to copy your password-store data on both
Xorg/X11 and Wayland, check out [pass-tessen](https://github.com/ayushnix/pass-tessen).

## Installation

### Dependencies

- [pass](https://git.zx2c4.com/password-store/)
- either [bemenu](https://github.com/Cloudef/bemenu) or [rofi](https://github.com/lbonn/rofi)
- [wtype](https://github.com/atx/wtype) (if you want to auto-type data)
- [wl-clipboard](https://github.com/bugaevc/wl-clipboard) or
  [wl-clipboard-rs](https://github.com/YaLTeR/wl-clipboard-rs) (if you want to copy data)
- [libnotify](https://gitlab.gnome.org/GNOME/libnotify) (to send notifications about copied data)

### Arch Linux

`tessen` is available in the [Arch User Repository](https://aur.archlinux.org/packages/tessen/).

### Git Release

```
git clone https://github.com/ayushnix/tessen.git
cd pass-tessen
sudo make install
```

You can also do `doas make install` if you're using [doas](https://github.com/Duncaen/OpenDoas),
which you probably should.

### Stable Release

```
wget https://github.com/ayushnix/tessen/releases/download/v1.0.0/tessen-1.0.0.tar.gz
tar xvzf tessen-1.0.0.tar.gz
cd tessen-1.0.0
sudo make install
```

or, you know, `doas make install`.

## Usage

```
tessen - autotype and copy data from password-store on wayland

Usage: tessen [options]

  tessen                        use bemenu and either autotype OR copy data
  tessen -b rofi                use rofi and either autotype OR copy data
  tessen -b rofi -a autotype    use rofi and always autotype data
  tessen -b rofi -a copy        use rofi and always copy data
  tessen -b rofi -a both        use rofi and always autotype AND copy data

  -b, --backend, --backend=     choose 'bemenu' or 'rofi' as backend (default: bemenu)
  -a, --action, --action=       choose one of 'autotype|copy|both'
  -h, --help                    print this help menu
  -v, --version                 print the version of tessen
```

## Why should I use `tessen`?

- `tessen` can autotype or copy (or, do both at the same time!) your password store data including
  all of your key-value pair data, not just besides passwords

  From what I've observed as of this commit, most scripts out there do not autotype and copy all of
  your key-value pair data. They also do not offer choices about autotyping or copying data with the
  same flexibility as `tessen` does.

  Although [rofi-pass](https://github.com/carnager/rofi-pass) is a good alternative, it only works
  on Xorg/X11. `tessen` is made to work on Wayland.

- `tessen` tries to minimize the number of external binaries used in the script for speed and
  efficiency. Besides the dependencies mentioned above, `tessen` doesn't use programs like `sed`,
  `awk`, `tr`, `cut`, `find`, `sort`, `head`, `tail`, and other GNU coreutils, often used casually
  by people when writing shell scripts

- the code is linted using [shellcheck](https://github.com/koalaman/shellcheck) and formatted using
  [shfmt](https://github.com/mvdan/sh)

- focuses on minimalism and security (please let me know if you have any suggestions for
  improvement)

## Caveats :warning:

The reason why `tessen` offers flexibility between autotyping and copying data is because autotyping
may not always work accurately. There can be several reasons for this.

One of the reasons when autotype doesn't work is when a web page doesn't follow the standard
expectation of having a username and password text field just after the other and links are insert
between them. In such cases, autotyping can make a real mess.

Autotyping also does not work on Chromium based browsers on Wayland when using
[v0.3](https://github.com/atx/wtype/releases/tag/v0.3) release of `wtype`. However, it works fine on
Firefox. This issue might've been fixed in
[this](https://github.com/atx/wtype/commit/a81540b7d4920566ad271236ca88befc0002b462) commit.

## Assumptions

`tessen` works under several assumptions and tries to fail gracefully if they are not met. Please
report any unexpected behavior.

The data organization format is assumed to be the same as mentioned on this
[page](https://www.passwordstore.org/). If valid key-value pairs aren't found, `tessen` will not
show them.

It is assumed that the name of the file itself is the username. For example, if you have a file
`bank/mybankusername.gpg` in your password store, the assumed default username is `mybankusername`.
However, if a valid username key value pair is present inside the file, `tessen` will show them for
selection as well.

If there are multiple non-unique keys, the value of the last key will be considered.

## What does `tessen` mean?

[Here](https://en.wikipedia.org/wiki/Japanese_war_fan) you go.

## Why did you choose this weird name?

Because obvious names like pass-fzf and pass-clip are already taken by other projects? Also, for
some reason, the way how FZF's UI instantly opens up and displays relevant information reminded me
of Japanese hand fans. I guess I was thinking of some anime while coming up with this name.

## Contributions

Please see [this](https://github.com/ayushnix/tessen/blob/master/CONTRIBUTING.md) file.

## Features that WON'T be implemented

- xorg/x11 support, use [rofi-pass](https://github.com/carnager/rofi-pass) or fork this repo and
  implement it yourself
- using [ydotool](https://github.com/ReimuNotMoe/ydotool), because it needs root access
