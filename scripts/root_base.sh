#!/bin/bash -ex

if [ "$EUID" -ne 0 ]; then
  echo "Please run as root: sudo $0"
  exit 1
fi

echo ========== Install Ansible ==========

# http://docs.ansible.com/ansible/2.5/installation_guide/intro_installation.html#latest-releases-via-apt-ubuntu
apt-get -y update
apt-get -y install python3-pip
pip3 install ansible

echo ========== Run Ansible ==========

ansible-playbook -v root_base.yml
