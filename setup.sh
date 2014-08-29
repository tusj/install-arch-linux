#!/bin/sh
### General install script for arch linux for new installations
INSTALL_OPTS="--noconfirm --needed"


## Installation
BASE="vim fish git btrfs-progs openssh sshfs wget ack"
BASE_YAOURT="trash-cli"

GRAPHIC="inkscape unclutter nautilus chromium gdm awesome skype vlc terminology"
GRAPHIC_YAOURT="chromium-pepper-flash awesome-gnome dropbox trayclock hawaii-wallpapers-git"

DEV="eclipse dart golang"
DEV_YAOURT="dartium-bin"

BBLD_YAOURT="broadcom-wl"

pacman $INSTALL_OPTS -S $BASE

mkdir package-query
cd package-query
wget http://aur.archlinux.org/packages/pa/package-query/PKGBUILD
makepkg -s --asroot
pacman $INSTALL_OPTS -U package-query*.pkg.tar.xz
cd
rm -r package-query

mkdir yaourt
cd yaourt
wget http://aur.archlinux.org/packages/ya/yaourt/PKGBUILD
makepkg -s --asroot
pacman $INSTALL_OPTS -U yaourt-*.pkg.tar.xz
cd
rm -r yaourt

## setup ssh
## has to be graphic

# Installation of own configurations
git clone git@github.com:tusj/vim-config.git .vim
cd .vim
git submodule init
git submodule update
cd
git clone git@github.com:tusj/awesome-config.git .config/awesome
cd .config/awesome
git submodule init
git submodule update
cd

## Dev
pacman $INSTALL_OPTS -S $DEV --noconfirm
yaourt $INSTALL_OPTS -S $DEV_YAOURT --noconfirm
ln -s /opt/dartium /usr/share/eclipse/chrome
ln -s /opt/dart-sdk /usr/share/eclipse/dart

## Configuration

# .Config
cd .config
ln -s ~/Dropbox/dotfiles/home/s/.config sync
cd fish
rm config.fish functions
ln -s ../sync/fish/config.fish
ln -s ../sync/fish/functions
cd ..
rm autostart
ln -s sync/autostart

# exit from user
exit

# root
chsh -s /usr/bin/fish root
