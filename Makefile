SRC_DIR := home
PLATFORM_DIR := platform
HOME_DIR := ${HOME}
REQUIRED := stow
VIMVENV := ${HOME_DIR}/.vim/.venv


ifndef PLATFORM
	PLATFORM_LIST := $(shell ls ${PLATFORM_DIR}/)
	PLATFORM_MSG := What platform would you like to install to (leave empty for none)?
	PLATFORM_PROMPT :=  ${PLATFORM_MSG} [${PLATFORM_LIST}]
	PLATFORM := $(shell read -p "${PLATFORM_PROMPT} " RESPONSE; echo $$RESPONSE)
endif

install: _install tic vim-plugins ${VIMVENV}

# TODO: Confirm bootstrap desired
_install: software-check
	stow --verbose=2 -t ${HOME_DIR} ${SRC_DIR}
ifneq ($(strip ${PLATFORM}),)  # If PLATFORM is defined and not empty...
	[ ! -d ${PLATFORM_DIR}/${PLATFORM} ] || \
        stow --verbose=2 -d ${PLATFORM_DIR} -t ${HOME_DIR} ${PLATFORM}
endif

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

${VIMVENV}:
	python -m venv ${VIMVENV}
	${VIMVENV}/bin/pip install neovim jedi

vim-plugins: ${VIMVENV}
	vim +PlugInstall +quitall

.PHONY: tic install _install software-check vim-plugins
