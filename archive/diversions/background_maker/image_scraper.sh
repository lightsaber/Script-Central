#!/bin/sh
SCREEN_DIMENSIONS=1920x1200

for i in `seq 1 175`;do
  wget -U Mozilla -O /tmp/interfacelift.html http://interfacelift.com/wallpaper_beta/downloads/downloads/widescreen/${SCREEN_DIMENSIONS}/index${i}.html
  grep -o "http://interfacelift.com/wallpaper_beta/previews/.*\.jpg" /tmp/interfacelift.html | sed -e s/previews/dl/g | sed s/\.jpg/"\_${SCREEN_DIMENSIONS}.jpg"/g | xargs wget --wait=20 -U Mozilla ;
done
