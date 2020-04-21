#!/bin/bash

create_user() {
  if [ $(id -u) -eq 0 ]; then
    read -p "Enter username : " username
    read -s -p "Enter password : " password
    egrep "^$username" /etc/passwd >/dev/null
    if [ $? -eq 0 ]; then
      echo "$username exists!"
    else
      pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
      useradd -m -p $pass $username
      [ $? -eq 0 ] && echo "User has been added to system!" || echo "Failed to add a user!"
    fi
  else
    echo "Only root may add a user to the system"
    exit 2
  fi
}

# create user
create_user

apt update
apt install -y sudo

# add GB locale
sudo update-locale
sudo locale-gen en_GB.utf8

# install rcm dotfiles manager
wget -qO - https://apt.thoughtbot.com/thoughtbot.gpg.key | sudo apt-key add -
echo "deb https://apt.thoughtbot.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/thoughtbot.list
sudo apt update
sudo apt install -y rcm
rcup rcrc
rcup -v

# install tmux
curl -LO https://github.com/tmux/tmux/releases/download/3.0a/tmux-3.0a-x86_64.AppImage
sudo mv tmux-3.0a-x86_64.AppImage /usr/bin/tmux
sudo chmod +x /usr/bin/tmux

# install utils
sudo apt install -y neovim git build-essential exuberant-ctags wget curl speedtest-cli htop jq ripgrep zip

# install ripgrep
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep_11.0.2_amd64.deb
sudo dpkg -i ripgrep_11.0.2_amd64.deb

# install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# install golang
sudo add-apt-repository ppa:longsleep/golang-backports
sudo apt update
sudo apt install -y golang-go

# install docker
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
sudo apt update
sudo apt install -y docker-ce
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# update user to groups
sudo usermod -aG sudo $username
sudo usermod -aG docker $username

# update default shell for user
su - $username
chsh -s /usr/bin/fish

# reload shell
su - $username
