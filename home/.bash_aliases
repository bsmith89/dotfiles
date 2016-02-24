# Various aliases.  Sourced as the second-to-last thing from .bashrc


alias ls='ls -Ap --color=auto'
alias ll='ls -alFh'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Safe copy and mv
alias cp="cp -i"
alias mv="mv -i"
alias psu="ps -u $USER"
alias ..="cd .."
alias nmsq="grep -c '^>'"
alias now="date +%r%n%a%t%D"
alias view="vim -R"
alias cl="column -s '	' -t"
alias clt=cl
alias cl,="column -s ',' -t"

table() {
    cl $1 | less -S
}
tablet() {
    clt $1 | less -S
}
alias less="less -S"


alias todo="todo.sh"
complete -F _todo todo

alias td="todo.sh"
complete -F _todo td

alias tdadd="td add"
alias tdedit="td edit"
alias tdnext="td next"

# Find backwards *up* the directory tree (towards root)
find_up() {
    in=$(pwd)
    find "$in" -maxdepth 1 -name "$@"
    while [ "$in" != "/" ]; do
        in=$(dirname "$in")
        find "$in" -maxdepth 1 -name "$@"
    done
}

export DEFAULT_VENV=.venv

activate_venv() {
    local venv="$1"
    [ -z "$venv" ] && venv="$DEFAULT_VENV"
    local dir=$(find_up $venv | head -n 1)
    if [ -n "$dir" ]; then
        if source "$dir/bin/activate"; then
            return 0
        else
            echo >&2 "ERROR: $dir exists but cannot be activated."
            return 1
        fi
    else
        echo >&2 "ERROR: no directory $venv found"
        return 1
    fi
}

make_venv() {
    local VENV="$1"
    shift
    [ -z "$VENV" ] && VENV="$DEFAULT_VENV"
    python3 -m venv $@ $VENV
    activate_venv $VENV
}

cd_venv() {
    cd "$@"
    START_ENV=$VIRTUAL_ENV
    activate_venv 2>/dev/null
    if [ "$?" = 0 ]; then
        if [ "$START_ENV" != "$VIRTUAL_ENV" ]; then
            echo "$VIRTUAL_ENV ACTIVATED" >&2
        else
            return 0
        fi
    elif [ -n "$VIRTUAL_ENV" ]; then
        echo "$VIRTUAL_ENV DEACTIVATED" >&2
        deactivate
    fi
}
