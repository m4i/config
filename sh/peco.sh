bundle-cd() {
    local gem
    if [[ -n "$1" ]]; then
        gem="$1"
    else
        gem="$(bundle list | awk '{ print $2 }' | peco)"
    fi
    cd "$(bundle show "$gem")"
}
