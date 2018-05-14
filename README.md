# Post-Install Scripts for Ubuntu

## Ubuntu 18.04 LTS

```
sudo apt-get -y install git &&
(cd ~/.local &&
git init &&
(git remote add joaocgreis/post-install https://github.com/joaocgreis/post-install.git || true) &&
git fetch joaocgreis/post-install &&
git checkout -B ubuntu_18.04 joaocgreis/post-install/ubuntu_18.04 &&
git reset --hard &&
cd scripts &&
sudo -H ./root_base.sh &&
ansible-playbook -v base.yml) &&
echo '========== SUCCESS =========='
```
