if [[ ! -f "${HOME}/.zgenom/zgenom.zsh" ]]; then
  git clone https://github.com/jandamm/zgenom.git "${HOME}/.zgenom"
fi
source "${HOME}/.zgenom/zgenom.zsh"

# check for updates ever 7 days
zgenom autoupdate


# only runs when .zgenom/sources/init.zsh doesn't exist
# use zgenom reset to delete init.zsh
# zgenom reset
if ! zgenom saved; then
  zgenom prezto editor key-bindings 'vi'
  zgenom prezto editor dot-expansion 'yes'
  zgenom prezto prompt theme 'pure'
  zgenom prezto

  zgenom prezto docker
  zgenom prezto git
  zgenom prezto homebrew
  zgenom prezto node
  zgenom prezto python
  zgenom prezto ssh
  zgenom prezto history-substring-search

  zgenom oh-my-zsh plugins/aws

  # zgenom load zsh-users/zsh-autosuggestions
  zgenom load zsh-users/zsh-syntax-highlighting
  # zgenom load zsh-users/zsh-completions
  # zgenom load marlonrichert/zsh-autocomplete
  zgenom load mafredri/zsh-async
  zgenom load ~/.zsh-functions
  zgenom load ~/.zshenv
  zgenom load ~/.gitaliases
  zgenom load ~/.deno/env

  zgenom save
fi



# Customize to your needs...

bindkey -e # Extra keybindings

HISTSIZE=999999999
SAVEHIST=$HISTSIZE


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
