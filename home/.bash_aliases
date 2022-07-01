# Various aliases.  Sourced as the second-to-last thing from .bashrc

alias ls='ls -Ap --color=auto'
alias ll='ls -alFh'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

topall() {
    status=0
    while [ "$status" -eq 0 ]
    do
        echo $1
        top -pid `pgrep "$1" | sed '2,$s:^:-pid :'`
        status=$?
        echo "Press ^C to quit for real."
        sleep 0.75
    done
}
alias topu='top -u $USER'
alias htopu='htop -u $USER'

# Safe copy and mv
alias cp="cp -i"
alias mv="mv -i"
alias psu="ps -u $USER"
alias ..="cd .."
alias topu='top -u $USER'
alias nmsq="grep -c '^>'"
alias view="vim -R"

alias less="less -Sr"

table() {
    column -s'	' -t $1 | less -S
}

alias todo="todo.sh"
complete -F _todo todo

alias td="todo.sh"
complete -F _todo td


set_diff() {
    diff <(sort $1 | uniq) <(sort $2 | uniq) | grep '^[><] ' | sort
}

serve_dir() {
    python3 -m http.server $1 -d $2
}

ssh-fwd() {
    port_start=$1
    port_end=$2
    shift 2
    ssh \
        $(for port in $(seq $port_start $port_end); do echo "-L localhost:$port:localhost:$port"; done) \
        $@
}

column-numbers() {
head -1 $1 | tr '\t' '\n' | nl
}
