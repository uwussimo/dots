# Exports
export ZSH="/Users/uwussimo/.oh-my-zsh"
export VOLTA_HOME="$HOME/.volta"
export PATH="/opt/homebrew/opt/python/libexec/bin:$PATH"
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export PATH="/Users/uwussimo/.deno/bin:$PATH"
export PATH="$VOLTA_HOME/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
export GOPATH="/Users/uwussimo/.go"
export LC_ALL=en_US.UTF-8
export LSCOLORS=""

# Oh-My-Zsh Variables
ZSH_THEME=""
ENABLE_CORRECTION="false"
HOMEBREW_NO_ENV_HINTS="true"
CACHED_PATH="$HOME"

# Oh-My-Zsh Configs
plugins=(zsh-autosuggestions zsh-completions fast-syntax-highlighting git deno nvm node brew docker gh heroku pipenv rust yarn rust cp github npm macos pip pm2 pyenv python vundle)
autoload -U compinit && compinit

# Evals
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(frum init)"

# Completion config
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

# Starting Oh-My-Zsh
source $ZSH/oh-my-zsh.sh

# Alias to existing functions
source $HOME/.dots/alias.config

# Functions
source $HOME/.dots/func.config
