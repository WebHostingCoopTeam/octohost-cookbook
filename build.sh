#!/bin/bash
#/usr/bin/time -v rake build_vagrant_without_tests
/usr/bin/time -v rake build_qemu
# beeper
#aplay /usr/share/sounds/alsa/Front_Center.wav
ogg123 /usr/share/sounds/KDE-Im-Irc-Event.ogg
