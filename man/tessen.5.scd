tessen(5)

# NAME

configuration file for *tessen*(1)

# DESCRIPTION

tessen will search for a config file in the following locations

- *$XDG_CONFIG_HOME/tessen/config*
- *$HOME/.config/tessen/config*
- *$XDG_CONFIG_DIRS/tessen/config*
- */etc/xdg/tessen/config*

The location of the configuration file can also be specified using the *-c*
option as specified in *tessen*(1).

The configuration file for *tessen*(1) uses the same format as variable
assignments when using bash

```
key="val"
```

The double quotes should always be specified as mentioned.

A default configuration file is also available at

https://git.sr.ht/~ayushnix/tessen/blob/master/config

## OPTIONS

The following options are understood by the configuration file for *tessen*(1):

	*pass_backend*

	The default pass backend to use - either *pass*(1) or *gopass*(1)

	*dmenu_backend*

	The default dmenu backend to use - either *fuzzel*(1), *tofi*(1),
	*bemenu*(1), *wofi*(1), *rofi*(1),  or *dmenu*

	*action*

	The action that should be performed by tessen. If you prefer to use both
	autotyping and copying, it is recommended to leave this option commented
	or unspecified.

	*fuzzel_config_file*

	The path to the configuration file of *fuzzel*(1). The location of the
	file specified here is passed to fuzzel using its *-config=* option.

	*tofi_config_file*

	The path to the configuration file of *tofi*(1). The location of the
	file specified here is passed to tofi using its *-c* option.

	*yofi_config_file*

	The path to the configuration file of yofi. The location of the file
	specified here is passed to fuzzel using its *-config-file* option.

	*rofi_config_file*

	The path to the configuration file of *rofi*(1). The location of the
	file specified here is passed to rofi using its *-config* option.

	*wofi_config_file*

	*wofi_style_file*

	*wofi_color_file*

	The path to the configuration files of *wofi*(1). The location of the
	files specified using these variables are passed to wofi using its *-c*,
	*-s*, *-C* options, respectively. Note that *-k* is unsupported and is
	explicitly set to */dev/null* to prevent leaking sensitive information.

	*userkey*

	The name of the key which will be used to decide the username. A simple
	regex can also be specified, such as

	```
	(user|login)
	```

	This will match both *user* and *login* keys and the first occurence
	will be used as the username. If unspecified, the default value is
	*user*.

	*urlkey*

	The name of the key which will be used to decide the URL. A simple regex
	can also be specified, such as

	```
	(url|website)
	```

	This will match both *url* and *website* keys and the first occurence
	will be used as the URL. If unspecified, the default value is *url*.

	*autotype_key*

	The name of the key which will be used to decide the autotype key. A
	simple regex can also be specified, such as

	```
	(type|auto)
	```

	This will match both *type* and *auto* keys and the first occurence will
	be used as the custom autotype operation key value pair. If unspecified,
	the default value is *autotype*.

	*delay*

	The delay, in milliseconds, introduced between successive autotype
	operations. If unspecified, the default value is *100* milliseconds.

	*web_browser*

	The default web browser that should be used for opening URLs. If this is
	specified, *xdg-open*(1) will not be used even if it's installed.

# SEE ALSO

*tessen*(5), *pass*(1), *gopass*(1) *pass-otp*(1), *fuzzel*(1), *tofi*(1),
*bemenu*(1), *wofi*(1), *rofi*(1), *wl-clipboard*(1), *wtype*(1),
*notify-send*(1)

# AUTHORS

Developed and Maintained by Ayush Agarwal <ayush at ayushnix dot com>.

The latest source can be found at https://git.sr.ht/~ayushnix/tessen and bugs or
suggestions can be reported on https://todo.sr.ht/~ayushnix/tessen. For
contributing to tessen, please read the CONTRIBUTING.md file in the tessen
source code and send patches by email to ~ayushnix/tessen@lists.sr.ht.
Alternatively, pull requests can be raised on
https://codeberg.org/ayushnix/tessen/pulls or
https://github.com/ayushnix/tessen/pulls.
