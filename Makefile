PROG ?= tessen
PREFIX ?= /usr
DESTDIR ?=
BINDIR ?= $(PREFIX)/bin
BASHCOMPDIR ?= /etc/bash_completion.d
FISHCOMPDIR ?= $(PREFIX)/share/fish/vendor_completions.d

all:
	@echo "$(PROG) is a shell script and doesn't need to be compiled"
	@echo ""
	@echo "To install it, enter \"make install\""
	@echo ""

install:
	@install -vd "$(DESTDIR)$(BINDIR)" "$(DESTDIR)$(BASHCOMPDIR)" "$(DESTDIR)$(FISHCOMPDIR)"
	@install -vm 0755 "$(PROG)" "$(DESTDIR)$(BINDIR)/$(PROG)"
	@install -vm 0644 "completion/$(PROG).bash-completion" "$(DESTDIR)$(BASHCOMPDIR)/$(PROG)"
	@install -vm 0644 "completion/$(PROG).fish-completion" "$(DESTDIR)$(FISHCOMPDIR)/$(PROG).fish"
	@echo
	@echo "$(PROG) has been installed succesfully"
	@echo

uninstall:
	@rm -f \
		"$(DESTDIR)$(BINDIR)/$(PROG)" \
		"$(DESTDIR)$(BASHCOMPDIR)/$(PROG)" \
		"$(DESTDIR)$(FISHCOMPDIR)/$(PROG).fish"

.PHONY: install uninstall
