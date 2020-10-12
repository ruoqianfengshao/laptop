#!/usr/bin/env zsh

if ! [ -e "$HOME/.ssh/id_rsa.pub" ]
then
  echo "Generating ssh key..."
  echo "Please enter the email you want to associate with your ssh key: \c"
  read email
  ssh-keygen -t rsa -C "$email"
fi

if [[ ! -x $(/usr/bin/which -s brew) ]]; then
  echo "Installing Homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo "Put Homebrew location earlier in PATH ..."
echo "\n# recommended by brew doctor" >> ~/.zshrc
echo "export PATH='/usr/local/bin:$PATH'\n" >> ~/.zshrc
source ~/.zshrc

echo "Installing Homebrew Versions..."
brew tap homebrew/versions

echo "Installing Git..."
brew install git

echo "Installing autojump"
brew install autojump

brew update

echo "Installing Build Essentials..."
brew install readline openssl coreutils
brew link --force openssl
brew link --force readline

echo "Installing Handy Tools..."
brew install wget curl tree ctags hub ssh-copy-id keychain zsh vim tmux

echo "Installing Databases..."
brew install mysql redis

echo "Installing Web Servers..."
brew install nginx

echo "Installing n and Node"
\wget -qO- https://git.io/n-install | bash
source ~/.zshrc
echo n version: $(n --version)
n lts
echo npm version: $(npm -v)
echo node version: $(node -v)
npm config set @ali:registry https://registry.npm.alibaba-inc.com/
npm config set @alife:registry https://registry.npm.alibaba-inc.com/
npm config set @terminus:registry https://registry.npm.terminus.io/
npm config set registry https://registry.npm.taobao.org/
npm i -g @terminus/herd
npm i -g @terminus/shepherd

echo "Embracing Cask..."
brew tap phinze/homebrew-cask
brew install brew-cask

echo "Installing Essential Applications with Cask..."
brew cask install google-chrome virtualbox iterm2 sequel-pro alfred2 visual-studio-code
brew cask alfred2 link
