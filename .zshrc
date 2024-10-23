# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/nix-profile/bin:/usr/local/bin:$PATH

# Import nvm
export NVM_DIR="$HOME/.nvm"
export NVM_COMPLETION=true
export NVM_LAZY_LOAD=true
export NVM_AUTO_USE=true

if [ -e /home/amelia/.nix-profile/etc/profile.d/nix.sh ]; then . /home/amelia/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

#Alias
alias dev_tmux='~/scripts/tmux.sh'

#Setup zsh plugins and starship prompt
source "$HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "$HOME/.zsh/zsh-nvm/zsh-nvm.plugin.zsh"
eval "$(fzf --zsh)"
eval "$(starship init zsh)"

bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down
bindkey -M emacs '^J' fzf-cd-widget
