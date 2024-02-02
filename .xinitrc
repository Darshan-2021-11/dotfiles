# Keyboard Layout
setxkbdmap ch &

# Display Resolution
xrandr --output Virtual-1 --mode 1366x768 &

# Compositor
# picom -f &

# Update status bar of dwm
while :; do
	# update internet_speed
	rx1=$(cat /sys/class/net/wlp9s0/statistics/rx_bytes)
	tx1=$(cat /sys/class/net/wlp9s0/statistics/tx_bytes)
	sleep 1s
	rx2=$(cat /sys/class/net/wlp9s0/statistics/rx_bytes)
	tx2=$(cat /sys/class/net/wlp9s0/statistics/tx_bytes)

	network_info="󰁅 $((rx2-rx1)) B/s, 󰁝 $((tx2-tx1)) B/s"

	# dwm status bar
	xprop -root -set WM_NAME " $(echo $network_info) | $(volume) | $(brightness) | $(battery) | $(date '+%r %a %d %b %y')"
done &

# Setting wallpaper
# changing wallpaper at some time interval
#while feh --bg-fill ~/.local/share/wallpapers/$(ls ~/.local/share/wallpapers/ | shuf -n 1); do sleep 5m; done &
# setting wallpaper once per login
exec feh --bg-fill ~/.local/share/wallpapers/$(ls ~/.local/share/wallpapers/ | shuf -n 1) &
# adjust blue light filter
redshift -O3000 -v

# Launch programs
exec st -e tmux &
exec firefox &

# sleep after inactivity
# disallow sleep when mouse cursor is at any corner of screen using the
# '-corners ----' command, useful while watching videos
exec xautolock -time 5 -locker "systemctl suspend; slock;" -corners ---- &

# Start dwm, with hot reload
# while true; do
# 	# Log stderror to a file 
# 	dwm 2> ~/.dwm.log
# 	# No error logging
# 	#dwm >/dev/null 2>&1
# done
exec dwm
