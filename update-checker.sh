#!/bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

yum check-update
yum list updates | grep 'updates-' | awk {'print $1'} > $DIR/updates-available 
echo "Update Check Complete"
