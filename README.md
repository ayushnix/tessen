## tessen

A bash script that can use [bemenu](https://github.com/Cloudef/bemenu),
[rofi](https://github.com/lbonn/rofi), or [wofi](https://hg.sr.ht/~scoopta/wofi) as an interface for
auto-typing and copying [password store](https://www.passwordstore.org/) data.

`tessen` is written to work only on Wayland.

If you'd rather use [fzf](https://github.com/junegunn/fzf) to copy your password-store data on both
Xorg/X11 and Wayland, check out [pass-tessen](https://github.com/ayushnix/pass-tessen).

### Why use `tessen`?

- `tessen` can autotype or copy (or, do both at the same time!) your password store data including
  all of your key-value pair data, besides the password

  From what I've observed as of this commit, most scripts out there do not autotype and copy all of
  your key-value pair data. They also do not offer choices about autotyping or copying data with the
  same flexibility as `tessen` does.

  Although [rofi-pass](https://github.com/carnager/rofi-pass) is a good alternative, it only works
  on Xorg/X11. `tessen` is made to work on Wayland.

- `tessen` tries to minimize the number of external binaries used in the script for speed and
  efficiency. Besides the dependencies mentioned above, `tessen` doesn't use programs like `sed`,
  `awk`, `tr`, `cut`, `find`, `sort`, `head`, `tail`, and other GNU coreutils, often used casually
  when writing shell scripts

- the code is linted using [shellcheck](https://github.com/koalaman/shellcheck) and formatted using
  [shfmt](https://github.com/mvdan/sh)

- focuses on minimalism and security (please let me know if you have any suggestions for
  improvement)

## Installation

### Dependencies

- [bash](https://www.gnu.org/software/bash/)
- [pass](https://git.zx2c4.com/password-store/)
- either one of [bemenu](https://github.com/Cloudef/bemenu), [rofi](https://github.com/lbonn/rofi),
  [wofi](https://hg.sr.ht/~scoopta/wofi)
- [wtype](https://github.com/atx/wtype) (if you want to auto-type data)
- [wl-clipboard](https://github.com/bugaevc/wl-clipboard) or
  [wl-clipboard-rs](https://github.com/YaLTeR/wl-clipboard-rs) (if you want to copy data)
- [libnotify](https://gitlab.gnome.org/GNOME/libnotify) (optional, to send notifications about
  copied data)
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
wget https://github.com/ayushnix/tessen/releases/download/v1.2.0/tessen-1.2.0.tar.gz
tar xvzf tessen-1.2.0.tar.gz
cd tessen-1.2.0
sudo make install
```

or, you know, `doas make install`.

## Usage

### Default Behavior

If a backend is not specified, tessen tries to find bemenu, rofi, and wofi in the order mentioned
here. If rofi is used, it is expected that the [Wayland fork of rofi](https://github.com/lbonn/rofi)
is being used. The [original rofi](https://github.com/davatorium/rofi) implementation made for X.Org
is NOT supported.

If an action is not specified, tessen shows an additional menu with the option to either autotype or
copy data.

The default value of the backend can also be set using the `TESSEN_BACKEND` environment variable.
The default value of the action can be set using the `TESSEN_ACTION` environment variable.

By default, tessen will keep a delay of 200 milliseconds when auto-typing data using wtype. This
can be changed using the `TESSEN_DELAY` environment variable.

### Additional Features

**tessen** assumes that the data organization format is the same as mentioned on the [home page of
password store](https://www.passwordstore.org/#organization).

The first line should always have the password, and nothing else. All other lines may have key-value
pairs like `key1: value1` or the `otpauth://` format URI. However, if a key called `password` is
present, it will be ignored.

If a key called `user` is present, it's value will be the default username instead of the basename
of the selected file. This key can be modified using the `TESSEN_USERKEY` environment variable.

If a key called `url` is present, an option to open the value of the `url` key in the default web
browser will be shown instead of auto type. This becomes the default behavior if `-a autotype`
option is provided during the execution of tessen. The `url` key can be modified using the
`TESSEN_URLKEY` environment variable.

The `otpauth://` format is supported and used if pass-otp is installed.

A value for the `autotype` key can be specified for custom auto-type behavior which overrides the
default behavior of auto-typing the username and the password. For example,

```
$ pass example/john
mypassword
key1: value1
key2: value2
key3: value3
key4: value4
otpauth://totp/ACME%20Co:john@example.com?secret=HXDMVJECJJWSRB3HWIZR4IF...
autotype: key1 :tab key2 :space key3 :enter key4 :delay :tab :otp pass :space path
```

When the default auto-type option is used, an output similar to what is shown
below will be auto-typed:

```
value1 <Tab> value2 <space> value3 <Return> value4 <delay for 1 sec> 384534 mypassword
```

When specified as a value of the `autotype` key,

- `:tab` can be used to type the Tab key
- `:space` can be used to type the Space key
- `:enter` can be used to type the Enter key
- `:delay` can be used to delay the type operation by 1 second
- `:otp` can be used to generate and type the OTP, if `otpauth://` is present
- `user`, or the value of `TESSEN_USERKEY`, can be used to type the username
- `pass` or `password` can be used to type the password
- `path`, `basename`, or `filename` can be used to type the name of the
  selected file
- any other key, such as `key1`, can be specified to print its value

The value of the `autotype` key can be modified using the `TESSEN_AUTOKEY`
environment variable.

### Environment Variables

`PASSWORD_STORE_DIR`

The default location of the password store directory.

`PASSWORD_STORE_CLIP_TIME`

The number of seconds after which the clipboard will be cleared.

`TESSEN_BACKEND`

The default dmenu like backend used by tessen. Choose either `bemenu`, the wayland fork of `rofi` by
lbonn on GitHub, or `wofi`.

`TESSEN_ACTION`

The default action of tessen. Choose either `autotype`, `copy`, or `both`.

`TESSEN_USERKEY`

The key which specifies the username. By default, it is assumed to be `user`.

`TESSEN_URLKEY`

The key which specifies the URL. By default, it is assumed to be `url`.

`TESSEN_AUTOKEY`

The key which specifies the auto-type key. By default, it is assumed to be `autotype`.

`TESSEN_DELAY`

The delay in milliseconds when auto-typing is done using wtype. By default, it is 200
milliseconds.

`BROWSER`

The default web browser to use to open URLs. If `xdg-open` is installed, this variable isn't needed.

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
- adding, editing, or removing existing password store data
- cache for storing frequently used password store selection data
- importing passwords or exporting them
