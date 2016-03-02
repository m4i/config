# http://blog.kenjiskywalker.org/blog/2014/06/12/peco/
function peco-select-history() {
  local tac=tac
  if ! type tac > /dev/null; then
    tac='tail -r'
  fi
  BUFFER=$(history -n 1 | eval $tac | peco --query "$LBUFFER")
  CURSOR=$#BUFFER
}
if which peco >/dev/null; then
  zle -N peco-select-history
  bindkey '^r' peco-select-history
fi

alias -g DPS='$(docker ps | tail -n +2 | peco | cut -d " " -f 1)'
alias -g DPSA='$(docker ps -a | tail -n +2 | peco | cut -d " " -f 1)'
alias -g SRC='~/src/$(ghq list | peco)'
