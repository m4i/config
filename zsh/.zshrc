# vim: fdm=marker

### compinit {{{1

fpath=(~/.local/share/zsh/completions $fpath)

autoload -Uz compinit
compinit

autoload -Uz bashcompinit
bashcompinit




### include {{{1

source $ZDOTDIR/options.zsh

# compinit/bashcompinit よりも後に読み込む必要あり
source $ZDOTDIR/../sh/rc.sh




### prompt {{{1

precmd() {
  psvar=()
  vcs_info
  [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}

PROMPT='%B%F{green}%n@%m%f%b%'                    # user@host
PROMPT="$PROMPT"'(1v.%F{yellow}%1v%f.)'           #  (git)-[master]-
PROMPT="$PROMPT"' %F{green}%~%f'                  #  ~/current/directory
PROMPT="$PROMPT"$'\n'
PROMPT="$PROMPT"'%B%(?.%F{green}.%F{red})%#%f%b ' # %

RPROMPT='%D{%F %T}'




### bindkey {{{1

# emacs like key bindings
bindkey -e

# history-pattern-search
bindkey '^R' history-incremental-pattern-search-backward
bindkey '^S' history-incremental-pattern-search-forward




### alias {{{1

alias -g G='| grep'
alias -g L='| less -r'
alias -g V='| xargs vim-tty'
alias -g V-='| vim -R -'
alias -g X='| xargs'
alias -g FX='-print0 | xargs -0'




### history {{{1

export HISTFILE=$HOME/.zsh_history
export HISTSIZE=1000000
export SAVEHIST=1000000




### vcs_info {{{1

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable bzr git hg svn




### completion {{{1

# 補完候補の表示数
LISTMAX=1000

# 補完で大文字小文字を区別しない
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# 補完候補に色をつける
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# 補完候補をカーソルで選択可能にする
zstyle ':completion:*:default' menu select true

# 補完候補の表示を充実させる
zstyle ':completion:*' verbose yes
zstyle ':completion:*' group-name ''
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:corrections'  format '%B%F{yellow}%d %F{red}(errors: %e)%f%b'
zstyle ':completion:*:descriptions' format '%F{yellow}Completing %B%d%b%f'
zstyle ':completion:*:messages'     format '%F{yellow}%d%f'
zstyle ':completion:*:warnings'     format '%F{red}No matches for: %B%d%b%f'




### colors {{{1

autoload -Uz colors
colors




### zmv {{{1

autoload -Uz zmv
alias zcp='noglob zmv -C'
alias zln='noglob zmv -L'
alias zmv='noglob zmv'




### misc {{{1

chpwd() {
  _cdd_chpwd
  ls -l >&2
}

# aws-cli
pyenv_prefix="$(pyenv prefix 2>/dev/null)"
if [[ -n "$pyenv_prefix" ]]; then
  aws_zsh_completer_path="$pyenv_prefix/bin/aws_zsh_completer.sh"
else
  aws_zsh_completer_path="$(command -v aws_zsh_completer.sh)"
fi
if [[ -e "$aws_zsh_completer_path" ]]; then
  source $aws_zsh_completer_path
fi
unset pyenv_prefix
unset aws_zsh_completer_path

# direnv
if type direnv >/dev/null; then
  eval "$(direnv hook zsh)"
fi




### include {{{1

# 最初の include 時点だとうまくいかないものはここで

source $ZDOTDIR/peco.zsh
