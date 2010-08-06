
sudo apt-get install openvpn openvpn-blacklist network-manager-openvpn resolvconf

echo "Opening Astaro server.  Log in, download the file and save it in the ~/Downloads directory.  Then close the browser to continue"
firefox https://ash-hq-fw1.lifeoptions.com

DEFAULT_FILENAME=~/Downloads/sslvpn_conf__Michael.Nishizawa__ash-hq-fw1_lifeoptions_com.zip
FILENAME=/big/long/fake/path/to/fake/file

while [ ! -e FILENAME ]; do

	if [ -e $DEFAULT_FILENAME ]; then
	   FILENAME=$DEFAULT_FILENAME
	else
	   echo -n "default file was not found, please enter the location of the zip file"
	   read FILENAME
	fi

done

echo "Extracting config from $FILENAME"
cd /tmp
unzip $FILENAME

mkdir ~/.vpn
mv config ~/.vpn

echo "Configuration has been successfully extracted to ${HOME}/.vpn/config"
echo "Open the Network Manager configuration and import the configuration from ${HOME}/.vpn/config"

