#!/bin/bash - 
#===============================================================================
#
#          FILE: wget-learning-resources.sh
# 
#         USAGE: ./wget-learning-resources.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 01/23/2020 22:09
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error


curl --header 'Host: docs.google.com' --user-agent 'Mozilla/5.0 (X11; Linux x86_64; rv:72.0) Gecko/20100101 Firefox/72.0' --header 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8' --header 'Accept-Language: en-US,en;q=0.5' --referer 'https://docs.google.com/spreadsheets/d/12bT8APhWsL-P8mBtWCYu4MLftwG1cPmIL25AEBtXDno/edit' --cookie 'S=apps-spreadsheets=TdDWBY8RGusAUGuSm8QY2hMAJrelD9Vy; NID=196=dZUBzmgLJLnPcalsqvGg4JBgHsYuWBgZ65X21g6wMHeyRltZSjdgoONWCnFeaCyL9khuyXoRwDpIkA1pAG--4tslP4JbIfHIoEeRFz-m9N3q7AXCbuYvvbBDANic4yhPUlzeDdzXe9sTI2WKCZ1gzIFbgguapQJOXYqHAE0rMtQzIV1sgMF_K2_Cy9o15S71UOQa; ANID=AHWqTUmi4uWrpQPTXfuHSgElGJ4onhpgKG7vzVU2Ife2Vhg76yoSI7wOw0ShPSVh; 1P_JAR=2020-1-23-16' --header 'Upgrade-Insecure-Requests: 1' 'https://docs.google.com/spreadsheets/d/12bT8APhWsL-P8mBtWCYu4MLftwG1cPmIL25AEBtXDno/export?format=xlsx&id=12bT8APhWsL-P8mBtWCYu4MLftwG1cPmIL25AEBtXDno' --output 'Learning Resources.xlsx'

curl --header 'Host: docs.google.com' --user-agent 'Mozilla/5.0 (X11; Linux x86_64; rv:72.0) Gecko/20100101 Firefox/72.0' --header 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8' --header 'Accept-Language: en-US,en;q=0.5' --referer 'https://docs.google.com/spreadsheets/d/12bT8APhWsL-P8mBtWCYu4MLftwG1cPmIL25AEBtXDno/edit' --header 'Content-Type: application/x-www-form-urlencoded' --header 'Origin: https://docs.google.com' --cookie 'S=apps-spreadsheets=TdDWBY8RGusAUGuSm8QY2hMAJrelD9Vy; NID=196=dZUBzmgLJLnPcalsqvGg4JBgHsYuWBgZ65X21g6wMHeyRltZSjdgoONWCnFeaCyL9khuyXoRwDpIkA1pAG--4tslP4JbIfHIoEeRFz-m9N3q7AXCbuYvvbBDANic4yhPUlzeDdzXe9sTI2WKCZ1gzIFbgguapQJOXYqHAE0rMtQzIV1sgMF_K2_Cy9o15S71UOQa; ANID=AHWqTUmi4uWrpQPTXfuHSgElGJ4onhpgKG7vzVU2Ife2Vhg76yoSI7wOw0ShPSVh; 1P_JAR=2020-1-23-16' --header 'Upgrade-Insecure-Requests: 1' --request POST --data-urlencode 'a=true' --data-urlencode 'pc=[null,null,null,null,null,null,null,null,null,0,null,10000000,null,null,null,null,null,null,null,null,null,null,null,null,null,null,43853.92374909722,null,null,[1,null,0,0,0,0,0,0,1,1,2,1,null,null,2,1],["A4",0,2,1,[0.75,0.75,0.7,0.7]],null,0,null,0]' --data-urlencode 'gf=[]' 'https://docs.google.com/spreadsheets/d/12bT8APhWsL-P8mBtWCYu4MLftwG1cPmIL25AEBtXDno/pdf?id=12bT8APhWsL-P8mBtWCYu4MLftwG1cPmIL25AEBtXDno' --output 'Learning Resources.pdf'

curl --header 'Host: docs.google.com' --user-agent 'Mozilla/5.0 (X11; Linux x86_64; rv:72.0) Gecko/20100101 Firefox/72.0' --header 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8' --header 'Accept-Language: en-US,en;q=0.5' --referer 'https://docs.google.com/spreadsheets/d/12bT8APhWsL-P8mBtWCYu4MLftwG1cPmIL25AEBtXDno/edit' --cookie 'S=apps-spreadsheets=TdDWBY8RGusAUGuSm8QY2hMAJrelD9Vy; NID=196=dZUBzmgLJLnPcalsqvGg4JBgHsYuWBgZ65X21g6wMHeyRltZSjdgoONWCnFeaCyL9khuyXoRwDpIkA1pAG--4tslP4JbIfHIoEeRFz-m9N3q7AXCbuYvvbBDANic4yhPUlzeDdzXe9sTI2WKCZ1gzIFbgguapQJOXYqHAE0rMtQzIV1sgMF_K2_Cy9o15S71UOQa; ANID=AHWqTUmi4uWrpQPTXfuHSgElGJ4onhpgKG7vzVU2Ife2Vhg76yoSI7wOw0ShPSVh; 1P_JAR=2020-1-23-16' --header 'Upgrade-Insecure-Requests: 1' 'https://docs.google.com/spreadsheets/d/12bT8APhWsL-P8mBtWCYu4MLftwG1cPmIL25AEBtXDno/export?format=ods&id=12bT8APhWsL-P8mBtWCYu4MLftwG1cPmIL25AEBtXDno' --output 'Learning Resources.ods'

