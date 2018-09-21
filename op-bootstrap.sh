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

if [ -e "$HOME/.zshrc" ]
then
  echo "Put Homebrew location earlier in PATH ..."
  echo "\n# recommended by brew doctor" >> ~/.zshrc
  echo "export PATH='/usr/local/bin:$PATH'\n" >> ~/.zshrc
  source ~/.zshrc
else
  echo "Put Homebrew location earlier in PATH ..."
  echo "\n# recommended by brew doctor" >> ~/.bashrc
  echo "export PATH='/usr/local/bin:$PATH'\n" >> ~/.bashrc
  source ~/.bashrc
fi

echo "Installing Homebrew Versions..."
brew tap homebrew/versions

if [[ ! -x $(which git) ]]; then
  echo "Installing Git..."
  brew install git
else
  echo "Git has installed"
fi

if [[ ! -x $(which autojump) ]]; then
  echo "Installing autojump"
  brew install autojump
fi

brew update

echo "Installing Build Essentials..."
brew install readline openssl coreutils
brew link --force openssl
brew link --force readline

echo "Installing Handy Tools..."
for tool in wget curl tree ctags hub ssh-copy-id keychain vim tmux
do
  if [[ ! -x $(which $tool) ]]; then
    echo "Installing $tool..."
    brew install $tool
  fi
done
echo "complete install tool..."

echo "Installing db..."
if [[ ! -x $(which redis-cli) ]]; then
  echo "Installing redis..."
  brew install redis
fi

if [[ ! -x $(which nginx) ]]; then
  echo "Installing Web Servers..."
  brew install nginx
fi
echo "complete install db..."


echo "Installing NVM and Node"
\wget -qO- https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
source ~/.zshrc
echo nvm version: $(nvm --version)
NVM_NODEJS_ORG_MIRROR=https://npm.taobao.org/mirrors/node nvm install 9
echo npm version: $(npm -v)
echo node version: $(node -v)
npm config set @ali:registry http://registry.npm.alibaba-inc.com/
npm config set @alife:registry http://registry.npm.alibaba-inc.com/
npm config set @terminus:registry http://registry.npm.terminus.io/
npm config set registry http://registry.npm.taobao.org/
npm i -g @terminus/herd
npm i -g @terminus/shepherd
echo "complete install frontend env..."

echo "Embracing Cask..."
brew tap phinze/homebrew-cask
brew install brew-cask

