.POSIX:

.PHONY: install docs install-docs uninstall

ASCIIDOCTOR:=$(shell command -v asciidoctor)
LUA:=$(shell for x in lua5.4 lua5.3 lua5.2 lua5.1 lua luajit; do command -v "$$x" && exit; done)

install: install-docs colorspec.lua
	(echo "#!$(LUA)"; cat colorspec.lua) > /usr/local/bin/colorspec
	chmod +x /usr/local/bin/colorspec
	mkdir -pv /usr/local/share/colorspec
	cp -v formats/* /usr/local/share/colorspec

docs/colorspec.1: docs/colorspec.adoc
	asciidoctor -b manpage $<

ifneq ($(ASCIIDOCTOR),)
install-docs: docs/colorspec.adoc
	asciidoctor -b manpage $<
	cp -v docs/colorspec.1 /usr/local/share/man/man1
	@echo "===================================="
	@echo " Run 'mandb' to update manual pages "
	@echo "===================================="
else
install-docs:
	@echo "asciidoctor not found; man pages won't be installed"
endif

docs: docs/colorspec.1

uninstall:
	rm -v /usr/local/bin/colorspec
	rm -v /usr/local/share/man/man1/colorspec.1
	rm -rv /usr/local/share/colorspec/
