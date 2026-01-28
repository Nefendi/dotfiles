#!/bin/bash

HOME_PACKAGES=(
  alacritty
  asdf
  conda
  elixir
  eza
  fish
  fontconfig
  git
  haskell
  kitty
  latex
  lazygit
  niri
  nvim
  paru
  poetry
  pulse
  starship
  swaylock
  tmux
  uv
  zathura
  zsh
)

ETC_PACKAGES=(
  udev
  xml
)

stow --verbose "${HOME_PACKAGES[@]}"
sudo stow --verbose --target="/etc" "${ETC_PACKAGES[@]}"
