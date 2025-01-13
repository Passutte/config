#!/usr/bin/env bash

# The script needs to be run with sudo

##########################################
# Global Variables
##########################################
(( step_num=0 ))
step_msg=""
(( sub_step_num=1 ))

os=""
home=""
user=""

##########################################
# Functions
##########################################
step() {
  # print step number and info
  (( step_num++ ))
  step_msg="$1"
  echo
  echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
  echo "[Step $step_num]: $step_msg"
  echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
  (( sub_step_num=1))
}

sub_step() {
  # print step.sub_step number and info
  echo
  echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
  echo "[Step $step_num.$sub_step_num]: ($step_msg) $1"
  echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
  (( sub_step_num++ ))
}

disp_usage() {
  # display script usage
  echo "Usage: sudo bash install.sh macOS|ubuntu|parallels $ HOME $ USER"
  echo "  - macOS: uses zshrc and iterm2"
  echo "  - ubuntu: uses bashrc and guake"
  echo "  - parallels: ubuntu running on parallels"
}

##########################################
# Script Execution Call
##########################################

# check for valid usage
if [ "$1" != "macOS" ] && [ "$1" != "ubuntu" ] && [ "$1" != "parallels" ]; then
  # invalid usage
  disp_usage
  # Ref exit codes: https://www.cyberciti.biz/faq/linux-bash-exit-status-set-exit-statusin-bash/
  exit 22  # invalid argument
elif [ "$EUID" -ne 0 ]; then
  disp_usage
  exit 1  # operation not permitted
else
  # Check if user exists and configure right home directory
  if [ "$1" = "macOS" ]; then
    os="macOS"
  elif [ "$1" = "ubuntu" ]; then
    os="ubuntu"
  elif [ "$1" = "parallels" ]; then
    os="parallels"
  fi
fi

home=$2
user=$3

##########################################
# Installation Steps - Ubuntu
##########################################
if [ $os = "ubuntu" ] || [ $os = "parallels" ]; then

    ##########################################
    step "add ppa-repositories"

    ##########################################
    step "apt update"
    sudo apt update -y
    
    ##########################################
    step "install with added ppa"

    sub_step "fish"
    sudo apt install -y fish

    ##########################################
    step "install apt packages"

    sub_step "openssh-server"
    sudo apt install -y openssh-server

    sub_step "curl"
    sudo apt install -y curl

    sub_step "tmux"
    sudo apt install -y tmux

    sub_step "vim"
    sudo apt install -y vim

    sub_step "git git-lfs"
    sudo apt install -y git git-lfs

    sub_step "python3 venv"
    sudo apt install -y python3-venv

    sub_step "guake"
    sudo apt install -y guake

    ##########################################
    # step "Install Docker via convenience script"
    # https://docs.docker.com/engine/install/ubuntu/#install-using-the-convenience-script
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    # Docker non-root user
    sudo groupadd docker
    sudo usermod -aG docker $user
    newgrp docker


##########################################
# Installation Steps - MacOS
##########################################
elif [ $os = "macOS" ]; then
    step "install with brew"

    sub_step "fish"
    sudo -u $user brew install fish

    sub_step "iterm2"
    sudo -u $user brew install --cask iterm2

    sub_step "tmux"
    sudo -u $user brew install tmux

fi

##########################################
# Config Files
##########################################
step "config files"

sub_step "fish"
mkdir -p $home/.config/fish
cp .config/fish/config.fish $home/.config/fish

# fish needs to be run as sudo - different location in parallels
if [ $os = "parallels" ]; then
  mkdir -p /root/.config/fish
  cp .config/fish/config.fish /root/.config/fish
fi

if [ $os = "ubuntu" ] || [ $os = "parallels" ]; then
  sub_step "bashrc"
  cat ubuntu/.bashrc >> "$home/.bashrc"
  echo "Appended content of ubuntu/.bashrc to $home/.bashrc"

elif [ $os = "macOS" ]; then
  sub_step "zshrc"
  cat macOS/.zshrc >> "$home/.zshrc"
  echo "Appended content of macOS/.zshrc to $home/.zshrc"
fi

sub_step "bash_aliases"
cp .bash_aliases "$home"


##########################################
# Bash Utilities
##########################################
sub_step "fzf"
git clone --depth 1 https://github.com/junegunn/fzf.git $home/.fzf
sudo -u $(logname) $home/.fzf/install

sub_step "loki"
git clone --depth 1 https://github.com/slim-bean/loki-shell.git $home/.loki-shell
sudo -u $(logname) $home/.loki-shell/install

sub_step "tmux"
git clone https://github.com/tmux-plugins/tpm $home/.tmux/plugins/tpm
cp .tmux.conf "$home"

##########################################
# Permissions
##########################################
if [ $os = "parallels" ]; then
  step "Permissions"
  sudo chown -R $user:$user $home/.config/fish
  chmod -R 700 $home/.config/fish
fi

exit 0