### Changing Directories

# 通常のコマンドとして実行できないコマンドが発行され、コマンドが
# ディレクトリの名前のとき、そのディレクトリへの cd コマンドが実行される。
#setopt auto_cd

# cd すると古いディレクトリがディレクトリスタックに積まれる。
setopt auto_pushd

# ディレクトリスタックに同じディレクトリの複数のコピーを push しない。
setopt pushd_ignore_dups


### Completion

# 補完の結果として得られる最後の文字がスラッシュで、
# 次に入力した文字が単語の区切文字、スラッシュ、
# もしくはコマンドを終端する文字のとき、そのスラッシュを取り除く。
setopt auto_remove_slash

# 単語の途中にカーソルがあっても補完可能
setopt complete_in_word

# 異なる幅のカラムを使うことで、補完リストを小さくしようとする。
setopt list_packed


### History

# コマンドの開始時のタイムスタンプ(エポックからの秒数)と
# 実行時間(秒単位)をヒストリに含める。
setopt extended_history

# コマンド行からヒストリリストに追加されたものが古いものと全く同じ場合に、
# 古いものをリストから削除する(それが直前のイベントでなくても)。
setopt hist_ignore_all_dups

# 直前のイベントと全く同じものの場合、コマンド行をヒストリリストに加えない。
setopt hist_ignore_dups

# 行の最初の文字がスペースの場合、もしくはスペースから開始される
# 拡張エイリアスの場合に、コマンド行をヒストリリストから削除する。
setopt hist_ignore_space

# ヒストリリストに追加するときに、各コマンド行の余計な空白を取り除く。
setopt hist_reduce_blanks

# ヒストリファイルに書き出すときに、古いコマンドと同じものは無視する。
setopt hist_save_no_dups

# ヒストリファイルから新しいコマンドをインポートするのと、
# 入力したコマンドをヒストリファイルに書き出すのの両方を行う
# (後者は INC_APPEND_HISTORY と似ている)。
setopt share_history


### Input/Output

# 補完リストその他でも8ビット文字を表示する。
setopt print_eight_bit

# disable C-q, C-s
setopt no_flow_control
