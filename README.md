# Dotfiles

**WARNING: The contents of this file are deprecated.**

A collection of different dotfiles and configuration files, which I use in my day-to-day work.

## How to quickly set everything up?

The preparation script `prepare.sh` takes care of the majority of things for you. If you do not want to use it straight away and instead see how the setup will look like, go to the [Testing the setup](#testing-the-setup) section for more information.

## Prerequisites

This setup needs a few programmes already installed to work properly. The preparation script checks for their presence in the **PATH** variable so you do not have to worry about running it without needed dependencies **assuming you are running an Ubuntu-based system**. For now, the list of necessary programmes is the following (please note that the names of the programmes come from an Ubuntu-based system, in other systems the names may be different):

```bash
zsh curl tmux nvim npm git ctags cmake xclip fasd rg batcat
```

In Ubuntu-based systems, you can install them by issuing:

```bash
sudo apt update && sudo apt install zsh curl tmux neovim npm git universal-ctags cmake xclip fasd ripgrep bat
```

### Testing the setup

You can easily test if the whole setup is to your liking or even modify some things and test them without affecting your current environment if you have **docker** installed. You can simply use the attached **Dockerfile** to build an image and then run a container based on it:

```bash
docker build . -t dotfiles_test_env
docker run -it --rm dotfiles_test_env
```

Please note that if you spin up the container without any command, the `prepare.sh` script will be automatically run.

## .clang-tidy && .clang-format

The files are based on Jason Turner's ones which can be seen [here](https://github.com/lefticus/cpp_weekly_game_project).

## Neovim config

The configuration for Neovim was taken from [here]("https://github.com/LunarVim/nvim-basic-ide"), [here](https://github.com/LunarVim/LunarVim) and also from [ChristianChiarulli](https://github.com/ChristianChiarulli/nvim), and then tweaked according to my needs.
