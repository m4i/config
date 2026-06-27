#!/usr/bin/env bash
set -euo pipefail

function run() {
  echo "+ $@"
  "$@"
}

function relpath() {
  dst="$1"
  src="$2"
  if command -v python3 &>/dev/null; then
    # Linux, macOS
    python3 -c "import os.path, sys; print(os.path.relpath(sys.argv[1], start=sys.argv[2]))" "$dst" "$src"
  else
    # python3 のない devcontainer
    realpath --relative-to="$src" "$dst"
  fi
}

function ln_rel() {
  dst="$1"
  src="$2"
  run ln -snf "$(relpath "$dst" "$src")" "$src"
}


cd "$(dirname "${BASH_SOURCE[0]}")"


### ~/.config

ln_rel dotfiles/.zshenv ~

run mkdir -p ~/.config
for file in config/*; do
  # config/git は後で処理するのでスキップ
  if [[ "$file" == config/git ]]; then continue; fi
  ln_rel $file ~/.config
done


### git

# ~/.config/git/config は書き込まれる(credential helper 等)のでディレクトリごと
# symlink せず、git が既定パスで読む attributes/ignore だけ symlink する
run mkdir -p ~/.config/git
ln_rel config/git/attributes ~/.config/git
ln_rel config/git/ignore ~/.config/git

if [[ ! -f ~/.config/git/config ]]; then
  cat > ~/.config/git/config <<'__EOF__'
[include]
	path = ../../dotfiles/config/git/config
__EOF__
fi


### aqua

PATH=~/.local/share/aquaproj-aqua/bin:~/.cargo/bin:$PATH
export AQUA_GLOBAL_CONFIG=~/.config/aquaproj-aqua/aqua.yaml
AQUA_MACOS_CONFIG=~/.config/aquaproj-aqua/aqua-macos.yaml
AQUA_LINUX_CONFIG=~/.config/aquaproj-aqua/aqua-linux.yaml

# aqua は macOS では cargo が必要
if [[ "$(uname -s)" == "Darwin" ]]; then
  if [[ ! -e ~/.cargo/bin/cargo ]]; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --no-modify-path
  fi
  # aqua でインストールするバイナリが Homebrew を前提としているものは動かないので cargo install する
  sed -En 's! *- +name: +[^/]+/([^@]+)@([^ ]+) *$!\1 \2!p' "$AQUA_LINUX_CONFIG" |
    while read -r crate version; do
      case "$crate" in
        sheldon)
          options=(--features vendored-openssl)
          ;;
        *)
          options=()
          ;;
      esac
      run cargo install "$crate" --version "$version" --locked "${options[@]}"
    done
  AQUA_GLOBAL_CONFIG=$AQUA_MACOS_CONFIG:$AQUA_GLOBAL_CONFIG
else
  AQUA_GLOBAL_CONFIG=$AQUA_LINUX_CONFIG:$AQUA_GLOBAL_CONFIG
fi

if [[ ! -d ~/.local/share/aquaproj-aqua ]]; then
  curl -sSfL https://raw.githubusercontent.com/aquaproj/aqua-installer/v4.0.4/aqua-installer | bash
fi

run aqua install --all


### private

if [[ ! -d config-private ]]; then
  run git clone https://github.com/m4i/config-private.git
fi
config-private/install.sh
