BACKUP_DIR := backups
SRC_DIR := home
PLT_DIR := platform
HOME_DIR := ${HOME}
REQUIRED := vim curl stow

ifndef PLATFORM
	PLATFORM_LIST := $(shell ls ${PLT_DIR}/)
	PLATFORM_PROMPT := What platform would you like to install to (empty for none)? [${PLATFORM_LIST}]
	PLATFORM := $(shell read -p "${PLATFORM_PROMPT} " RESPONSE; echo $$RESPONSE)
endif

install: _install tic

_install: home/.vim/mthesaur.txt software-check
	stow --verbose=2 -t ${HOME_DIR} home
ifneq ($(strip ${PLATFORM}),)
	stow --verbose=2 -d platform -t ${HOME_DIR} ${PLATFORM}
endif
	vim +PlugInstall +qall

tic: terminfo/*
	@for file in $^ ; do \
		echo "tic $$file" ; \
		tic $$file ; \
	done

software-check:
	@for command in ${REQUIRED} ; do \
        which $$command 2>&1 >/dev/null \
        && echo "$$command: OK " \
        || echo "$$command: FAILED"; \
    done

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
