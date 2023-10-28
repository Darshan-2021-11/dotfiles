# Keyboard Layout
setxkbdmap ch &

# Display Resolution
xrandr --output Virtual-1 --mode 1366x768 &

# Compositor
picom -f &

# Find fonts

# xset +fp /usr/share/fonts/misc &
# xset fp rehash &

# or we can also use `fc-cache` or `fc-cache -r` to refresh font cache

# Update status bar of dwm
date_format() {
	dateFormat="$(date '+%r %a %d %b %y')"
	echo -e "$dateFormat"
}

while :; do
	xsetroot -name " $(network) | $(volume) | $(brightness) | $(battery) | $(date_format)"
done &

# Setting wallpaper
#while feh --bg-fill ~/.local/share/wallpapers/$(ls ~/.local/share/wallpapers/ | shuf -n 1); do sleep 5m; done &
#feh --bg-fill ~/.local/share/wallpapers/wallhaven-8oy372.jpg &

# Start dwm
exec dwm
