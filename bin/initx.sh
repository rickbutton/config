~/config/bin/screen.sh

killall stalonetray >/dev/null 2>&1
stalonetray >/dev/null 2>&1 &

killall nm-applet >/dev/null 2>&1 
nm-applet >/dev/null 2>&1 &

killall feh >/dev/null 2>&1
feh --bg-scale ~/.xmonad/background.jpg >/dev/null 2>&1

setxkbmap -layout us -option ctrl:nocaps
xsetroot -cursor_name left_ptr
