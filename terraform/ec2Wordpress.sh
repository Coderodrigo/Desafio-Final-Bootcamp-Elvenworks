#!/bin/bash

# Atualiza os repositórios e instala os pacotes necessários
sudo apt update
sudo apt install -y software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install -y ansible

sudo apt install -y unzip

# Download e extração dos arquivos
cd /tmp
sudo wget #colocar o link do github
sudo unzip main.zip -d /tmp
cd /tmp/ansible-main/

# Executa o playbook do Ansible com as variáveis especificadas
sudo ansible-playbook playbook.yml \
--extra-vars "wp_db_name=${wp_db_name} wp_username=${wp_username} wp_user_password=${wp_user_password} wp_db_host=${wp_db_host}"
