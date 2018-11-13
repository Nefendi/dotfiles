export ZSH="/Users/nefendi/.zplug/repos/robbyrussell/oh-my-zsh"

ZSH_THEME="candy"

ENABLE_CORRECTION="true"

plugins=(
  gitfast
  hacker-quotes
  osx
  colored-man-pages
  sudo
  cargo
  python
  pep8
  pip
)

export ZSH_HACKER_QUOTES_ENABLE_WHEN_INTERACTIVE="1"

source $ZSH/oh-my-zsh.sh
source /Users/nefendi/.oh-my-zsh/custom/plugins/hacker-quotes/hacker-quotes.plugin.zsh

export PATH="/Users/nefendi/Library/Orca401:/usr/local/bin:/anaconda3/bin:/usr/local/opt/llvm/bin:$HOME/.cargo/bin:$PATH"

if [ -f ~/.zsh_nocorrect ]; then
    while read -r COMMAND; do
        alias $COMMAND="nocorrect $COMMAND"
    done < ~/.zsh_nocorrect
fi
