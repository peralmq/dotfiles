# Prerequisites
```
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
curl -L http://install.ohmyz.sh | sh
```
# Usage
```
cd ~
ln -s dotfiles/vim ~/.vim
ln -s dotfiles/ipython ~/.ipython
rm .zshrc
ln -s dotfiles/zsh/.zshrc
ln -s dotfiles/zsh/.zshell
ln -s dotfiles/.tmux.conf
ln -s dotfiles/git/.gitconfig
ln -s dotfiles/git/.gitignore_global
cp dotfiles/com.googlecode.iterm2.plist ~/Library/Preferences/com.googlecode.iterm2.plist
```
