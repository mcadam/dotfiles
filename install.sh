#!/bin/bash

timedatectl set-timezone Australia/Melbourne

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
~/.fzf/install --all

# install docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# install microk8s
snap install microk8s --classic --stable
microk8s enable dns ingress storage metrics-server
snap alias microk8s.kubectl kubectl
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
mkdir -p ~/.kube
microk8s config > ~/.kube/config
echo "--allow-privileged=true" >> /var/snap/microk8s/current/args/kube-apiserver
systemctl restart snap.microk8s.daemon-apiserver
wget https://github.com/derailed/k9s/releases/download/v0.20.2/k9s_Linux_x86_64.tar.gz
tar xvf k9s_Linux_x86_64.tar.gz && mv k9s /usr/local/bin/ && rm k9s_Linux_x86_64.tar.gz
iptables -P FORWARD ACCEPT

# update user to groups
sudo usermod -aG sudo $USER
sudo usermod -aG docker $USER

# use fish shell
chsh -s /usr/bin/fish

# install dotfiles
rcup rcrc
rcup -v

sudo su - $USER
