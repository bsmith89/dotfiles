BACKUP_DIR := ${PWD}/backups
SRC_DIR := ${PWD}/home
HOME_DIR := ${HOME}

ALL_FILES :=
SRC_FILES := $(filter-out ${SRC_DIR}/. ${SRC_DIR}/.., $(wildcard ${SRC_DIR}/* ${SRC_DIR}/.*))
ALL_FILES += ${SRC_FILES}

ifdef PLATFORM
PLT_DIR := ${PWD}/platform/${PLATFORM}
PLT_FILES := $(filter-out ${PLT_DIR}/. ${PLT_DIR}/.., $(wildcard ${PLT_DIR}/* ${PLT_DIR}/.*))
ALL_FILES += ${PLT_FILES}
endif

install: _install tic

tic: terminfo/*
	@for file in $^ ; do \
		echo "tic $$file" ; \
		tic $$file ; \
	done

_install: home/.vim/mthesaur.txt
	@for source in ${ALL_FILES} ; do \
		base=`basename $$source` ; \
		echo Linking $$base ; \
		target=${HOME_DIR}/$$base ; \
		backup=${BACKUP_DIR}/$$base ; \
		if [ -e "$$target" ] && [ ! -L "$$target" ]; then \
			echo Backing up $$target first. ; \
			echo "mv $$target $$backup" ; \
			mv $$target $$backup ; \
		fi ; \
		ln -sTf $$source $$target ; \
	done
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

restore:
	# Return backed-up files to their original place
	@for file in ${SRC_FILES} ${PLATFORM_FILES} ; do \
		base=`basename $$file` ; \
		target=${HOME_DIR}/$$base ; \
		backup=${BACKUP_DIR}/$$base ; \
		if [ -e "$$backup" ] && [ -L "$$target" ]; then \
			echo Restoring $$base from backup.
			unlink $$target ; \
			mv $$backup $$target ; \
		fi ; \
	done

test:
	@echo ${ALL_FILES}
