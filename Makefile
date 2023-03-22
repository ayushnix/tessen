# tessen: GNU Makefile

DESTDIR =
PREFIX = /usr
BINDIR := $(PREFIX)/bin
DATAROOTDIR := $(PREFIX)/share
MANDIR := $(DATAROOTDIR)/man
BASHCOMPDIR := $(DATAROOTDIR)/bash-completion/completions
FISHCOMPDIR := $(DATAROOTDIR)/fish/vendor_completions.d
PROG = tessen

SCDOC = scdoc
SHCHK = shellcheck
SHFMT = shfmt
INSTALL = install

.PHONY: all install minimal bashcomp fishcomp clean uninstall

all:
	@echo "$(PROG) is a shell script and doesn't need to be compiled"
	@echo "To install it, enter \"make install\""

install: man bashcomp fishcomp
	$(INSTALL) -Dm 0755 $(PROG) -t $(DESTDIR)$(BINDIR)
	@echo ""
	@echo "$(PROG) has been installed succesfully"

minimal:
	$(INSTALL) -Dm 0755 $(PROG) -t $(DESTDIR)$(BINDIR)
	@echo ""
	@echo "$(PROG) has been installed succesfully"

man: man/$(PROG).1 man/$(PROG).5
	$(INSTALL) -Dm 0644 man/$(PROG).1 -t $(DESTDIR)$(MANDIR)/man1
	$(INSTALL) -Dm 0644 man/$(PROG).5 -t $(DESTDIR)$(MANDIR)/man5

man/%: man/%.scd
	$(SCDOC) < $^ > $@

bashcomp:
	$(INSTALL) -Dm 0644 completion/$(PROG).bash-completion $(DESTDIR)$(BASHCOMPDIR)/$(PROG)

fishcomp:
	$(INSTALL) -Dm 0644 completion/$(PROG).fish-completion $(DESTDIR)$(FISHCOMPDIR)/$(PROG).fish

clean:
	rm -f man/$(PROG).1
	rm -f man/$(PROG).5

check:
	$(SHCHK) $(PROG)
	$(SHFMT) -d -s -i 2 -bn -ci -sr $(PROG)

uninstall:
	rm -f "$(DESTDIR)$(BINDIR)/$(PROG)"
	rm -f "$(DESTDIR)$(MANDIR)/man1/$(PROG).1"
	rm -f "$(DESTDIR)$(MANDIR)/man5/$(PROG).5"
	rm -f "$(DESTDIR)$(BASHCOMPDIR)/$(PROG)"
	rm -f "$(DESTDIR)$(FISHCOMPDIR)/$(PROG).fish"
