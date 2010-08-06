
USAGE_MSG="usage: ${0} [-c user@hostname] [-p grindr/instance/homedir]"

while getopts c:p: o
do
  case $o in
  c) CONNECTION=$OPTARG;;
  p) GRINDR_HOME=$OPTARG;;
  esac
done

#Set default values for the variables if no input is given
if [ -z "$CONNECTION" ]; then
  CONNECTION=localhost
fi

if [ -z "$GRINDR_HOME" ]; then
  GRINDR_HOME=/lifeoptions/apps/grindr
fi

echo "Checking status of Grindr on ${CONNECTION}:${GRINDR_HOME}"
 
OUTPUT=$(ssh $CONNECTION "if [ -e ${GRINDR_HOME}/.pid ]; then PID=\`cat ${GRINDR_HOME}/.pid\`; fi && if [ -n \"\${PID}\" ]; then ps hp \${PID}; else echo \"pid was \$PID\" fi")

echo "STATUS: ${OUTPUT}"

if [ -z "${OUTPUT}" ]; then
   echo "GRINDR IS NOT RUNNING FOR CONNECTION ${CONNECTION}"
else
   echo OK
fi
