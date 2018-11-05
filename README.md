# Redes

#Network Namespaces

-Crear
    ip netns add <new namespace name>

-Mostrar
    ip netns list

-Eliminar todas
    sudo ip -all netns delete

-Ejecuta
    ip netns exec <namespace name>

#Redes NN

-Agrega loopback al namespcae
    ip netns exec <namespace name> ip link set dev lo up

-Muestra ruta
    ip netns exec <namespace name> ip route show

-Crea veth pair
    ip link add <v-name1> type veth peer name <v-name2>

-Agrega interfaz al NN
    ip link set <interfaz> netns <namespace name>

-Configura IPv4
    ip addr add <ip>/<mascara> dev <interfaz>
    ip link set <interfaz> up

###
    # Share internet access between host and NS.

    # Enable IP-forwarding.
    echo 1 > /proc/sys/net/ipv4/ip_forward

    # Flush forward rules, policy DROP by default.
    iptables -P FORWARD DROP
    iptables -F FORWARD

    # Flush nat rules.
    iptables -t nat -F

    # Enable masquerading of 10.200.1.0.
    iptables -t nat -A POSTROUTING -s 10.200.1.0/255.255.255.0 -o eth0 -j MASQUERADE

    # Allow forwarding between eth0 and v-eth1.
    iptables -A FORWARD -i eth0 -o v-eth1 -j ACCEPT
    iptables -A FORWARD -o eth0 -i v-eth1 -j ACCEPT
###

#Bridge

-Crea, activa y agrega interfzes 
    brctl addbr <nombre-bridge>
    brctl stp   <nombre-bridge> off
    ip link set dev <nombre-bridge> up
    brctl addif <nombre-bridge> <interfaz>
    brctl addif <nombre-bridge> <interfaz2>

-elimina
    brctl delbr <nombre-bridge> 

#Activa broadcast

echo 0 >/proc/sys/net/ipv4/icmp_echo_ignore_broadcasts
