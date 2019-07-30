#!/bin/bash

vol=$(amixer -D pulse get Master | awk -F'[]%[]' '/%/ {if ($5 == "off") { print "mm" } else { print $2 }}' | head -n 1)

echo vol=$vol%
exit 0
