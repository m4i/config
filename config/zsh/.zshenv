export XDG_CACHE_HOME=~/.cache
export XDG_CONFIG_HOME=~/.config
export XDG_DATA_HOME=~/.local/share
export XDG_STATE_HOME=~/.local/state

mkdir -p \
  "$XDG_CACHE_HOME" \
  "$XDG_CONFIG_HOME" \
  "$XDG_DATA_HOME" \
  "$XDG_STATE_HOME"

# aqua
path=(~/.local/share/aquaproj-aqua/bin(N-/) $path)
typeset -U path # 重複を削除
if [[ -z "$AQUA_GLOBAL_CONFIG" ]]; then
  export AQUA_GLOBAL_CONFIG=~/.config/aquaproj-aqua/aqua.yaml
fi
