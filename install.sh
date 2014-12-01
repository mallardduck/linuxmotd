#!/bin/bash
# DynMotd Install Script
#!/bin/bash
#!/bin/bash

echo -ne "\033[0;32mPlease input installation directory (ENTER /etc/dynmotd)> \033[1;37m"
read dirinput
OS=`lsb_release -si`
inpsize=${#dirinput}

if [ "$inpsize" -eq 0 ]
then
echo "firstif"
installdir="/etc/dynmotd"
fi
if [ "$inpsize" -gt 0 ]
then
echo "secondif"
installdir=$dirinput
fi

echo "Installing 160k of lsb-core"
yum install redhat-lsb-core

mkdir $installdir
cp dynmotd.sh $installdir/dynmotd.sh
chmod 755 $installdir/dynmotd.sh
touch $installdir/dynmotdart
chmod 755 $installdir/dynmotdart
echo "MOTD ART DEFAULT: Please replace some ASCII art or the MOTD in /etc/dynmotd/dynmotdart" >> $installdir/dynmotdart
cp update-checker.sh $installdir/update-checker.sh
chmod 755 $installdir/update-checker.sh
touch $installdir/updates-available
chmod 755 $installdir/updates-available
echo "--" >> $installdir/updates-available
$installdir/update-checker.sh
echo -e "\033[0;33mScript setup complete, please refer to https://github.com/ReidWeb/linuxmotd/blob/master/README.md for instructions on how to complete the installation process \033[1;37m"
