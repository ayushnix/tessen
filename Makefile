# tessen: GNU Makefile

DESTDIR =
PREFIX = /usr
BINDIR := $(PREFIX)/bin
DATAROOTDIR := $(PREFIX)/share
MANDIR := $(DATAROOTDIR)/man
BASHCOMPDIR := $(DATAROOTDIR)/bash-completion/completions
FISHCOMPDIR := $(DATAROOTDIR)/fish/vendor_completions.d
CONFDIRS = /etc/xdg
PROG = tessen
PROGCFG = config
EXPATH = explicit_path.patch
SCDOC = scdoc
SHCHK = shellcheck
SHFMT = shfmt
INSTALL = install

.PHONY: all help install minimal bashcomp fishcomp man expatch clean uninstall

##all: print the help message and an instruction for installation
all: help
	@echo ""
	@echo "$(PROG) is a bash script and doesn't need to be compiled"
	@echo "To install it, enter \"make install\""

##help: print this help message
help: Makefile
	@sed -n 's/^##//p' $<

##install: install the program, its man pages, configuration files, and shell completion files
install: man bashcomp fishcomp minimal
	@echo ""
	@echo "$(PROG) has been installed succesfully"

##minimal: install the program and its default configuration file
minimal:
	$(INSTALL) -Dm 0755 $(PROG) -t $(DESTDIR)$(BINDIR)
	$(INSTALL) -Dm 0644 $(PROGCFG) -t $(DESTDIR)$(CONFDIRS)/$(PROG)

##man: build and install the man pages for this program
man: man/$(PROG).1 man/$(PROG).5
	$(INSTALL) -Dm 0644 man/$(PROG).1 -t $(DESTDIR)$(MANDIR)/man1
	$(INSTALL) -Dm 0644 man/$(PROG).5 -t $(DESTDIR)$(MANDIR)/man5

##expatch: apply the explicit path patch to the program
expatch:
	patch -N $(PROG) < $(EXPATH)

man/%: man/%.scd
	$(SCDOC) < $^ > $@

##bashcomp: install the bash shell completion file
bashcomp:
	$(INSTALL) -Dm 0644 completion/$(PROG).bash-completion $(DESTDIR)$(BASHCOMPDIR)/$(PROG)

##fishcomp: install the fish shell completion file
fishcomp:
	$(INSTALL) -Dm 0644 completion/$(PROG).fish-completion $(DESTDIR)$(FISHCOMPDIR)/$(PROG).fish

##clean: remove files that might've been generated while installing this program
clean:
	rm -f man/$(PROG).1
	rm -f man/$(PROG).5
	rm -f $(PROG).rej

##check: lint the program using shellcheck and report formatting errors, if any, using shfmt
check:
	$(SHCHK) $(PROG)
	$(SHFMT) -d -s -i 2 -bn -ci -sr $(PROG)

##uninstall: uninstall the program, its man pages, configuration files, and shell completion files
uninstall:
	rm -f "$(DESTDIR)$(BINDIR)/$(PROG)"
	rm -f "$(DESTDIR)$(MANDIR)/man1/$(PROG).1"
	rm -f "$(DESTDIR)$(MANDIR)/man5/$(PROG).5"
	rm -f "$(DESTDIR)$(BASHCOMPDIR)/$(PROG)"
	rm -f "$(DESTDIR)$(FISHCOMPDIR)/$(PROG).fish"
	rm -f "$(DESTDIR)$(CONFDIRS)/$(PROG)/$(PROGCFG)"
