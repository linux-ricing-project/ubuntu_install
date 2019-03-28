#!/bin/bash

################################################################################
# Configurações
# set:
# -e: se encontrar algum erro, termina a execução imediatamente
set -e

# ============================================
# mostrar o banner inicial
# ============================================
show_header(){
cat << "HEADER"
   __  ____                __           ____           __        ____
  / / / / /_  __  ______  / /___  __   /  _/___  _____/ /_____ _/ / /
 / / / / __ \/ / / / __ \/ __/ / / /   / // __ \/ ___/ __/ __ `/ / /
/ /_/ / /_/ / /_/ / / / / /_/ /_/ /  _/ // / / (__  ) /_/ /_/ / / /
\____/_.___/\__,_/_/ /_/\__/\__,_/  /___/_/ /_/____/\__/\__,_/_/_/

HEADER
}

# ============================================
# Fazendo as atualizações iniciais
# ============================================
init_updates(){
  # updagrade inicial, por volta de uns 300 MB
  echo "==========================================="
  echo "Do the initial upgrades..."
  echo "==========================================="
  sudo apt -y upgrade
  sudo apt -y dist-upgrade
  sudo apt -y full-upgrade

  # ============================================
  # Instalando o Ansible
  # ============================================
  if ! type ansible > /dev/null 2>&1; then
    echo "==========================================="
    echo "Installing Ansible..."
    echo "==========================================="
    sudo apt -y install software-properties-common
    sudo apt-add-repository --yes --update ppa:ansible/ansible
    sudo apt -y install ansible curl wget
  fi
}

show_header
init_updates

echo "======== GIT CONFIG ========"
echo "Whats your name?"
read git_user
echo "Whats your email?"
read git_email

echo "==========================================="
echo "Running Ansible Job"
echo "==========================================="
echo -n | ansible-playbook --ask-become-pass \
  --extra-vars "git_user=$git_user git_email=$git_email" main.yaml

echo "==========================================="
echo "Getting the dotfiles repo..."
echo "==========================================="

clear
echo "==========================================="
echo "OK"
echo "Everything is installed."
echo "Is recommended restart the machine now"
echo "==========================================="