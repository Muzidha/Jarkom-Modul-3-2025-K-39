# Jarkom-Modul-3-2025-K-39

| Nama                   | NRP         |
|------------------------|-------------|
| Raihan Fahri Ghazali   | 5027241061  |
| M. Ziddan Habibi       | 5027241122  |

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

### Soal 3
Untuk mengontrol arus informasi ke dunia luar (Valinor/Internet), sebuah menara pengawas, Minastir didirikan. Minastir mengatur agar semua node (kecuali Durin) hanya dapat mengirim pesan ke luar Arda setelah melewati pemeriksaan di Minastir.

#### 1. Instalasi Paket BIND9
Sebelum konfigurasi dilakukan, pastikan kedua node (**Minastir** dan **Durin**) telah terpasang paket **BIND9** dan utilitas jaringan lain yang diperlukan.

Jalankan perintah berikut di kedua node:
```bash
apt-get update
apt-get install -y bind9 bind9utils bind9-doc dnsutils
```

#### 2. Konfigurasi pada Node Minastir (DNS Forwarder)
a. Aktifkan IP Forwarding
agar minastir dapat meneruspkan paket dari subnet lain, aktifkan fitur IP Forwarding menggunakan nano.

```bash
nano /etc/sysctl.conf
```

Tambahkan atau pastikan baris berikut ada di dalam file:
```bash
net.ipv4.ip_forward=1
```

Kemudian jalankan perintah berikut untuk mengaktifkan perubahan secara langsung:
```bash
sysctl -p
```

----

<img width="269" height="34" alt="image" src="https://github.com/user-attachments/assets/ec841933-06fc-4e09-88a9-c940d2103ec8" />

---

b. Atur Jalur Default Gateaway
Tambahkan route defauly agar Minastir dapat mengirim paket keluar melalui Durin.
```bash
ip route add default via 10.83.2.10
```

Lalu tambhakan route tambahan agar dapat menjangkau jaringan eksternal melalui NAT:
```
ip route add default via 10.83.5.1
```

c. Jalankan IP Forwarding Manual
Sebagai langkah tambahan, aktifkan IP forwarding langsung tanpa perlu reboot.
```bash
echo 1 > /proc/sys/net/ipv4/ip_forward
```

#### 3. Konfigurasi pada Node Durin (Sebagai Router & NAT Gateraway)
a. Aktifkan IP Forwarding
Buka file konfigurasi systcl.conf untuk mengaktifkan forwarding pada node Durin.
```bash
nano /etc/sysctl.conf

```

Tambahkan baris berikut:
```bash
net.ipv4.ip_forward=1
```

Kemudian jalankan perintah untuk pengecekan:
```bash
sysctl -p
```

---

<img width="234" height="39" alt="image" src="https://github.com/user-attachments/assets/ffe753d8-a321-4866-a0c9-2876b1b81471" />

---

b. Tambahkan Aturan NAT 
Agar jaringan di belakang Durin dapat mengakses internet, tambahkan aturan NAT menggunakan iptables.

```bash
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

```

#### 4. Verifikasi & Hasil Pengujian
Setelah semua konfigurasi dilakukan, lakukan pengujian konektivitas untuk memastikan semua node dapat berkomunikasi dengan baik.

a. Uji Koneksi dari Minastir 
```bash
dig google.com
```
---

<img width="632" height="439" alt="image" src="https://github.com/user-attachments/assets/d8784486-142c-40b4-ab00-6299675746e4" />

---

b. Uji koneksi dari Luar
```bash
dig google.com
```
---

<img width="646" height="433" alt="image" src="https://github.com/user-attachments/assets/6382e855-4591-4a18-baac-6ca6b564997c" />

---


### Soal 4
Ratu Erendis, sang pembuat peta, menetapkan nama resmi untuk wilayah utama (<xxxx>.com). Ia menunjuk dirinya (ns1.<xxxx>.com) dan muridnya Amdir (ns2.<xxxx>.com) sebagai penjaga peta resmi. Setiap lokasi penting (Palantir, Elros, Pharazon, Elendil, Isildur, Anarion, Galadriel, Celeborn, Oropher) diberikan nama domain unik yang menunjuk ke lokasi fisik tanah mereka. Pastikan Amdir selalu menyalin peta (master-slave) dari Erendis dengan setia.

#### 1. Instalasi Paket BIND9 di Erendis dan Amdir
Langkah pertama yaitu memasang layanan **BIND9** sebagai DNS server di kedua node, baik Master maupun Slave.
```bash
apt-get update
apt-get install -y bind9 bind9utils dnsutils
```

#### 2. Konfigurasi DNS Master (Node Erendis)
Setelah instalasi selesai, kita mulai mengatur DNS Master yang akan memegan kendali penuh atas zona k.39.com

a. Backup file konfigurasi lama
```bash
cp /etc/bind/named.conf.local /etc/bind/named.conf.local.backup 2>/dev/null
cp /etc/bind/named.conf.options /etc/bind/named.conf.options.backup 2>/dev/null
```

isi file dengan konfigurasi berikut:
```bash
zone "k39.com" {
    type master;
    file "/etc/bind/jarkom/k39.com";
    allow-transfer { 10.83.3.4; }; // IP Amdir
};
```

c. Atur file named.conf.options
```bash
nano /etc/bind/named.conf.options
```
isi file seperti berikut:

```bash
options {
    directory "/var/cache/bind";
    allow-query { any; };
    allow-transfer { 10.83.3.4; };
    auth-nxdomain no;
    listen-on-v6 { any; };
};
```

d. Buat direktori untuk file zone
```bash
mkdir -p /etc/bind/jarkom
```

e. Buat file zona k39.com
```
nano /etc/bind/jarkom/k39.com
```

Isi file sebagai berikut:
```bash
$TTL    604800
@       IN      SOA     k39.com. root.k39.com. (
                        2024103102
                        604800
                        86400
                        2419200
                        604800 )
;
@       IN      NS      ns1.k39.com.
@       IN      NS      ns2.k39.com.

@       IN      A       10.83.3.3
ns1     IN      A       10.83.3.3
ns2     IN      A       10.83.3.4

palantir    IN  A       10.83.4.3
elros       IN  A       10.83.1.6
pharazon    IN  A       10.83.2.3
elendil     IN  A       10.83.1.2
isildur     IN  A       10.83.1.3
anarion     IN  A       10.83.1.4
galadriel   IN  A       10.83.2.4
celeborn    IN  A       10.83.2.5
oropher     IN  A       10.83.2.6
```

f. Ubah hak akses file zona
```bash
chown -R bind:bind /etc/bind/jarkom
chmod 644 /etc/bind/jarkom/k39.com
```

g. Periksa sintaks file konfigurasi 
```bash
named-checkzone k39.com /etc/bind/jarkom/k39.com
named-checkconf
```
Jika hasil menunjukkan OK dan tidak ada error, konfigurasi sudah benar.

h. Restart layanan BIND9
```BASH
pkill named 2>/dev/null
sleep 2
named -u bind
sleep 3
```

i. Atur resolver agar Erendis menggunakan DNS sendiri
```bash
echo "nameserver 10.83.3.3" > /etc/resolv.conf
```

j. Pengujian pada DNS Master
```bash
ping k39.com -c 2
ping ns1.k39.com -c 2
dig elendil.k39.com | grep -A 2 "ANSWER SECTION"
```
Hasil pengujian yang berhasil akan menampilkan IP yang sesuai dari file zona

---

<img width="600" height="376" alt="image" src="https://github.com/user-attachments/assets/0470b35c-870a-4bcc-bf77-980ccbe78304" />

---

#### 3. Konfigurasi DNS Slave (Node Amadir)
Langkah berikutnya adalah mengatur Amdir sebagai DNS Slave yang akan menerima data zona dari Erendis secara otomatis.

a. Backup konfigurasi lama
```bash
cp /etc/bind/named.conf.local /etc/bind/named.conf.local.backup 2>/dev/null
cp /etc/bind/named.conf.options /etc/bind/named.conf.options.backup 2>/dev/null
```

b. Atur file named.conf.local
```bash
nano /etc/bind/named.conf.local
```

isi dengan konfigurasi berikut:
```bash
zone "k39.com" {
    type slave;
    file "/var/lib/bind/k39.com";
    masters { 10.83.3.3; };
};
```

c. Atur file named.conf.options
```
nano /etc/bind/named.conf.options
```

isi file seperti berikut:
```
options {
    directory "/var/cache/bind";
    allow-query { any; };
    auth-nxdomain no;
    listen-on-v6 { any; };
};
```

d. Pastikan izin direktori bind
```bash
chown bind:bind /var/lib/bind
chmod 755 /var/lib/bind
```

e. Periksa konfigurasi 
```bash
named-checkconf
```

f. Jalankan ulang layanan BIND9
```bash
pkill named 2>/dev/null
sleep 2
named -u bind
sleep 5
```

g. Atur resolver agar Amdir menggunakan DNS sendiri
```bash
echo "nameserver 10.83.3.4" > /etc/resolv.conf
```

h. Verifikasi transfer zona dari Master 
```bash
ls -la /var/lib/bind/k39.com
```
Jika file k39.com sudah muncul, berarti proses transfer AXFR berhasil.

---

<img width="579" height="46" alt="image" src="https://github.com/user-attachments/assets/d16d2253-ba7d-45e9-9443-a0206a1fbe26" />

---

i. Uji koneksi dan resolusi DNS
```bash
dig @10.83.3.3 k39.com AXFR | head -20
ping k39.com -c 2
ping ns2.k39.com -c 2
dig elendil.k39.com | grep -A 2 "ANSWER SECTION"
```
Hasil yang diharapkan:
Semua ping dan dig berhasil dengan IP yang benar, menandakan bahwa Amdir berhasil menjadi DNS Slave dari Erendis.

---

<img width="1015" height="728" alt="image" src="https://github.com/user-attachments/assets/83d2832b-5902-49a8-af8e-8d5164ac8c21" />

---

### Soal 5
---

Untuk memudahkan, nama alias www.<xxxx>.com dibuat untuk peta utama <xxxx>.com. Reverse PTR juga dibuat agar lokasi Erendis dan Amdir dapat dilacak dari alamat fisik tanahnya. Erendis juga menambahkan pesan rahasia (TXT record) pada petanya: "Cincin Sauron" yang menunjuk ke lokasi Elros, dan "Aliansi Terakhir" yang menunjuk ke lokasi Pharazon. Pastikan Amdir juga mengetahui pesan rahasia ini.

1. Update zone file k39.com dengan CNAME dan TXT records

```
cat > /etc/bind/jarkom/k39.com << 'EOF'
;
; BIND data file for k39.com
;
$TTL    604800
@       IN      SOA     k39.com. root.k39.com. (
                        2024103103      ; Serial
                        604800          ; Refresh
                        86400           ; Retry
                        2419200         ; Expire
                        604800 )        ; Negative Cache TTL
;
; Name servers
@       IN      NS      ns1.k39.com.
@       IN      NS      ns2.k39.com.

; A record untuk domain utama
@       IN      A       10.83.3.3

; CNAME record untuk www
www     IN      CNAME   k39.com.

; A records for name servers
ns1     IN      A       10.83.3.3
ns2     IN      A       10.83.3.4

; A records for all important nodes
palantir    IN  A       10.83.4.3
elros       IN  A       10.83.1.6
pharazon    IN  A       10.83.2.3
elendil     IN  A       10.83.1.2
isildur     IN  A       10.83.1.3
anarion     IN  A       10.83.1.4
galadriel   IN  A       10.83.2.4
celeborn    IN  A       10.83.2.5
oropher     IN  A       10.83.2.6

; TXT records dan A records untuk pesan rahasia
cincinsauron        IN  TXT     "Cincin Sauron"
cincinsauron        IN  A       10.83.1.6

aliansiterakhir     IN  TXT     "Aliansi Terakhir"
aliansiterakhir     IN  A       10.83.2.3
EOF
```

2. Set permission

```
chown bind:bind /etc/bind/jarkom/k39.com
chmod 644 /etc/bind/jarkom/k39.com
```

3. Check syntax zone file

```
echo "Checking zone file syntax..."
named-checkzone k39.com /etc/bind/jarkom/k39.com
```

4. Tambahkan reverse zone ke named.conf.local

```
echo "Configuring reverse zone in named.conf.local..."
cat > /etc/bind/named.conf.local << 'EOF'
zone "k39.com" {
    type master;
    file "/etc/bind/jarkom/k39.com";
    allow-transfer { 10.83.3.4; };
};

zone "3.83.10.in-addr.arpa" {
    type master;
    file "/etc/bind/jarkom/3.83.10.in-addr.arpa";
    allow-transfer { 10.83.3.4; };
};
EOF
```

5. Buat reverse zone file
```
echo "Creating reverse zone file..."
cat > /etc/bind/jarkom/3.83.10.in-addr.arpa << 'EOF'
;
; BIND reverse data file for 10.83.3.x
;
$TTL    604800
@       IN      SOA     k39.com. root.k39.com. (
                        2024103103      ; Serial
                        604800          ; Refresh
                        86400           ; Retry
                        2419200         ; Expire
                        604800 )        ; Negative Cache TTL
;
@       IN      NS      ns1.k39.com.
@       IN      NS      ns2.k39.com.

; PTR Records
3       IN      PTR     ns1.k39.com.
4       IN      PTR     ns2.k39.com.
EOF
```

6. Set permission reverse zone

```
chown bind:bind /etc/bind/jarkom/3.83.10.in-addr.arpa
chmod 644 /etc/bind/jarkom/3.83.10.in-addr.arpa
```

7. Check syntax reverse zone
```
echo "Checking reverse zone syntax..."
named-checkzone 3.83.10.in-addr.arpa /etc/bind/jarkom/3.83.10.in-addr.arpa
```

8. Check configuration
```
echo "Checking configuration..."
named-checkconf
```

9. Restart BIND9
```
echo "Restarting BIND9..."
pkill named 2>/dev/null
sleep 2
named -u bind
sleep 3
```

10. Update resolver

```
echo "nameserver 10.83.3.3" > /etc/resolv.conf
```


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
- Manusia: 30 menit (1800 detik)
- Peri: 10 menit (600 detik)  
- Max lease time: 1 jam (3600 detik) untuk semua


