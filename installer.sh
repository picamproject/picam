#!/bin/sh
# installer.sh will install the necessary packages to get the gifcam up and running with 
# basic functions

# Install packages
PACKAGES="python-picamera python-pip samba samba-common-bin python3-pip python3-picamera"
apt-get update
apt-get install $PACKAGES -y
sudo pip3 install guizero


## Enable Camera Interface
CONFIG="/boot/config.txt"

# If a line containing "start_x" exists
if grep -Fq "start_x" $CONFIG
then
	# Replace the line
	echo "Modifying start_x"
	sed -i "s/start_x=0/start_x=1/g" $CONFIG
else
	# Create the definition
	echo "start_x not defined. Creating definition"
	echo "start_x=1" >> $CONFIG
fi

# If a line containing "gpu_mem" exists
if grep -Fq "gpu_mem" $CONFIG
then
	# Replace the line
	echo "Modifying gpu_mem"
	sed -i "/gpu_mem/c\gpu_mem=128" $CONFIG
else
	# Create the definition
	echo "gpu_mem not defined. Creating definition"
	echo "gpu_mem=128" >> $CONFIG
fi
## Enable Samba
SCONFIG="/etc/samba/smb.conf"

# If a line containing "workgroup" exists
if grep -Fq "workgroup = WORKGROUP" $SCONFIG
then
	# Checking again that workgroup is defined
	echo "Modifying workgroup"
	sed -i "s/#workgroup = WORKGROUP/workgroup = WORKGROUP/g" $SCONFIG
else
	# Create the definition
	echo "wingroup not defined. Creating definition"
	echo "workgroup = WORKGROUP" >> $SCONFIG
fi
# If a line containing "wins support" exists
if grep -Fq "workgroup = WORKGROUP" $SCONFIG
then
	# Checking again that workgroup is defined
	echo "Modifying wins support"
	sed -i "s/#wins support = yes/wins support = yes/g" $SCONFIG
else
	# Create the definition
	echo "wins support not defined. Creating definition"
	echo "wins support = yes" >> $SCONFIG
fi
# Create settings for samba
	echo "Creating config"
	echo "[PiShare]
 comment=Raspberry Pi Share
 path=/home/pi/share
 browseable=Yes
 writeable=Yes
 only guest=no
 create mask=0777
 directory mask=0777
 public=no" >> $SCONFIG

echo "Install complete, rebooting."
reboot