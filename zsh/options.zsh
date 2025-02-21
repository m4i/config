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


### Input/Output

# 補完リストその他でも8ビット文字を表示する。
setopt print_eight_bit

# disable C-q, C-s
setopt no_flow_control
