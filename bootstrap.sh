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
  ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go/install)"
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

echo "Installing NVM and Node"
\wget -qO- https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
source ~/.zshrc
echo nvm version: $(nvm --version)
NVM_NODEJS_ORG_MIRROR=https://npm.taobao.org/mirrors/node nvm install 9
echo npm version: $(npm -v)
echo node version: $(node -v)
npm config set @ali:registry http://registry.npm.alibaba-inc.com/
npm config set @alife:registry http://registry.npm.alibaba-inc.com/
npm config set @terminus:registry http://registry.npm.terminus.com/
npm config set registry http://registry.npm.taobao.org/
npm i -g @terminus/herd
npm i -g @terminus/shepherd

echo "Embracing Cask..."
brew tap phinze/homebrew-cask
brew install brew-cask

echo "Installing Essential Applications with Cask..."
brew cask install google-chrome virtualbox iterm2 sequel-pro alfred2 visual-studio-code sublime-text
brew cask alfred2 link
