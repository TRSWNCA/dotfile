export ZSH="/home/trswnca/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="ys"

# Use case-sensitive completion.
CASE_SENSITIVE="true"

# Use hyphen-insensitive completion.
HYPHEN_INSENSITIVE="true"

# Automatically update without prompting.
DISABLE_UPDATE_PROMPT="true"
export UPDATE_ZSH_DAYS=30

plugins=(git extract z zsh-syntax-highlighting zsh-autosuggestions tmux npm)

source $ZSH/oh-my-zsh.sh

# User configuration

# You may need to manually set your language environment
# export LANG=en_US.UTF-8
# GO
export PATH=$PATH:/usr/local/go/bin
export GOPATH=/home/trswnca/go/

# Preferred editor for local and remote sessions
export EDITOR='vim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

alias python="python3"
alias pip="pip3"
alias ft="astyle --style=google -t2 -p -H -U -k1"

