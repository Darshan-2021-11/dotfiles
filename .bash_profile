#
# ~/.bash_profile
#

# load bashrc file if present
[[ -f ~/.bashrc ]] && . ~/.bashrc

# Set man-pager to nvim
export MANPAGER='nvim +Man!'
export EDITOR='nvim'

# start x-server
startx
