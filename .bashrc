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
	
PROMPT_COMMAND='__git_info=$(git symbolic-ref --short HEAD 2>/dev/null | awk '\''NF { printf " [%s]", $0 }'\'')'
export PS1='\[\e[38;5;1m\][\u\[\e[38;5;6m\]@\h \[\e[38;5;4m\]\W]\[\e[1;38;5;3m\]$__git_info\[\e[0m\]\$ '

#include path for cpp
export CPLUS_INCLUDE_PATH=~/include:$CPLUS_INCLUDE_PATH

# custom aliases

# stop clear from clearing scrollback buffer in tmux
alias clear='clear -x'
