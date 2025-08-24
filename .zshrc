# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/nix-profile/bin:/usr/local/bin:$PATH

if [ -e /home/amelia/.nix-profile/etc/profile.d/nix.sh ]; then . /home/amelia/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

#asdf
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
# append completions to fpath
fpath=(${ASDF_DATA_DIR:-$HOME/.asdf}/completions $fpath)

source "$HOME/keybinds/env.sh"
source "$HOME/keybinds/aliases.sh"
source "$HOME/keybinds/functions.zsh"
export FZF_DEFAULT_OPTS='--multi --no-height --extended'

#Setup zsh features
autoload -Uz compinit && compinit
#Setup zsh plugins and starship prompt
if [ -e "$HOME/.zsh/zsh-vi-mode/zsh-vi-mode.plugin.zsh" ]; then
    source "$HOME/.zsh/zsh-vi-mode/zsh-vi-mode.plugin.zsh"
fi
if [ -e "$HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
    source "$HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi
if [ -e "$HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
    source "$HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi
# The plugin will auto execute this zvm_after_init function
zvm_after_init() {
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

# keychain
if type keychain >/dev/null 2>&1; then
  eval "$(keychain --eval --quiet ~/.ssh/github)"
  # Add any other specific key names you want to load by default.
  # Or, to attempt loading all keys in ~/.ssh:
  # eval "$(keychain --eval --quiet --agents ssh ~/.ssh/id_*)"
  # Or simply:
  # eval "$(keychain --eval --quiet)" # This will try to load default keys
fi


