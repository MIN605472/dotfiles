export PATH=$PATH:$HOME/.local/bin

# gpg
export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye >/dev/null

# alias
alias cp='cp -i'
alias mv='mv -i'
alias df='df -h'

# rust
export PATH="$HOME/.cargo/bin:$PATH"

# node
source /usr/share/nvm/init-nvm.sh
export PATH="$PATH:$HOME/.node_modules/bin"
export npm_config_prefix=$HOME/.node_modules

