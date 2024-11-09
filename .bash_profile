#
# ~/.bash_profile
#

# load bashrc file if present
[[ -f ~/.bashrc ]] && . ~/.bashrc

# do not start xserver when tmux set
[[ -n "$TMUX" ]] && return

# Set man-pager to nvim
export MANPAGER='nvim +Man!'
export EDITOR='nvim'

# Fixing errors with JAVA applications
export AWT_TOOLKIT=MToolkit
export _JAVA_AWT_WM_NONREPARENTING=1

# start x-server
startx
