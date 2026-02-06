#!/bin/bash

HOME_PACKAGES=(
  alacritty
  asdf
  elixir
  eza
  fontconfig
  gemini
  ghostty
  git
  haskell
  kitty
  latex
  lazygit
  niri
  noctalia
  nvim
  paru
  poetry
  pulse
  starship
  tmux
  uv
  yazi
  zathura
  zsh
)

ETC_PACKAGES=(
  udev
  xml
)

stow --verbose "${HOME_PACKAGES[@]}"
sudo stow --verbose --target="/etc" "${ETC_PACKAGES[@]}"
