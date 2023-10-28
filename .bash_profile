#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# Adding scripts to path
export PATH=~/.local/bin:$PATH

# start xorg server
startx
