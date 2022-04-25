# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## UNRELEASED

### Fixed

- use a generic message in the notification when data is copied

## [2.1.2] - 2022-04-02

### Fixed

- fixed parsing issue in the config file for the `action` variable

## [2.1.1] - 2022-03-21

### Fixed

- `tessen` is able to parse multiple files inside a gopass mount correctly

## [2.1.0] - 2022-03-08

### Added

- `dmenu` can now be specified as the dmenu backend, this was motivated by
  [this](https://codeberg.com/dnkl/fuzzel/commit/ffec2bc2ef7e5ca1398ab7ed7f134bd769706dcd) commit

### Fixed

- using `wofi` will no longer create a directory with an empty name containing another directory
  called `dev` with a file called `null`

### Changed

- `tessen -v` will now print only the version number and will omit the unnecessary prefix `tessen
  version`

## [2.0.2] - 2022-03-02

### Fixed

- the clipboard is not cleared if no action is performed and tessen exits when ESC is pressed

- if the `sleep` process which runs for `PASSWORD_STORE_CLIP_TIME` is terminated, the clipboard is
  cleared as expected

## [2.0.1] - 2022-03-01

### Fixed

- even if the selected file has 0 size, it will now be considered as a valid selection because the
  file name may be used as a value for autotyping/copying

- autotyping data no longer clears the clipboard

## [2.0.0] - 2022-02-19

### Added

- gopass has been added as a supported pass backend

- tessen can now be configured using a configuration file placed at
  `$XDG_CONFIG_HOME/tessen/config`, `$HOME/.config/tessen/config`, or a custom location specified
  using the new `-c`, `--config`, and `--config=` option

- the user key, url key, and the autotype key can now be specified in the configuration file and
  these keys can be set to simple regular expressions such as `(username|login)` to consider
  multiple values when selecting keys

- a man page for the tessen configuration file has been added

- added the `-s` option to simplify the code using shfmt in the github actions job and in
  CONTRIBUTING.md

- an optional patch has been provided to change the shebang back to `#!/bin/bash` and to set the
  `$PATH` explicitly to `/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin`

### Changed

- instead of considering the last non-unique key in the list of key-value pairs inside a password
  store file, the first non-unique key will now be considered and other keys with the same name will
  be ignored

- if copy action is selected, the option to autotype is no longer shown

- fuzzel no longer spams the terminal when it's being used as the dmenu backend

- the shebang for bash has been changed from `#!/bin/bash` to `#!/usr/bin/env bash` to accomodate
  users who don't use an operating system with `/bin/bash`

### Removed

- the `-b`, `--backend`, `--backend=` options have been removed and replaced with `-d`, `--dmenu`,
  and `--dmenu=`

- the following environment variables are no longer used for configuring how tessen behaves, the
  same functionality has been provided in the form of a configuration file

    TESSEN_BACKEND
    TESSEN_ACTION
    TESSEN_USERKEY
    TESSEN_URLKEY
    TESSEN_AUTOKEY
    TESSEN_DELAY
    BROWSER

### Fixed

- tessen should now clear all sensitive variables on exit if it receives the `SIGINT` signal

## [1.3.1] - 2022-01-17

### Fixed

- if the provided backend isn't recognized, return an empty value for the list of options passed to
  the dmenu backend

## [1.3.0] - 2022-01-16

### Added

- add support for using arbitary dmenu backends and arbitary options for dmenu backends

- shellcheck and shfmt CI jobs are added on the github repository for tessen to make sure that
  commits and pull requests conform to the guidelines in CONTRIBUTING.md

### Changed

- fuzzel will now be searched before rofi and wofi

## [1.2.3] - 2021-11-29

### Changed

- don't check for the prescence of oathtool if pass-otp is installed

## [1.2.2] - 2021-11-15

### Fixed

- if the selected gpg file is empty or if the decryption fails, exit

## [1.2.1] - 2021-11-14

### Changed

- use tabs instead of spaces in the Makefile

## [1.2.0] - 2021-11-14

### Added

- opening and copying URLs is now supported

- generating, autotyping, and copying HOTP/TOTP is now supported by using pass-otp as a dependency

- keys in password store files which have `#`, `+`, and `@` characters will now be parsed as well

- added a man page for tessen

- `TESSEN_USERKEY` environnment variable has been defined to accept custom values for username keys

- `TESSEN_URLKEY` environnment variable has been defined to accept custom values for url keys

- `TESSEN_AUTOKEY` environnment variable has been defined to accept custom values for autotype keys

- `TESSEN_DELAY` environnment variable has been defined to accept custom values for delay between
  successive autotype operations

### Changed

- bemenu is no longer the default dmenu backend

- the username will be set from the `TESSEN_USERKEY` environment variable and if that is unset, the
  basename of the selected file will be used as the username

- the location of the bash completion file has been changed from `/etc/bash_completion.d/` to
  `/usr/share/bash-completion/completions/`

### Fixed

- don't proceed if the selected gpg file is empty

## [1.1.2] - 2021-11-06

### Fixed

- don't parse the username and password keys if they exist to avoid conflicts

## [1.1.1] - 2021-09-22

### Fixed

- fix the semver in the README and tessen

## [1.1.0] - 2021-09-21

### Added

- wofi is now supported as a dmenu backend

- fish completion for wofi as a dmenu backend

## [1.0.0] - 2021-09-21

initial release
