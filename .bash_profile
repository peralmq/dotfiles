
# Source .bashrc for interactive settings (aliases, PATH, etc.)
[[ -f ~/.bashrc ]] && source ~/.bashrc

. "$HOME/.cargo/env"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# Work-only overrides (untracked)
[ -f "$HOME/.env.work" ] && source "$HOME/.env.work"
