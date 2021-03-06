#!/usr/bin/env bash

cmake -DCMAKE_TOOLCHAIN_FILE=/usr/share/ECM/toolchain/Android.cmake -DQt5_DIR=${QT5_ANDROID}/Qt5/ -DQt5Qml_DIR=${QT5_ANDROID}/Qt5Qml/ -DQt5Network_DIR=${QT5_ANDROID}/Qt5Network -DQt5Core_DIR=${QT5_ANDROID}/Qt5Core -DQt5Quick_DIR=${QT5_ANDROID}/Qt5Quick -DQt5Gui_DIR=${QT5_ANDROID}/Qt5Gui -DQt5Multimedia_DIR=${QT5_ANDROID}/Qt5Multimedia -DQt5Svg_DIR=${QT5_ANDROID}/Qt5Svg -DQt5Widgets_DIR=${QT5_ANDROID}/Qt5Widgets -DQt5LinguistTools_DIR=${QT5_ANDROID}/Qt5LinguistTools -DQt5Sensors_DIR=${QT5_ANDROID}/Qt5Sensors -DQt5AndroidExtras_DIR=${QT5_ANDROID}/Qt5AndroidExtras "$1"
