export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye >/dev/null
export PATH=$PATH:$HOME/.local/bin

alias cp='cp -i'
alias mv='mv -i'
alias df='df -h'

export PATH="$HOME/.cargo/bin:$PATH"
