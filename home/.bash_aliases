# Various aliases.  Sourced as the second-to-last thing from .bashrc


alias ls='ls -Ap --color=auto'
alias ll='ls -alFh'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# SSH
hpcc="smithby1@hpcc.msu.edu"
alias hpcc-ssh="ssh $hpcc"
alias hpcc-sshx="ssh -X $hpcc"
lyorn="smithby1@lyorn.idyll.org"
alias lyorn-ssh="ssh $lyorn"
alias lyorn-sshx="ssh -X $lyorn"
webhost="byronjsm@byronjsmith.com"
alias webhost-ssh="ssh $webhost"
flux="bjsm@flux-login.engin.umich.edu"
flux1="bjsm@flux-login1.engin.umich.edu"
flux2="bjsm@flux-login2.engin.umich.edu"
alias flux-ssh="ssh $flux"
alias flux-ssh1="ssh $flux1"
alias flux-ssh2="ssh $flux2"
alias flux-sshx="ssh -X $flux"
alias flux-sshx1="ssh -X $flux1"
alias flux-sshx2="ssh -X $flux2"

# Safe copy and mv
alias cp="cp -i"
alias mv="mv -i"
alias psu="ps -u $USER"
alias ..="cd .."
alias nmsq="grep -c '^>'"
alias now="date +%r%n%a%t%D"
alias view="vim -R"
alias top="top -o cpu"
alias topu="top -U $USER"
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

# SSH to local virtualbox
# Must have setup and started a virtualbox guest
# with the same username as the host
# And port forwarding a la: http://stackoverflow.com/a/10532299/848121
vbox="${USER}@127.0.0.1"
alias vbox-ssh="ssh -p 3022 ${vbox}"
alias vbox-sshx="ssh -X -p 3022 ${vbox}"

alias todo="todo.sh"
complete -F _todo todo

alias td="todo.sh"
complete -F _todo td

alias tdadd="td add"
alias tdedit="td edit"
alias tdnext="todo.sh lsfile next.txt"

DEFAULT_VENV=./.venv

activate_venv() {
    local START_DIR=$PWD
    local VENV="$1"
    [ -z "$VENV" ] && VENV="$DEFAULT_VENV"
    while [ ! -d "$VENV" ]; do
        cd ..
        if [ "$PWD" == "/" ]; then
            echo "ERROR: no venv \"$VENV\" found." >&2
            cd "$START_DIR"
            return 1
        fi
    done
    source "${VENV}/bin/activate"
    local OUTCODE="$?"
    [ "$OUTCODE" = "0" ] || echo "ERROR: $PWD/$VENV exists but cannot be activated." >&2
    cd $START_DIR
    return "$OUTCODE"
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

alias cd="cd_venv"
