tessen(1)

# NAME

tessen - an interactive menu to autotype and copy pass(1) data

# SYNOPSIS

tessen [*-hv*] [*-b* dmenu_backend] [*-a* action]

# DESCRIPTION

tessen is a *bash*(1) script that helps interact with *pass*(1). It can autotype
and copy data from pass, open URLs, generate one-time passwords using
*pass-otp*(1), and execute custom auto-type operations.

tessen has been written to work on wayland compositors based on wlroots, such as
*sway*(1). It will not work on window managers and desktop environments using
the legacy X.Org display server.

The options understood by tessen are:

*-b*, *--backend*, *--backend=*[dmenu_backend]
	specify a dmenu like backend and (optionally) its flags

*-a*, *--action*, *--action=*[action]
	choose either *autotype*, *copy*, or *both*

*-t*, *--autotype-backend*, *--autotype-backend*=[backend]
	autotype backend, wtype and ydotool are supported (default: wtype)

*-h*, *--help*
	show a brief help message

*-v*, *--version*
	show the installed version number of tessen

## DEFAULT BEHAVIOR

If a backend is not specified, tessen tries to find either one of *bemenu*(1),
*fuzzel*(1), *rofi*(1), or *wofi*(1) in the order mentioned here. If rofi is
used, it is expected that the Wayland fork of rofi
_https://github.com/lbonn/rofi_ is being used. The original rofi
_https://github.com/davatorium/rofi_ implementation made for X.Org is NOT
supported.

If an action is not specified, tessen shows an additional menu with the option
to either autotype or copy data. If data is copied, it will be removed from the
clipboard after *PASSWORD_STORE_CLIP_TIME*. If this environment variable isn't
set, a default value of 10 seconds is used.

The default value of the backend can also be set using the *TESSEN_BACKEND*
environment variable. The default value of the action can be set using the
*TESSEN_ACTION* environment variable. Autotype action can be configured
by setting *TESSEN_AUTOTYPE_BACKEND* environment variable.

By default, tessen will keep a delay of 200 milliseconds when auto-typing data
using wtype(1). This can be changed using the *TESSEN_DELAY* environment
variable.

## DEPENDENCIES

tessen depends on

- *bash*(1)
- *pass*(1)
- a wayland native dmenu like backend such as *bemenu*(1) and *fuzzel*(1)
- *wtype*(1)
- *ydotool*(1) (optional), alternative auto-type backend
- *wl-clipboard*(1)
- *scdoc*(1) (optional, to build this man page)
- *libnotify* (optional, to use *notify-send*(1) for showing notifications)
- *pass-otp*(1) (optional, to generate one-time password tokens)
- *xdg-open*(1), provided by *xdg-utils* (optional, to open URLs)

## ADDITIONAL FEATURES

tessen assumes that the data organization format is the same as mentioned on
the home page of password store.

_https://www.passwordstore.org/#organization_

The first line should always have the password, and nothing else. All other
lines may have key-value pairs like 'key1: value1' or the *otpauth://* format
URI. However, if a key called 'password' is present, it will be ignored.

If a key called 'user' is present, its value will be the default username
instead of the basename of the selected file. This key can be modified using the
*TESSEN_USERKEY* environment variable. If entries in password store use
different keys for specifying user names regular expression can be used.

If a key called 'url' is present, an option to open the value of the 'url' key
in the default web browser will be shown instead of auto type. This becomes the
default behavior if *-a autotype* option is provided during the execution of
tessen. The 'url' key can be modified using the *TESSEN_URLKEY* environment
variable.

The *otpauth://* format is supported and used if pass-otp is installed.

A value for the 'autotype' key can be specified for custom auto-type behavior
which overrides the default behavior of auto-typing the username and the
password. For example,

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

When specified as a value of the 'autotype' key,

- *:tab* can be used to type the Tab key
- *:space* can be used to type the Space key
- *:enter* can be used to type the Enter key
- *:delay* can be used to delay the type operation by 1 second
- *:otp* can be used to generate and type the OTP, if *otpauth://* is present
- *user*, or the value of *TESSEN_USERKEY*, can be used to type the username
- *pass* or *password* can be used to type the password
- *path*, *basename*, or *filename* can be used to type the name of the
  selected file
- any other key, such as 'key1', can be specified to print its value

The value of the 'autotype' key can be modified using the *TESSEN_AUTOKEY*
environment variable.

# EXAMPLES

Find a dmenu-like backend and autotype or copy data:

	$ tessen

Use bemenu and autotype or copy data:

	$ tessen -b bemenu

Use bemenu but override default options and show 20 lines

	$ tessen -b 'bemenu -l 20'

Use bemenu and always autotype data:

	$ tessen -b bemenu -a autotype

Use bemenu and always copy data:

	$ tessen -b bemenu -a copy

Use bemenu and always autotype AND copy data simultaneously:

	$ tessen -b bemenu -a both

# ENVIRONMENT

*PASSWORD_STORE_DIR*
	The default location of the password store directory.

*PASSWORD_STORE_CLIP_TIME*
	The number of seconds after which the clipboard will be cleared.

*TESSEN_BACKEND*
	A wayland native dmenu like backend that should be used by tessen.
	Although tessen provides default options for bemenu, fuzzel, rofi, and
	wofi, any compatible backend may be used.

*TESSEN_ACTION*
	The default action of tessen. Choose either *autotype*, *copy*, or
	*both*.

*TESSEN_USERKEY*
	The key which specifies the username. By default, it is assumed to be
	*user*.

*TESSEN_URLKEY*
	The key which specifies the URL. By default, it is assumed to be *url*.

*TESSEN_AUTOKEY*
	The key which specifies the auto-type key. By default, it is assumed to
	be *autotype*.

*TESSEN_DELAY*
	The delay in milliseconds when auto-typing is done using wtype(1). By
	default, it is 200 milliseconds.

*BROWSER*
	The default web browser to use to open URLs. If xdg-open is installed,
	this variable isn't needed.

# SEE ALSO

*pass*(1), *pass-otp*(1), *bemenu*(1), *fuzzel*(1), *rofi*(1), *wofi*(1),
*wl-clipboard*(1), *wtype*(1), *notify-send*(1)

# AUTHORS

Maintained by Ayush Agarwal

The latest source can be found at _https://github.com/ayushnix/tessen_ and
bugs/patches/suggestions should be submitted there as well.
