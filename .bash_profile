#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# Adding scripts to path
export PATH=~/.local/src:$PATH

# Enable java applications support
export AWT_TOOLKIT=MToolkit
export _JAVA_AWT_WM_NONREPARENTING=1

# start xorg server
startx

# clear screen at the end
clear && neofetch
