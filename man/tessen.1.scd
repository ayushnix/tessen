tessen(1)

# NAME

tessen - autotype and copy *pass*(1) and *gopass*(1) data on wayland

# SYNOPSIS

tessen [*-hv*] [*-p* pass backend] [*-d* dmenu backend] [*-a* action] [*-c* config file]

# DESCRIPTION

tessen is a *bash*(1) script that helps to autotype and copy data encrypted
using *pass*(1) and *gopass*(1). It can also open URLs, generate HOTP and TOTP,
and execute custom autotype operations.

tessen has been written for wayland compositors like *sway*(1) and it will NOT
work on window managers and desktop environments based on X.Org/X11.

The options understood by tessen are:

*-p*, *--pass*, *--pass=*[pass backend]
	specify either *pass* or *gopass*

*-d*, *--dmenu*, *--dmenu=*[dmenu backend]
	specify a dmenu backend - the list of recognized backends are *rofi*,
	*fuzzel*, *bemenu*, *wofi*, and *dmenu*

*-a*, *--action*, *--action=*[action]
	specify either *autotype*, *copy*, or *both*

*-c*, *--config*, *--config=*[location of config file]
	specify the location of the config file for *tessen*(5)

*-h*, *--help*
	show a brief help message

*-v*, *--version*
	show the installed version number of tessen

## DEFAULT BEHAVIOR

If a pass backend is not specified, tessen tries to find either one of *pass*(1)
or *gopass*(1) in the order mentioned here.

tessen assumes that the data organization format is the same as mentioned on
the home page of password store, when using *pass*(1) and *gopass*(1)

https://www.passwordstore.org/#organization

The first line should always have the password, and nothing else. All other
lines may have key-value pairs like 'key1: value1' or the *otpauth://* format
URI. However, if a key called 'password' is present, it will be ignored. Note
that tessen does NOT support parsing YAML files when using *gopass*(1).

If a dmenu backend is not specified, tessen tries to find either one of
*rofi*(1), *fuzzel*(1), *bemenu*(1), *wofi*(1), or *dmenu* in the order
mentioned here. If *rofi* is used, it is expected that the wayland native fork
of rofi (https://github.com/lbonn/rofi) is being used. The original rofi
(https://github.com/davatorium/rofi) implementation made for X.Org is NOT
supported.

If an action is not specified, tessen shows an additional menu with the option
to either autotype or copy data.

If data is copied, it will be removed from the clipboard after
*PASSWORD_STORE_CLIP_TIME* when using *pass*(1) and after *cliptimeout* when
using *gopass*(1). If *PASSWORD_STORE_CLIP_TIME* is not set, a default value of
15 seconds is assumed.

A delay of 100 milliseconds will be used between successive autotype operations.
This can be changed using the 'delay' option in the *tessen*(5) configuration
file.

tessen will look for a configuration file in *$XDG_CONFIG_HOME/tessen/config*
and *$HOME/.config/tessen/config*. A custom location can be specified using the
*-c* flag.

Command line flags have the highest preference and supersede equivalent options
set in the config file.

## DEPENDENCIES

tessen depends on

- *bash*(1)
- at least one wayland native dmenu backend - *rofi*(1), *fuzzel*(1),
  *bemenu*(1), *wofi*(1), *dmenu*
- at least one pass backend - either *pass*(1) or *gopass*(1)
- *wtype*(1) (if you want to autotype data)
- *wl-clipboard*(1) (if you want to copy and paste data)
- *scdoc*(1) (optional, to build this man page)
- *libnotify* (optional, to use *notify-send*(1) for showing notifications about
  copied data and the timeout for clearing the clipboard)
- *pass-otp*(1) (optional, to generate HOTP/TOTP when using *pass*(1))
- *xdg-utils* (optional, if you want to use *xdg-open*(1) to open URLs)

## ADDITIONAL FEATURES

If a key called 'user' is present inside a password file, its value will be the
default username instead of the basename of the selected file. This key can be
modified using the 'userkey' variable in the *tessen*(5) configuration file.

If a key called 'url' is present, an option to open the value of the 'url' key
in the default web browser will be shown instead of auto type. This becomes the
default behavior if *-a autotype* option is provided during the execution of
tessen. The 'url' key can be modified using the 'urlkey' variable in the
*tessen*(5) config file.

The *otpauth://* format is supported and used if *pass-otp*(1) is installed when
using *pass*(1). *gopass*(1) supports this feature natively.

A value for the 'autotype' key can be specified in password files for custom
autotype behavior which overrides the default behavior of autotyping the
username and the password. For example,

```
$ pass example/john
mypassword
key1: value1
key2: value2
key3: value3
key4: value4
otpauth://totp/ACME%20Co:john@example.com?secret=HXDMVJECJJWSRB3HWIZR4IF...
autotype: key1 :tab key2 :space key3 :enter key4 :delay :tab :otp pass
```

When specified as a value of the 'autotype' key,

- *:tab* can be used to type the Tab key
- *:space* can be used to type the Space key
- *:enter* can be used to type the Enter key
- *:delay* can be used to delay the type operation by 1 second
- *:otp* can be used to generate and type the OTP, if *otpauth://* is present
- *user*, or the value of *user* in the config file, can be used to type the
  username
- *pass* or *password* can be used to type the password
- *path*, *basename*, or *filename* can be used to type the name of the
  selected file
- any other key, such as 'key1', can be specified to print its value

The 'autotype' key can be changed using the 'autotype_key' variable in the
*tessen*(5) configuration file.

# FILES

_$XDG_CONFIG_HOME/tessen/config_, _$HOME/.config/tessen/config_
	The default configuration file for tessen. It can be used to specify all
	the options provided by the command line flags and additional
	customization options for keys interpreted by tessen.

# SEE ALSO

*tessen*(5), *pass*(1), *gopass*(1) *pass-otp*(1), *rofi*(1), *fuzzel*(1),
*bemenu*(1), *wofi*(1), *wl-clipboard*(1), *wtype*(1), *notify-send*(1)

# AUTHORS

Developed and Maintained by Ayush Agarwal <ayushnix at fastmail dot com>.

The latest source can be found at https://sr.ht/~ayushnix/tessen and
bugs/patches/suggestions should be reported there as well.
