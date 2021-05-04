#!/bin/bash

NEEDED_SOFTWARE=("zsh" "curl" "tmux" "fzf" "nvim" "npm" "git" "ctags" "cmake" "xclip")

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

if [[ ! -d "${HOME}/.oh-my-zsh" ]]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# ANTIGEN
printf "\nDownloading Antigen...\n\n"

mkdir -p "${HOME}/antigen"

if [[ ! -f "${HOME}/antigen/antigen.zsh" ]]; then
    git clone https://github.com/zsh-users/antigen.git "${HOME}/antigen"
fi

# STARSHIP
printf "\nInstalling or updating Starship prompt...\n"

sh -c "$(curl -fsSL https://starship.rs/install.sh)" "" --yes

# MINICONDA
printf "\nInstalling Miniconda3...\n\n"

curl -fsSL https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -o ~/miniconda.sh
bash ~/miniconda.sh -f -b -p "${HOME}/miniconda3"

# SYMBOLIC LINKS
printf "\nMaking symbolic links...\n"

mkdir -p ~/.config/nvim

ln -fs "$(realpath coc-settings.json)" ~/.config/nvim/coc-settings.json
ln -fs "$(realpath init.vim)" ~/.config/nvim/init.vim
ln -fs "$(realpath .antigenrc)" ~/.antigenrc
ln -fs "$(realpath starship.toml)" ~/.config/starship.toml
ln -fs "$(realpath .zshrc)" ~/.zshrc
ln -fs "$(realpath .latexmkrc)" ~/.latexmkrc
ln -fs "$(realpath .global_gitignore)" ~/.global_gitignore
ln -fs "$(realpath .gitconfig)" ~/.gitconfig
ln -fs "$(realpath .alacritty.yml)" ~/.alacritty.yml
ln -fs "$(realpath .condarc)" ~/.condarc

# NEOVIM
printf "\nSetting up Neovim...\n\n"

sleep 2
nvim +'PlugInstall --sync' +qa
sh -c "${HOME}/miniconda3/bin/conda install --yes pynvim"

printf "\ncoc.nvim extensions will be downloaded after you run Neovim next time."

# FINALISING
printf "\n\nAll done! Please, log out and log in to finish applying the changes."

sleep 1

printf "\n\nNow, ZSH will be started in your current shell...\n\n"

sleep 2
zsh
