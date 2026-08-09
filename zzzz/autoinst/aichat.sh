#!/bin/bash
## dl aichat
if [ "${PREFIX}" ]; then apt install aichat -y; else wget -L "https://github.com/sigoden/aichat/releases/download/v0.30.0/aichat-v0.30.0-x86_64-unknown-linux-musl.tar.gz"; tar -xvf ./aichat-v0.30.0-x86_64-unknown-linux-musl.tar.gz; rm ./aichat-v0.30.0-x86_64-unknown-linux-musl.tar.gz; mv ./aichat -t $HOME/bin/; fi; 
####
# mkdir $HOME/.config/aichat 2>/dev/null; 
# [ -e "${HOME}/.safe/pw.sh" ] && \
# gpg --pinentry loopback --passphrase-file "${HOME}/.safe/pw.sh" -o "${HOME}/.config/aichat/config.yaml" -d "${HOME}/zz/setup/gpg/aichat.config.yaml.gpg" || \
# gpg --pinentry loopback -o "${HOME}/.config/aichat/config.yaml" -d "${HOME}/zz/setup/gpg/aichat.config.yaml.gpg"; 
####
