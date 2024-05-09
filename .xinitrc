# Keyboard Layout
setxkbdmap ch &

# Display Resolution
#xrandr --output eDP-1 --mode 1368x768 &

# Import custom script functions, and run
. startup.sh
# INITIAL SETUP
init_setup &
# DAEMONS
daemon_setup &

# Enable java applications support
export AWT_TOOLKIT=MToolkit
export _JAVA_AWT_WM_NONREPARENTING=1

# Start dwm
exec dwm
