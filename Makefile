PROG ?= tessen
PREFIX ?= /usr
DESTDIR ?=
BINDIR ?= $(PREFIX)/bin
MANDIR ?= $(PREFIX)/share/man
BASHCOMPDIR ?= $(PREFIX)/share/bash-completion/completions
FISHCOMPDIR ?= $(PREFIX)/share/fish/vendor_completions.d

RM := rm
ECHO := @echo
SCDOC := scdoc
INSTALL := install

.PHONY: all man install clean uninstall

all:
        $(ECHO) "$(PROG) is a shell script and doesn't need to be compiled"
        $(ECHO) "To install it, enter \"make install\""

man: man/tessen.1

man/%: man/%.scd
        $(SCDOC) < $^ > $@

install: man
        $(INSTALL) -Dm 0755 $(PROG) -t $(DESTDIR)$(BINDIR)
        $(INSTALL) -Dm 0644 man/*.1 -t $(DESTDIR)$(MANDIR)/man1
        $(INSTALL) -Dm 0644 completion/$(PROG).bash-completion $(DESTDIR)$(BASHCOMPDIR)/$(PROG)
        $(INSTALL) -Dm 0644 completion/$(PROG).fish-completion $(DESTDIR)$(FISHCOMPDIR)/$(PROG).fish
        $(ECHO) ""
        $(ECHO) "$(PROG) has been installed succesfully"

clean:
        $(RM) -f man/*.1

uninstall:
        $(RM) -f "$(DESTDIR)$(BINDIR)/$(PROG)"
        $(RM) -f "$(DESTDIR)$(MANDIR)/man1/$(PROG).1"
        $(RM) -f "$(DESTDIR)$(BASHCOMPDIR)/$(PROG)"
        $(RM) -f "$(DESTDIR)$(FISHCOMPDIR)/$(PROG).fish"
