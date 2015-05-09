# http://blog.kenjiskywalker.org/blog/2014/06/12/peco/
function peco-select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(history -n 1 | \
        eval $tac | \
        peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}
if type peco >/dev/null; then
  zle -N peco-select-history
  bindkey '^r' peco-select-history
fi

function look() {
  SHELL=zsh ghq look $(ghq list | peco)
}

alias -g SRC='~/src/$(ghq list | peco)'
