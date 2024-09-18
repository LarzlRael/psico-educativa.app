#!/bin/bash
#dont forget to give permission to the file
# chmod +x adb_connect.sh
# Verifica si se ha proporcionado una IP
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 YOUR_IP"
    exit 1
fi

# Asigna el primer parámetro a la variable IP
IP=$1

# Mata el servidor ADB
adb kill-server

# Cambia ADB al modo TCP/IP en el puerto 5555
adb tcpip 5555

# Conéctate a la IP proporcionada
adb connect "$IP:5555"
