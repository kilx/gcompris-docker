FROM ubuntu:21.10

WORKDIR /

SHELL ["/bin/bash", "-c"]

# define versions
ARG ANDROID_API_LEVEL=25
ARG ANDROID_BUILD_TOOLS_LEVEL=28.0.3
ARG ANDROID_NDK_VERSION=18.1.5063045
ARG CMDTOOLS_VERSION=7583922
ARG QT_ANDROID_VERSION=5.15.2

ARG DEBIAN_FRONTEND=noninteractive
RUN apt update -qq && apt install -qq -y \
vim git unzip wget \
openjdk-8-jdk libglu1 libpulse-dev libasound2 libc6 \
libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 libxi6 libxtst6 libnss3 \
g++ cmake extra-cmake-modules g++-11-multilib \
python3-pip git

CMD bash

## install android stuff
RUN mkdir /opt/android \
&& mkdir /opt/android/cmdline-tools \
&& wget -q "https://dl.google.com/android/repository/commandlinetools-linux-${CMDTOOLS_VERSION}_latest.zip" -P /tmp \
&& unzip -q -d /opt/android/cmdline-tools /tmp/commandlinetools-linux-${CMDTOOLS_VERSION}_latest.zip \
&& mv /opt/android/cmdline-tools/cmdline-tools /opt/android/cmdline-tools/tools \
&& yes Y | /opt/android/cmdline-tools/tools/bin/sdkmanager --install "build-tools;${ANDROID_BUILD_TOOLS_LEVEL}" "platforms;android-${ANDROID_API_LEVEL}" "platform-tools" "ndk;${ANDROID_NDK_VERSION}" \
&& yes Y | /opt/android/cmdline-tools/tools/bin/sdkmanager --licenses

## set  envs
ENV ANDROID_HOME=/opt/android
ENV ANDROID_NDK_HOME=${ANDROID_HOME}/ndk/${ANDROID_NDK_VERSION}
ENV PATH "$PATH:$ANDROID_HOME/emulator:$ANDROID_HOME/cmdline-tools/tools/bin:$ANDROID_HOME/platform-tools:${ANDROID_NDK_HOME}"
ENV LD_LIBRARY_PATH "$ANDROID_HOME/emulator/lib64:$ANDROID_HOME/emulator/lib64/qt/lib"
ENV ANDROID_NDK=${ANDROID_HOME}/ndk/${ANDROID_NDK_VERSION}
ENV ANDROID_NDK_ROOT=${ANDROID_HOME}/ndk/${ANDROID_NDK_VERSION}
ENV CMAKE_ANDROID_NDK=${ANDROID_HOME}/ndk/${ANDROID_NDK_VERSION}
ENV ANDROID_SDK_ROOT=/opt/android
ENV QT5_ANDROID=/opt/qt/${QT_ANDROID_VERSION}/android/lib/cmake

## cleanup
RUN rm -f /tmp/commandlinetools-linux-${CMDTOOLS_VERSION}_latest.zip

## install qt
RUN pip install aqtinstall
RUN mkdir -p /opt/qt
WORKDIR /opt/qt
RUN aqt install-qt linux android ${QT_ANDROID_VERSION}

## prep for build
RUN mkdir -p /opt/build/build_android
WORKDIR /opt/build
RUN git clone https://github.com/KDE/gcompris.git
WORKDIR /opt/build/gcompris
RUN git submodule init
RUN git submodule update
COPY cmake.sh /opt/build
RUN chmod 755 /opt/build/cmake.sh
WORKDIR /opt/build/build_android
