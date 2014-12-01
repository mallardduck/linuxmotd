#!/bin/bash

yum check-update
yum list updates | grep 'updates-' | awk {'print $1'} > /etc/dynmotd/updates-available 
echo "Update Check Complete"
