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

#### Cek di gilgalad
---

<img width="970" height="283" alt="image" src="https://github.com/user-attachments/assets/d3ad4b60-ea5a-4842-96f6-011e47654258" />

#### cek di Amandil
---

<img width="969" height="294" alt="image" src="https://github.com/user-attachments/assets/9927b2ef-4b6b-47cd-8b90-2a561e8ca496" />


### Soal 4
---

<img width="816" height="507" alt="image" src="https://github.com/user-attachments/assets/5a4295b4-6d7c-4cf9-a714-20b40b7210b9" />


<img width="812" height="569" alt="image" src="https://github.com/user-attachments/assets/75f4aeed-c2c8-4191-8452-358aea2fe8bb" />


### Soal 5
---

#### Cek Erendis
---
<img width="879" height="583" alt="image" src="https://github.com/user-attachments/assets/a538781e-30b9-4acc-84b9-d26e2c149ba0" />

#### Cek Amdir
---

<img width="828" height="513" alt="image" src="https://github.com/user-attachments/assets/74c7b9b6-47ce-4f84-8d73-6f5f3871cecd" />

### Soal 5
---

#### Cek Amandil
---

<img width="961" height="189" alt="image" src="https://github.com/user-attachments/assets/06012121-f4fb-4369-ba3d-856f432f50eb" />

#### Cek gilgalad
---

<img width="963" height="162" alt="image" src="https://github.com/user-attachments/assets/f32331b5-c281-49d9-9e27-e45f86495a77" />

#### Cek di Aldarion
---

```
set vendor-class-identifier = "udhcp 1.36.1";
}
lease 10.83.1.7 {
  starts 6 2025/11/01 16:58:58;
  ends 6 2025/11/01 17:28:58;
  cltt 6 2025/11/01 16:58:58;
  binding state active;
  next binding state free;
  rewind binding state free;
  hardware ethernet 02:42:fa:df:52:00;
  uid "\001\002B\372\337R\000";
  set vendor-class-identifier = "udhcp 1.36.1";
}
lease 10.83.2.36 {
  starts 6 2025/11/01 17:00:02;
  ends 6 2025/11/01 17:10:02;
  cltt 6 2025/11/01 17:00:02;
  binding state active;
  next binding state free;
  rewind binding state free;
  hardware ethernet 02:42:8d:d8:4f:00;
  client-hostname "Gilgalad";
```


### Soal 6
---


status di Aldarion
```

root@Aldarion:~# cat /var/lib/dhcp/dhcpd.leases | grep -E "10.83.1|10.83.2" -A 5
lease 10.83.2.35 {
  starts 5 2025/10/31 08:09:41;
  ends 5 2025/10/31 08:19:41;
  tstp 5 2025/10/31 08:19:41;
  cltt 5 2025/10/31 08:09:41;
  binding state active;
--
lease 10.83.1.7 {
  starts 5 2025/10/31 08:09:42;
  ends 5 2025/10/31 08:19:42;
  tstp 5 2025/10/31 08:19:42;
  cltt 5 2025/10/31 08:09:42;
  binding state active;
--
lease 10.83.1.6 {
  starts 5 2025/10/31 07:54:40;
  ends 6 2025/11/01 07:54:40;
  tstp 6 2025/11/01 07:54:40;
  cltt 5 2025/10/31 07:54:40;
  binding state abandoned;
--
lease 10.83.2.35 {
  starts 5 2025/10/31 08:14:42;
  ends 5 2025/10/31 08:24:42;
  cltt 5 2025/10/31 08:14:42;
  binding state active;
  next binding state free;
--
lease 10.83.1.7 {
  starts 5 2025/10/31 08:14:42;
  ends 5 2025/10/31 08:44:42;
  cltt 5 2025/10/31 08:14:42;
  binding state active;
  next binding state free;
--
lease 10.83.1.8 {
  starts 5 2025/10/31 08:16:34;
  ends 5 2025/10/31 08:46:34;
  cltt 5 2025/10/31 08:16:34;
  binding state active;
  next binding state free;
--
lease 10.83.2.36 {
  starts 5 2025/10/31 08:19:18;
  ends 5 2025/10/31 08:29:18;
  cltt 5 2025/10/31 08:19:18;
  binding state active;
  next binding state free;
--
lease 10.83.2.35 {
  starts 5 2025/10/31 08:19:42;
  ends 5 2025/10/31 08:29:42;
  cltt 5 2025/10/31 08:19:42;
  binding state active;
  next binding state free;
```


