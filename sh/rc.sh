# vim: fdm=marker

### include {{{1

sh_dir="${BASH_SOURCE:-$0}"
sh_dir="${sh_dir%/*}"

source "$sh_dir/cdd.sh"

unset sh_dir




### BASE {{{1

export GREP_OPTIONS=--color=auto

if ! EDITOR="$(command -v vim)"; then
  EDITOR="$(command -v vi)"
fi
export EDITOR

export PAGER="$(command -v less) -r"

if command -v colordiff >/dev/null; then
  alias diff=colordiff
fi

alias less='less -r'

alias tree='tree --charset=ascii'

case "$OSTYPE" in
  darwin*)
    ;;
  *)
    alias pstree='pstree --ascii'
    ;;
esac




### ls {{{1

case "$OSTYPE" in
  freebsd*|darwin*)
    alias ls='ls -G -w'
    ;;
  *)
    alias ls='ls --color=auto'
    ;;
esac

alias l='ls -l'
alias l.='l -d .*'
alias la='l -A'




### vim {{{1

case "$OSTYPE" in
  darwin*)
    macvim=$HOME/Applications/MacVim.app
    if [[ ! -e $macvim ]]; then
      macvim=/Applications/MacVim.app
    fi
    if [[ -e $macvim ]]; then
      EDITOR=$macvim/Contents/MacOS/Vim
      alias vim=$EDITOR
      alias vi=$EDITOR
      alias gvim="$EDITOR -g --remote-tab-silent"
    fi
    unset macvim
    ;;
esac




### Git {{{1

alias g=git




### Node.js {{{1

_prepend_path PATH ~/.nodebrew/current/bin




### Ruby {{{1

# alias
alias b='bundle exec'
alias r='bundle exec rails'

# chruby
if [[ -e /usr/local/share/chruby/chruby.sh ]]; then
  source /usr/local/share/chruby/chruby.sh

  # for chef embedded ruby
  if [[ -e /opt/chef/embedded ]]; then
    RUBIES+=(/opt/chef/embedded)
  fi

  if [[ -e /usr/local/share/chruby/auto.sh ]]; then
    # chruby 0.3.6 では RUBY_AUTO_VERSION を unset しないと
    # 更に shell を実行した時に auto-switch が効かない
    unset RUBY_AUTO_VERSION
    source /usr/local/share/chruby/auto.sh
  fi

# rbenv
elif [[ -e ~/.rbenv ]]; then
  _prepend_path PATH ~/.rbenv/bin
  eval "$(rbenv init -)"

# rvm
elif [[ -e ~/.rvm ]]; then
  source ~/.rvm/scripts/rvm
fi




### Gurobi Optimizer {{{1

case "$OSTYPE" in
  linux*)
    gurobi_dir="$(ls /usr/local/app/gurobi 2>/dev/null | tail -1)"
    if [[ -n "$gurobi_dir" ]]; then
      GUROBI_HOME=/usr/local/app/gurobi/$gurobi_dir
    fi
    ;;
  darwin*)
    gurobi_dir="$(ls /Library | grep ^gurobi | tail -1)"
    if [[ -n "$gurobi_dir" ]]; then
      GUROBI_HOME=/Library/$gurobi_dir/mac64
    fi
    ;;
esac
unset gurobi_dir

if [[ -n "$GUROBI_HOME" ]]; then
  export GUROBI_HOME
  _prepend_path PATH "$GUROBI_HOME/bin"
  _prepend_path CPATH "$GUROBI_HOME/include"
  case "$OSTYPE" in
    linux*)
      _prepend_path LD_LIBRARY_PATH "$GUROBI_HOME/lib"
      ;;
    darwin*)
      : #_prepend_path DYLD_LIBRARY_PATH "$GUROBI_HOME/lib"
      ;;
  esac
else
  unset GUROBI_HOME
fi




### tmux {{{1

file="$(sh -c 'ls /usr/local/src/tmux/*/examples/bash_completion_tmux.sh 2>/dev/null | tail -1')"
if [[ -n "$file" ]]; then
  source "$file"
fi
unset file
