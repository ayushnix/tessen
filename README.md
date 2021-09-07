# tessen

A bash script for Wayland that presents an interactive menu to copy and auto-type
[password store](https://www.passwordstore.org/) data.

:warning: This script is a work in progress. For now, it should not be relied upon for using your
password store.

`tessen` relies on one of the following tools -

- [bemenu](https://github.com/Cloudef/bemenu)
- [rofi](https://github.com/lbonn/rofi)
- [fzf](https://github.com/junegunn/fzf)

Additionally, if you want to auto-type password store data, you'll need
[wtype](https://github.com/atx/wtype).

`tessen` also uses the `notify-send` command from the
[libnotify](https://gitlab.gnome.org/GNOME/libnotify) package to send notifications when
password-data is copied to the clipboard and after how much time will the clipboard be cleared.

## Caveats :warning:

Although bemenu and rofi work fine, fzf doesn't work as expected when calling `tessen` from a
terminal popup window using `exec $TERMINAL -e tessen`. I've tried to make this work but I couldn't
figure out how to and I didn't wanna rely sway specific hacks like
[this](https://github.com/FunctionalHacker/fzf-pass/blob/master/fzf-pass#L24). Pull requests are
welcome to fix this issue with the fzf backend.

I've also observed that auto-typing using `wtype` isn't really accurate. From what I've tested,
Firefox works mostly fine with `wtype` but Chromium doesn't. Even if you do use Firefox, auto-type
must be done with care because some web pages don't follow the standard convention of having a
username and password text field just after another and insert links between them. In such cases,
auto-type can't work as expected.

Using [ydotool](https://github.com/ReimuNotMoe/ydotool) will not be supported because it needs root
access and I'd rather avoid yet another daemon on my system running with root privileges. Feel free
to fork this script and use ydotool if you want.

## Assumptions

`tessen` works on several assumptions and tries to fail if they are not met. Please report any
unexpected behavior.

A password store gpg encrypted file should be in the following format -

```
12o423asef0912`1!@#12-`4a`
User Name: ayushnix
Profile Password 1: 1231bnga--312ob
Profile-Password-2: asdf-123-3012
Profile_Password_3: f=211n2r1=-12-31
```

The first line should be the password.

The keys in additional lines can have alphanumerics, spaces, hyphen, and underscore. The
corresponding values can have arbitrary data.  There should be a space between `key:` and `value`.
The result should be `key:<space>value`.

It is assumed that the file name is the username but one can still select a custom username key
value pair from the selection menu. For example, if the file is `bank/mybankusername.gpg`, the
assumed default username is `mybankusername`.

If there are non-unique keys, the value of the last key will be considered.

## TODO

- implement traps to catch errors and do cleanup
- find a decent alternative for [libnotify](https://gitlab.gnome.org/GNOME/libnotify) if possible
- review the script for any security flaws
