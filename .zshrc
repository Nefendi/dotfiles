export ZSH="/Users/nefendi/.zplug/repos/robbyrussell/oh-my-zsh"

ZSH_THEME="candy"

ENABLE_CORRECTION="true"

plugins=(
  git
  hacker-quotes
  osx
  colored-man-pages
  sudo
  cargo
)

export ZSH_HACKER_QUOTES_ENABLE_WHEN_INTERACTIVE="1"

source $ZSH/oh-my-zsh.sh
source /Users/nefendi/.oh-my-zsh/custom/plugins/hacker-quotes/hacker-quotes.plugin.zsh

export PATH="/Users/nefendi/Library/Orca401:/usr/local/bin:/anaconda3/bin:/usr/local/Cellar/llvm/6.0.1/bin:$HOME/.cargo/bin:$PATH"
