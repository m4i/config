### history

mkdir -p "$XDG_STATE_HOME/zsh"
HISTFILE="$XDG_STATE_HOME/zsh/history"
HISTSIZE=2000000 # HIST_EXPIRE_DUPS_FIRST によれば HISTSIZE > SAVEHIST すべきとのこと
SAVEHIST=1000000

setopt EXTENDED_HISTORY         # 開始時刻:経過秒数を記録する
setopt HIST_EXPIRE_DUPS_FIRST   # 履歴上限に達したら重複から削除
setopt HIST_FCNTL_LOCK          # パフォーマンス向上
#setopt HIST_IGNORE_ALL_DUPS    # HIST_IGNORE_DUPS を採用しないなら当然こちらも採用しない
#setopt HIST_IGNORE_DUPS        # 同じコマンドでも経過時間が知りたい時があるので採用しない
setopt HIST_IGNORE_SPACE        # 余分な空白を削除
setopt HIST_REDUCE_BLANKS       # 連続したスペースを1つにする
setopt HIST_SAVE_NO_DUPS        # シェル終了時に重複を削除する
setopt INC_APPEND_HISTORY_TIME  # コマンド実行完了後すぐに経過秒数と共に記録する
#setopt SHARE_HISTORY           # 経過秒数を記録したいので採用しない

alias hist='history -t "%F %T" -D'



### prompt

setopt PROMPT_SUBST

PROMPT=$'\n'
PROMPT="$PROMPT"'%F{blue}%D{%dT%T}%f'           # DDThh:mm:ss

### git-prompt
if [[ -e /usr/share/git-core/contrib/completion/git-prompt.sh ]]; then
  source /usr/share/git-core/contrib/completion/git-prompt.sh
elif [[ -e /Library/Developer/CommandLineTools/usr/share/git-core/git-prompt.sh ]]; then
  source /Library/Developer/CommandLineTools/usr/share/git-core/git-prompt.sh
fi
if type __git_ps1 &>/dev/null; then
  GIT_PS1_SHOWDIRTYSTATE=true
  GIT_PS1_SHOWSTASHSTATE=true
  GIT_PS1_SHOWUNTRACKEDFILES=true
  GIT_PS1_SHOWUPSTREAM=auto
  GIT_PS1_SHOWCONFLICTSTATE=yes
  GIT_PS1_DESCRIBE_STYLE=branch
  GIT_PS1_SHOWCOLORHINTS=true
  PROMPT="$PROMPT"'$(__git_ps1)'
fi

# AWS_PROFILE
function _aws_profile() {
  if [[ -n $AWS_PROFILE ]]; then
    echo " %F{yellow}AWS:$AWS_PROFILE%f"
  fi
}
PROMPT="$PROMPT"'$(_aws_profile)'

PROMPT="$PROMPT"' %F{green}%m:%~%f'             # host:~/current/directory
PROMPT="$PROMPT"$'\n'
PROMPT="$PROMPT"'%(?.%F{green}.%F{red})%#%f '   # % ($?==0 ? green : red)



### alias

alias l=eza
alias ll='eza -la'
alias lt='eza -la -T -I ".git|node_modules"'

alias diff='git diff --no-index'




### completion

#bindkey -e
#zstyle :compinstall filename '/home/mtakeuchi/.zshrc'

if [[ -n $HOMEBREW_PREFIX ]]; then
  fpath=(
    $HOMEBREW_PREFIX/share/zsh/site-functions(N-/)
    $HOMEBREW_PREFIX/share/zsh-completions(N-/)
    $fpath
  )
  if [[ -d $HOMEBREW_PREFIX/share/zsh-autocomplete ]]; then
    source $HOMEBREW_PREFIX/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh
  fi
fi

# 重複を削除する
typeset -U fpath

mkdir -p "$XDG_CACHE_HOME/zsh"
autoload -Uz compinit
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump"



### mise

if type mise &>/dev/null; then
  eval "$(mise activate zsh)"
fi



### fzf

if type fzf &>/dev/null; then
  source <(fzf --zsh)
fi
