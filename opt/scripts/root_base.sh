#!/bin/bash -ex

if [ "$EUID" -ne 0 ]; then
  echo "Please run as root: sudo $0"
  exit 1
fi

sudo sed -i '/partner$/s/^# *//' /etc/apt/sources.list

sudo add-apt-repository -y ppa:webupd8team/java
sudo apt-add-repository -s 'http://linux.dropbox.com/ubuntu main'
sudo apt-key adv --keyserver pgp.mit.edu --recv-keys 5044912E
sudo add-apt-repository -y ppa:graysky/utils
sudo add-apt-repository -y ppa:peterlevi/ppa
sudo apt-add-repository -y ppa:git-core/ppa
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -

sudo sh -c 'echo "deb http://download.virtualbox.org/virtualbox/debian trusty contrib" >> /etc/apt/sources.list.d/virtualbox.list'

sudo apt-get update
sudo apt-get dist-upgrade

sudo apt-get install \
byobu screen nautilus-open-terminal lsb-core \
mesa-utils dconf-tools lm-sensors \
gparted smartmontools gsmartcontrol acpi gksu \
rar p7zip-full p7zip-rar lzop mmv tree htop dstat iotop \
wireshark nmap wavemon links lynx curl \
minicom picocom playonlinux k3b qemu-system-x86 qemu-utils \
build-essential manpages-posix-dev doxygen doxygen-gui \
subversion subversion-tools git-all gitk \
automake autoconf cmake cmake-curses-gui ant scons \
valgrind ddd kcachegrind indent ccache kdiff3 \
clang llvm-dev golang sqlite3 cpphs \
python-all-dev python3-all-dev python-pip \
libboost-all-dev freeglut3-dev libsqlite3-dev libncurses5-dev \
`apt-cache search libsdl | awk '/^libsdl.*-dev - /{print $1}'` \
kdevelop kate kwrite emacs23-nox \
eclipse eclipse-cdt eclipse-jdt \
scala scala-mode-el \
haskell-platform ghc-mod \
audacity flac lame vorbis-tools cdparanoia normalize-audio \
tuxguitar tuxguitar-jsa \
timidity freepats fluid-soundfont-gm fluid-soundfont-gs \
gnuplot-qt inkscape dia gimp imagemagick xsane \
ubuntu-restricted-extras libavcodec-extra flashplugin-installer \
vlc smplayer smtube mplayer2 audacious xdotool libav-tools \
openssh-server myspell-pt-pt texlive-full fig2ps kile \
compizconfig-settings-manager gnome-tweak-tool unity-tweak-tool \
hplip-gui ubuntustudio-font-meta \
fonts-croscore fonts-crosextra-caladea fonts-crosextra-carlito \
dosbox mupen64plus fceux zsnes \
desmume visualboyadvance dgen yabause \
dkms virtualbox-5.0 \
skype gtk2-engines-murrine:i386 gtk2-engines-pixbuf:i386 \
oracle-java8-installer oracle-java8-set-default \
dropbox libappindicator1 python-gpgme \
profile-sync-daemon variety

echo ========== Base ==========

sudo sh -c 'echo allow-guest=false >> /usr/share/lightdm/lightdm.conf.d/50-ubuntu.conf'

sudo mkdir -p /etc/mplayer/

sudo sh -c 'echo heartbeat-cmd=\"xdotool key shift\" >> /etc/mplayer/mplayer.conf'

sudo /usr/share/doc/libdvdread4/install-css.sh

echo ========== Google Chrome ==========

wget -T 20 -t 20 https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -P /tmp/

sudo dpkg -i /tmp/google-chrome-stable_current_amd64.deb

echo ========== CCache ==========

sudo rm -rfv /opt/ccache/bin/

sudo mkdir -p /opt/ccache/bin/

cd /opt/ccache/bin/

sudo ln -s /usr/bin/ccache cc
sudo ln -s /usr/bin/ccache c++
sudo ln -s /usr/bin/ccache gcc
sudo ln -s /usr/bin/ccache g++
sudo ln -s /usr/bin/ccache clang
sudo ln -s /usr/bin/ccache clang++

echo ========== Timidity ==========

wget -T 20 -t 20 'http://distfiles.gentoo.org/distfiles/eawpats12_full.tar.gz' -P /tmp/

sudo tar xavf /tmp/eawpats12_full.tar.gz -C /opt/

sudo sh -c "echo >> /etc/timidity/timidity.cfg"
sudo sh -c "echo source /etc/timidity/freepats.cfg >> /etc/timidity/timidity.cfg"
sudo sh -c "echo source /etc/timidity/fluidr3_gm.cfg >> /etc/timidity/timidity.cfg"
sudo sh -c "echo source /etc/timidity/fluidr3_gs.cfg >> /etc/timidity/timidity.cfg"
sudo sh -c "echo dir /opt/eawpats/ >> /etc/timidity/timidity.cfg"
sudo sh -c "grep ^source /opt/eawpats/linuxconfig/timidity.cfg >> /etc/timidity/timidity.cfg"

echo ========== Cleaning up ==========

sudo apt-get autoremove

sudo apt-get clean

echo ========== SUCCESS ==========

cd
