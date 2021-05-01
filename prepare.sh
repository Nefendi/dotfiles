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

ln -s "$(realpath .clang-tidy)" ~/.clang-tidy
ln -s "$(realpath .clang-format)" ~/.clang-format
ln -s "$(realpath coc-settings.json)" ~/.config/nvim/coc-settings.json
ln -s "$(realpath init.vim)" ~/.config/nvim/init.vim
ln -s "$(realpath .antigenrc)" ~/.antigenrc
ln -s "$(realpath .zshrc)" ~/.zshrc
ln -s "$(realpath .zsh_nocorrect)" ~/.zsh_nocorrect
ln -s "$(realpath .latexmkrc)" ~/.latexmkrc
ln -s "$(realpath .global_gitignore)" ~/.global_gitignore
ln -s "$(realpath .gitconfig)" ~/.gitconfig
ln -s "$(realpath .alacritty.yml)" ~/.alacritty.yml
ln -s "$(realpath .condarc)" ~/.condarc

printf "\nAll done! Please, log out and log in to finish applying the changes.\n"
