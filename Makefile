BACKUP_DIR=${PWD}/backups
SRC_DIR=${PWD}/home
HOME_DIR=${HOME}
SRC_FILES=$(wildcard ${SRC_DIR}/*)
SRC_FILES+=$(wildcard ${SRC_DIR}/.*)
$(info PLATFORM=${PLATFORM})
ifdef PLATFORM
	PLATFORM_DIR=${PWD}/platform/${PLATFORM}
	PLATFORM_FILES=$(wildcard ${PLATFORM_DIR}/*)
	PLATFORM_FILES+=$(wildcard ${PLATFORM_DIR}/.*)
endif
ALL_FILES=$(filter-out ${SRC_DIR}/. ${SRC_DIR}/.. ${PLATFORM_DIR}/. ${PLATFORM_DIR}/.. ,${SRC_FILES} ${PLATFORM_FILES})

install:
	for source in ${ALL_FILES} ; do \
		base=`basename $$source` ; \
		echo Linking $$base ; \
		target=${HOME_DIR}/$$base ; \
		backup=${BACKUP_DIR}/$$base ; \
		if [ -e "$$target" ] && [ ! -L "$$target" ]; then \
			echo Backing up $$target first. ; \
			mv $$target $$backup ; \
		fi ; \
		ln -sTf $$source $$target ; \
	done
	vim +PluginInstall +qall

restore:
	# Return backed-up files to their original place
	for file in ${SRC_FILES} ${PLATFORM_FILES} ; do \
		base=`basename $$file` ; \
		target=${HOME_DIR}/$$base ; \
		backup=${BACKUP_DIR}/$$base ; \
		if [ -e "$$backup" ] && [ -L "$$target" ]; then \
			Restoring $$base from backup.
			unlink $$target ; \
			mv $$backup $$target ; \
		fi ; \
	done

test:
	@echo ${ALL_FILES}
