#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

# original `PS1` or shell prompt
# PS1='[\u@\h \W]\$ '

# modified PROMPT_COMMAND(original in /etc/bash.bashrc) for git info
# in custom prompt in bash, look for PROMPTING in `man bash`
PROMPT_COMMAND='__git_info=$(git symbolic-ref --short HEAD 2>/dev/null)'
# export PS1='\[\e[38;5;9m\]\u\[\e[38;5;14m\]@\h \[\e[38;5;4m\]\w \[\e[38;5;11m\]$__git_info \[\e[0m\]\d \t\n$ '
export PS1='\[\e[38;5;9m\]\u\[\e[38;5;14m\]@\h \[\e[38;5;4m\]\w \[\e[38;5;11m\]$__git_info \[\e[0m\]\$ '

# custom aliases

# stop clear from clearing scrollback buffer
alias clear='clear -x'
