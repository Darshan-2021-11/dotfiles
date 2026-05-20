#
# ~/.bash_profile
#

# load bashrc file if present
[[ -f ~/.bashrc ]] && . ~/.bashrc

# Set editor & man-pager to nvim
#export MANPAGER='nvim +Man!'
#export EDITOR='nvim'

# start x-server
if [[ -z $DISPLAY ]] && [[ $(tty) == /dev/tty1 ]]; then
    startx
fi
