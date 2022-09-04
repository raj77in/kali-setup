# filename="/tmp/$(date '+%Y%m%d%H%M%S%3N').png"
filename="/tmp/temp.png"
# import -window root  -crop 1845x1000+40+40 -comment aka -label AmitAgarwal -quality 100 -resize 200% -frame -silent $filename
wmctrl -a Typora
sleep 0.5 
xdotool type '### '
xdotool key Control_L+v
xdotool key Return
wmctrl -a Firefox
sleep 0.5 
import -window root  -comment aka -label AmitAgarwal -quality 100 -frame -silent $filename -crop 1330x759+295+230 -frame -resize 200%
xclip -selection clipboard -target image/png -filter -i $filename
wmctrl -a Typora
xdotool key Control_L+v
sleep 2
xdotool key Return
