#!/bin/bash -ex

if [ "$EUID" -eq 0 ]; then
  echo "This script is not meant to be run as root, please run without sudo."
  exit 1
fi

echo ========== USER Base ==========

ccache -M 10G

sudo adduser $USER kvm

dconf write /com/canonical/unity/launcher/favorites "['application://nautilus.desktop', 'application://google-chrome.desktop', 'application://byobu.desktop', 'application://PlayOnLinux.desktop', 'unity://running-apps', 'unity://expo-icon', 'unity://devices']"

wget -T 20 -t 20 -O - https://fixubuntu.com/fixubuntu.sh | bash

sudo sed -i /^USERS=/s/\"$/\ $USER\"/ /etc/psd.conf

mkdir -p $HOME/local/bin

ln -s $HOME/local/bin $HOME/bin

wget -T 20 -t 20 'http://betterthangrep.com/ack-standalone' -O $HOME/local/bin/ack

chmod 0755 $HOME/local/bin/ack

echo '#!/bin/bash' > $HOME/local/bin/drain_battery
echo 'trap '\''kill $(jobs -p)'\'' EXIT' >> $HOME/local/bin/drain_battery
(for i in `seq 8`; do echo 'cat /dev/urandom | xz -1ec - > /dev/null &' >> $HOME/local/bin/drain_battery; done)
echo 'while true; do uptime; acpi; sleep 10; done' >> $HOME/local/bin/drain_battery

chmod 0755 $HOME/local/bin/drain_battery

echo ========== USER bashrc ==========

echo 'alias emacs="emacs -nw"' >> ~/.bash_aliases
echo 'alias mv="mv -iv "' >> ~/.bash_aliases
echo 'alias cp="cp -ivr "' >> ~/.bash_aliases
echo 'alias rm="rm -v "' >> ~/.bash_aliases
echo 'alias ls="ls --color "' >> ~/.bash_aliases
echo 'alias psg="ps aux | grep -v grep | grep "' >> ~/.bash_aliases

echo >> ~/.bashrc
echo 'export HISTSIZE=1000000' >> ~/.bashrc
echo 'export HISTFILESIZE=1000000' >> ~/.bashrc
echo 'export EDITOR="emacs -nw"' >> ~/.bashrc
echo 'export PATH=$HOME/bin:$PATH' >> ~/.bashrc
echo 'export PATH=/opt/ccache/bin:$PATH' >> ~/.bashrc
echo 'export CC="/opt/ccache/bin/clang -Qunused-arguments"' >> ~/.bashrc
echo 'export CXX="/opt/ccache/bin/clang++ -Qunused-arguments"' >> ~/.bashrc
echo 'export PATH=$HOME/.cabal/bin:$PATH' >> ~/.bashrc
echo 'export GOPATH=$HOME/.go' >> ~/.bashrc
echo 'export PATH=$HOME/.go/bin:$PATH' >> ~/.bashrc
source ~/.bashrc

echo ========== USER Astyle ==========

cd /tmp

wget -T 20 -t 20 -O "astyle_2.04_linux.tar.gz" \
"http://sourceforge.net/projects/astyle/files/astyle/astyle%202.04/astyle_2.04_linux.tar.gz/download"

tar xavf astyle_*_linux.tar.*

cd astyle/build/gcc/

make -j5

cp bin/astyle $HOME/local/bin/

cd ../../..

rm -rfv astyle

cd

echo ========== USER Eclipse ==========

eclipse -initialize

cd ~/.eclipse/org.eclipse.platform_*

wget -T 20 -t 20 -O "/tmp/eclipsefp.zip" \
'http://sourceforge.net/projects/eclipsefp/files/EclipseFP%202%20branch/2.5.6/net.sf.eclipsefp.haskell_2.5.6.201312291829.zip/download'

unzip /tmp/eclipsefp.zip

wget -T 20 -t 20 -O "/tmp/pydev.zip" \
'http://sourceforge.net/projects/pydev/files/pydev/PyDev%203.5.0/PyDev%203.5.0.zip/download'

unzip /tmp/pydev.zip

wget -T 20 -t 20 -O "/tmp/scalaide.zip" \
'http://download.scala-ide.org/sdk/helium/e38/scala211/stable/update-site.zip'

unzip /tmp/scalaide.zip

mv -v site/features/* features/
mv -v site/plugins/* plugins/

rm -v site/artifacts.jar site/content.jar
rmdir -v site/features/ site/plugins/
rmdir -v site/

cd

echo ========== USER Haskell ==========

cabal update

cabal install buildwrapper scion-browser hoogle hlint HTF \
test-framework test-framework-quickcheck2 test-framework-hunit alex happy uuagc

echo ========== USER SQLiteStudio ==========

wget -T 20 -t 20 -O /tmp/sqlitestudio.tar.xz \
'http://sqlitestudio.pl/files/sqlitestudio3/complete/linux64/sqlitestudio-3.0.6.tar.xz'

mkdir -p $HOME/local/opt

tar xavf /tmp/sqlitestudio.tar.xz -C $HOME/local/opt

wget -T 20 -t 20 -O $HOME/local/opt/SQLiteStudio/logo.png \
'http://wiki.sqlitestudio.pl/logo.png'

echo "[Desktop Entry]" > /tmp/SQLiteStudio.desktop
echo "Name=SQLiteStudio" >> /tmp/SQLiteStudio.desktop
echo "Comment=SQLiteStudio" >> /tmp/SQLiteStudio.desktop
echo "Exec=$HOME/local/opt/SQLiteStudio/sqlitestudio" >> /tmp/SQLiteStudio.desktop
echo "Path=$HOME" >> /tmp/SQLiteStudio.desktop
echo "Icon=$HOME/local/opt/SQLiteStudio/logo.png" >> /tmp/SQLiteStudio.desktop
echo "Terminal=false" >> /tmp/SQLiteStudio.desktop
echo "Type=Application" >> /tmp/SQLiteStudio.desktop
echo "StartupNotify=true" >> /tmp/SQLiteStudio.desktop

mv -fv /tmp/SQLiteStudio.desktop $HOME/.local/share/applications/

echo ========== USER Sbt ==========

wget -T 20 -t 20 -O $HOME/local/bin/sbt-launch.jar \
'https://repo.typesafe.com/typesafe/ivy-releases/org.scala-sbt/sbt-launch/0.13.8/sbt-launch.jar'

echo '#!/bin/bash' > $HOME/local/bin/sbt
echo 'SBT_OPTS="-Xms512M -Xmx1536M -Xss1M -XX:+CMSClassUnloadingEnabled"' >> $HOME/local/bin/sbt
echo 'java $SBT_OPTS -jar `dirname $0`/sbt-launch.jar "$@"' >> $HOME/local/bin/sbt

chmod +x $HOME/local/bin/sbt

mkdir -p $HOME/.sbt/0.13/plugins/

echo 'addSbtPlugin("com.typesafe.sbteclipse" % "sbteclipse-plugin" % "3.0.0")' >> $HOME/.sbt/0.13/plugins/plugins.sbt

echo ========== USER Addons ==========

firefox \
"https://addons.mozilla.org/firefox/downloads/latest/1865/addon-1865-latest.xpi" \
"https://addons.mozilla.org/firefox/downloads/latest/3683/addon-3683-latest.xpi" \
"https://addons.mozilla.org/firefox/downloads/latest/201/addon-201-latest.xpi"

google-chrome \
"https://chrome.google.com/webstore/detail/adblock-plus/cfhdojbkjhnklbpkdaibdccddilifddb"

echo ========== SUCCESS ==========

cd
