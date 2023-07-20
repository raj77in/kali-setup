#!/bin/bash - 
#===============================================================================
#
#          FILE: setup.sh
# 
#         USAGE: ./setup.sh 
# 
#   DESCRIPTION: Script to setup kali machine.
#                My blog: https://blog.amit-agarwal.co.in, https://blog.aka.rocks
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Amit Agarwal (aka),
#  ORGANIZATION: Individual
#       CREATED: 11/29/2019 09:37
# Last modified: Thu Jul 20, 2023  11:49AM
#      REVISION:  ---
#===============================================================================

script_path=$(cd $(dirname $0); pwd)
param=${1:-none}
TOOLS="$HOME/tools"

function dfonts()
{
    cd ~/.fonts
    U="https://github.com/ryanoasis/nerd-fonts/releases/download/v2.0.0/"
    # Ensure we do not download the file again or if left in between then
    # continue from there.
    wget -nc -c "$U/$1"
    unzip $1
    # Leave the zip files, can be useful
    # rm -rf $1
}

function download_fonts()
{
    dfonts FiraCode.zip
    dfonts BigBlueTerminal.zip
    dfonts FiraMono.zip
    dfonts Hack.zip
    dfonts CascadiaCode.zip
}

function create_link()
{
    dest=$HOME/$2
    if [[ -d $dest || -f $dest || -L $dest ]] 
    then
        [[ ! -d ~/kali-setup-backup-files ]] && mkdir ~/kali-setup-backup-files
        # Backup the files only first time.
        if [[ ! -r $dest ]] 
        then
            [[ ! -d $(dirname $dest) ]] && mkdir $(dirname $dest)
            mv $dest ~/kali-setup-backup-files
        else
            rm $dest
        fi
    fi
    ln -s $script_path/$1 $dest
}

function config_JSParser() {
  cd $TOOLS/JSParser || return
  python setup.py install --user
}

function config_Sublist3r()
{
  cd $TOOLS/Sublist3r || return
  pip install -r requirements.txt --user
}

function config_wpscan()
{
  cd $TOOLS/wpscan || return
  sudo gem install bundler && bundle install --without test
}

function config_massdns()
{
  cd $TOOLS/massdns || return
  make
}

function config_asnlookup()
{
  cd $TOOLS/asnlookup || return
  pip install -r requirements.txt --user
}

function config_SecLists()
{
  cd "$TOOLS/SecLists/Discovery/DNS/" || return
  ##THIS FILE BREAKS MASSDNS AND NEEDS TO BE CLEANED
  sudo ln -s $TOOLS/Seclists /usr/share/seclists
}

function gitdw()
{
    cd $TOOLS || return
    echo "Check out $1"
    gitd="$(echo $(basename "$1") |sed 's/.git//')"
    if [[ -d $gitd ]]
    then
        { cd "$gitd" || return
            git pull
        }
    else
        git clone "https://github.com/$1"
    fi
    if [[ $(type -t "config_${gitd}" ) == "function" ]]
    then
      "config_${gitd}"
    else
      echo "There is no function called config_$gitd to configure $1"
    fi
    echo "Done"
}


if [[ $1 == "config" ]] 
then
    #git clone --recurse-submodules -j8 https://github.com/raj77in/kali-setup
    echo "Check if bashrc sources ~/.bash_aliases, if not source the same"
    [[ ! -d ~/.config/rofi ]] && mkdir ~/.config/rofi

    [[ ! -d $script_path/my ]] && mkdir -p "$script_path/my/bash"
    echo 'echo "customize here :: $0"'> "$script_path/my/bash/00-default.sh"


    # ln -s kali-setup/config/.bashrc
    create_link Xdefaults .Xdefaults
    create_link bash.d/bash_profile .bash_profile
    echo "Add the following to .bashrc"
    echo "[[ -r bash_profile ]] && source ~/.bash_profile"
    create_link bash.d/funcs .funcs
    create_link bash.d/alias .alias
    create_link my .my
    create_link inputrc .inputrc
    create_link dotfiles/vim .vim
    create_link vimrc .vimrc
    create_link colorcombo .colorcombo
    create_link tmux.conf .tmux.conf
    ## Some useful tmux plugins ...
    create_link tmux .tmux
    create_link rofi-config .config/rofi/config
    create_link Xdefaults .Xdefaults
    create_link Xdefaults .Xresources
    create_link urxvt-resize-font/resize-font /usr/lib/x86_64-linux-gnu/urxvt/perl/
    create_link gdbinit .gdbinit
    create_link netrc .netrc
    create_link Burp .Burp
    create_link my/gitconfig .gitconfig
    create_link rofi-config .config/rofi/config
    create_link i3 .config/i3
    create_link kitty .config/kitty
    create_link bin .local/bin

    ## Fonts
    [[ ! -d ~/.fonts ]] && mkdir ~/.fonts
    cd ~/.fonts || return
    download_fonts
    # Once the fonts are downlaoded to the fonts folder, refresh cache'
    fc-cache
    ## Install oh my posh

    sudo wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh
    sudo chmod +x /usr/local/bin/oh-my-posh

    mkdir ~/.poshthemes
    wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/themes.zip -O ~/.poshthemes/themes.zip
    unzip ~/.poshthemes/themes.zip -d ~/.poshthemes
    chmod u+rw ~/.poshthemes/*.json
    rm ~/.poshthemes/themes.zip

    ## Check all the themes

    for file in ~/.poshthemes/*.omp.json; do echo "$file\n"; oh-my-posh --config $file --shell universal; echo "\n"; done;


    ## From kali site: https://www.offensive-security.com/kali-linux/kali-linux-customization/
    xfconf-query -c xsettings -p /Net/IconThemeName -s Flat-Remix-Blue-Dark
    xfconf-query -c xsettings -p /Net/ThemeName -s Kali-Dark
    xfconf-query -c xfwm4 -p /general/theme -s Kali-Dark
    gsettings set org.xfce.mousepad.preferences.view color-scheme Kali-Dark

    ## Kali Light theme
    ## xfconf-query -c xsettings -p /Net/IconThemeName -s Flat-Remix-Blue-Light
    ## xfconf-query -c xsettings -p /Net/ThemeName -s Kali-Light
    ## xfconf-query -c xfwm4 -p /general/theme -s Kali-Light
    ## gsettings set org.xfce.mousepad.preferences.view color-scheme Kali-Light

    # Remove panel shadow
    xfconf-query -c xfwm4 -p /general/show_dock_shadow -s false
    ## Theme

    [[ ! -d /.themes ]] && mkdir ~/.themes
    cd ~/.themes || return
    wget --header 'Host: ocs-dl.fra1.cdn.digitaloceanspaces.com' --user-agent 'Mozilla/5.0 (X11; Linux x86_64; rv:106.0) Gecko/20100101 Firefox/106.0' --header 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8' --header 'Accept-Language: en-US,en;q=0.5' --referer 'https://www.xfce-look.org/' --header 'Upgrade-Insecure-Requests: 1' --header 'Sec-Fetch-Dest: document' --header 'Sec-Fetch-Mode: navigate' --header 'Sec-Fetch-Site: cross-site' --header 'Sec-Fetch-User: ?1' 'https://ocs-dl.fra1.cdn.digitaloceanspaces.com/data/files/1515879642/XFCE-D-PRO-1.6.tar.xz?response-content-disposition=attachment%3B%2520XFCE-D-PRO-1.6.tar.xz&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=RWJAQUNCHT7V2NCLZ2AL%2F20221029%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20221029T132254Z&X-Amz-SignedHeaders=host&X-Amz-Expires=60&X-Amz-Signature=4d767b84ab48d16f476f8bb8af31924e9cd2fc86e712d2f2fd896c44d170903c' --output-document 'XFCE-D-PRO-1.6.tar.xz'
    tar xvf XFCE-D-PRO-1.6.tar.xz
    rm -rf XFCE-D-PRO-1.6.tar.xz

    ## Moka icons

    xfconf-query -c xsettings -p /Net/ThemeName -s "Greybird"

    ## Some nerd fonts

    [[ ! -d ~/.fonts ]] && mkdir ~/.fonts
    cd ~/.fonts || return
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/CascadiaCode.zip
    unzip CascadiaCode.zip && rm CascadiaCode.zip
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/Go-Mono.zip
    unzip Go-Mono.zip && rm Go-Mono.zip
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/Hack.zip
    unzip Hack.zip && rm Hack.zip
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/InconsolataGo.zip
    unzip InconsolataGo.zip && rm InconsolataGo.zip
fi

# update apt cache
sudo apt update -y
## Install all packages

sudo apt install -y $(grep -v '^#' pkgs|tr '\n' ' ')

## Install some useful stuff :)

# apt autoremove -y
sudo apt autoclean -y

echo "Remove some tools from apt, its old"
# sudo apt remove --purge seclists python3-impacket

## Downlaod git repos to be used

for i in nahamsec/JSParser.git \
	aboul3la/Sublist3r.git \
	tomdev/teh_s3_bucketeers.git \
	wpscanteam/wpscan.git \
	maurosoria/dirsearch.git \
	nahamsec/lazys3.git \
	jobertabma/virtual-host-discovery.git \
	sqlmapproject/sqlmap.git \
	nahamsec/lazyrecon.git \
	blechschmidt/massdns.git \
	yassineaboukir/asnlookup.git \
	nahamsec/crtndstry.git \
	danielmiessler/SecLists.git \
	swisskyrepo/PayloadsAllTheThings \
	Flangvik/SharpCollection \
	jpillora/chisel \
	carlospolop/PEASS-ng \
	WithSecureLabs/chainsaw \
	BloodHoundAD/BloodHound \
	fortra/impacket.git \
	mpgn/CrackMapExec.git \
	ly4k/Certipy.git \
	sebastiencs/icons-in-terminal \
	IppSec/ctf-scripts \
	urbanadventurer/username-anarchy
do
  gitdw "$i"
done


# Some python tools
pip install --user pwntools

echo "Installing aquatone"
go install github.com/michenriksen/aquatone@latest


echo "Downloading binaries"
[[ ! -d $TOOLS/bin ]] && mkdir $TOOLS/bin
python ${script_path}/githubdownload.py jpillora/chisel _linux_amd64.gz $TOOLS/bin
python ${script_path}/githubdownload.py jpillora/chisel _windows_amd64.gz $TOOLS/bin
python ${script_path}/githubdownload.py carlospolop/PEASS-ng linpeas.sh $TOOLS/bin
python ${script_path}/githubdownload.py carlospolop/PEASS-ng winPEASx64.exe $TOOLS/bin
python ${script_path}/githubdownload.py WithSecureLabs/chainsaw chainsaw_all_ $TOOLS/bin
python ${script_path}/githubdownload.py BloodHoundAD/BloodHound BloodHound-linux-x64.zip $TOOLS/bin
python ${script_path}/githubdownload.py NationalSecurityAgency/ghidra  ghidra_*.zip  $TOOLS/bin/


echo -e "\n\n\n\n\n\n\n\n\n\n\nDone! All tools are set up in $TOOLS"
ls -la
echo "One last time: don't forget to set up AWS credentials in ~/.aws/!"

