# Base
FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /opt/android-lab

# Installazioni base
RUN apt-get update && apt-get install -y \
    openjdk-11-jdk \
    wget \
    unzip \
    git \
    python3 \
    python3-pip \
    default-jre \
    bash \
    vim \
    xvfb \
    x11vnc \
    fluxbox \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Installazione apktool
RUN wget -q https://raw.githubusercontent.com/iBotPeaches/Apktool/master/scripts/linux/apktool -O /usr/local/bin/apktool \
    && chmod +x /usr/local/bin/apktool \
    && wget -q https://bitbucket.org/iBotPeaches/apktool/downloads/apktool_2.12.1.jar -O /usr/local/bin/apktool.jar

# Installazione dex2jar
RUN wget -q https://github.com/pxb1988/dex2jar/releases/download/v2.4/dex-tools-v2.4.zip -O /tmp/dex2jar.zip \
    && unzip /tmp/dex2jar.zip -d /opt/dex2jar \
    && rm /tmp/dex2jar.zip

# JD-GUI
RUN wget -q https://github.com/java-decompiler/jd-gui/releases/download/v1.6.6/jd-gui-1.6.6.jar -O /opt/jd-gui.jar

# Bytecode Viewer
RUN wget -q https://github.com/Konloch/bytecode-viewer/releases/download/v2.13.1/Bytecode-Viewer-2.13.1.jar -O /opt/bytecode-viewer.jar

# PATH
ENV PATH="/opt/dex2jar:${PATH}"

# Copia entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

