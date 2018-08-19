export ZSH="/Users/nefendi/.zplug/repos/robbyrussell/oh-my-zsh"

ZSH_THEME="candy"

ENABLE_CORRECTION="true"

plugins=(
  git
  hacker-quotes
  osx
)

export ZSH_HACKER_QUOTES_ENABLE_WHEN_INTERACTIVE="1"

source $ZSH/oh-my-zsh.sh
source /Users/nefendi/.oh-my-zsh/custom/plugins/hacker-quotes/hacker-quotes.plugin.zsh

export PATH="$HOME/.cargo/bin:$PATH"