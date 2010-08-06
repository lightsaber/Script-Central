#!/bin/bash
#this only works on hma proxies


url='http://www.hidemyass.com/proxy-list/search-3843'

if [ -e /tmp/fpx ]; then
    rm -rf /tmp/fpx
fi
mkdir /tmp/fpx
cd /tmp/fpx

wget -O'data.html' $url

csplit -fpx data.html '/<tr class/' '{*}'

#the first file is garbage
rm px00

if [ ! -e work ]; then 
   mkdir work
fi 
cd work

for px in $(ls ../px*); do
    rm -rf *
    csplit -frow $px '/<td/' '{*}'
    rm row00
    if [ 2 -eq $(grep 'speed_green.gif') ]; then
        #parse out the ip address
        grep -0
        ip=$(cat row02 | sed -rn 's/^.*>([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}).*/\1/p')
        #portimg= HERE IS THE PROBLEM
        #hma stores port numbers as images, and the image files seem to rotate so you can't index the number
        echo "found a good proxy $ip"
        exit 0
    fi
done

echo "no proxy found"
