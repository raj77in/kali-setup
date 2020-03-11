#!/bin/bash - 
#===============================================================================
#
#          FILE: fix.sh
# 
#         USAGE: ./fix.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Amit Agarwal (aka), amit.agarwal@mobileum.com
#  ORGANIZATION: Individual
#       CREATED: 03/10/2020 13:02
# Last modified: Tue Mar 10, 2020  01:05PM
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
for i in *
do
    f="${i// /_}.xdefaults"
    echo $f
    sed 's/*\./*/' "$i" > $f
    rm -f "$i"
done

