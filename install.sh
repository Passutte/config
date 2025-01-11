#!/usr/bin/env bash

# The script needs to be run with sudo

##########################################
# Global Variables
##########################################
(( step_num=0 ))
step_msg=""
(( sub_step_num=1 ))

os=""

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
  echo "Usage: sudo bash install.sh macOS|ubuntu|parallels"
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
    user_name=$1
    if [ ! -d "/Users/$1" ]; then
    disp_usage
    exit 22
    fi

  elif [ "$1" = "ubuntu" ]; then
    os="ubuntu"
    user_name=$1
    if [ ! -d "/home/$1" ]; then
    disp_usage
    exit 22
    fi

  elif [ "$1" = "parallels" ]; then
    os="parallels"
    user_name=$1
    if [ ! -d "/home/$1" ]; then
    disp_usage
    exit 22
    fi
  fi
fi

##########################################
# Installation Steps - Ubuntu
##########################################
if [ $os = "ubuntu" ] || [ $os = "parallels" ]; then

    ##########################################
    step "add ppa-repositories"

    sub_step "fish"
    sudo apt-add-repository -y --no-update ppa:fish-shell/release-3

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
    step "Install Docker via convenience script"
    # https://docs.docker.com/engine/install/ubuntu/#install-using-the-convenience-script
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh


##########################################
# Installation Steps - MacOS
##########################################
elif [ $os = "macOS" ]; then
    step "install with brew"

    sub_step "fish"
    sudo -u $USER brew install fish

    sub_step "iterm2"
    sudo -u $USER brew install --cask iterm2

    sub_step "tmux"
    sudo -u $USER brew install tmux

fi

##########################################
# Config Files
##########################################
step "config files"

sub_step "fish"
mkdir -p ~/.config/fish
cp .config/fish/config.fish ~/.config/fish

# fish needs to be run as sudo - different location in parallels
if [ $os = "parallels" ]; then
  mkdir -p /root/.config/fish
  cp .config/fish/config.fish /root/.config/fish
fi

if [ $os = "ubuntu" ] || [ $os = "parallels" ]; then
  sub_step "bashrc"
  cat ubuntu/.bashrc >> "$HOME/.bashrc"
  echo "Appended content of ubuntu/.bashrc to $HOME/.bashrc"

elif [ $os = "macOS" ]; then
  sub_step "zshrc"
  cat macOS/.zshrc >> "$HOME/.zshrc"
  echo "Appended content of macOS/.zshrc to $HOME/.zshrc"
fi

sub_step "bash_aliases"
cp .bash_aliases "$HOME"


##########################################
# Bash Utilities
##########################################
sub_step "fzf"
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

sub_step "loki"
git clone --depth 1 https://github.com/slim-bean/loki-shell.git ~/.loki-shell
~/.loki-shell/install

sub_step "tmux"
git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
mkdir -p $HOME/.tmux/plugins/tpm
cp .tmux.conf "$HOME"
git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm

##########################################
# Permissions
##########################################
if [ $os = "parallels" ]; then
  step "Permissions"
  sudo chown -R $user_name:$user_name $HOME/.config/fish
  chmod -R 700 $HOME/.config/fish
fi

exit 0