export XDG_CACHE_HOME=~/.cache
export XDG_CONFIG_HOME=~/.config
export XDG_DATA_HOME=~/.local/share
export XDG_STATE_HOME=~/.local/state

mkdir -p \
  "$XDG_CACHE_HOME" \
  "$XDG_CONFIG_HOME" \
  "$XDG_DATA_HOME" \
  "$XDG_STATE_HOME"

_homebrew_prefix=/home/linuxbrew/.linuxbrew
if [[ $(uname) == Darwin ]]; then
  _homebrew_prefix=/opt/homebrew
fi
if [[ -e $_homebrew_prefix/bin/brew ]]; then
  eval "$($_homebrew_prefix/bin/brew shellenv)"
fi
unset _homebrew_prefix

if type mise >/dev/null; then
  eval "$(mise activate zsh)"
fi

if [[ ":$PATH:" != *":$HOME/bin:"* ]]; then
  export PATH="$HOME/bin:$PATH"
fi
