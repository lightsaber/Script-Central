LOCAL=/tmp/packages
#SHARE=~/Ubuntu\ One/packages
SHARE=/tmp/shared_packages
PATCH=/tmp/packages.patch

#make sure apt package information is up to date
apt-get update
dpkg --get-selections > $LOCAL
diff $SHARE $LOCAL > $PATCH

# get the total number of changes
changes=`cat ${PATCH} | wc -l`
if [ $changes -le 0 ]; then
   echo "No changes"
   exit 0
fi

#patch shared file with outgoing changes
#TODO: this needs to be a smarter test as it does not capture what happens if only removals are done
outgoing=`grep ">" ${PATCH} | wc -l`
if [ 0 -lt ${outgoing} ]; then
   print "Patching shared file with ${outgoing} changes"
   patch $SHARE $PATCH
fi

## Section 3: apply changes
print "Applying ${incoming} incoming changes"
#dpkg --set-selections < ${SHARE}
#apt-get -u dselect-upgrade
 

#Clean up
rm $LOCAL $PATCH

