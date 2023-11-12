# Keyboard Layout
setxkbdmap ch &

# Display Resolution
xrandr --output Virtual-1 --mode 1366x768 &

# Compositor
# picom -f &

# Update status bar of dwm
date_format() {
	dateFormat="$(date '+%r %a %d %b %y')"
	echo -e "$dateFormat"
}

while :; do
	xsetroot -name " $(network) | $(volume) | $(brightness) | $(battery) | $(date_format)"
done &

# Setting wallpaper
#while feh --bg-fill ~/downloads/wallpapers/$(ls ~/downloads/wallpapers/ | shuf -n 1); do sleep 5m; done &
feh --bg-fill ~/.local/share/wallpapers/wallhaven-8oy372.jpg &

st &
brave &

# Start dwm
exec dwm
