#!/bin/bash
export dbh='/mnt/Dropbox/Win-Downloads/Hacking'
export wdt='/mnt/Dropbox/Calibre-Kindle-Unlimited/Security/WindowsTools'
export gwt='/root/amitag/git/tools/Windows'
grep -i $1 /root/kali-setup/bin/repo-files | envsubst
