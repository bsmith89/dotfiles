# Various aliases.  Sourced from .bashrc


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

function table {
    cl $1 | less -S
}
alias less="less -S"

# SSH to local virtualbox
# Must have setup and started a virtualbox guest
# with the same username as the host
# And port forwarding a la: http://stackoverflow.com/a/10532299/848121
vbox="${USER}@127.0.0.1"
alias vbox-ssh="ssh -p 3022 ${vbox}"
alias vbox-sshx="ssh -X -p 3022 ${vbox}"

alias td="todo.sh"
alias todo="todo.sh"

alias activate_env="source venv/bin/activate"
