# vim: fdm=marker

### Functions {{{1

function _append_path() {
  _add_path append "$1" "$2"
}

function _prepend_path() {
  _add_path prepend "$1" "$2"
}

function _add_path() {
  local direction="$1"
  local env_name="$2"
  local adding_path="$3"

  local paths="$(eval "echo \$$env_name")"

  local adding_paths=
  if [[ "$adding_path" == *\** ]]; then
    adding_paths=($(eval "ls -d $adding_path" 2>/dev/null))
  else
    adding_paths=("$adding_path")
  fi

  for path_ in "${adding_paths[@]}"; do
    if [[ -z "$paths" ]]; then
      paths="$path_"

    else
      paths="$(echo "$paths" | sed \
        -e "s!:$path_:!:!g" \
        -e "s!:$path_\$!!"  \
        -e "s!^$path_:!!"   \
      )"
      if [[ "$direction" = append ]]; then
        paths="$paths:$path_"
      else
        paths="$path_:$paths"
      fi
    fi
  done

  eval $env_name=\'$paths\'
}




### $LANG {{{1

function _set_locale() {
  local locales="$(locale -a)"
  local locale=
  for regex in "$@"; do
    locale=$(echo "$locales" | grep -i "$regex")
    if [[ -n "$locale" ]]; then break; fi
  done
  if [[ -z "$locale" ]]; then
    locale=C
  fi
  export LANG=$locale
  export LC_CTYPE=$locale
}

_set_locale 'en_US.UTF-\?8' 'C.UTF-\?8'




### $PATH {{{1

if [[ $OSTYPE =~ ^darwin ]]; then
  # Homebrew
  _prepend_path PATH /usr/local/opt/coreutils/libexec/gnubin
  #_prepend_path PATH /usr/local/opt/python/libexec/bin
fi

_prepend_path PATH /usr/local/sbin
_prepend_path PATH /usr/local/bin

_prepend_path PATH '~/.local/share/vim/plugged/*/bin'
_prepend_path PATH '~/.local/*/bin'
_prepend_path PATH ~/.local/bin
_prepend_path PATH '~/Library/Python/*/bin'
_prepend_path PATH ~/src/github.com/m4i/config/bin
_prepend_path PATH ~/bin




### Environment Variables {{{1

export GEM_HOME=~/.local/gem
export GOPATH=~/.local/go
export HOMEBREW_CASK_OPTS='--appdir=~/Applications'
export NPM_CONFIG_PREFIX=~/.local/npm




### Homebrew {{{1

test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)




### anyenv {{{1

if command -v anyenv >/dev/null; then
  eval "$(anyenv init -)"
fi
