BACKUP_DIR := backups
SRC_DIR := home
HOME_DIR := ${HOME}

install: _install tic

_install: home/.vim/mthesaur.txt software-check
	stow --verbose=2 -t ${HOME_DIR} home
ifdef PLATFORM
	stow --verbose=2 -d platform -t ${HOME_DIR} ${PLATFORM}
endif
	vim +PlugInstall +qall

tic: terminfo/*
	@for file in $^ ; do \
		echo "tic $$file" ; \
		tic $$file ; \
	done

software-check:
	vim --version 2>&1 >/dev/null
	stow --version 2>&1 >/dev/null
	curl --version 2>&1 >/dev/null

.PHONY: tic install _install software-check

# Un-versioned data
build/:
	mkdir -p $@

home/.vim/mthesaur.txt: build/mthesaur.txt
	cp $^ $@

build/mthesaur.txt: | build/mthes10.zip
	unzip -o -d $(@D) $| $(@F)
	touch $@

build/mthes10.zip: | build/
	curl -o $@ http://www.gutenberg.org/dirs/etext02/mthes10.zip
