#!/bin/vbash
source /opt/vyatta/etc/functions/script-template

# Set console
sudo systemctl enable serial-getty@ttyS0.service

# Add Debian Jessie repository
set system package repository jessie url 'http://ftp.nl.debian.org/debian/'
set system package repository jessie distribution 'jessie'
set system package repository jessie components 'main contrib non-free'

# Add Azure repository
set system package repository azure-backports url 'http://debian-archive.trafficmanager.net/debian'
set system package repository azure-backports distribution 'jessie-backports'
set system package repository azure-backports components 'main'
set system package repository azure url 'http://debian-archive.trafficmanager.net/debian-azure'
set system package repository azure distribution 'jessie'
set system package repository azure components 'main'
commit
save

# Install waagent
sudo apt-get update
sudo apt-get -y --force-yes install waagent

# Put waagent.conf
sudo cp /tmp/waagent.conf /etc/waagent.conf
sudo rm /tmp/waagent.conf

# Removing leftover leases and persistent rules
sudo rm -f /var/lib/dhcp3/*

# Removing apt caches
sudo rm -rf /var/cache/apt/*

# Removing hw-id
delete interfaces ethernet eth0 hw-id
commit
save
