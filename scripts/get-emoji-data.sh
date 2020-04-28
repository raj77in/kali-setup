#!/bin/bash


if  [[ -f emoji ]]
then
    if [[ -f emoji.bak ]]
    then
    	echo "backup exists"
    else
    	mv emoji emoji.bak
    fi
fi

# wget -c https://www.unicode.org/Public/UCD/latest/ucd/emoji/emoji-data.txt
# wget -c https://www.unicode.org/Public/emoji/13.0/emoji-test.txt

##aka grep -vE '^#' emoji-data.txt | grep -v '^$' | awk -F'[;#)\t]' '{
##aka     a = substr($1, 1,4);
##aka     b = $NF ;
##aka     gsub("^ +","", b)
##aka     printf("%c\t%s ; U+%s\n", strtonum("0x"a), b, a)
##aka }' >emoji


grep -v  '^#' emoji-test.txt|grep -v '^$'| while read line
do
    i=$(echo $line |sed 's;.*# ;;'|sed 's/ E[0-9]\{1,2\}\.[0-9]//')
    echo $i
done
