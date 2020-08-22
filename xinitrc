#!/bin/sh

# /etc/X11/xinit/xinitrc
#
# global xinitrc file, used by all X sessions started by xinit (startx)

# invoke global X session script
# . /etc/X11/Xsession
#
#

terminator & 
xrandr --output Virtual-1 --auto --mode 1920x1080 & 
dunst & 
unclutter & 
/usr/bin/urxvtd -q -f -m -o &
compton --config ~/.config/i3/compton.conf &
f=$(cd /root/kali-setup/xrdb-colors; find . -type f -name \*xdefaults|sort -R|head -1); xrdb -merge ~/.Xdefaults; cd /root/kali-setup/xrdb-colors/$(dirname $f); xrdb -merge $(basename $f)
nm-applet &
/root/Documents/firefox/firefox &
# retext &
# /usr/bin/typora --no-sandbox
# /usr/bin/joplin --no-sandbox &
/usr/bin/cherrytree &
nitrogen --set-zoom-fill --random &
udiskie &
xset -dpms &
xset r rate 200  60 &
caffeine &
caffeine-indicator &
xautolock --time 2 --locker 'i3lock-fancy'
xfce4-power-manager &

cd /root
# exec i3
