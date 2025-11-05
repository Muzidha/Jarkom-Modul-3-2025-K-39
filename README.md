# Jarkom-Modul-3-2025-K-39

## Topologi
---

<img width="891" height="718" alt="image" src="https://github.com/user-attachments/assets/9a9f1248-2b6b-42e7-a34a-10d453e0075d" />


### Soal 1
---
Di awal Zaman Kedua, setelah kehancuran Beleriand, para Valar menugaskan untuk membangun kembali jaringan komunikasi antar kerajaan. Para Valar menyalakan Minastir, Aldarion, Erendis, Amdir, Palantir, Narvi, Elros, Pharazon, Elendil, Isildur, Anarion, Galadriel, Celeborn, Oropher, Miriel, Amandil, Gilgalad, Celebrimbor, Khamul, dan pastikan setiap node (selain Durin sang penghubung antar dunia) dapat sementara berkomunikasi dengan Valinor/Internet (nameserver 192.168.122.1) untuk menerima instruksi awal.

#### Konfigurasi
```
#Durin
auto eth0
iface eth0 inet dhcp

auto eth1
iface eth1 inet static
	address 10.83.1.1
	netmask 255.255.255.0

auto eth2
iface eth2 inet static
	address 10.83.2.1
	netmask 255.255.255.0

auto eth3
iface eth3 inet static
	address 10.83.3.1
	netmask 255.255.255.0

auto eth4
iface eth4 inet static
	address 10.83.4.1
	netmask 255.255.255.0

auto eth5
iface eth5 inet static
	address 10.83.5.1
	netmask 255.255.255.0

up iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 10.83.0.0/16

#Elendil
auto eth0
iface eth0 inet static
    address 10.83.1.2
    netmask 255.255.255.0
    gateway 10.83.1.1
 up echo nameserver 192.168.122.1 > /etc/resolv.conf

#Isildur
auto eth0
iface eth0 inet static
    address 10.83.1.3
    netmask 255.255.255.0
    gateway 10.83.1.1
    up echo nameserver 192.168.122.1 > /etc/resolv.conf

#Anarion
auto eth0
iface eth0 inet static
    address 10.83.1.4
    netmask 255.255.255.0
    gateway 10.83.1.1
    up echo nameserver 192.168.122.1 > /etc/resolv.conf

#Miriel
auto eth0
iface eth0 inet static
    address 10.83.1.5
    netmask 255.255.255.0
    gateway 10.83.1.1
    up echo nameserver 192.168.122.1 > /etc/resolv.conf

#Amandil
auto eth0
iface eth0 inet dhcp

#Elros
auto eth0
iface eth0 inet static
    address 10.83.1.6
    netmask 255.255.255.0
    gateway 10.83.1.1
    up echo nameserver 192.168.122.1 > /etc/resolv.conf

#Gilgalad
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet dhcp


#Celebrimbor
auto eth0
iface eth0 inet static
    address 10.83.2.2
    netmask 255.255.255.0
    gateway 10.83.2.1
    up echo nameserver 192.168.122.1 > /etc/resolv.conf

#Pharazon
auto eth0
iface eth0 inet static
    address 10.83.2.3
    netmask 255.255.255.0
    gateway 10.83.2.1
    up echo nameserver 192.168.122.1 > /etc/resolv.conf

#Galadriel
auto eth0
iface eth0 inet static
    address 10.83.2.4
    netmask 255.255.255.0
    gateway 10.83.2.1
    up echo nameserver 192.168.122.1 > /etc/resolv.conf

#Celeborn
auto eth0
iface eth0 inet static
    address 10.83.2.5
    netmask 255.255.255.0
    gateway 10.83.2.1
    up echo nameserver 192.168.122.1 > /etc/resolv.conf

#Oropher
auto eth0
iface eth0 inet static
    address 10.83.2.6
    netmask 255.255.255.0
    gateway 10.83.2.1
    up echo nameserver 192.168.122.1 > /etc/resolv.conf

#Khamul
auto eth0
iface eth0 inet static
    address 10.83.3.2
    netmask 255.255.255.0
    gateway 10.83.3.1
    up echo nameserver 192.168.122.1 > /etc/resolv.conf

#Erendis
auto eth0
iface eth0 inet static
    address 10.83.3.3
    netmask 255.255.255.0
    gateway 10.83.3.1
    up echo nameserver 192.168.122.1 > /etc/resolv.conf

#Amdir
auto eth0
iface eth0 inet static
    address 10.83.3.4
    netmask 255.255.255.0
    gateway 10.83.3.1
    up echo nameserver 192.168.122.1 > /etc/resolv.conf

#Aldarion
auto eth0
iface eth0 inet static
    address 10.83.4.2
    netmask 255.255.255.0
    gateway 10.83.4.1
    up echo nameserver 192.168.122.1 > /etc/resolv.conf

#Palantir
auto eth0
iface eth0 inet static
    address 10.83.4.3
    netmask 255.255.255.0
    gateway 10.83.4.1
    up echo nameserver 192.168.122.1 > /etc/resolv.conf

#Narvi
auto eth0
iface eth0 inet static
    address 10.83.4.4
    netmask 255.255.255.0
    gateway 10.83.4.1
    up echo nameserver 192.168.122.1 > /etc/resolv.conf

#Minastir
auto eth0
iface eth0 inet static
    address 10.83.5.2
    netmask 255.255.255.0
    gateway 10.83.5.1
    up echo nameserver 192.168.122.1 > /etc/resolv.conf
```


#### Tes untuk setiap node bisa connect ke internet
---

#### Durin

<img width="958" height="349" alt="image" src="https://github.com/user-attachments/assets/759143c8-e7c3-4bcc-86d7-68e23e78d679" />

#### Celebrimbor
---

<img width="942" height="287" alt="image" src="https://github.com/user-attachments/assets/6f6b3665-ffa8-4a73-8459-d75c2a79f8e9" />


### Soal 2
---
Raja Pelaut Aldarion, penguasa wilayah Númenor, memutuskan cara pembagian tanah client secara dinamis. Ia menetapkan:
- Client Dinamis Keluarga Manusia: Mendapatkan tanah di rentang [prefix ip].1.6 - [prefix ip].1.34 dan [prefix ip].1.68 - [prefix ip].1.94.
- Client Dinamis Keluarga Peri: Mendapatkan tanah di rentang [prefix ip].2.35 - [prefix ip].2.67 dan [prefix ip].2.96 - [prefix ip].2.121.
- Khamul yang misterius: Diberikan tanah tetap di [prefix ip].3.95, agar keberadaannya selalu diketahui. Pastikan Durin dapat menyampaikan dekrit ini ke semua wilayah yang terhubung dengannya.
---
##### 1. Instalasi DHCP Server
Pertama, lakukan update package dan instalasi DHCP server di node **Alderion**.
```bash
apt-get update
apt-get install isc-dhcp-server -y
dhcpd --version
```

##### 2. Konfigurasi Interface DHCP Server 
Buka file konfigurasi /etc/default/isc-dhcp-server dan sesuaikan interface yang digunakan.
```bash
nano /etc/default/isc-dhcp-server
```

Lalu kita isi file menjadi seperti berikut
```bash
INTERFACESv4="eth0"
INTERFACESv6=""
```

<img width="207" height="84" alt="image" src="https://github.com/user-attachments/assets/12a4937d-603b-4e1c-ae3b-894bbf169869" />

##### 3. Konfigurasi file dhcpd.conf
Selanjutnya, buka dan ubah konfigurasi utama DHCP di file /etc/dhcp/dhcpd.conf pada node Alderion 
`nano /etc/dhcp/dhcpd.conf`
Isilah konfigurasi sebagai berikut:
```bash
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
##### 4. Restart dan Verifikasi Layanan DHCP
Setelah konfigurasi selesai, lakukan restart pada service DHCP server.
```bash
service isc-dhcp-server restart
service isc-dhcp-server status
```
Jika konfigurasi benar, maka status service akan menunjukkan active (running).

##### 5. Pengujian DHCP Client.
Setelah konfigurasi DHCP Server selesai dan service telah berjalan dengan status **active (running)**, langkah selanjutnya adalah melakukan pengujian pada node client untuk memastikan bahwa node tersebut sudah mendapatkan IP address secara otomatis serta dapat terkoneksi ke internet.

#### Pengujian pada Node **Gilgalad**
Pada node **Gilgalad**, dilakukan perintah berikut untuk menguji koneksi internet sekaligus memastikan IP yang diperoleh dari DHCP Server dapat digunakan dengan baik:

```bash
ping google.com
```

Hasil pengujian:

---

<img width="970" height="283" alt="image" src="https://github.com/user-attachments/assets/d3ad4b60-ea5a-4842-96f6-011e47654258" />

---

#### Pengujian pada Node **Amandil**
Langkah pengujian yang sama dilakukan pada node Amandil untuk memastikan DHCP Server juga melayani subnet lain dengan benar:

```bash
ping google.com
```

hasil pengujian:

---

<img width="969" height="294" alt="image" src="https://github.com/user-attachments/assets/9927b2ef-4b6b-47cd-8b90-2a561e8ca496" />

---


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

Berdasarkan hasil `dhcpd.leases` yang Anda tunjukkan, ini adalah penjelasan untuk **Soal No. 6** mengenai pengaturan waktu peminjaman tanah (lease time):

## Analisis Lease Time dari Log

### **Client Dinamis Keluarga Manusia (10.83.1.x)**
Contoh lease: `10.83.1.7` dan `10.83.1.8`
```
starts 5 2025/10/31 08:14:42;
ends 5 2025/10/31 08:44:42;
```
- **Durasi**: 08:14:42 → 08:44:42 = **30 menit** 
- Sesuai persyaratan: "Client Dinamis Keluarga Manusia dapat meminjam tanah selama **setengah jam**"

### **Client Dinamis Keluarga Peri (10.83.2.x)**
Contoh lease: `10.83.2.35` dan `10.83.2.36`
```
starts 5 2025/10/31 08:19:42;
ends 5 2025/10/31 08:29:42;
```
- **Durasi**: 08:19:42 → 08:29:42 = **10 menit** 
- Sesuai persyaratan: "Client Dinamis Keluarga Peri hanya **seperenam jam**" (1/6 × 60 = 10 menit)

## Kesimpulan
Konfigurasi DHCP untuk **Soal No. 6 sudah benar**:
- ✅ Manusia: 30 menit (1800 detik)
- ✅ Peri: 10 menit (600 detik)  
- ✅ Max lease time: 1 jam (3600 detik) untuk semua


