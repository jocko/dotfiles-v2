#!/bin/sh

# Now set in ~/.xserverrc instead
#xset r rate 200 30

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

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

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

export TERMINAL=xterm

eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK
# /etc/pam.d/login
# ----------------
# session    optional     pam_gnome_keyring.so
# export $(gnome-keyring-daemon --start --components=pkcs11,secrets,ssh,gpg)
# eval $(ssh-agent)
# export SSH_ASKPASS=/usr/libexec/openssh/ssh-askpass
# ssh-add

exec ssh-agent i3
#ssh-agent -k
