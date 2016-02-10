BACKUP_DIR := backups
SRC_DIR := home
HOME_DIR := ${HOME}

install: _install tic

tic: terminfo/*
	@for file in $^ ; do \
		echo "tic $$file" ; \
		tic $$file ; \
	done

_install: home/.vim/mthesaur.txt software-check
	stow --verbose=2 -t ${HOME_DIR} home
	[ -z "${PLATFORM}" ] || stow --verbose=2 -d platform -t ${HOME_DIR} ${PLATFORM}
	vim +PlugInstall +qall

# If I'm not mistaken, this should make any required directories.
build/:
	mkdir -p $@

home/.vim/mthesaur.txt: build/mthesaur.txt
	cp $^ $@

# Using a bit of Make-foo: $(@D) is the directory part of the target
# and $(@F) is the filename part.
build/mthesaur.txt: | build/mthes10.zip
	unzip -o -d $(@D) $| $(@F)
	touch $@

build/mthes10.zip: | build/
	curl -o $@ http://www.gutenberg.org/dirs/etext02/mthes10.zip

.PHONY: tic install _install software-check

software-check:
	vim --version 2>&1 >/dev/null
	stow --version 2>&1 >/dev/null
	curl --version 2>&1 >/dev/null

