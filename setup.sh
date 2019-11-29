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
#        AUTHOR: Amit Agarwal (aka), amit.agarwal@mobileum.com
#  ORGANIZATION: Individual
#       CREATED: 11/29/2019 09:37
# Last modified: Fri Nov 29, 2019  10:20AM
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





