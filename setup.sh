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


git clone --recurse-submodules -j8 https://github.com/raj77in/kali-setup
cd 
echo "Check if bashrc sources ~/.bash_aliases, if not source the same"
# ln -s kali-setup/config/.bashrc
ln -s $PWD/Xdefaults .Xdefaults
ln -s $PWD/funcs .funcs
ln -s $PWD/inputrc .inputrc
ln -s $PWD/vimrc .vimrc
ln -s $PWD/bash_aliases .bash_aliases
ln -s $PWD/colorcombo .colorcombo
ln -s $PWD/tmux.conf .tmux.conf
## Some useful tmux plugins ...
ln -s $PWD/tmux ~/.tmux



## Install some useful stuff :)

apt update
apt autoremove
apt autoclean
apt install -y tmux-themepack-jimeh fonts-powerline fonts-font-awesome exploitdb-papers neofetch ack


## And now for pip3 and pwntools
#
apt install -y python3-pip
pip3 install --user pwntools


