#
# ~/.bash_profile
#

# load bashrc file if present
[[ -f ~/.bashrc ]] && . ~/.bashrc
[[ -f ~/.fehbg ]] && . ~/.fehbg

# Set editor & man-pager to nvim
#export MANPAGER='nvim +Man!'
#export EDITOR='nvim'

# start x-server
exec startx
