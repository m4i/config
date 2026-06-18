#!/usr/bin/env bash
set -euo pipefail

function run() {
  echo "$@"
  "$@"
}

function relpath() {
  dst="$1"
  src="$2"
  if command -v realpath &>/dev/null; then
    realpath --relative-to="$src" "$dst"
  else
    python3 -c "import os.path, sys; print(os.path.relpath(sys.argv[1], start=sys.argv[2]))" "$dst" "$src"
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
files=(
  aquaproj-aqua
  git
  sheldon
  starship.toml
  zellij
  zsh
  zsh-abbr
)
for file in "${files[@]}"; do
  ln_rel config/$file ~/.config
done


### aqua

if [[ ! -d ~/.local/share/aquaproj-aqua ]]; then
  curl -sSfL https://raw.githubusercontent.com/aquaproj/aqua-installer/v4.0.4/aqua-installer | bash
fi

PATH=$HOME/.local/share/aquaproj-aqua/bin:$PATH
export AQUA_GLOBAL_CONFIG=~/.config/aquaproj-aqua/aqua.yaml
run aqua install --all


### git user

if [[ ! -d config-private ]]; then
  run git clone https://github.com/m4i/config-private.git
fi
ln_rel config-private/git/config-user config/git
ln_rel config-private/git/config-winworks config/git
