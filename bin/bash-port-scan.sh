#!/bin/bash -
#===============================================================================
#
#          FILE: bash-port-scan.sh
#
#         USAGE: ./bash-port-scan.sh
#
#   DESCRIPTION:
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Amit Agarwal (aka),
#  ORGANIZATION: Individual
#       CREATED: 11/07/18 23:05:43
#      REVISION:  ---
#===============================================================================

ip=$1
# for port in {1..65535}; do
#   echo | tee /dev/tcp/$ip/$port &>/dev/null &&
#     echo "port $port is open" ||
#     echo -n " . "
# done

function portscan() {
  for p in {0..65535}; do
    (
    printf "%06d\r" $p
      (
         bash -c "(>/dev/tcp/$1/$p)" 2> /dev/null && echo open: $p
      ) &
      read -t0.1
      kill $! 2>/dev/null
    ) 2>/dev/null
  done
}


portscan $1
