#!/bin/bash

NEEDED_SOFTWARE=("zsh" "curl" "tmux" "nvim" "npm" "git" "ctags" "cmake" "xclip" "fasd" "rg" "batcat")

# https://raymii.org/s/snippets/Bash_Bits_Check_if_command_is_available.html
command_exists() {
    command -v "$1" >/dev/null 2>&1
    if [[ $? -ne 0 ]]; then
        printf "\n%s is required for this setup to work correctly. Please, install it before running the script.\n" "$1"
        AT_LEAST_ONE_PACKAGE_IS_NOT_INSTALLED=1
    fi
}

# PREREQUISITES
printf "\nChecking for the existence of needed software...\n"

for COMMAND in "${NEEDED_SOFTWARE[@]}"; do
    command_exists "${COMMAND}"
done

if [[ -v AT_LEAST_ONE_PACKAGE_IS_NOT_INSTALLED ]]; then
    exit 1
fi

set -e

# ZSH
printf "\nChanging the default shell to ZSH...\n"

chsh -s /bin/zsh

# OH-MY-ZSH
printf "\nInstalling Oh-My-Zsh...\n\n"

if [[ ! -d "${HOME}"/.oh-my-zsh ]]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    printf "Oh-My-Zsh is already installed, skipping...\n\n"
fi

# SYMBOLIC LINKS
printf "\nMaking symbolic links...\n"

mkdir -p "${HOME}"/.config/nvim
mkdir -p "${HOME}"/.config/pypoetry
mkdir -p "${HOME}"/.config/fish
mkdir -p "${HOME}"/.config/pulse

ln -fs "$(realpath .config/nvim/coc-settings.json)" ~/.config/nvim/coc-settings.json
ln -fs "$(realpath .config/nvim/init.vim)" ~/.config/nvim/init.vim
ln -fs "$(realpath .zsh_plugins.txt)" ~/.zsh_plugins.txt
ln -fs "$(realpath .config/starship.toml)" ~/.config/starship.toml
ln -fs "$(realpath .bashrc)" ~/.bashrc
ln -fs "$(realpath .zshrc)" ~/.zshrc
ln -fs "$(realpath .latexmkrc)" ~/.latexmkrc
ln -fs "$(realpath .global_gitignore)" ~/.global_gitignore
ln -fs "$(realpath .gitconfig)" ~/.gitconfig
ln -fs "$(realpath .alacritty.yml)" ~/.alacritty.yml
ln -fs "$(realpath .condarc)" ~/.condarc
ln -fs "$(realpath .ghci)" ~/.ghci
ln -fs "$(realpath .config/pypoetry/config.toml)" ~/.config/pypoetry/config.toml
ln -fs "$(realpath .config/fish/config.fish)" ~/.config/fish/config.fish
ln -fs "$(realpath .config/fish/fish_plugins)" ~/.config/fish/fish_plugins
ln -fs "$(realpath .config/pulse/daemon.conf)" ~/.config/pulse/daemon.conf
ln -fs "$(realpath .tmux.conf)" ~/.tmux.conf

# ANTIBODY
printf "\nDownloading and initialising Antibody...\n\n"

curl -sfL git.io/antibody | sh -s - -b "${HOME}"/antibody
"${HOME}"/antibody/antibody bundle <"${HOME}"/.zsh_plugins.txt >"${HOME}"/.zsh_plugins.sh

# STARSHIP
# printf "\nInstalling or updating Starship prompt...\n"

# sh -c "$(curl -fsSL https://starship.rs/install.sh)" "" --yes

# MINICONDA
printf "\nInstalling Miniconda3...\n\n"

curl -fsSL https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -o ~/miniconda.sh
bash ~/miniconda.sh -f -b -p "${HOME}"/miniconda3

# FZF
printf "\nDownloading and installing fzf...\n\n"

if [[ ! -d "${HOME}"/.fzf ]]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git "${HOME}"/.fzf
    "${HOME}"/.fzf/install --key-bindings --completion --no-update-rc
else
    printf "fzf is already installed, skipping...\n\n"
fi

# DRACULA THEME FOR ALACRITTY
# printf "\nDownloading Dracula theme for Alacritty...\n\n"

# mkdir -p "${HOME}"/alacritty-themes/dracula
# git clone --depth 1 https://github.com/dracula/alacritty.git "${HOME}"/alacritty-themes/dracula

# NEOVIM
printf "\nSetting up Neovim...\n\n"

sleep 2
nvim +'PlugInstall --sync' +UpdateRemotePlugins +qa
sh -c "${HOME}/miniconda3/bin/conda install --yes --verbose pynvim"

printf "\ncoc.nvim extensions will be downloaded after you run Neovim next time."

# FINALISING
printf "\n\nAll done! Please, log out and log in to finish applying the changes."

sleep 1

printf "\n\nNow, ZSH will be started in your current shell...\n\n"

sleep 2
zsh
