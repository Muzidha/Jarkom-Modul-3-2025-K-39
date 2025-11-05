#Aldarion
nano /etc/default/isc-dhcp-server

INTERFACESv4="eth0"
INTERFACESv6=""

nano /etc/dhcp/dhcpd.conf

default-lease-time 600;
max-lease-time 7200;
authoritative;

subnet 10.83.1.0 netmask 255.255.255.0 {
    range 10.83.1.6 10.83.1.34;
    range 10.83.1.68 10.83.1.94;
    option routers 10.83.1.1;
    option broadcast-address 10.83.1.255;
    option domain-name-servers 10.83.1.2;
}

subnet 10.83.2.0 netmask 255.255.255.0 {
    range 10.83.2.35 10.83.2.67;
    range 10.83.2.96 10.83.2.121;
    option routers 10.83.2.1;
    option broadcast-address 10.83.2.255;
    option domain-name-servers 10.83.2.2;
}

subnet 10.83.3.0 netmask 255.255.255.0 {
    option routers 10.83.3.1;
    option broadcast-address 10.83.3.255;
    option domain-name-servers 10.83.3.2;
}

host khamul {
    hardware ethernet 02:42:ca:fb:1c:00;
    fixed-address 10.83.3.95;
}

subnet 10.83.4.0 netmask 255.255.255.0 {
}

service isc-dhcp-server restart

service isc-dhcp-server status

#Durin

apt-get update
apt-get install isc-dhcp-relay -y
service isc-dhcp-relay start

nano /etc/default/isc-dhcp-relay

SERVERS="10.83.4.2"  
INTERFACES="eth0 eth1 eth2 eth3 eth4"
OPTIONS=""

nano /etc/sysctl.conf
net.ipv4.ip_forward=1

#kemudian jalankan
sysctl -p
service isc-dhcp-relay restart


