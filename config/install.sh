#!/usr/bin/env bash

# The script needs to be run with sudo

##########################################
# Global Variables
##########################################
(( step_num=0 ))
step_msg=""
(( sub_step_num=1 ))
os=""
user_name=""
user_name_macbook="pascalsutter"
user_home_dir=""


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
  echo "Usage: sudo bash install.sh \$USER macOS|ubuntu|parallels"
  echo "  - USER: username"
  echo "  - macOS: uses zshrc and iterm2"
  echo "  - ubuntu: uses bashrc and guake"
  echo "  - parallels: ubuntu running on parallels"
}

##########################################
# Script Execution Call
##########################################

# check for valid usage
if [ "$#" -ne 2 ] || [ "$2" != "macOS" ] && [ "$2" != "ubuntu" ] && [ "$2" != "parallels" ]; then
  # invalid usage
  disp_usage
  # Ref exit codes: https://www.cyberciti.biz/faq/linux-bash-exit-status-set-exit-statusin-bash/
  exit 22  # invalid argument
elif [ "$EUID" -ne 0 ]; then
  disp_usage
  exit 1  # operation not permitted

else
  # Check if user exists and configure right home directory
  if [ "$2" = "macOS" ]; then
    os="macOS"
    user_name=$1
    if [ ! -d "/Users/$1" ]; then
    disp_usage
    exit 22
    fi
    user_home_dir="/Users/$user_name"
    echo ">>> Starting setup for a macOS device with home directory: $user_home_dir"

  elif [ "$2" = "ubuntu" ]; then
    os="ubuntu"
    user_name=$1
    if [ ! -d "/home/$1" ]; then
    disp_usage
    exit 22
    fi
    user_home_dir="/Users/$user_name"
    echo ">>> Starting setup for a ubuntu device with home directory: $user_home_dir"

  elif [ "$2" = "parallels" ]; then
    os="parallels"
    user_name=$2
    if [ ! -d "/home/$2" ]; then
    disp_usage
    exit 22
    fi
    user_home_dir="/home/$user_name"
    echo ">>> Starting setup for a parallels device with home directory: $user_home_dir"
  
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

    sub_step "copyq"
    sudo add-apt-repository -y --no-update ppa:hluk/copyq
    
    ##########################################
    step "apt update"
    sudo apt update -y
    
    ##########################################
    step "install with added ppa"

    sub_step "fish"
    sudo apt install -y fish

    sub_step "copyq"
    sudo apt install -y copyq

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
    sudo -u $user_name_macbook brew install fish

    #sub_step "copyq"
    #sudo -u $user_name_macbook brew install --cask copyq

    sub_step "iterm2"
    sudo -u $user_name_macbook brew install --cask iterm2

fi

##########################################
# Config Files
##########################################
step "config files"

sub_step "fish"
mkdir -p ~/.config/fish && \
cp .config/fish/config.fish ~/.config/fish

sub_step "ssh"
mkdir -p ~/.ssh && \
cp .ssh/config ~/.ssh

if [ $os = "ubuntu" ] || [ $os = "parallels" ]; then
  sub_step "bashrc"
  cp ubuntu/.bashrc "$user_home_dir"

elif [ $os = "macOS" ]; then
  sub_step "zshrc"
  cp macOS/.zshrc "$user_home_dir"

fi

exit 0