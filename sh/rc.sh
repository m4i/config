# vim: fdm=marker

### include {{{1

_sh_dir="${BASH_SOURCE:-$0}"
_sh_dir="${_sh_dir%/*}"

source "$_sh_dir/cdd.sh"
source "$_sh_dir/deprecated-net-tools.sh"
source "$_sh_dir/peco.sh"

unset _sh_dir




### BASE {{{1

alias grep='grep --color=auto'

if ! EDITOR="$(command -v vim)"; then
  EDITOR="$(command -v vi)"
fi
export EDITOR

export PAGER="$(command -v less) -r"

if type colordiff >/dev/null 2>&1; then
  alias diff=colordiff
fi

alias less='less -r'

alias tree='tree --charset=ascii'

case "$OSTYPE" in
  darwin*)
    ;;
  *)
    alias crontab='crontab -i'
    alias pstree='pstree --ascii'
    ;;
esac

alias tig='tig --find-renames --find-copies'

alias gg='git grep'




### ls {{{1

if [[ $OSTYPE =~ ^darwin ]] && [[ "$(command -v ls)" = /bin/ls ]]; then
  alias ls='ls -G -w'
else
  alias ls='ls --color=auto'
fi

alias l='ls -CF'
alias la='ls -AF'
alias ll='ls -AFl'
alias l.='ll -d .*'




### Gurobi Optimizer {{{1

case "$OSTYPE" in
  linux*)
    _gurobi_dir="$(ls /usr/local/app/gurobi 2>/dev/null | tail -1)"
    if [[ -n "$_gurobi_dir" ]]; then
      GUROBI_HOME=/usr/local/app/gurobi/$_gurobi_dir
    fi
    ;;
  darwin*)
    _gurobi_dir="$(ls /Library | grep ^gurobi | tail -1)"
    if [[ -n "$_gurobi_dir" ]]; then
      GUROBI_HOME=/Library/$_gurobi_dir/mac64
    fi
    ;;
esac
unset _gurobi_dir

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
