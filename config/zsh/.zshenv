export XDG_CACHE_HOME=~/.cache
export XDG_CONFIG_HOME=~/.config
export XDG_DATA_HOME=~/.local/share
export XDG_STATE_HOME=~/.local/state

mkdir -p \
  "$XDG_CACHE_HOME" \
  "$XDG_CONFIG_HOME" \
  "$XDG_DATA_HOME" \
  "$XDG_STATE_HOME"

path=(~/.cargo/bin(N-/) $path)
path=(~/.local/share/aquaproj-aqua/bin(N-/) $path)
typeset -U path # 重複を削除

# aqua
export AQUA_GLOBAL_CONFIG=~/.config/aquaproj-aqua/aqua.yaml
if [[ "$(uname -s)" == "Darwin" ]]; then
  AQUA_GLOBAL_CONFIG=~/.config/aquaproj-aqua/aqua-macos.yaml:$AQUA_GLOBAL_CONFIG
else
  AQUA_GLOBAL_CONFIG=~/.config/aquaproj-aqua/aqua-linux.yaml:$AQUA_GLOBAL_CONFIG
fi
