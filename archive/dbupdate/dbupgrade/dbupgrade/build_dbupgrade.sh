#!/bin/bash

function filter
{
    sql_script=$1
    startrev=$2

    #filter files that were last changed previous to this start date
    for file in $(ls); do
    change_version=$(svn info $file  | sed -n 's/Last Changed Rev: \([[:digit:]]*\)/\1/p')
    if [ $change_version -gt $startrev ]; then
        echo "${file} was last changed at version ${change_version}"
        echo "" >> ${sql_script} #make sure we start on a new line for the next file
        echo "--  $file " >> ${sql_script} 
        cat $file >> ${sql_script}
        echo ";" >> ${sql_script}
    fi
    done

}

if [ -z ${1} ]; then
  echo "USAGE: ${0} svn_location start_rev end_rev"
  echo "EXAMPLE: ${0} svn+ssh://username@svn.lifeoptions.com/repos/platform/trunk/core/db 1301 1311"
  echo "The script expects that svn_location will contain tables, views, and updates directories so the directory structure would be:"
  echo "db"
  echo " |- tables"
  echo " |- updates"
  echo " |- views"
  exit 1
fi

location=$1
start=$2
end=$3
if [ -z $end ]; then
   end=HEAD
fi

SCRIPT_OUTPUT=$(pwd)
script=${SCRIPT_OUTPUT}/update${start}To${end}.sql
# remove the file if it already exists
if [ -e $script ]; then
   rm $script
fi

svn co -r${end} $location .svntmp

#add updates to the script
cd .svntmp/updates
filter ${script} ${start}

# add views to the script
cd ../views
filter ${script} ${start}

if [ ! -e ${script} ]; then
    echo "No updates found between ${start} and ${end}"
fi

cd ../..

rm -rf .svntmp

