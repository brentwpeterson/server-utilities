date +%s | sha256sum | base64 | head -c $1 ; echo
