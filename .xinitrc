# Enable java applications support
export AWT_TOOLKIT=MToolkit
export _JAVA_AWT_WM_NONREPARENTING=1

# If no match found, run the process in the background
check_and_run() {
  local input_string=$1
  if ! top -b -n 1 | grep -q "$ {input_string}$"; then
    "$@" &
  fi
}

#Start autostart before dwm
check_and_run xautolock -time 3 -locker "systemctl suspend" -corners ---- -cornersize 50
check_and_run redshift -PO3000
check_and_run dunst
check_and_run slstatus
check_and_run st
check_and_run firefox
exec dwm
