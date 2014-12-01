#!/bin/bash
# DynMotd Install Script
#!/bin/bash
#!/bin/bash

echo -ne "\033[0;32mInput installation directory (ENTER /usr/local/scripts/liquidstat)> \033[1;37m"
read dirinput
inpsize=${#dirinput}

if [ "$inpsize" -eq 0 ]
then
installdir="/usr/local/scripts"
fi
if [ "$inpsize" -gt 0 ]
then
installdir=$dirinput
fi

echo "Installing 160k of lsb-core"
yum install redhat-lsb-core

mkdir $installdir
cp liquidstat $installdir/liquidstat
chmod 755 $installdir/liquidstat
ln -s $installdir/liquidstat /usr/bin/liquidstat

cp update-checker.sh $installdir/update-checker.sh
chmod 755 $installdir/update-checker.sh
touch $installdir/updates-available
chmod 755 $installdir/updates-available
echo "--" >> $installdir/updates-available
echo -e "\033[0;33mScript setup complete, please refer to https://github.com/ReidWeb/linuxmotd/blob/master/README.md for instructions on how to complete the installation process \033[1;37m"
