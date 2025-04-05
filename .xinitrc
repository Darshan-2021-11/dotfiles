# autostart before WM
## If no match found, run the process in the background
check_process() {
  local input_string=$1
  if ! top -b -n 1 | grep -q "$ {input_string}$"; then
    "$@" &
  fi
}
## daemons
check_process xautolock -time 3 -locker "systemctl suspend" -corners ---- -cornersize 50
check_process dunst
check_process slstatus
## setups
check_process redshift -PO3000
## applications
st &
##decrease response time of keyboard in Xserver for faster nvim
xset r rate 300 40
firefox &

# Run WM
## Enable java applications support
export AWT_TOOLKIT=MToolkit
export _JAVA_AWT_WM_NONREPARENTING=1
exec dwm
