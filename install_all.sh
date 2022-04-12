#!/bin/bash

function install_yay {
    WORK_DIR=$(mktemp -d)
    if [[ ! "$WORK_DIR" || -d "$WORK_DIR" ]]; then
        echo "Could not create temporary working directory"
        exit 1
    fi
    cd $WORK_DIR
    curl -O https://aur.archlinux.org/cgit/aur.git/snapshot/yay.tar.gz
    tar xvf yay.tar.gz
    cd yay
    makepkg -s -i -c
    rm -rf "$WORK_DIR"
}

function install_pkgs {
    yay -S \
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
        picom \
        polybar \
        dunst \
        gvim \
        zsh \
        mpv \
        zathura-pdf-mupdf \
        lxappearance \
        yaru \
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
        libva-vdpau-driver \
        detox
}

function install_oh_my_zsh {
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
}

install_pacaur
install_pkgs
for d in $(ls -d */); do
    (stow $d)
done
