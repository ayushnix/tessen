DESTDIR ?=
PREFIX ?= /usr
BINDIR ?= ${PREFIX}/bin
DATAROOTDIR ?= ${PREFIX}/share
MANDIR ?= ${DATAROOTDIR}/man
BASHCOMPDIR ?= ${DATAROOTDIR}/bash-completion/completions
FISHCOMPDIR ?= ${DATAROOTDIR}/fish/vendor_completions.d
PROG ?= tessen

RM := rm
ECHO := @echo
SCDOC := scdoc
INSTALL := install

.PHONY: all install minimal bashcomp fishcomp clean uninstall

all:
	${ECHO} "${PROG} is a shell script and doesn't need to be compiled"
	${ECHO} "To install it, enter \"make install\""

install: man bashcomp fishcomp
	${INSTALL} -Dm 0755 ${PROG} -t ${DESTDIR}${BINDIR}
	${ECHO} ""
	${ECHO} "${PROG} has been installed succesfully"

minimal:
	${INSTALL} -Dm 0755 ${PROG} -t ${DESTDIR}${BINDIR}
	${ECHO} ""
	${ECHO} "${PROG} has been installed succesfully"

man: man/${PROG}.1 man/${PROG}.5
	${INSTALL} -Dm 0644 man/${PROG}.1 -t ${DESTDIR}${MANDIR}/man1
	${INSTALL} -Dm 0644 man/${PROG}.5 -t ${DESTDIR}${MANDIR}/man5

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
