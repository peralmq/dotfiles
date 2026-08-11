#!/usr/bin/env bash
#
# Bootstrap a new personal Mac from this dotfiles repo.
# Usage: run from anywhere; safe to re-run (idempotent).
#   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/peralmq/dotfiles/master/install.sh)"

set -euo pipefail

DOTFILES_REPO="https://github.com/peralmq/dotfiles.git"
DOTFILES_DIR="$HOME/dotfiles"

# Files/dirs in the repo that get symlinked into $HOME.
LINKS=(
  .zshrc .zshenv .zsh-functions
  .bashrc .bash_profile .profile
  .gitconfig .gitaliases
  .npmrc
  .tmux.conf
  .vimrc .vim
)

info()  { printf '\033[1;34m==>\033[0m %s\n' "$*"; }

# 1. Homebrew
if ! command -v brew >/dev/null 2>&1; then
  info "Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
eval "$(/opt/homebrew/bin/brew shellenv)"

# 2. Dotfiles repo
if [ -d "$DOTFILES_DIR/.git" ]; then
  info "Updating existing dotfiles repo"
  git -C "$DOTFILES_DIR" pull --ff-only
else
  info "Cloning dotfiles"
  git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
fi

# 3. Packages
info "Installing Brewfile packages (this takes a while on first run)"
brew bundle --file="$DOTFILES_DIR/Brewfile"

# 4. Symlinks (existing real files are backed up once as <name>.pre-dotfiles)
info "Linking dotfiles into \$HOME"
for f in "${LINKS[@]}"; do
  src="$DOTFILES_DIR/$f"
  dst="$HOME/$f"
  [ -e "$src" ] || { echo "  skip $f (not in repo)"; continue; }
  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    mv "$dst" "$dst.pre-dotfiles"
    echo "  backed up existing $f -> $f.pre-dotfiles"
  fi
  ln -sfn "$src" "$dst"
  echo "  linked $f"
done

# 5. zsh plugin manager (zgenom), used by .zshrc
if [ ! -d "$HOME/.zgenom" ]; then
  info "Installing zgenom"
  git clone https://github.com/jandamm/zgenom.git "$HOME/.zgenom"
fi

info "Done. Remaining manual steps:"
cat <<'EOF'
  - SSH keys: restore via Bitwarden SSH agent (Bitwarden app > enable SSH agent)
  - iTerm2: import iterm2-Profile.json from the repo (Settings > Profiles > Other Actions > Import)
  - npm/JFrog: run `npm login --registry=https://viaplay.jfrog.io/...` ONLY if this
    machine needs work registry access; otherwise replace ~/.npmrc symlink with a
    plain personal one
  - Work-only env (~/.env.work) intentionally does not exist on this machine
  - Open a new terminal so zsh/zgenom initialize
EOF
