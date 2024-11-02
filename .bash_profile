#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# stop tmux from loading bash_profile
[[ -n "$TMUX" ]] && return

# Adding scripts to path
export PATH=~/.local/src:$PATH

# Set man-pager to nvim
export MANPAGER='nvim +Man!'

# start xorg-server
startx
