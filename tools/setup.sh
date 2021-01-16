#!/bin/bash

export TUN=${TUN:-tap0}
export GDIR=${GDIR:-/root/amitag/git/tools}
export IP=${1:-10.10.10.10}
export LPORT=${LPORT:-8001}
export LIP=$(ip -o -4 --brief a \
             show dev  $TUN |awk '{print $3}'|sed 's;/.*;;')

BASE=$(cd $(dir=$(dirname $0);cd $dir; pwd))

export autorecon="$GDIR/AutoRecon/src/autorecon"
export gobuster="$GDIR/Scanning/ffuf"
export nmap="/usr/bin/nmap"

if [[ $# -lt 2 ]]
then
    echo "Not enough arguments."
    echo "Run with <folder> <script>"
    dirs=$(find -type f|sed 's/^..//'|grep '\/'|awk -F'/' '{print $1}'|sort |uniq)
    echo "Folders : $dirs"
    echo "All modules :: $(for i in $dirs; do find $i -type f -name \*sh ; done)"
    exit 2
fi

. $BASE/$1/$2.sh
    