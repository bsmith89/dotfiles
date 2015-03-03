# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=5000
HISTFILESIZE=5000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
    xterm-256color-italic) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

###################################################

# Additional PATH variables
export PATH="$HOME/.local/bin:$PATH"

# Additional MANPATH variables
export MANPATH="$HOME/.local/share/man:$MANPATH"

# Additonal LD_LIBRARY_PATH variables
export LD_LIBRARY_PATH=$HOME/.local/lib:$LD_LIBRARY_PATH

# Local Bash settings:
if [ -f $HOME/.bashrc_local ]; then
    . $HOME/.bashrc_local
fi

# Set it so that the 'v' shortcut uses vim instead of vi
export EDITOR=nvim

# Set it so that globbing includes hidden files but not the . and .. directories.
export GLOBIGNORE=". .."

# enable color support of ls and grep
if command -v dircolors >/dev/null 2>&1; then
    test -r ~/.dir_colors && eval "$(dircolors -b ~/.dir_colors)" || eval "$(dircolors -b)"
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# git-completion can be found here:
# https://github.com/git/git/blob/master/contrib/completion/git-completion.bash
# Must be downloaded to ~/.local/src
if [ -f ~/.local/bin/git-completion.sh ]; then
	source ~/.local/src/git-completion.sh
fi

# These lines are required for virtualenvwrapper to work correctly
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Projects


# Load either the contents of $VIRTUAL_ENV (e.g. if a tmux session is loaded)
# or activate the default environment.
if [ -n "$VIRTUAL_ENV" ]; then
  source "$VIRTUAL_ENV/bin/activate"
elif [[ -e $HOME/.virtualenvs/default/bin/activate ]]; then
	source $HOME/.virtualenvs/default/bin/activate
fi

if [[ -e $HOME/.local/bin/virtualenvwrapper_lazy.sh ]]; then
	source $HOME/.local/bin/virtualenvwrapper_lazy.sh
fi

# and these make virtualenv work the same way, even if not using
# virtualenvwrapper
export PIP_VIRTUALENV_BASE=$WORKON_HOME
export PIP_RESPECT_VIRTUALENV=true

if [[ -e $HOME/.vim/bundle/gruvbox/gruvbox_256palette_osx.sh ]]; then
   source $HOME/.vim/bundle/gruvbox/gruvbox_256palette_osx.sh
fi
