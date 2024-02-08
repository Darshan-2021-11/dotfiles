#
# ~/.bash_profile
#

# show off comes first
neofetch

[[ -f ~/.bashrc ]] && . ~/.bashrc

# stop tmux from loading bash_profile
[[ -n "$TMUX" ]] && return

# Adding scripts to path
export PATH=~/.local/src:$PATH

# start xorg-server
startx
