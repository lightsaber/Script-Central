
echo "This script will remove the following directories. If you are not prepared to do this, please exit now."

echo `ls deploy tomcat/lib/ext tomcat/temp/ tomcat/webapps/ tomcat/work/`

in=""

echo "Do you want to continue? y/N"
read in

if [ -z "${in}" -o "$in" != "y" ]; then
 echo "Exiting..."
 exit 0
fi

rm -rf deploy
rm -rf tomcat/lib/ext
rm -rf tomcat/temp
rm -rf tomcat/webapps
rm -rf tomcat/work

echo "All application data has been cleaned from the application.  You may now extract the package"  
