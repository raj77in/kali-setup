# Setup

```


apt install zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/stevemcilwain/quiver.git ~/.oh-my-zsh/custom/plugins/quiver
git clone https://github.com/jhwohlgemuth/zsh-pentest.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-pentest

cp functions.zsh ~/.oh-my-zsh/custom
cp aliases.zsh ~/.oh-my-zsh/custom

```

## Edit ~/.zshrc and
plugins=(git quiver zsh-pentest zsh-handy-helpers quiver nmap zsh-pentest zsh-handy-helpers zsh-interactive-cd z alias-finder autoenv autojmp colorize copybuffer copyfile cp  catimg emoji emoji-clock fzf history vi-mode)
