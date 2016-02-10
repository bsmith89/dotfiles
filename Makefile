BACKUP_DIR := backups
SRC_DIR := home
PLT_DIR := platform
HOME_DIR := ${HOME}
REQUIRED := vim curl stow gzip

ifndef PLATFORM
	PLATFORM_LIST := $(shell ls ${PLT_DIR}/)
	PLATFORM_PROMPT := What platform would you like to install to (empty for none)? [${PLATFORM_LIST}]
	PLATFORM := $(shell read -p "${PLATFORM_PROMPT} " RESPONSE; echo $$RESPONSE)
endif

install: _install tic

_install: software-check
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
