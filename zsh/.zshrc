# zsh configuration
export ZSH="$HOME/.oh-my-zsh"
plugins=(git git-prompt ls tmux)

# tmux configuration
ZSH_TMUX_AUTOSTART=true
ZSH_TMUX_AUTOSTART_ONCE=true
ZSH_TMUX_AUTOCONNECT=false
ZSH_TMUX_UNICODE=true

source $ZSH/oh-my-zsh.sh

# To initialize zoxide, add this to your configuration (usually ~/.zshrc):
eval "$(zoxide init zsh)"

bindkey -e
zstyle :compinstall filename '/home/hannibal/.zshrc'
autoload -Uz compinit promptinit
compinit
promptinit
