#!/bin/bash - 
#===============================================================================
#
#          FILE: setup.sh
# 
#         USAGE: ./setup.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Amit Agarwal (aka),
#  ORGANIZATION: Individual
#       CREATED: 11/29/2019 09:37
# Last modified: Fri Nov 29, 2019  12:32PM
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error


cd 
echo "Check if bashrc sources ~/.bash_aliases, if not source the same"
ln -s kali-setup/config/Xdefaults .Xdefaults
ln -s kali-setup/config/funcs .funcs
ln -s kali-setup/config/inputrc .inputrc
ln -s kali-setup/config/vimrc .vimrc
# ln -s kali-setup/config/.bashrc
ln -s kali-setup/config/bash_aliases .bash_aliases
ln -s kali-setup/config/colorcombo .colorcombo
ln -s kali-setup/config/tmux.conf .tmux.conf


## Install some useful stuff :)

apt update
apt autoremove
apt autoclean
apt install -y tmux-themepack-jimeh fonts-powerline fonts-font-awesome exploitdb-papers neofetch ack


## Some useful tmux plugins ...
mkdir ~/.tmux

cd ~/.tmux
git clone https://github.com/tmux-plugins/tmux-logging
git clone https://github.com/tmux-plugins/tmux-online-status
git clone https://github.com/tmux-plugins/tmux-pain-control
git clone https://github.com/tmux-plugins/tmux-sensible
git clone https://github.com/tmux-plugins/tmux-yank

## And now for pip3 and pwntools
#
apt install -y python3-pip
pip3 install --user pwntools


