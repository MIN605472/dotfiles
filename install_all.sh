#!/bin/bash

function install_pacaur {
  mkdir pacaur_install
  cd pacaur_install
  curl -O https://aur.archlinux.org/cgit/aur.git/snapshot/cower.tar.gz
  tar xvf cower.tar.gz
  cd cower
  gpg --recv-keys --keyserver hkp://pgp.mit.edu 1EB2638FF56C0C53
  makepkg -s -i -c
  cd ..
  curl -O https://aur.archlinux.org/cgit/aur.git/snapshot/pacaur.tar.gz
  tar xvf pacaur.tar.gz
  cd pacaur
  makepkg -s -i -c
  cd ../../
  rm -rf pacaur_install
}

function install_pkgs {
  pacaur -S \
    stow \
    xorg-server \
    xorg-xinit \
    bspwm \
    sxhkd \
    polybar \
    termite \
    python-pywal \
    rofi \
    feh \
    sxiv \
    ntfs-3g \
    udisks2 \
    compton \
    polybar \
    dunst \
    gvim \
    zsh \
    mpv \
    zathura-pdf-mupdf \
    lxappearance \
    arc-gtk-theme \
    arc-icon-theme \
    gnome-themes-standard \
    gtk-engine-murrine \
    pulseaudio \
    pavucontrol \
    xdg-user-dirs \
    noto-fonts \
    noto-fonts-cjk \
    noto-fonts-emoji \
    bdf-tewi-git \
    siji-git \
    firefox \
    openssh \
    mesa-vdpau \
    libva-vdpau-driver
}

function install_oh_my_zsh {
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
}

install_pacaur
install_pkgs
for d in $(ls -d */); do
  (stow $d)
done
install_oh_my_zsh
