#!/bin/bash -ex

FILE="sqlitestudio-3.1.0.tar.xz"

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

rm -rfv "${DIR}/SQLiteStudio" || true
rm -rfv "$HOME/.local/share/applications/SQLiteStudio.desktop" || true

wget -c -T 20 -t 20 -O "${DIR}/${FILE}" "http://sqlitestudio.pl/files/sqlitestudio3/complete/linux64/${FILE}"

tar xavf "${DIR}/${FILE}" -C "${DIR}"

wget -c -T 20 -t 20 -O "${DIR}/SQLiteStudio/logo.png" 'http://wiki.sqlitestudio.pl/logo.png'

echo "[Desktop Entry]" > /tmp/SQLiteStudio.desktop
echo "Name=SQLiteStudio" >> /tmp/SQLiteStudio.desktop
echo "Comment=SQLiteStudio" >> /tmp/SQLiteStudio.desktop
echo "Exec=${DIR}/SQLiteStudio/sqlitestudio" >> /tmp/SQLiteStudio.desktop
echo "Path=$HOME" >> /tmp/SQLiteStudio.desktop
echo "Icon=${DIR}/SQLiteStudio/logo.png" >> /tmp/SQLiteStudio.desktop
echo "Terminal=false" >> /tmp/SQLiteStudio.desktop
echo "Type=Application" >> /tmp/SQLiteStudio.desktop
echo "StartupNotify=true" >> /tmp/SQLiteStudio.desktop
mv -fv "/tmp/SQLiteStudio.desktop" "$HOME/.local/share/applications/"
