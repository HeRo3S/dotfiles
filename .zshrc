# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/nix-profile/bin:/usr/local/bin:$PATH

if [ -e /home/amelia/.nix-profile/etc/profile.d/nix.sh ]; then . /home/amelia/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

source "$HOME/keybinds/aliases.sh"
source "$HOME/keybinds/aliases.zsh"

#Setup zsh features
autoload -Uz compinit && compinit
#Setup zsh plugins and starship prompt
source "$HOME/.zsh/zsh-vi-mode/zsh-vi-mode.plugin.zsh"
source "$HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
# The plugin will auto execute this zvm_after_init function
zvm_after_init() {
  source /usr/share/doc/fzf/examples/key-bindings.zsh
  source /usr/share/doc/fzf/examples/completion.zsh
  source "$HOME/keybinds/keybinds.sh"
}
eval "$(fzf --zsh)"
eval "$(starship init zsh)"

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# fnm
FNM_PATH="/home/amelia/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="/home/amelia/.local/share/fnm:$PATH"
  eval "`fnm env --use-on-cd --version-file-strategy=recursive`"
fi
