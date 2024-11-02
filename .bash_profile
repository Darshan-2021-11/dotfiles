#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# stop tmux from loading bash_profile
[[ -n "$TMUX" ]] && return

# Adding scripts to path
export PATH=~/.local/src:$PATH

# make neovim default editor and visual
export EDITOR=nvim
export VISUAL=nvim

# start xorg-server
startx
