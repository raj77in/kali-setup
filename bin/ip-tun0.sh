#!/bin/bash

# [[ -f /proc/sys/net/ipv4/conf/tun0 ]] && ip a show dev tun0|awk '/inet /{print $2}' || echo "Tun Down"
[[ -x /proc/sys/net/ipv4/conf/tun0 ]] && ip -o -4 --color=never -br -p  a s dev tun0 |awk '{print $3}' || echo "Tun Down"
