# Jarkom-Modul-3-2025-K-39


### Soal 1
---

### Soal 2
---
Simpan di root :

```
apt-get update
apt-get install isc-dhcp-server
dhcpd --version
```

`nano /etc/default/isc-dhcp-server`

<img width="207" height="84" alt="image" src="https://github.com/user-attachments/assets/12a4937d-603b-4e1c-ae3b-894bbf169869" />



Pada node Alderion `nano /etc/dhcp/dhcpd.conf`

```
default-lease-time 600;
max-lease-time 7200;
authoritative;

subnet 10.83.1.0 netmask 255.255.255.0 {
    range 10.83.1.6 10.83.1.34;
    range 10.83.1.68 10.83.1.94;
    option routers 10.83.1.1;
    option broadcast-address 10.83.1.255;
    option domain-name-servers 192.168.122.1;
}

subnet 10.83.2.0 netmask 255.255.255.0 {
    range 10.83.2.35 10.83.2.67;
    range 10.83.2.96 10.83.2.121;
    option routers 10.83.2.1;
    option broadcast-address 10.83.2.255;
    option domain-name-servers 192.168.122.1;
}

subnet 10.83.3.0 netmask 255.255.255.0 {}

host khamul {
    hardware ethernet 02:42:ca:fb:1c:00 ;
    fixed-address 10.83.3.95;
}
```
`service isc-dhcp-server restart`
`service isc-dhcp-server status`


