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
# Last modified: Fri Jan 17, 2020  02:21PM
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

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

#git clone --recurse-submodules -j8 https://github.com/raj77in/kali-setup

## Fonts
[[ ! -d ~/.fonts ]] && mkdir ~/.fonts
cd ~/.fonts
download_fonts
cd

## Install all packages

apt install -y $(grep -v '^#' pkgs|tr '\n' ' ')

echo "Check if bashrc sources ~/.bash_aliases, if not source the same"
[[ ! -d ~/.config/rofi ]] && mkdir ~/.config/rofi


# ln -s kali-setup/config/.bashrc
ln -s $PWD/Xdefaults ~/.Xdefaults
ln -s $PWD/bash.d/bash_profile ~/.bash_profile
echo "Add the following to .bashrc"
echo "[[ -r ~/.bash_profile ]] && source ~/.bash_profile"
ln -s $PWD/bash.d/funcs ~/.funcs
ln -s $PWD/bash.d/alias ~/.alias
ln -s $PWD/my ~/.my
ln -s $PWD/inputrc ~/.inputrc
ln -s $PWD/dotfiles/vim ~/.vim
ln -s $PWD/vimrc ~/.vimrc
ln -s $PWD/colorcombo ~/.colorcombo
ln -s $PWD/tmux.conf ~/.tmux.conf
## Some useful tmux plugins ...
ln -s $PWD/tmux ~/.tmux
ln -s $PWD/rofi-config ~/.config/rofi/config
ln -s $PWD/Xdefaults ~/.Xdefaults
ln -s $PWD/Xdefaults ~/.Xresources
ln -s $PWD/urxvt-resize-font/resize-font /usr/lib/x86_64-linux-gnu/urxvt/perl/
ln -s $PWD/gdbinit ~/.gdbinit
ln -s $PWD/netrc ~/.netrc
ln -s $PWD/Burp ~/.Burp
ln -s $PWD/my/gitconfig ~/.gitconfig
ln -s $PWD/rofi-config .config/rofi/config
ln -s $PWD/i3 .config/i3
ln -s $PWD/kitty .config/kitty




## Install some useful stuff :)

apt update
apt autoremove
apt autoclean
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


