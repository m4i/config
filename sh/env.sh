# vim: fdm=marker

### Functions {{{1

_add_path() {
  local direction="$1"
  local name="$2"
  local directory="$3"

  if [[ ! -d "$directory" ]]; then
    return
  fi

  local _path="$(eval echo \$$name)"

  if [[ -z "$_path" ]]; then
    eval $name=\'$directory\'    #'

  else
    _path="$(echo "$_path" | sed \
      -e "s!:$directory:!:!g" \
      -e "s!:$directory\$!!"  \
      -e "s!^$directory:!!"   \
    )"
    if [[ "$direction" = append ]]; then
      eval $name=\'$_path:$directory\'    #'
    else
      eval $name=\'$directory:$_path\'    #'
    fi
  fi
}

_append_path() {
  _add_path append "$1" "$2"
}

_prepend_path() {
  _add_path prepend "$1" "$2"
}

_prepend_paths() {
  local name="$1"
  shift
  for directory in "$@"; do
    _add_path prepend "$name" "$directory"
  done
}




### Environment Variables {{{1

export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

_prepend_path PATH /usr/local/sbin
_prepend_path PATH /usr/local/bin
_prepend_path PATH ~/.local/bin
_prepend_paths PATH ~/.local/*/bin
_prepend_path PATH ~/src/github.com/m4i/config/bin
_prepend_path PATH ~/bin
