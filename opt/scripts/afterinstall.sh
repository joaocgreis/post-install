sudo sed -i '/partner$/s/^# *//' /etc/apt/sources.list &&
sudo add-apt-repository -y ppa:webupd8team/java &&
sudo apt-add-repository -s 'http://linux.dropbox.com/ubuntu main' &&
sudo apt-key adv --keyserver pgp.mit.edu --recv-keys 5044912E &&
sudo add-apt-repository -y ppa:graysky/utils &&
sudo add-apt-repository -y ppa:peterlevi/ppa &&
sudo apt-add-repository -y ppa:git-core/ppa &&
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add - &&
sudo sh -c 'echo "deb http://download.virtualbox.org/virtualbox/debian trusty contrib" >> /etc/apt/sources.list.d/virtualbox.list' &&
sudo apt-get update &&
sudo apt-get dist-upgrade &&
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
profile-sync-daemon variety &&
echo ========== Base ========== &&
sudo sh -c 'echo allow-guest=false >> /usr/share/lightdm/lightdm.conf.d/50-ubuntu.conf' &&
sudo mkdir -p /etc/mplayer/ &&
sudo sh -c 'echo heartbeat-cmd=\"xdotool key shift\" >> /etc/mplayer/mplayer.conf' &&
sudo /usr/share/doc/libdvdread4/install-css.sh &&
echo ========== Google Chrome ========== &&
wget -T 20 -t 20 https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -P /tmp/ &&
sudo dpkg -i /tmp/google-chrome-stable_current_amd64.deb &&
echo ========== CCache ========== &&
sudo rm -rfv /opt/ccache/bin/ &&
sudo mkdir -p /opt/ccache/bin/ &&
cd /opt/ccache/bin/ &&
sudo ln -s /usr/bin/ccache cc &&
sudo ln -s /usr/bin/ccache c++ &&
sudo ln -s /usr/bin/ccache gcc &&
sudo ln -s /usr/bin/ccache g++ &&
sudo ln -s /usr/bin/ccache clang &&
sudo ln -s /usr/bin/ccache clang++ &&
echo ========== Timidity ========== &&
wget -T 20 -t 20 'http://distfiles.gentoo.org/distfiles/eawpats12_full.tar.gz' -P /tmp/ &&
sudo tar xavf /tmp/eawpats12_full.tar.gz -C /opt/ &&
sudo sh -c "echo >> /etc/timidity/timidity.cfg" &&
sudo sh -c "echo source /etc/timidity/freepats.cfg >> /etc/timidity/timidity.cfg" &&
sudo sh -c "echo source /etc/timidity/fluidr3_gm.cfg >> /etc/timidity/timidity.cfg" &&
sudo sh -c "echo source /etc/timidity/fluidr3_gs.cfg >> /etc/timidity/timidity.cfg" &&
sudo sh -c "echo dir /opt/eawpats/ >> /etc/timidity/timidity.cfg" &&
sudo sh -c "grep ^source /opt/eawpats/linuxconfig/timidity.cfg >> /etc/timidity/timidity.cfg" &&
echo ========== USER Base ========== &&
ccache -M 10G &&
sudo adduser $USER kvm &&
dconf write /com/canonical/unity/launcher/favorites "['application://nautilus.desktop', 'application://google-chrome.desktop', 'application://byobu.desktop', 'application://PlayOnLinux.desktop', 'unity://running-apps', 'unity://expo-icon', 'unity://devices']" &&
wget -T 20 -t 20 -O - https://fixubuntu.com/fixubuntu.sh | bash &&
sudo sed -i /^USERS=/s/\"$/\ $USER\"/ /etc/psd.conf &&
mkdir -p $HOME/local/bin &&
ln -s $HOME/local/bin $HOME/bin &&
wget -T 20 -t 20 'http://betterthangrep.com/ack-standalone' -O $HOME/local/bin/ack &&
chmod 0755 $HOME/local/bin/ack &&
echo '#!/bin/bash' > $HOME/local/bin/drain_battery &&
echo 'trap '\''kill $(jobs -p)'\'' EXIT' >> $HOME/local/bin/drain_battery &&
(for i in `seq 8`; do echo 'cat /dev/urandom | xz -1ec - > /dev/null &' >> $HOME/local/bin/drain_battery; done) &&
echo 'while true; do uptime; acpi; sleep 10; done' >> $HOME/local/bin/drain_battery &&
chmod 0755 $HOME/local/bin/drain_battery &&
echo ========== USER bashrc ========== &&
echo 'alias emacs="emacs -nw"' >> ~/.bash_aliases &&
echo 'alias mv="mv -iv "' >> ~/.bash_aliases &&
echo 'alias cp="cp -ivr "' >> ~/.bash_aliases &&
echo 'alias rm="rm -v "' >> ~/.bash_aliases &&
echo 'alias ls="ls --color "' >> ~/.bash_aliases &&
echo 'alias psg="ps aux | grep -v grep | grep "' >> ~/.bash_aliases &&
echo >> ~/.bashrc &&
echo 'export HISTSIZE=1000000' >> ~/.bashrc &&
echo 'export HISTFILESIZE=1000000' >> ~/.bashrc &&
echo 'export EDITOR="emacs -nw"' >> ~/.bashrc &&
echo 'export PATH=$HOME/bin:$PATH' >> ~/.bashrc &&
echo 'export PATH=/opt/ccache/bin:$PATH' >> ~/.bashrc &&
echo 'export CC="/opt/ccache/bin/clang -Qunused-arguments"' >> ~/.bashrc &&
echo 'export CXX="/opt/ccache/bin/clang++ -Qunused-arguments"' >> ~/.bashrc &&
echo 'export PATH=$HOME/.cabal/bin:$PATH' >> ~/.bashrc &&
echo 'export GOPATH=$HOME/.go' >> ~/.bashrc &&
echo 'export PATH=$HOME/.go/bin:$PATH' >> ~/.bashrc &&
source ~/.bashrc &&
echo ========== USER Astyle ========== &&
cd /tmp &&
wget -T 20 -t 20 -O "astyle_2.04_linux.tar.gz" \
"http://sourceforge.net/projects/astyle/files/astyle/astyle%202.04/astyle_2.04_linux.tar.gz/download" &&
tar xavf astyle_*_linux.tar.* &&
cd astyle/build/gcc/ &&
make -j5 &&
cp bin/astyle $HOME/local/bin/ &&
cd ../../.. &&
rm -rfv astyle &&
cd &&
echo ========== USER Eclipse ========== &&
eclipse -initialize &&
cd ~/.eclipse/org.eclipse.platform_* &&
wget -T 20 -t 20 -O "/tmp/eclipsefp.zip" \
'http://sourceforge.net/projects/eclipsefp/files/EclipseFP%202%20branch/2.5.6/net.sf.eclipsefp.haskell_2.5.6.201312291829.zip/download' &&
unzip /tmp/eclipsefp.zip &&
wget -T 20 -t 20 -O "/tmp/pydev.zip" \
'http://sourceforge.net/projects/pydev/files/pydev/PyDev%203.5.0/PyDev%203.5.0.zip/download' &&
unzip /tmp/pydev.zip &&
wget -T 20 -t 20 -O "/tmp/scalaide.zip" \
'http://download.scala-ide.org/sdk/helium/e38/scala211/stable/update-site.zip' &&
unzip /tmp/scalaide.zip &&
mv -v site/features/* features/ &&
mv -v site/plugins/* plugins/ &&
rm -v site/artifacts.jar site/content.jar &&
rmdir -v site/features/ site/plugins/ &&
rmdir -v site/ &&
cd &&
echo ========== USER Haskell ========== &&
cabal update &&
cabal install buildwrapper scion-browser hoogle hlint HTF \
test-framework test-framework-quickcheck2 test-framework-hunit alex happy uuagc &&
echo ========== USER SQLiteStudio ========== &&
wget -T 20 -t 20 -O /tmp/sqlitestudio.tar.xz \
'http://sqlitestudio.pl/files/sqlitestudio3/complete/linux64/sqlitestudio-3.0.6.tar.xz' &&
mkdir -p $HOME/local/opt &&
tar xavf /tmp/sqlitestudio.tar.xz -C $HOME/local/opt &&
wget -T 20 -t 20 -O $HOME/local/opt/SQLiteStudio/logo.png \
'http://wiki.sqlitestudio.pl/logo.png' &&
echo "[Desktop Entry]" > /tmp/SQLiteStudio.desktop &&
echo "Name=SQLiteStudio" >> /tmp/SQLiteStudio.desktop &&
echo "Comment=SQLiteStudio" >> /tmp/SQLiteStudio.desktop &&
echo "Exec=$HOME/local/opt/SQLiteStudio/sqlitestudio" >> /tmp/SQLiteStudio.desktop &&
echo "Path=$HOME" >> /tmp/SQLiteStudio.desktop &&
echo "Icon=$HOME/local/opt/SQLiteStudio/logo.png" >> /tmp/SQLiteStudio.desktop &&
echo "Terminal=false" >> /tmp/SQLiteStudio.desktop &&
echo "Type=Application" >> /tmp/SQLiteStudio.desktop &&
echo "StartupNotify=true" >> /tmp/SQLiteStudio.desktop &&
mv -fv /tmp/SQLiteStudio.desktop $HOME/.local/share/applications/ &&
echo ========== USER Sbt ========== &&
wget -T 20 -t 20 -O $HOME/local/bin/sbt-launch.jar \
'https://repo.typesafe.com/typesafe/ivy-releases/org.scala-sbt/sbt-launch/0.13.8/sbt-launch.jar' &&
echo '#!/bin/bash' > $HOME/local/bin/sbt &&
echo 'SBT_OPTS="-Xms512M -Xmx1536M -Xss1M -XX:+CMSClassUnloadingEnabled"' >> $HOME/local/bin/sbt &&
echo 'java $SBT_OPTS -jar `dirname $0`/sbt-launch.jar "$@"' >> $HOME/local/bin/sbt &&
chmod +x $HOME/local/bin/sbt &&
mkdir -p $HOME/.sbt/0.13/plugins/ &&
echo 'addSbtPlugin("com.typesafe.sbteclipse" % "sbteclipse-plugin" % "3.0.0")' >> $HOME/.sbt/0.13/plugins/plugins.sbt &&
echo ========== USER Addons ========== &&
firefox \
"https://addons.mozilla.org/firefox/downloads/latest/1865/addon-1865-latest.xpi" \
"https://addons.mozilla.org/firefox/downloads/latest/3683/addon-3683-latest.xpi" \
"https://addons.mozilla.org/firefox/downloads/latest/201/addon-201-latest.xpi" &&
google-chrome \
"https://chrome.google.com/webstore/detail/adblock-plus/cfhdojbkjhnklbpkdaibdccddilifddb" &&
echo ========== Cleaning up ========== &&
sudo apt-get autoremove &&
sudo apt-get clean &&
echo ========== SUCCESS ========== &&
cd
