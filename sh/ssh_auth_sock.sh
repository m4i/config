sock_symlink=~/tmp/ssh-auth-sock

if [[ -S "$SSH_AUTH_SOCK" ]]; then
  if [[ "$SSH_AUTH_SOCK" =~ ^/tmp/ssh-.*/agent\.[0-9]*$ ]]; then
    mkdir -p "$(dirname "$sock_symlink")"
    ln -sf "$SSH_AUTH_SOCK" "$sock_symlink" && \
      export SSH_AUTH_SOCK="$sock_symlink"
  fi

elif [[ -S "$sock_symlink" ]]; then
  export SSH_AUTH_SOCK="$sock_symlink"
fi

unset sock_symlink
