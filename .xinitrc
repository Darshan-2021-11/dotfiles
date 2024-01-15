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

network_format() {
	echo $network_info
}

while :; do
	# internet_speed
	rx1=$(cat /sys/class/net/wlp9s0/statistics/rx_bytes)
	tx1=$(cat /sys/class/net/wlp9s0/statistics/tx_bytes)
	sleep 1s
	rx2=$(cat /sys/class/net/wlp9s0/statistics/rx_bytes)
	tx2=$(cat /sys/class/net/wlp9s0/statistics/tx_bytes)

	network_info="󰁅 $((rx2-rx1)) B/s, 󰁝 $((tx2-tx1)) B/s"

	rx1=$rx2
	tx1=$tx2

	# dwm status bar
	xprop -root -set WM_NAME " $(network_format) | $(volume) | $(brightness) | $(battery) | $(date_format)"
done &

# Setting wallpaper
#while feh --bg-fill ~/downloads/wallpapers/$(ls ~/.local/share/wallpapers/ | shuf -n 1); do sleep 5m; done &
feh --bg-fill ~/.local/share/wallpapers/wallhaven-967rgd.jpg &

st -e tmux &
firefox &

# Start dwm
exec dwm
