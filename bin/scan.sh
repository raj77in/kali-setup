#!/bin/bash -
#===============================================================================
#
#          FILE: basic-scan.sh
#
#         USAGE: ./basic-scan.sh
#
#   DESCRIPTION:
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Amit Agarwal (aka), amit.agarwal@mobileum.com
#  ORGANIZATION: Mobileum
#       CREATED: 12/30/2017 22:39
# Last modified: Mon Jan 20, 2020  11:03PM
#      REVISION:  ---
#===============================================================================

## TODO: snmpwalk -- done
##       UDP scan  -- done
##       dirsearch -- dirsearch.py -u http://docker.hackthebox.eu:33594/ -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt -t 200 -e php --recursive --follow-redirects


alias dirb=gobuster
alias dirb=$TOOLS/Scanning/ffuf/ffuf
trap 'eval echo "$(date) \| DEBUG \| $BASH_COMMAND"' DEBUG



header ()
{
    cat <<-'EOF'


                       /\ \
                    __ \ \ \/'\      __
                  /'__'\\ \ , <    /'__'\
                 /\ \L\.\\ \ \\'\ /\ \L\.\_
                 \ \__/.\_\ \_\ \_\ \__/.\_\
                  \/__/\/_/\/_/\/_/\/__/\/_/
                 
    Initial Scan of Host - $2 (IP: $1)
    Script written by: Amit Agarwal
    Execution at : $(date)
    ------------------------------------

EOF
}   # ----------  end of function header  ----------

if [[ -z $1 || -z $2 ]]
then
    echo "Need two params param"
    header
    echo "Run as : $0 <IP> <Hostname>"
    exit -1
fi

export SESSION="$2-$$"
tmux -2 new-session -d -s $SESSION

export count=0
export ncount=1
cfile=/tmp/$$.count
cnfile=/tmp/$$.ncount
echo "0" >$cfile
echo "0" >$cnfile

tpane()
{
    count=$(< "$cfile" )
    [[ $count != "0" ]] && tmux split-window -v;
    # tmux select-pane -t $count
    tmux send-keys "$*" C-m && tmux display-message "Completed $1" || \
        tmux display-message "Failed $1"
            (( ++count ))
            printf '%s\n' "$count" >"$cfile"
            #wait for pane to open
            # sleep 1
        }

    twin()
    {
        ncount=$(< "$cnfile" )
        tmux new-window -t $SESSION -n "$1"
        (( ++counter_curr ))
        printf '%s\n' "$ncount" >"$cnfile"
        echo "0" >$cfile
        # sleep 1
    }

webscan ()
{

    read -p "Enter the web port to use :: " wport
    wport=${wport:-80}
    read -p "https? " ans
    if [[ $ans == 'y' ]]
    then
        https="https"
    else
        https="http"
    fi
    export https

    lynx -dump -listonly ${https}://$ip:$wport  > $odir/web-links.txt

    read -p "Do you want to run nikto :: " ans
    if [[ $ans == 'y' ]]
    then
        twin "web-$wport"

        tpane nikto -host $ip -port $wport -output  $odir/nikto-$wport.txt
        #dirb $ip

        tpane uniscan -u ${https}://$ip:$wport -qweds |tee   $odir/nikto-$wport.txt
        echo "Web details"
        whatweb $ip:$wport |tee $odir/whatweb-$wport

        curl -m 10 "$https://$ip:$wport/robots.txt" |tee $odir/robots-$wport.txt

    fi
    # twin "web-analysis"
    # read -p "Do you want to run web analysis tools :: " ans
    # if [[ $ans == "y" ]]
    # then
    # commix --level 3 --output-dir $odir/commix/  -u "$https://$ip" --all
    # w3af
    # skipfish -d 4 -c 5 -o $odir/skipfish/$ip  $https://$ip
    # echo "Nothing to do"
    # fi

    read -p "Enumerate Web Server directory :: " ans
    curl ${https}://$ip:$wport -s -L | grep "title\|href" | sed -e 's/^[[:space:]]*//' | \
        tee $odir/curl-links-$wport.txt

    curl ${https}://$ip:$wport -s -L | html2text -width '99' | uniq | \
        tee $odir/curl-html-$wport.txt


    if [[ $ans == "y" ]]
    then
        twin "web-enum-$wport"
        [[ ! -d $odir/dirb ]] && mkdir $odir/dirb
        tpane dirb $https://$ip:$wport |tee $odir/dirb/initial-$wport.txt

        tpane dirb $https://$ip:$wport \
            /usr/share/dirb/wordlists/vulns/cgis.txt \
            -x /usr/share/dirb/wordlists/extensions_common.txt | \
            tee $odir/dirb/extensions-$wport.txt


        [[ ! -d $odir/gobuster ]] && mkdir $odir/gobuster
        tpane gobuster -u $https://$ip:$wport/ \
            -w /usr/share/seclists/Discovery/Web-Content/common.txt \
            -s '200,204,301,302,307,403,500' -e -l | \
            tee $odir/gobuster/basic-$wport.txt


        tpane gobuster -u $https://$ip:$wport/ \
            -w /usr/share/seclists/Discovery/Web-Content/CGIs.txt \
            -s '200,204,301,302,307,403,500' -e -l | \
            tee $odir/gobuster/cgis-$wport.txt

    fi


    read -p "Enumerate Extended Web Server directory :: " ans

    if [[ $ans == "y" ]]
    then
        twin "EWeb-$wport"
        tpane dirb $https://$ip:$wport /usr/share/dirb/wordlists/big.txt  | \
            tee $odir/dirb/big-$wport.txt

        tpane wfuzz -A -c -w  \
            /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt  \
            --hc 404  --follow -t 64 \"$https://$ip:$wport/FUZZ\"  | \
            tee  $odir/wfuzz-dir-medium-$wport.txt

        printf 'php\nbak\ntxt\nhtml\nhtm\n~\n' >extensions

        tpane wfuzz -A -c -w \
            /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt  \
            -w extensions --hc 404,401 \
            --follow \"$https://$ip:$wport/FUZZ.FUZ2Z\" | \
            tee $odir/wfuzz-dir-ext-$wport.txt

    fi


    echo "Try this: dirb $https://$ip /usr/share/dirb/wordlists/common.txt  -x /usr/share/dirb/wordlists/extensions_common.txt"
    echo "and this: dirsearch -- dirsearch.py -u http://docker.hackthebox.eu:33594/ -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt -t 200 -e php --recursive --follow-redirects"

}   # ----------  end of function webscan  ----------


ip=$1
name=$2
odir=$(cd ../scans/; echo $PWD/$name)


[[ ! -f $odir ]]  && mkdir -p $odir/nmap


exec  > >(tee $odir/basic-scan.log)
exec 2> >(tee $odir/basic-scan-err.log)


echo "$ip" > $odir/ip.txt

read -p "Run Unicorn and sniper ? " ans
if [[ $ans == 'y' ]]
then
    twin "Unicorn"
    tpane unicornscan -v -m U -E $ip:a |tee $odir/unicorn-udp
    tpane unicornscan -v -E $ip:a |tee $odir/unicorn-tcp

    tpane sniper $ip |tee $odir/$ip-sniper.log
fi

read -p "Do you want to run 12punch :: " ans
if [[ $ans == 'y' ]]
then
    cd /root/amitag/git/onetwopunch
    echo $ip > targets
    ./onetwopunch.sh -t targets -p all -i tun0 -n '-sC -sV' |tee $odir/$ip-12punch
    cd -
fi

read -p "Do you want to run basic tests :: " ans
if [[ $ans == 'y' ]]
then
    twin nmap
    # nmap -O -sV -A -sS -sU -o $odir/$ip-all $ip
    #### tpane nmap -n -O -A $ip -oA $odir/nmap/quick
    tpane nmap -n -sC -sV -O -A $ip -oA $odir/nmap/quick-scripts
    # tpane nmap -n --min-parallelism 100 --min-rate 50000  -p- -O -A $ip \
    #     -oA $odir/nmap/full
    tpane nmap -n -sT --min-rate 5000  -p- --max-retries 2 $ip \
        -oA $odir/nmap/full

    tpane nmap -n -sU --min-rate 5000  -p- --max-retries 2 $ip \
        -oA $odir/nmap/full-udp

    read -p 'Do you want to re-run with no ping (-Pn) :: ' ans

    [[ $ans == "y" ]] && nmap -O -n -A $ip -oA $odir/nmap/pn-full-scan

    tpane masscan -p1-65535,U:1-65535 $ip --rate=1000 -e tun0 |tee $odir/masscan-all.txt
    # vpane masscan -p1-65535 --rate 500000 -e tun0 $ip |tee $odir/masscan.txt
    #### tpane masscan -p1-65535,U:1-65535 --rate 1000 -e tun0 $ip |tee $odir/masscan-udp.txt


fi

all_ports=$(grep Ports $odir/*.gnmap \
    grep -Eo  '[0-9]{1,5}/'|sed 's;/;;'|sort -u|tr '\n' ' ' )

if [[ $(grep -ci 'snmp' $odir/*gnmap) -ge 1 ]]
then
    twin snmpwalk

    tpane snmpwalk -mALL -v1 -cpublic 10.10.10.9$ip | tee $odir/snmpwalk-v1.log
    tpane snmpwalk -v2c -c public $ip | tee $odir/snmpwalk-v2.log
fi

read -p "Do you want to run smb tests :: " ans
if [[ $ans == 'y' ]]
then
    twin smb

    tpane nmap -n -v -p 139,445 --script=smb-vuln-*  -oA $odir/nmap/smb-security-scan $ip
    # nmap -n -O --fuzzy  -sV -sC -oA $odir/$ip-service-owners $ip
    tpane nmap -v -p 139,445 --script=smb-vuln-ms08-067 --script-args=unsafe=1 \
        $ip -oA $odir/nmap/smb-vuln-ms08-067

    tpane nmap -n --script=vuln $ip -oA $odir/nmap/vuln

fi


read -p "Do you want to scan web port :: " ans
while [[ $ans == 'y' ]]
do
    webscan
    ans=''
    read -p "Do you want to scan web port :: " ans
done


# xsser  --all $https://$IP -c 99999 --Cw 1 --Cl -s -v --no-head --hash --heuristic --user-agent 'Googlebot/2.1 (+http://www.google.com/bot.html)' --reverse-check --follow-redirects --follow-limit 50 --threads 10 --timeout 60 --retries 2 --delay 5 --auto --Str --Une --Hex --Hes --Dwo --Doo --Dec --Coo --Xsa --Xsr --Dom --Dcp --Ind --Anchor --Ifr --save --xml "scans/xsser-$IP.xml"
echo tmux -2 attach-session -t $SESSION
