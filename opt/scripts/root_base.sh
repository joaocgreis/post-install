#!/bin/bash -ex

if [ "$EUID" -ne 0 ]; then
  echo "Please run as root: sudo $0"
  exit 1
fi

echo ========== Install Ansible ==========

# http://docs.ansible.com/ansible/2.5/installation_guide/intro_installation.html#latest-releases-via-apt-ubuntu
apt-get -y update
apt-get -y install software-properties-common
apt-add-repository -y ppa:ansible/ansible
apt-get -y update
apt-get -y install ansible

echo ========== Run Ansible ==========

ansible-playbook -v root_base.yml
