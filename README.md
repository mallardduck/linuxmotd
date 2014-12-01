Liquid Status
=========

Dynamically Generated Status reads for Linux Servers 

Compatibility: Fedora/RHEL/CentOs based Distributions

![animated-screenshot](http://download.reidweb.com/dynmotdimg.gif)

## Fedora/RHEL/CentOs Installation

Clone the github repository
```bash
git clone https://github.com/MallardDuck/linuxmotd.git -b liquid
```
Run the 'installation' script
```bash
cd linuxmotd
sudo ./install.sh
```
I'd recommend installing to /usr/var/scripts, if you don't input anything it will default to /usr/var/scripts. If you decided to use another directory, remember to change the directories below

### Run the script
From it's (default) home:
```bash
/usr/var/scripts/liquidstat
```
