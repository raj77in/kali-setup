addhosts () 
{ 
    for i in {1..254};
    do
        echo "192.168.183.$i vm$i" | sudo tee -a /etc/hosts;
    done
}
copy_shell_code () 
{ 
    xclip -selection clipboard -o | grep --color=auto '"\\x' | awk -F'"' '{print $2}' | tr -d '\n' | xlip -i
}
dequote () 
{ 
    eval printf %s "$1" 2> /dev/null
}
disk_usage () 
{ 
    while read line; do
        [[ $line == *KB* ]] && echo -e '\E[37;32m'$line'\033[0m';
        [[ $line == *MB* ]] && echo -e '\E[37;34m'$line'\033[0m';
        [[ $line == *GB* ]] && echo -e '\E[34;31m'$line'\033[0m';
    done < <(
    (du -kod 2>/dev/null|| du -Sxk)| sort -nr | head -${1:-10}|awk '{
    if ($1/1024 > 1024)
        size=$1/1024/1024."GB";
    else
        size=$1/1024."MB";
        print size"\t"$2;
    }'
    )
}
ex () 
{ 
    if [[ -f $1 ]]; then
        case $1 in 
            *.tar.bz2)
                tar xjf $1
            ;;
            *.tar.gz)
                tar xzf $1
            ;;
            *.bz2)
                bunzip2 $1
            ;;
            *.rar)
                rar x $1
            ;;
            *.gz)
                gunzip $1
            ;;
            *.tar)
                tar xf $1
            ;;
            *.tbz2)
                tar xjf $1
            ;;
            *.tgz)
                tar xzf $1
            ;;
            *.zip)
                unzip $1
            ;;
            *.Z)
                uncompress $1
            ;;
            *.7z)
                7z x $1
            ;;
            *)
                echo $1 cannot be extracted
            ;;
        esac;
    else
        echo $1 is not a valid file;
    fi
}
exitstatus () 
{ 
    if [[ $? == 0 ]]; then
        printf "😄";
    else
        printf "😥($?)";
    fi
}
f () 
{ 
    find . -iname \*$1\*
}
gtfobins () 
{ 
    firefox "https://gtfobins.github.io/gtfobins/$1/"
}
mcd () 
{ 
    mkdir -pv -p $1;
    cd $1
}
mkdir-linrecon () 
{ 
    mkdir www;
    cd www;
    cp /root/amitag/git/tools/Linux/privilege-escalation-awesome-scripts-suite/linPEAS/linpeas.sh .;
    cp /root/amitag/git/tools/Linux/LinEnum/LinEnum.sh .;
    cp /root/amitag/git/pspy/pspy .
}
portnumber () 
{ 
    cd $DROPBOX/personal/myscripts/port-numbers;
    awk -F, -v p=$1 -v pn=$2 '$3 == p && $2 == pn' service-names-port-numbers.csv
}
quote () 
{ 
    local quoted=${1//\'/\'\\\'\'};
    printf "'%s'" "$quoted"
}
quote_readline () 
{ 
    local ret;
    _quote_readline_by_ref "$1" ret;
    printf %s "$ret"
}
rdesktop_my () 
{ 
    if [[ $1 == "kevin" ]]; then
        rdesktop -u kevin -p f8uHwN88Sx 10.11.1.230 -T win -r clipboard:PRIMARYCLIPBOARD -5 -x l -z -g 70% -5 -N -e &
    else
        if [[ $1 == "14" ]]; then
            rdesktop -u bob -p bobis2coolof 10.11.1.14 -T win -r clipboard:PRIMARYCLIPBOARD -5 -x l -z -g 70% -5 -N -e &
        fi;
    fi
}
record () 
{ 
    name="$*";
    sed 's/EXER/'"${name}"'/' /mnt/Dropbox/Calibre-Kindle-Unlimited/Courses/mosse/MICS/intro.txt > /tmp/intro.txt;
    pango-view --dpi=110 --markup /tmp/intro.txt & recordmydesktop --on-the-fly-encoding --no-sound -o ${name// /_}
}
remote-desktop () 
{ 
    case $1 in 
        dnn)
            /usr/bin/xfreerdp /wm-class:"xfreerdp" +nego +sec-rdp +sec-tls +sec-nla /v:dnn /u:"Administrator" /p:"studentlab" /t:DNN /rfx +home-drive +fonts /dynamic-resolution /cert-ignore +auto-reconnect /auto-reconnect-max-retries:3 /v:dnn &
        ;;
        manageengine)
            /usr/bin/xfreerdp /wm-class:"xfreerdp" +nego +sec-rdp +sec-tls +sec-nla /v:manageengine /u:"Administrator" /p:"studentlab" /t:ME /rfx +home-drive +fonts /dynamic-resolution /cert-ignore +auto-reconnect /auto-reconnect-max-retries:3 /v:manageengine &
        ;;
        dnn)
            /usr/bin/xfreerdp /wm-class:"xfreerdp" +nego +sec-rdp +sec-tls +sec-nla /v:manageengine /u:"Administrator" /p:"studentlab" /t:DNN /rfx +home-drive +fonts /dynamic-resolution /cert-ignore +auto-reconnect /auto-reconnect-max-retries:3 /v:dnn &
        ;;
        100.105)
            /usr/bin/xfreerdp /wm-class:"xfreerdp" +nego +sec-rdp +sec-tls +sec-nla /v:manageengine /u:"Administrator" /p:"Pa$$w0rd" /t:IoT-105 /rfx +home-drive +fonts /dynamic-resolution /cert-ignore +auto-reconnect /auto-reconnect-max-retries:3 /v:172.25.100.105
        ;;
        170.170)
            /usr/bin/xfreerdp /wm-class:"xfreerdp" +nego +sec-rdp +sec-tls +sec-nla /v:manageengine /u:"Administrator" /p:"Pa$$w0rd123456" /t:AD-170 /rfx +home-drive +fonts /dynamic-resolution /cert-ignore +auto-reconnect /auto-reconnect-max-retries:3 /v:172.25.170.170
        ;;
        *)
            echo "nothing to do"
        ;;
    esac
}
ssh-server () 
{ 
    case $1 in 
        atmail)
            sshpass -p "V*hUX88cX's%{z:q" ssh atmail@atmail
        ;;
        atutor | bassmaster)
            sshpass -p "studentlab" ssh student@$1
        ;;
        *)
            echo "Do nothing, I am lzy"
        ;;
    esac
}
urldecode () 
{ 
    local url_encoded="${1//+/ }";
    printf '%b' "${url_encoded//%/\\x}"
}
urlencode () 
{ 
    hURL -U "$1" -s --nocolor;
    return;
    old_lc_collate=$LC_COLLATE;
    LC_COLLATE=C;
    local length="${#1}";
    for ((i = 0; i < length; i++ ))
    do
        local c="${1:i:1}";
        case $c in 
            [a-zA-Z0-9.~_-])
                printf "$c"
            ;;
            *)
                printf '%%%02X' "'$c"
            ;;
        esac;
    done;
    LC_COLLATE=$old_lc_collate
}
wfuzz-beast () 
{ 
    wfuzz -c -z file,/usr/share/wfuzz/wordlist/general/megabeast.txt --hc 400,403,404,000 --hw 4 -H "User-Agent: Mozilla" "$1/FUZZ"
}
xssh () 
{ 
    c=($(cat ~/.colorcombo |sort -R |head -1|sed 's/-/ /'));
    if [[ $SHELL = "/bin/bash" ]]; then
        fg=${c[0]};
        bg=${c[1]};
    else
        fg=${c[1]};
        bg=${c[2]};
    fi;
    XTOPTS='-fs 9 -geom 120x36';
    xt="xterm $XTOPTS -bg '#$bg' -fg '#$fg'";
    if [[ $# -ne 1 ]]; then
        _known_hosts_real -a -F '' '';
        host=$(zenity --list --title "Select Host" --column "host" ${COMPREPLY[@]});
        cmd="TERM=xterm $xt -T $fg-$bg-$1 -e ssh -Y $host";
        echo "$fg-$bg" > /tmp/colorcombo;
        echo "Executing CMD :: $cmd";
        eval $cmd &
    fi;
    cmd="TERM=xterm $xt -T $fg-$bg-$1 -e ssh -Y $1";
    echo "$fg-$bg" > /tmp/colorcombo;
    echo "Executing CMD :: $cmd";
    eval $cmd &
}
