#!/bin/bash
#/usr/bin/time -v rake build_vagrant_without_tests

#cp http/ubuntu-14.04/preseed.cfg.oltorf http/ubuntu-14.04/preseed.cfg
cp http/ubuntu-14.04/preseed-noproxy.cfg http/ubuntu-14.04/preseed.cfg
/usr/bin/time -v nice ionice -c3 rake build_qemu
cp http/ubuntu-14.04/preseed-noproxy.cfg http/ubuntu-14.04/preseed.cfg
# beeper
#aplay /usr/share/sounds/alsa/Front_Center.wav
ogg123 /usr/share/sounds/KDE-Im-Irc-Event.ogg
