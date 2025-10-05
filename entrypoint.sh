#!/bin/bash

# UID e GID dell'host (passati come variabili d'ambiente dal docker-compose)
HOST_UID=${HOST_UID:-1000}
HOST_GID=${HOST_GID:-1000}

# Crea utente hostuser con stesso UID/GID
if ! id -u hostuser >/dev/null 2>&1; then
    groupadd -g $HOST_GID hostuser
    useradd -m -u $HOST_UID -g $HOST_GID hostuser
fi

chown -R hostuser:hostuser /opt/android-lab/apks

# Avvia X virtual framebuffer
Xvfb :1 -screen 0 1920x1080x16 &
export DISPLAY=:1

# Avvia Fluxbox
fluxbox &

# Avvia server VNC
x11vnc -display :1 -nopw -forever -shared &

echo "Lab Android pronto!"
echo "Collegati via VNC a localhost:5900"
echo "Strumenti disponibili: apktool, dex2jar, JD-GUI, Bytecode Viewer"

# Mantieni il container attivo
tail -f /dev/null

