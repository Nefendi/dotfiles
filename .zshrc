ZSH="/Users/nefendi/.zplug/repos/robbyrussell/oh-my-zsh"

ZSH_THEME="candy"

ENABLE_CORRECTION="true"

EDITOR="vim"

plugins=(
  gitfast
  osx
  common-aliases
  colored-man-pages
  sudo
  cargo
  python
  pep8
  pylint
  pip
  z
  copyfile
  docker
  encode64
  extract
)

source $ZSH/oh-my-zsh.sh
source /Users/nefendi/.oh-my-zsh/custom/plugins/rand-quote/rand-quote.plugin.zsh

quote

PATH="/usr/local/texlive/2018/bin/x86_64-darwin:/Users/nefendi/anaconda3/envs:/usr/local/opt/llvm/bin:/Users/nefendi/.local/bin:$PATH"

if [ -f ~/.zsh_nocorrect ]; then
    while read -r COMMAND; do
        alias $COMMAND="nocorrect $COMMAND"
    done < ~/.zsh_nocorrect
fi

PERL5LIB="/Users/nefendi/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/Users/nefendi/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/Users/nefendi/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/nefendi/perl5"; export PERL_MM_OPT;

export CPLUS_INCLUDE_PATH=/usr/local/Cellar/gcc/9.2.0_2/include/c++/9.2.0:/usr/include:/usr/local/include:$HOME/.local/include:/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include:$CPLUS_INCLUDE_PATH

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/nefendi/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/nefendi/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/nefendi/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/nefendi/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

fpath+=${ZDOTDIR:-~}/.zsh_functions
