#!/bin/bash - 
#===============================================================================
#
#          FILE: setup.sh
# 
#         USAGE: ./setup.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Amit Agarwal (aka),
#  ORGANIZATION: Individual
#       CREATED: 11/29/2019 09:37
# Last modified: Tue Jan 21, 2020  04:14PM
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
script_path=$(cd $(dirname $0); pwd)

function dfonts()
{
    cd ~/.fonts
    U="https://github.com/ryanoasis/nerd-fonts/releases/download/v2.0.0/"
    wget "$U/$1"
    unzip $1
    rm -rf $1
}

function download_fonts()
{
    dfonts FiraCode.zip
    dfonts BigBlueTerminal.zip
    dfonts FiraMono.zip
    dfonts Hack.zip
}

function create_link()
{
    if [[ -d $HOME/$2 || -f $HOME/$2 || -L $HOME/$2 ]] 
    then
        [[ ! -d ~/kali-setup-backup-files ]] && mkdir ~/kali-setup-backup-files
        mv $HOME/$2 ~/kali-setup-backup-files
    fi
    ln -s $script_path/$1 $HOME/$2
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
# download_fonts
cd

## Install all packages

apt install -y $(grep -v '^#' pkgs|tr '\n' ' ')



## Install some useful stuff :)

apt update -y
# apt autoremove -y
apt autoclean -y
apt install -y tmux-themepack-jimeh fonts-powerline fonts-font-awesome exploitdb-papers neofetch ack

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


