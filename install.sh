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


# if root create user and log in as user and cp dotfiles
if [[ $EUID -eq 0 ]]; then
  apt install -y sudo
  create_user
  cp -r /root/.dotfiles /home/$username/.dotfiles
  chown -R $username:$username /home/$username
  export USER=$username
fi

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
sudo chsh -s /usr/bin/fish $USER
sudo chsh -s /usr/bin/fish root

# install dotfiles
sudo su - $USER -c rcup rcrc
sudo su - $USER -c rcup -v

rcup rcrc
rcup -v

sudo su - $USER
