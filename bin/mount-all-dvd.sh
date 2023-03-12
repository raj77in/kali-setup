#!/bin/bash - 
#===============================================================================
#
#          FILE: mount-all-dvd.sh
# 
#         USAGE: ./mount-all-dvd.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 12/28/2022 19:31
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
udisksctl dump |
  awk -F':\n' -v'RS=\n\n' '/[ \t]*HintAuto:[ \t]*true/&&/\.Filesystem:/{
                             print $1
                           }' | while read dev
  do
    udisksctl mount --object-path "${dev##*/UDisks2/}"
  done

