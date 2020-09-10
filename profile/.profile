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
export SPARK_HOME="$HOME/.local/bin/spark-2.4.4-bin-hadoop2.7"
export PATH=$SPARK_HOME/bin:$SPARK_HOME/sbin:$PATH
export PYSPARK_DRIVER_PYTHON=jupyter
export PYSPARK_DRIVER_PYTHON_OPTS='notebook'
