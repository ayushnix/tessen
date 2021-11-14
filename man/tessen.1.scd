tessen(1)

# NAME

tessen - an interactive menu to autotype and copy pass(1) data

# SYNOPSIS

tessen [*-hv*] [*-b* dmenu_backend] [*-a* action]

# DESCRIPTION

tessen is a bash(1) script that helps interact with pass(1). It can autotype
and copy data from pass(1), open URLs, generate one-time passwords using
pass-otp(1), and execute custom auto-type operations.

tessen has been written to work on Wayland compositors, such as sway(1). It
will NOT work on window managers and desktop environments using the legacy
X.Org display server.

The options understood by tessen are as follows:

*-b*, *--backend*, *--backend=*[dmenu_backend]
	choose either *bemenu*, *rofi* or *wofi*

*-a*, *--action*, *--action=*[action]
	choose either *autotype*, *copy*, or *both*

*-h*, *--help*
	show a brief help message

*-v*, *--version*
	show the installed version number of tessen

## DEFAULT BEHAVIOR

If a backend is not specified, tessen tries to find bemenu(1), rofi(1), and
wofi(1) in the order mentioned here. If rofi(1) is used, it is expected that
the Wayland fork of rofi(1) _https://github.com/lbonn/rofi_ is being used. The
original rofi(1) _https://github.com/davatorium/rofi_ implementation made for
X.Org is NOT supported.

If an action is not specified, tessen shows an additional menu with the option
to either autotype or copy data.

The default value of the backend can also be set using the *TESSEN_BACKEND*
environment variable. The default value of the action can be set using the
*TESSEN_ACTION* environment variable.

By default, tessen will keep a delay of 200 milliseconds when auto-typing data
using wtype(1). This can be changed using the *TESSEN_DELAY* environment
variable.

## DEPENDENCIES

tessen depends on

- bash(1)
- pass(1)
- a dmenu like backend interface such as bemenu(1), rofi(1), or wofi(1)
- wtype(1)
- wl-clipboard(1)
- scdoc(1) (optional, make dependency to build this man page)
- libnotify (optional, if you want to use notify-send(1) to show notifications
  when copying data)
- xdg-open(1), provided by xdg-utils (optional, if you want to open URLs)

## ADDITIONAL FEATURES

tessen assumes that the data organization format is the same as mentioned on
the home page of password store.

_https://www.passwordstore.org/#organization_

The first line should always have the password, and nothing else. All other
lines may have key-value pairs like 'key1: value1' or the *otpauth://* format
URI. However, if a key called 'password' is present, it will be ignored.

If a key called *user* is present, it's value will be the default username
instead of the basename of the selected file. This key can be modified using
the *TESSEN_USERKEY* environment variable.

If a key called *url* is present, an option to open the value of the *url* key
in the default web browser will be shown instead of auto type. This becomes the
default behavior if *-a autotype* option is provided during the execution of
tessen. The *url* key can be modified using the *TESSEN_URLKEY* environment
variable.

The *otpauth://* format is supported and used if pass-otp(1) is installed.

A value for the *autotype* key can be specified for custom auto-type behavior
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

When specified as a value of the *autotype* key,

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

The value of the *autotype* key can be modified using the *TESSEN_AUTOKEY*
environment variable.

# EXAMPLES

Find a dmenu-like backend and autotype or copy data:

	$ tessen

Use bemenu(1) and autotype or copy data:

	$ tessen -b bemenu

Use bemenu(1) and always autotype data:

	$ tessen -b bemenu -a autotype

Use bemenu(1) and always copy data:

	$ tessen -b bemenu -a copy

Use bemenu(1) and always autotype AND copy data simultaneously:

	$ tessen -b bemenu -a both

# ENVIRONMENT

*PASSWORD_STORE_DIR*
	The default location of the password store directory.

*PASSWORD_STORE_CLIP_TIME*
	The number of seconds after which the clipboard will be cleared.

*TESSEN_BACKEND*
	The default dmenu like backend used by tessen. Choose either *bemenu*,
	the wayland fork of *rofi* by lbonn on GitHub, or *wofi*.

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

pass(1), pass-otp(1), bemenu(1), rofi(1), wofi(1), wl-clipboard(1), wtype(1),
notify-send(1)

# AUTHORS

Maintained by Ayush Agarwal

The latest source can be found at _https://github.com/ayushnix/tessen_ and
bugs/patches/suggestions should be submitted there as well.
