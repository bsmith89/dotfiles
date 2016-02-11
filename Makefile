BACKUP_DIR := backups
SRC_DIR := home
PLATFORM_DIR := platform
BOOTSTRAP_DIR := bootstrap
HOME_DIR := ${HOME}
REQUIRED := vim curl stow gzip



ifndef PLATFORM
	PLATFORM_LIST := $(shell find ${PLATFORM_DIR} ${BOOTSTRAP_DIR} -maxdepth 1 -mindepth 1 | cut -f2 -d'/' | sort | uniq )
	PLATFORM_MSG := What platform would you like to install to (leave empty for none)?
	PLATFORM_PROMPT :=  ${PLATFORM_MSG} [${PLATFORM_LIST}]
	PLATFORM := $(shell read -p "${PLATFORM_PROMPT} " RESPONSE; echo $$RESPONSE)
endif

install: _install tic

# TODO: Confirm bootstrap desired
_install: software-check
ifneq ($(strip ${PLATFORM}),)
	[ ! -x ${BOOTSTRAP_DIR}/${PLATFORM} ] || \
        ${BOOTSTRAP_DIR}/${PLATFORM}
	[ ! -d ${PLATFORM_DIR}/${PLATFORM} ] || \
        stow --verbose=2 -d ${PLATFORM_DIR} -t ${HOME_DIR} ${PLATFORM}
endif
	stow --verbose=2 -t ${HOME_DIR} home
	vim +PlugInstall +qall

tic: terminfo/*
	@for file in $^ ; do \
        echo "tic $$file" ; \
        tic $$file ; \
    done

software-check:
	@for command in ${REQUIRED} ; do \
        which $$command 2>&1 >/dev/null \
        && echo "$$command: OK" \
        || echo "$$command: NOT INSTALLED" ; \
    done

.PHONY: tic install _install software-check
