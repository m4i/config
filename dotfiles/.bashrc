# vim: fdm=marker

M4I_CONFIG=$HOME/src/github.com/m4i/config

source $M4I_CONFIG/sh/env.sh

if [[ $OSTYPE =~ ^darwin ]]; then
  # OS X では /etc/bashrc は /etc/profile によってしか読み込まれない。
  # 新規に bash を立ち上げた時にも読み込みたいので、 ~/.bashrc が
  # ~/.bash_profile から読み込まれているのでなければ /etc/bashrc を読み込む。
  #
  # その時の $BASH_SOURCE:
  #   - ~/.bashrc
  #   - ~/.bash_profile
  if [[ "${BASH_SOURCE[1]}" != $HOME/.bash_profile ]]; then
    source /etc/bashrc
  fi
fi




### include {{{1

if [[ -f /etc/skel/.bashrc ]]; then
  source /etc/skel/.bashrc
fi

[[ "$-" =~ i ]] || return

source $M4I_CONFIG/sh/rc.sh




### prompt {{{1

## PROMPT_COMMAND {{{2

_prompt_commands=()
_prompt_command() {
  for command in "${_prompt_commands[@]}"; do
    $command
  done
}
PROMPT_COMMAND=_prompt_command


## PS1 {{{2

_ps1_prefix='\[\e[1;32m\]\u@\h\[\e[0m\]'           # user@host
_ps1_prefix="$_ps1_prefix"' \[\e[32m\]\w\[\e[0m\]' #  ~/current/directory
_ps1_prefix="$_ps1_prefix"'\n'

_ps1_success='\[\e[1;32m\]\$\[\e[0m\] '            # (green)$
_ps1_error='\[\e[1;31m\]\$\[\e[0m\] '              # (red)  $

_set_ps1() {
  if (($?)); then
    PS1="$_ps1_prefix$_ps1_error"
  else
    PS1="$_ps1_prefix$_ps1_success"
  fi
}
_prompt_commands+=(_set_ps1)




### history {{{1

export HISTCONTROL=ignoreboth
export HISTFILE=$HOME/.bash_history
export HISTFILESIZE=10000
export HISTSIZE=10000

shopt -u histappend

# http://iandeth.dyndns.org/mt/ian/archives/000651.html
_share_history() {
  history -a
  history -c
  history -r
}
_prompt_commands+=(_share_history)




### misc {{{1

cd() {
  builtin cd "$@"
  local ret=$?
  ((ret)) || {
    _cdd_chpwd
    ls -l >&2
  }
  return $ret
}

# direnv
eval "$(direnv hook bash)"
