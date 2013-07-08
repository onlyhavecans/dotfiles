xrandr --output DVI-0 --auto --mode 1920x1200 --primary
xrandr --output VGA-0 --auto --mode 1920x1080 --left-of DVI-0
xrandr --output DisplayPort-0 --auto --mode 1920x1080 --right-of DVI-0
setxkbmap -option ctrl:nocaps
eval `cat $HOME/.fehbg`
tint2 &
