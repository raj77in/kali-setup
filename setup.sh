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
# Last modified: Mon Jul 10, 2023  01:55PM
#      REVISION:  ---
#===============================================================================

script_path=$(cd $(dirname $0); pwd)
param=${1:-none}

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

function gitdw()
{
    cd ~/tools
    gitd=$(basename $1)
    if [[ -d $gitd ]]
    then
        { cd $gitd;
            git pull
        }
    else
        git clone https://github.com/$1
    fi
}


if [[ $1 == "config" ]] 
then
    #git clone --recurse-submodules -j8 https://github.com/raj77in/kali-setup
    echo "Check if bashrc sources ~/.bash_aliases, if not source the same"
    [[ ! -d ~/.config/rofi ]] && mkdir ~/.config/rofi

    [[ ! -d $script_path/my ]] && mkdir -p $script_path/my/bash
    echo 'echo "customize here :: $0"'> $script_path/my/bash/00-default.sh


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
    cd ~/.fonts
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
    cd ~/.themes
    wget --header 'Host: ocs-dl.fra1.cdn.digitaloceanspaces.com' --user-agent 'Mozilla/5.0 (X11; Linux x86_64; rv:106.0) Gecko/20100101 Firefox/106.0' --header 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8' --header 'Accept-Language: en-US,en;q=0.5' --referer 'https://www.xfce-look.org/' --header 'Upgrade-Insecure-Requests: 1' --header 'Sec-Fetch-Dest: document' --header 'Sec-Fetch-Mode: navigate' --header 'Sec-Fetch-Site: cross-site' --header 'Sec-Fetch-User: ?1' 'https://ocs-dl.fra1.cdn.digitaloceanspaces.com/data/files/1515879642/XFCE-D-PRO-1.6.tar.xz?response-content-disposition=attachment%3B%2520XFCE-D-PRO-1.6.tar.xz&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=RWJAQUNCHT7V2NCLZ2AL%2F20221029%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20221029T132254Z&X-Amz-SignedHeaders=host&X-Amz-Expires=60&X-Amz-Signature=4d767b84ab48d16f476f8bb8af31924e9cd2fc86e712d2f2fd896c44d170903c' --output-document 'XFCE-D-PRO-1.6.tar.xz'
    tar xvf XFCE-D-PRO-1.6.tar.xz
    rm -rf XFCE-D-PRO-1.6.tar.xz

    ## Moka icons

    xfconf-query -c xsettings -p /Net/ThemeName -s "Greybird"

    ## Some nerd fonts

    [[ ! -d ~/.fonts ]] && mkdir ~/.fonts
    cd ~/.fonts
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

# Some python tools
pipx install --user pwntools

echo "Installing aquatone"
go get github.com/michenriksen/aquatone

echo "Installing jsparser"
gitdw nahamsec/JSParser.git
cd JSParser*
sudo python setup.py install

echo "installing Sublist3r"
gitdw aboul3la/Sublist3r.git
cd Sublist3r*
pipx install -r requirements.txt

echo "installing teh_s3_bucketeers"
gitdw tomdev/teh_s3_bucketeers.git
cd ~/tools/
echo "done"


echo "installing wpscan"
gitdw wpscanteam/wpscan.git
cd wpscan*
sudo gem install bundler && bundle install --without test

echo "installing dirsearch"
gitdw maurosoria/dirsearch.git


echo "installing lazys3"
gitdw nahamsec/lazys3.git

echo "installing virtual host discovery"
gitdw jobertabma/virtual-host-discovery.git


echo "installing sqlmap"
gitdw sqlmapproject/sqlmap.git

echo "installing knock.py"
git clone https://github.com/guelfoweb/knock.git

echo "installing lazyrecon"
gitdw nahamsec/lazyrecon.git

echo "installing massdns"
gitdw blechschmidt/massdns.git
cd massdns
make

echo "installing asnlookup"
gitdw yassineaboukir/asnlookup.git

cd asnlookup
pipx install -r requirements.txt

echo "installing httprobe"
go get -u github.com/tomnomnom/httprobe

echo "installing unfurl"
go get -u github.com/tomnomnom/unfurl

echo "installing waybackurls"
go get github.com/tomnomnom/waybackurls

echo "installing crtndstry"
gitdw nahamsec/crtndstry.git

echo "downloading Seclists"
cd ~/tools/
gitdw danielmiessler/SecLists.git
cd ~/tools/SecLists/Discovery/DNS/
##THIS FILE BREAKS MASSDNS AND NEEDS TO BE CLEANED
cat dns-Jhaddix.txt | head -n -14 > clean-jhaddix-dns.txt

echo "Remove some tools from apt, its old"
sudo apt remove --purge seclists python-impacket

ln -s ~/tools/Seclists /usr/share/seclists

echo "Cloning PayloadAllTheThings"
gitdw swisskyrepo/PayloadsAllTheThings


echo "Sharp collections"
gitdw Flangvik/SharpCollection

echo "Chisel for tunneling"
gitdw jpillora/chisel

echo "PEASS-ng"
gitdw carlospolop/PEASS-ng

echo "Chainsaw"
gitdw WithSecureLabs/chainsaw

echo "Bloodhound"
gitdw BloodHoundAD/BloodHound


echo "impacket latest"
gitdw fortra/impacket.git

echo "CrackMapExec"
gitdw mpgn/CrackMapExec.git

echo certipy
gitdw ly4k/Certipy.git

echo -e "\n\n\n\n\n\n\n\n\n\n\nDone! All tools are set up in ~/tools"
ls -la
echo "One last time: don't forget to set up AWS credentials in ~/.aws/!"

