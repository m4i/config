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
  elif ! echo "$_path" | grep -Eq "(^|:)$directory(:|$)"; then
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




### Environment Variables {{{1

export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

_prepend_path PATH ~/bin
