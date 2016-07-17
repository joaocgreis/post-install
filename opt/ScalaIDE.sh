#!/bin/bash -ex

FILE="scala-SDK-4.4.1-vfinal-2.11-linux.gtk.x86_64.tar.gz"

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

rm -rfv "${DIR}/eclipse" || true
rm -rfv "${DIR}/ScalaIDE" || true
rm -rfv "$HOME/.local/share/applications/ScalaIDE.desktop" || true

wget -c -T 20 -t 20 -O "${DIR}/${FILE}" "http://downloads.typesafe.com/scalaide-pack/4.4.1-vfinal-luna-211-20160504/${FILE}"

tar xavf "${DIR}/${FILE}" -C "${DIR}"
mv -v "${DIR}/eclipse" "${DIR}/ScalaIDE"

echo "[Desktop Entry]" > /tmp/ScalaIDE.desktop
echo "Name=ScalaIDE" >> /tmp/ScalaIDE.desktop
echo "Comment=ScalaIDE" >> /tmp/ScalaIDE.desktop
echo "Exec=${DIR}/ScalaIDE/eclipse" >> /tmp/ScalaIDE.desktop
echo "Path=$HOME" >> /tmp/ScalaIDE.desktop
echo "Icon=${DIR}/ScalaIDE/icon.xpm" >> /tmp/ScalaIDE.desktop
echo "Terminal=false" >> /tmp/ScalaIDE.desktop
echo "Type=Application" >> /tmp/ScalaIDE.desktop
echo "StartupNotify=true" >> /tmp/ScalaIDE.desktop
mv -fv "/tmp/ScalaIDE.desktop" "$HOME/.local/share/applications/"
