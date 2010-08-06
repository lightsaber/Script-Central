#!/bin/sh
SHOW_DURATION=100
TRANSITION_DURATION=5.0

format=jpg
source_dir=$(pwd)

while getopts jph fmt
do
  case $fmt in 
  j) format=jpg;;
  p) format=png;;
  h) echo "Usage: $0 [jph] [image directory]";exit 0;
  esac
done

shift $(($OPTIND - 1))
if [ -n "$*" ]; then
  source_dir=$*
fi


echo "<background>" > background.xml
echo "<starttime><year>2009</year><month>08</month><day>04</day><hour>00</hour><minute>00</minute><second>00</second></starttime>" >> background.xml
for file in $( ls ${source_dir}/*.${format} ); do
   if [ -n "${first}" ]; then
	echo "<to>${file}</to></transition>" >> background.xml
   else
   	first=$file
   fi
   echo "<static><duration>${SHOW_DURATION}</duration><file>${file}</file></static>" >> background.xml
   echo "<transition><duration>${TRANSITION_DURATION}</duration><from>${file}</from>" >> background.xml
done
echo "<to>${first}</to></transition>" >> background.xml
echo "</background>" >> background.xml
