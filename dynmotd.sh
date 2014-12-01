#!/bin/bash
 
echo "Start DynMOTD"
 
PROCCOUNT=`ps -Afl | wc -l`
PROCCOUNT=`expr $PROCCOUNT - 5`
GROUPZ=`groups`
USER=`whoami`
# ADMINS=`cat /etc/group | grep --regex "^sudo" | awk -F: '{print $4}' | tr ',' '|'`
# ADMINSLIST=`grep -E $ADMINS /etc/passwd | tr ':' ' ' | tr ',' ' ' | awk {'print $5,$6,"("$1")"'} | tr '\n' ',' | sed '$s/.$//'`
DIR=`dirname "$0"`
UPDATESAVAIL=`cat $DIR/updates-available`
UCOUNT=`$UPDATESAVAIL | wc -l`

if [[ $GROUPZ == "$USER sudo" ]]; then
export USERGROUP="Administrator"
elif [[ $USER = "root" ]]; then
export USERGROUP="Root"
elif [[ $USER = "$USER" ]]; then
export USERGROUP="Regular User"
else
export USERGROUP="$GROUPZ"
fi

if [ $UCOUNT = 0 ]; then
export UTEXT="No Updates Available"
else
export UTEXT=$UCOUNT "Updates Available"
fi

echo -e "\033[1;32m `cat $DIR/dynmotdart`
\033[0;35m+++++++++++++++++: \033[0;37mSystem Data\033[0;35m :+++++++++++++++++++
\033[0;35m+       \033[0;37mHostname \033[0;35m= \033[1;32m`hostname`
\033[0;35m+   \033[0;37mIPv4 Address \033[0;35m= \033[1;32m`ip addr show eth0 | grep "inet\ " | awk {'print $2'}`
\033[0;35m+   \033[0;37mIPv6 Address \033[0;35m= \033[1;32m`ip addr show eth0 | grep -m 1 "inet6\ " | awk {'print $2'}`	 
\033[0;35m+         \033[0;37mKernel \033[0;35m= \033[1;32m`uname -r`
\033[0;35m+         \033[0;37mDistro \033[0;35m= \033[1;32m`cat /etc/*release | grep "PRETTY_NAME" | cut -d "=" -f 2- | sed 's/"//g'`
\033[0;35m+         \033[0;37mUptime \033[0;35m= \033[1;32m`uptime | sed 's/.*up ([^,]*), .*/1/'`
\033[0;35m+           \033[0;37mTime \033[0;35m= \033[1;32m`date`
\033[0;35m+            \033[0;37mCPU \033[0;35m= \033[1;32m`cat /proc/cpuinfo | grep "model name" | cut -d ' ' -f3- | awk {'print $1,$2,$3,$4,$5,$6,$7,$8,$9,$10'} | head -1`
\033[0;35m+         \033[0;37mMemory \033[0;35m= \033[1;32m`free -t -m | grep "Mem" | awk {'print $4'}`MB Available, `free -t -m | grep "Mem" | awk {'print $3'}`MB Used, `free -t -m | grep "Mem" | awk {'print $2'}`MB Total
\033[0;35m+      \033[0;37mHDD Usage \033[0;35m= \033[1;32m`df -hT | grep "/home" | awk {'print $5'}`B Available, `df -hT | grep "/home" | awk {'print $4'}`B Used, `df -hT | grep "/home" | awk {'print $3'}`B Total 
\033[0;35m+        \033[0;37mUpdates \033[0;35m= \033[1;32m$UCOUNT $UTEXT 
\033[0;35m++++++++++++++++++: \033[0;37mUser Data\033[0;35m :++++++++++++++++++++
\033[0;35m+      \033[0;37m Username \033[0;35m= \033[1;32m`whoami`
\033[0;35m+      \033[0;37mUsergroup \033[0;35m= \033[1;32m$USERGROUP
\033[0;35m+     \033[0;37mLast Login \033[0;35m= \033[1;32m`last -a $USER | head -2 | awk 'NR==2{print $3,$4,$5,$6}'` from `last -a $USER | head -2 | awk 'NR==2{print $10}'`
\033[0;35m+       \033[0;37mSessions \033[0;35m= \033[1;32m`who | grep $USER | wc -l`
\033[0;35m+      \033[0;37mProcesses \033[0;35m= \033[1;32m$PROCCOUNT of `ulimit -u` max
\033[0;35m+        \033[0;37mScreens \033[0;35m= \033[1;32m`screen -ls`
\033[0;35m+++++++++++++: \033[0;37mHelpful Information\033[0;35m :+++++++++++++++    
\033[0;37m
"
