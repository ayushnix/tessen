# `?=` assigns value to a variable only if it has not been set before
# this can be useful when you want to override variables during execution of
# the make command
# for example, sudo make PREFIX=/custom/dir install
DESTDIR ?=
PREFIX ?= /usr
BINDIR ?= ${PREFIX}/bin
DATAROOTDIR ?= ${PREFIX}/share
MANDIR ?= ${DATAROOTDIR}/man
BASHCOMPDIR ?= ${DATAROOTDIR}/bash-completion/completions
FISHCOMPDIR ?= ${DATAROOTDIR}/fish/vendor_completions.d
PROG ?= tessen

# `:=` is simple variable assignment and variables which are part of the values
# being assigned are expanded only if they are already set
RM := rm
# `@echo` prevents the command itself from being printed
ECHO := @echo
SCDOC := scdoc
INSTALL := install

# this is where the basic structure of Makefiles start and it looks like
# file_a : file_b
# 	command
# 	command
# 	...
#
# file_b: file_c
# 	command
# 	command
# 	...
#
# file_a needs file_b and file_b needs file_c - this is how Makefiles operate

# file_a can be a `.PHONY`, a special target, which says that the files `all`,
# `man` etc aren't really files but other targets
# think of them as pseudo files or fake files which don't exist but serve to
# execute commands in a certain logical sequence
# by default, if nothing is specified, the `all` target is executed
.PHONY: all install minimal bashcomp fishcomp clean uninstall

all:
	${ECHO} "${PROG} is a shell script and doesn't need to be compiled"
	${ECHO} "To install it, enter \"make install\""

install: man bashcomp fishcomp
	${INSTALL} -Dm 0755 ${PROG} -t ${DESTDIR}${BINDIR}
	${ECHO} ""
	${ECHO} "${PROG} has been installed succesfully"

# a minimal alternative for people who don't want completion files or man pages
# `make man`, `make install_man`, `make bashcomp`, `man fishcomp`, and `make
# minimal` can be used selectively to install what's needed
minimal:
	${INSTALL} -Dm 0755 ${PROG} -t ${DESTDIR}${BINDIR}
	${ECHO} ""
	${ECHO} "${PROG} has been installed succesfully"

man: man/${PROG}.1 man/${PROG}.5
	${INSTALL} -Dm 0644 man/${PROG}.1 -t ${DESTDIR}${MANDIR}/man1
	${INSTALL} -Dm 0644 man/${PROG}.5 -t ${DESTDIR}${MANDIR}/man5

# we want *.scd files from the files that are inside man/
# the `$^` is an automatic variable which means the list of `file_b`'s
# the `$@` is an automatic variable which means the list of `file_a`'s
man/%: man/%.scd
	${SCDOC} < $^ > $@

bashcomp:
	${INSTALL} -Dm 0644 completion/${PROG}.bash-completion ${DESTDIR}${BASHCOMPDIR}/${PROG}

fishcomp:
	${INSTALL} -Dm 0644 completion/${PROG}.fish-completion ${DESTDIR}${FISHCOMPDIR}/${PROG}.fish

clean:
	${RM} -f man/${PROG}.1
	${RM} -f man/${PROG}.5

uninstall:
	${RM} -f "${DESTDIR}${BINDIR}/${PROG}"
	${RM} -f "${DESTDIR}${MANDIR}/man1/${PROG}.1"
	${RM} -f "${DESTDIR}${MANDIR}/man5/${PROG}.5"
	${RM} -f "${DESTDIR}${BASHCOMPDIR}/${PROG}"
	${RM} -f "${DESTDIR}${FISHCOMPDIR}/${PROG}.fish"
