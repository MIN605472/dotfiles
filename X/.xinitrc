#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
  xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
  xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
  xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
 xmodmap "$usermodmap"
fi

. ~/.profile
# if [ -x /usr/bin/gpg-agent ]; then
#   eval "$(/usr/bin/gpg-agent --daemon)"
# fi
# dbus-update-activation-environment --systemd DISPLAY
# eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
# export SSH_AUTH_SOCK
xmodmap ~/.xmodmap
exec i3
# exec bspwm
# export GDK_BACKEND=x11
# exec gnome-session
