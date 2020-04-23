.POSIX:

.PHONY: install docs install-docs uninstall

install: install-docs colorspec
	chmod +x colorspec
	cp -v colorspec /usr/local/bin
	mkdir -pv /usr/local/share/colorspec
	cp -v formats/* /usr/local/share/colorspec

docs/colorspec.1: docs/colorspec.adoc
	asciidoctor -b manpage $<

install-docs: docs/colorspec.adoc
	@which asciidoctor \
		|| (echo "asciidoctor not found; man pages won't be installed")
	asciidoctor -b manpage $<
	cp -v docs/colorspec.1 /usr/local/share/man/man1
	@echo "===================================="
	@echo " Run 'mandb' to update manual pages "
	@echo "===================================="

docs: docs/colorspec.1

uninstall:
	rm -v /usr/local/bin/colorspec
	rm -v /usr/local/share/man/man1/colorspec.1
	rm -rv /usr/local/share/colorspec/
