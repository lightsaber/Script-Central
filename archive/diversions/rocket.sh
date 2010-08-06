

function printRocket
{
	# You did realize that all rockets have USA on the side, right?
	echo ""
	echo "       ^"
	echo "      / \\"
	echo "     /   \\" 
	echo "    /     \\"
	echo "   /       \\"
	echo "   ~|~~~~~|~"
	echo "    |     |"
	echo "    |  U  |"
	echo "    |  S  |"
	echo "    |  A  |"
	echo "    |     |"
	echo "   /       \\"
	echo "  /         \\"
	echo "  ~~/ \\~/ \\~~"
	echo "     V   V"
}

# put the rocket at or near the bottom of the screen
for i in `seq 0 50`; do
   echo " "
done

printRocket

start=5
for i in `seq 0 $start`; do
  c=$(($start-$i))
  printf "\rBlasting off in %01d" \ $c
  sleep 1
done

blinks=5
for i in `seq 0 $blinks`; do
  line=$(($i%2))
  if [ $line = 0 ]; then
     printf "\r   BLAST OFF!!!!!!   "
  else
     printf "\r                     "
  fi
  sleep 1
done
printf "\r                  \r"

trail=50
for i in `seq 1 $trail`; do
  line=$(($i%2))
  if [ $line = 0 ]; then
     echo "   ((( ((("
  else
      echo "    ))) )))"
  fi  

   #my rudimentary acceleration algorithm
   printf -v c "%02d" \ $(($trail/$i))
   sleep 0.$c
done



