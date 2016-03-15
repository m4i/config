# Mac OS X の /etc/zprofile により $PATH が変更されるため、再度設定し直す
#
# /etc/zprofile:
#
#     if [ -x /usr/libexec/path_helper ]; then
#       eval `/usr/libexec/path_helper -s`
#     fi

if [[ -x /usr/libexec/path_helper ]]; then
  source $ZDOTDIR/.zshenv
fi
