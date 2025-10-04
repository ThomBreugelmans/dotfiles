# zsh configuration
export ZSH="$HOME/.oh-my-zsh"
plugins=(ls tmux)

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
promptinit; prompt gentoo

# Setup Prompt
autoload -Uz vcs_info
precmd() { vcs_info }

zstyle ':vcs_info:git:*' formats '%b '

setopt PROMPT_SUBST
PROMPT='%F{green}%*%f %F{blue}%~%f %F{yellow}${vcs_info_msg_0_}%f$ '

# Aliases
alias pow="cat /sys/class/power_supply/BAT0/status | tr -d '\\n'; echo -n ' - '; cat /sys/class/power_supply/BAT0/capacity | tr -d '\\n'; echo '%'"
alias please="(fc -ln | tail -n 1) | xargs -o sudo"
