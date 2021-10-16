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
# Last modified: Sat Oct 16, 2021  04:40PM
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
script_path=$(cd $(dirname $0); pwd)

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


# update apt cache
apt update -y
## Install all packages

apt install -y $(grep -v '^#' pkgs|tr '\n' ' ')



## Install some useful stuff :)

apt update -y
# apt autoremove -y
apt autoclean -y
apt install -y tmux-themepack-jimeh fonts-powerline fonts-font-awesome neofetch ack

## meld diff tool, dont you just love this
apt install -y meld

## Screenshot is never same with this
apt install -y flameshot

## Some tools for documentation
apt install -y xclip pandoc wkhtmltopdf

## And terminal
apt install -y kitty

## And now for pip3 and pwntools
#
apt install -y python3-pip
pip3 install --user pwntools


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

