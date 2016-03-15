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

  if echo "$adding_path" | grep -q \*; then
    local adding_paths=($(eval "ls -d $adding_path" 2>/dev/null))
  else
    local adding_paths=("$adding_path")
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




### Environment Variables {{{1

export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

_prepend_path PATH /usr/local/sbin
_prepend_path PATH /usr/local/bin
_prepend_path PATH ~/bin
_prepend_path PATH ~/.local/bin
_prepend_path PATH '~/.local/*/bin'
_prepend_path PATH ~/src/github.com/m4i/config/bin
_prepend_path PATH ~/src/bitbucket.org/m4i/config/bin
