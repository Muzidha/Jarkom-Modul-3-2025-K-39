#minastir
nano /etc/sysctl.conf
net.ipv4.ip_forward=1

sysctl -p

ip route add default via 10.83.2.10

echo 1 > /proc/sys/net/ipv4/ip_forward
nano /etc/sysctl.conf

ip route add default via 10.83.5.1


#durin
echo 1 > /proc/sys/net/ipv4/ip_forward
nano /etc/sysctl.conf

net.ipv4.ip_forward=1

iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

#verifikasi pengujian
ping 10.83.5.1   # tes ke Durin
ping 8.8.8.8     # tes koneksi keluar lewat NAT1





