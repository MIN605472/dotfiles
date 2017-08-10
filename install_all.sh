# !/bin/bash

function install_pacaur {
  mkdir pacaur_install
  cd pacaur_install
  curl -O https://aur.archlinux.org/cgit/aur.git/snapshot/cower.tar.gz
  tar xvf cower.tar.gz
  cd cower
  gpg --recv-keys --keyserver hkp://pgp.mit.edu 1EB2638FF56C0C53
  makepkg -s -i -c
  mkap
  cd ..
  curl -O https://aur.archlinux.org/cgit/aur.git/snapshot/pacaur.tar.gz
  tar xvf pacaur.tar.gz
  cd pacaur
  makepkg -s -i -c
  cd ../../
  rm -rf pacaur_install
}

function install_pkgs {
  pacaur -S feh compton polybar wal vim zsh mpv lxappearance pulseaudio pavucontrol xdg-user-dirs
}

install_pacaur
install_pkgs
for d in $(ls -d */); do
  (stow $d)
done
