INTERNAL=eDP-1-1
EXTERNAL=DP-3.1

INTERNAL_RES=1920x1080
EXTERNAL_RES=3440x1440

xrandr --output $INTERNAL --mode $INTERNAL_RES

if xrandr -q | grep -q "$EXTERNAL connected"; then
    echo "external detected"
    xrandr --output $EXTERNAL --mode $EXTERNAL_RES
    xrandr --output $EXTERNAL --right-of $INTERNAL
    xrandr --output $EXTERNAL --primary
else
    echo "no external detected"
    xrandr --output $INTERNAL --primary
fi
