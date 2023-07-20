#!/bin/bash


ip=$1

exec &> check-ports-$ip.log
#TCP Ports
ports=$(cat nmap/full-$ip.gnmap |grep Ports  |sed -e 's/.*Ports://' -e 's/Ignored State:.*//' -e 's/ //g' -e 's#/.[^,]*##g' | tr ',' '\n')
for i in ${ports[*]}
do
  echo ;echo; echo;
  echo "Checking port number $i on $ip"
  echo "====================================="

  echo; echo "OPTIONS http request"
  cat <<EOF | timeout 5 nc -v $ip $i
OPTIONS / HTTP/1.0

EOF

  echo; echo "GET http request"
  cat <<EOF | timeout 5 nc -v $ip $i
GET / HTTP/1.0

EOF
  echo; echo "POST http request"
  cat <<EOF | timeout 5 nc -v $ip $i
POST / HTTP/1.0

EOF
  echo; echo "help command"
  cat <<EOF | timeout 5 nc -v $ip $i
help

EOF
  echo; echo "? command"
  cat <<EOF | timeout 5 nc -v $ip $i
?

EOF
done


## UDP Ports
# ports=$(cat nmap/full-$ip.gnmap |grep Ports  |sed -e 's/.*Ports://' -e 's/Ignored State:.*//' -e 's/ //g' -e 's#/.[^,]*##g')
