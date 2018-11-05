#!/bin/bash

#Comprueba si es usuario root
if [ "$(id -u)" != "0" ]; then
   echo "Para generar la red se necesitan permisos de root" 1>&2
   exit 1
fi

# Crea red
ip netns add ns1