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
  zgenom prezto prompt theme 'sorin'
  zgenom prezto

  zgenom prezto git
  zgenom prezto docker
  zgenom prezto homebrew
  zgenom prezto python
  zgenom prezto tmux
  zgenom prezto ssh

  # zgenom load zsh-users/zsh-autosuggestions
  zgenom load zsh-users/zsh-syntax-highlighting
  # zgenom load marlonrichert/zsh-autocomplete
  zgenom load mafredri/zsh-async
  zgenom load ~/.gitaliases
  zgenom load ~/.zsh-functions
  zgenom load ~/.zshenv

 zgenom save
fi



# Customize to your needs...

bindkey -e # Extra keybindings

HISTSIZE=999999999
SAVEHIST=$HISTSIZE

. /opt/homebrew/opt/asdf/libexec/asdf.sh

