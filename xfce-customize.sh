#!/bin/bash - 
#===============================================================================
#
#          FILE: xfce-customize.sh
# 
#         USAGE: ./xfce-customize.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Amit Agarwal (aka), 
#  ORGANIZATION: Individual
#       CREATED: 01/16/2021 11:36
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
## From :: https://www.offensive-security.com/kali-linux/kali-linux-customization/?hss_channel=lcp-5384047

## Light theme
# xfconf-query -c xsettings -p /Net/IconThemeName -s Flat-Remix-Blue-Light
# xfconf-query -c xsettings -p /Net/ThemeName -s Kali-Light
# xfconf-query -c xfwm4 -p /general/theme -s Kali-Light
# gsettings set org.xfce.mousepad.preferences.view color-scheme Kali-Light
## Dark theme
xfconf-query -c xsettings -p /Net/IconThemeName -s Flat-Remix-Blue-Dark
xfconf-query -c xsettings -p /Net/ThemeName -s Kali-Dark
xfconf-query -c xfwm4 -p /general/theme -s Kali-Dark
gsettings set org.xfce.mousepad.preferences.view color-scheme Kali-Dark

## Remove dock shadow
xfconf-query -c xfwm4 -p /general/show_dock_shadow -s false

## Add plank
sudo apt install plank
echo "Window Manager Tweaks → Compositor → disable Show shadows under dock windows"

sudo apt -y install compton
xfconf-query -c xfwm4 -p /general/use_compositing -s false

