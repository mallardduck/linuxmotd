#!/bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
PROCCOUNT=`ps -Afl | wc -l`
PROCCOUNT=`expr $PROCCOUNT - 5`
GROUPZ=`groups`
USER=`whoami`
DIR=`dirname "$0"`
UCOUNT=`cat $DIR/updates-available | wc -l`
LASTTIME=`last -a $USER | head -2 | awk 'NR==2{print $3,$4,$5,$6}'`
LASTLOG=`last -a $USER | head -2 | awk 'NR==2{print $10}'`
LASTLOGIN="$LASTTIME  from $LASTLOG"

## FIX this eventually
# ADMINS=`cat /etc/group | grep --regex "^sudo" | awk -F: '{print $4}' | tr ',' '|'`
# ADMINSLIST=`grep -E $ADMINS /etc/passwd | tr ':' ' ' | tr ',' ' ' | awk {'print $5,$6,"("$1")"'} | tr '\n' ',' | sed '$s/.$//'`

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
export UTEXT="$UCOUNT Updates Available"
fi

if [[ $LASTLOGIN == from ]];then LASTLOGIN="No Previous";fi
if [[ -z $LASTLOG ]];then LASTLOGIN="No Previous";fi

echo -e "\033[1;32m`cat $DIR/dynmotdart`
\033[0;35m+++++++++++++++++: \033[0;37mSystem Data\033[0;35m :+++++++++++++++++++
\033[0;35m+           \033[0;37mTime \033[0;35m= \033[1;32m`date`
\033[0;35m+       \033[0;37mHostname \033[0;35m= \033[1;32m`hostname`
\033[0;35m+         \033[0;37mUptime \033[0;35m= \033[1;32m`uptime | sed 's/.*up ([^,]*), .*/1/'`
\033[0;35m+   \033[0;37mIPv4 Address \033[0;35m= \033[1;32m`ip addr show eth0 | grep "inet\ " | awk {'print $2'}`
\033[0;35m+   \033[0;37mIPv6 Address \033[0;35m= \033[1;32m`ip addr show eth0 | grep -m 1 "inet6\ " | awk {'print $2'}`
\033[0;35m+         \033[0;37mKernel \033[0;35m= \033[1;32m`uname -r`
\033[0;35m+         \033[0;37mDistro \033[0;35m= \033[1;32m`lsb_release -sd`
\033[0;35m+            \033[0;37mCPU \033[0;35m= \033[1;32m`cat /proc/cpuinfo | grep "model name" | cut -d ' ' -f3- | awk {'print $1,$2,$3,$4,$5,$6,$7,$8,$9,$10'} | head -1`
\033[0;35m+         \033[0;37mMemory \033[0;35m= \033[1;32m`free -t -m | grep "Mem" | awk {'print $4'}`MB Available, `free -t -m | grep "Mem" | awk {'print $3'}`MB Used, `free -t -m | grep "Mem" | awk {'print $2'}`MB Total
\033[0;35m+      \033[0;37mHDD Usage \033[0;35m= \033[1;32m`df -hT | grep -P '[/]$' | awk {'print $5'}`B Available, `df -hT | grep -P '[/]$' | awk {'print $4'}`B Used, `df -hT | grep -P '[/]$' | awk {'print $3'}`B Total 
\033[0;35m+        \033[0;37mUpdates \033[0;35m= \033[1;32m$UTEXT
\033[0;35m++++++++++++++++++: \033[0;37mUser Data\033[0;35m :++++++++++++++++++++
\033[0;35m+      \033[0;37m Username \033[0;35m= \033[1;32m`whoami`
\033[0;35m+      \033[0;37mUsergroup \033[0;35m= \033[1;32m$USERGROUP
\033[0;35m+     \033[0;37mLast Login \033[0;35m= \033[1;32m$LASTLOGIN
\033[0;35m+       \033[0;37mSessions \033[0;35m= \033[1;32m`who | grep $USER | wc -l`
\033[0;35m+      \033[0;37mProcesses \033[0;35m= \033[1;32m$PROCCOUNT of `ulimit -u` max
\033[0;35m+        \033[0;37mScreens \033[0;35m= \033[1;32m`screen -ls`
\033[0;35m+++++++++++++: \033[0;37mHelpful Information\033[0;35m :+++++++++++++++
\033[0;37m
\033[0;35m+++++++++++++: \033[0;37mWho else is Logged-In\033[0;35m :+++++++++++++++
\033[0;37m"
w