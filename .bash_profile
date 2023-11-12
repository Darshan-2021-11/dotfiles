#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# Adding scripts to path
export PATH=~/.local/src:$PATH

# start xorg server
startx
