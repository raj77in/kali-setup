#!/bin/bash
#
ip=$1

nmap -p- --min-rate=5000 $ip -oA nmap/full-$ip
ports=$(cat nmap/full-$ip.gnmap |grep Ports  |sed -e 's/.*Ports://' -e 's/Ignored State:.*//' -e 's/ //g' -e 's#/.[^,]*##g')

nmap -sC -sV -A -p$ports $ip -oA nmap/ports-$ip

sudo nmap -p- --min-rate=5000 -sU $ip -oA nmap/full-udp-$ip
ports=$(cat nmap/full-$ip.gnmap |grep Ports  |sed -e 's/.*Ports://' -e 's/Ignored State:.*//' -e 's/ //g' -e 's#/.[^,]*##g')

sudo nmap -sU -sC -sV -A -p$ports $ip -oA nmap/ports-udp-$ip

sudo chown $USER:$USER nmap/*
