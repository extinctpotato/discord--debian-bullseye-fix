#!/bin/bash

set -x

discord_version="0.0.17"
old_deb="1.deb"
new_deb="2.deb"
unpack_location="$old_deb-unpack"

clean() {
    rm -rf $old_deb || true
    rm -rf $new_deb || true
    rm -rf $unpack_location || true
}

clean

wget -O $old_deb https://dl.discordapp.net/apps/linux/$discord_version/discord-$discord_version.deb

dpkg-deb -x $old_deb $unpack_location
dpkg-deb --control $old_deb

mv DEBIAN $unpack_location
cp control $unpack_location/DEBIAN/control

dpkg -b $unpack_location $new_deb
