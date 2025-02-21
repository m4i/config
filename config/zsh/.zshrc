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

PROMPT=$'\n'
PROMPT="$PROMPT"'%F{blue}%D{%dT%T}%f'           # DDThh:mm:ss
PROMPT="$PROMPT"' %F{green}%n@%m:%~%f'          # user@host:~/current/directory
PROMPT="$PROMPT"$'\n'
PROMPT="$PROMPT"'%(?.%F{green}.%F{red})%#%f '   # % ($?==0 ? green : red)




#bindkey -e
#zstyle :compinstall filename '/home/mtakeuchi/.zshrc'

mkdir -p "$XDG_CACHE_HOME/zsh"
autoload -Uz compinit
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump"

alias l=eza
alias ll='eza -la'
