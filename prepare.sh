#!/bin/bash

# mkdir -p "${HOME}"/.config/fish
mkdir -p "${HOME}"/.config/nvim
mkdir -p "${HOME}"/.config/pypoetry
mkdir -p "${HOME}"/.config/pulse
mkdir -p "${HOME}"/.config/lazygit
mkdir -p "${HOME}"/.config/zathura
mkdir -p "${HOME}"/.config/fontconfig/conf.d
mkdir -p "${HOME}"/.config/eza

# ln -fs "$(realpath .config/nvim/coc-settings.json)" ~/.config/nvim/coc-settings.json
# ln -fs "$(realpath .config/nvim/init.vim)" ~/.config/nvim/init.vim
# ln -fs "$(realpath .condarc)" ~/.condarc
# ln -fs "$(realpath .config/fish/config.fish)" ~/.config/fish/config.fish
# ln -fs "$(realpath .config/fish/fish_plugins)" ~/.config/fish/fish_plugins
# ln -fs "$(realpath .tmux.conf)" ~/.tmux.conf
ln -fs "$(realpath .zsh_plugins.txt)" ~/.zsh_plugins.txt
ln -fs "$(realpath .config/nvim)" ~/.config/nvim
ln -fs "$(realpath .config/starship.toml)" ~/.config/starship.toml
ln -fs "$(realpath .config/lazygit/config.yml)" ~/.config/lazygit/config.yml
ln -fs "$(realpath .bashrc)" ~/.bashrc
ln -fs "$(realpath .zshrc)" ~/.zshrc
ln -fs "$(realpath .latexmkrc)" ~/.latexmkrc
ln -fs "$(realpath .global_gitignore)" ~/.global_gitignore
ln -fs "$(realpath .gitconfig)" ~/.gitconfig
ln -fs "$(realpath .alacritty.toml)" ~/.alacritty.toml
ln -fs "$(realpath .ghci)" ~/.ghci
ln -fs "$(realpath .iex.exs)" ~/.iex.exs
ln -fs "$(realpath .config/pypoetry/config.toml)" ~/.config/pypoetry/config.toml
ln -fs "$(realpath .config/pulse/daemon.conf)" ~/.config/pulse/daemon.conf
ln -fs "$(realpath .config/fontconfig/conf.d/99-alias-fonts.conf)" ~/.config/fontconfig/conf.d/99-alias-fonts.conf
ln -sf "$(realpath .config/fontconfig/conf.d/80-maplemono-fontfeatures.conf)" ~/.config/fontconfig/conf.d/80-maplemono-fontfeatures.conf
ln -fs "$(realpath .tool-versions)" ~/.tool-versions
ln -fs "$(realpath .config/zathura/zathurarc)" ~/.config/zathura/zathurarc
ln -fs "$(realpath .config/eza/theme.yml)" ~/.config/eza/theme.yml
