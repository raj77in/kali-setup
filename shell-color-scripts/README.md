## Taken from https://gitlab.com/dwt1/shell-color-scripts and made some modifications.

# Shell Color Scripts

![Screenshot of shell-color-scripts](https://gitlab.com/dwt1/dotfiles/raw/master/.screenshots/dotfiles12.png) 

A collection of terminal color scripts I've accumulated over the years.
	
# Installing shell-color-scripts on Arch Linux

All you need to do is download the PKGBUILD from this repository.  Then run the following command:

	makepkg -cf
	
This will create a file that ends in .pkg.tar.xz (for example, shell-color-scripts-0.1-1-x86_64.pkg.tar.xz).  Then run:

	sudo pacman -U *.pkg.tar.xz 
	
Alternately, you could also install shell-color-scripts from the AUR using an AUR helper such as yay:

	yay -S shell-color-scripts
	
# Installing shell-color-scripts on other Linux distrtibutions

Download the source code from this repository or use a git clone:

	git clone https://gitlab.com/dwt1/shell-color-scripts.git
	cd shell-color-scripts
	sudo rm -rf /opt/shell-color-scripts/ || return 1
    sudo mkdir -p /opt/shell-color-scripts || return 1
    sudo cp -rf * /opt/shell-color-scripts
	
# The Scripts Are Located in /opt

The source for shell-color-scripts is placed in:
	
	/opt/shell-color-scripts
	
For even more fun, add the following line to your .bashrc or .zshrc and you will run a random color script each time you open a terminal:

	### RANDOM COLOR SCRIPT ###
	/opt/shell-color-scripts/randomcolors.sh
