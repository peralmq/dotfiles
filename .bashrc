# ~/.bashrc

# Locale settings
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Project directories
export PROJECT_HOME="$HOME/Projects"

# PATH configuration
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# NVM setup
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Aliases

# Cargo environment
[ -f "$HOME/.cargo/env" ] && \. "$HOME/.cargo/env"

# History settings
HISTSIZE=999999999
HISTFILESIZE=$HISTSIZE

# SDKMAN
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# Work-only overrides (untracked)
[ -f "$HOME/.env.work" ] && source "$HOME/.env.work"
