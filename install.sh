#!/bin/bash

# add repos
sudo add-apt-repository -y ppa:martin-frost/thoughtbot-rcm
sudo add-apt-repository -y ppa:neovim-ppa/stable
sudo add-apt-repository -y ppa:longsleep/golang-backports
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# update package list
sudo apt update

# add GB locale
sudo update-locale
sudo locale-gen en_GB.utf8

# install tmux
curl -LO https://github.com/tmux/tmux/releases/download/3.0a/tmux-3.0a-x86_64.AppImage
sudo mv tmux-3.0a-x86_64.AppImage /usr/bin/tmux
sudo chmod +x /usr/bin/tmux

# install apps
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common \
  git build-essential exuberant-ctags wget speedtest-cli htop jq zip fish \
  golang-go docker-ce rcm neovim

# install ripgrep
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep_11.0.2_amd64.deb
sudo dpkg -i ripgrep_11.0.2_amd64.deb
sudo rm ripgrep_11.0.2_amd64.deb

# install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# install docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# update user to groups
sudo usermod -aG sudo $USER
sudo usermod -aG docker $USER

# use fish shell
chsh -s /usr/bin/fish

# install dotfiles
rcup rcrc
rcup -v

sudo su - $USER
