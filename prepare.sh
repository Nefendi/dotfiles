#!/bin/bash

set -e

# ZSH
printf "\nChanging the default shell to ZSH...\n"

chsh -s $(grep /zsh$ /etc/shells | tail -1)

# OH-MY-ZSH
printf "\nInstalling Oh-My-Zsh...\n"

if [[ ! -d "${HOME}/.oh-my-zsh" ]]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# ANTIGEN
printf "\nInstalling Antigen...\n"

mkdir -p "${HOME}/antigen"

if [[ ! -f "${HOME}/antigen/antigen.zsh" ]]; then
    curl -L git.io/antigen >"${HOME}/antigen/antigen.zsh"
fi

# SYMBOLIC LINKS
printf "\nMaking symbolic links...\n"

mkdir -p ~/.config/nvim

ln -fs "$(realpath coc-settings.json)" ~/.config/nvim/coc-settings.json
ln -fs "$(realpath init.vim)" ~/.config/nvim/init.vim
ln -fs "$(realpath .antigenrc)" ~/.antigenrc
ln -fs "$(realpath .zshrc)" ~/.zshrc
ln -fs "$(realpath .latexmkrc)" ~/.latexmkrc
ln -fs "$(realpath .global_gitignore)" ~/.global_gitignore
ln -fs "$(realpath .gitconfig)" ~/.gitconfig
ln -fs "$(realpath .alacritty.yml)" ~/.alacritty.yml
ln -fs "$(realpath .condarc)" ~/.condarc

printf "\nAll done! Please, log out and log in to finish applying the changes.\n"
