#!/bin/bash

echo "======================================"
echo "Setup DHCP Lease Time - Aldarion (Soal 6)"
echo "======================================"

# Backup konfigurasi
echo "Backing up DHCP configuration..."
cp /etc/dhcp/dhcpd.conf /etc/dhcp/dhcpd.conf.backup 2>/dev/null

# Konfigurasi dhcpd.conf dengan lease time
echo "Configuring DHCP with lease time..."
cat > /etc/dhcp/dhcpd.conf << 'EOF'
# Global configuration
default-lease-time 600;
max-lease-time 3600;
authoritative;

# Subnet untuk Keluarga Manusia (Numenor)
# Default lease time: 1800 detik (setengah jam)
subnet 10.83.1.0 netmask 255.255.255.0 {
    range 10.83.1.6 10.83.1.34;
    range 10.83.1.68 10.83.1.94;
    option routers 10.83.1.1;
    option broadcast-address 10.83.1.255;
    option domain-name-servers 10.83.3.3;
    default-lease-time 1800;  # setengah jam (30 menit)
    max-lease-time 3600;      # 1 jam
}

# Subnet untuk Keluarga Peri (Elf)
# Default lease time: 600 detik (seperenam jam)
subnet 10.83.2.0 netmask 255.255.255.0 {
    range 10.83.2.35 10.83.2.67;
    range 10.83.2.96 10.83.2.121;
    option routers 10.83.2.1;
    option broadcast-address 10.83.2.255;
    option domain-name-servers 10.83.3.4;
    default-lease-time 600;   # seperenam jam (10 menit)
    max-lease-time 3600;      # 1 jam
}

# Subnet untuk Fixed Address
subnet 10.83.3.0 netmask 255.255.255.0 {
    option routers 10.83.3.1;
    option broadcast-address 10.83.3.255;
    option domain-name-servers 10.83.3.3;
}

# Fixed address untuk Khamul
host khamul {
    hardware ethernet 02:42:ca:fb:1c:00;
    fixed-address 10.83.3.95;
}

# Subnet untuk koneksi ke DHCP Server (tidak ada range)
subnet 10.83.4.0 netmask 255.255.255.0 {
}
EOF

# Check syntax
echo "Checking DHCP configuration syntax..."
dhcpd -t -cf /etc/dhcp/dhcpd.conf

if [ $? -ne 0 ]; then
    echo "✗ DHCP configuration syntax error!"
    exit 1
fi

# Restart DHCP server
echo "Restarting DHCP server..."
service isc-dhcp-server stop
sleep 2
service isc-dhcp-server start
sleep 2

# Check status
echo ""
echo "======================================"
echo "Checking DHCP Server Status..."
echo "======================================"
service isc-dhcp-server status

if service isc-dhcp-server status | grep -q "dhcpd is running"; then
    echo "✓ DHCP Server is running"
else
    echo "✗ DHCP Server failed to start"
    echo "Check logs: tail -f /var/log/syslog"
    exit 1
fi

# Show configuration summary
echo ""
echo "======================================"
echo "Configuration Summary"
echo "======================================"
echo "Keluarga Manusia (Subnet 10.83.1.0/24):"
echo "  - Default Lease Time: 1800 detik (30 menit)"
echo "  - Max Lease Time: 3600 detik (1 jam)"
echo ""
echo "Keluarga Peri (Subnet 10.83.2.0/24):"
echo "  - Default Lease Time: 600 detik (10 menit)"
echo "  - Max Lease Time: 3600 detik (1 jam)"
echo ""
echo "Fixed Address:"
echo "  - Khamul: 10.83.3.95"
echo ""
echo "======================================"
echo "Setup DHCP Lease Time COMPLETE!"
echo "======================================"
echo ""
echo "Testing Instructions:"
echo "1. Pada client dinamis, jalankan: dhclient -r && dhclient"
echo "2. Check lease: cat /var/lib/dhcp/dhclient.leases"
echo "3. Pada Aldarion, check active leases: cat /var/lib/dhcp/dhcpd.leases"
echo "======================================"


#testing
#di Amandil-----

# Release IP lama dan minta IP baru
dhclient -r && dhclient

# Check lease time yang diterima
cat /var/lib/dhcp/dhclient.leases | grep -E "lease|renew|rebind|expire"

# Seharusnya dapat lease time 1800 detik (30 menit)

#di Gilgalad-----
# Release IP lama dan minta IP baru
dhclient -r && dhclient

# Check lease time yang diterima
cat /var/lib/dhcp/dhclient.leases | grep -E "lease|renew|rebind|expire"

# Seharusnya dapat lease time 600 detik (10 menit)

#verify di Aldarion
# Lihat lease aktif
cat /var/lib/dhcp/dhcpd.leases

# Atau monitoring real-time
tail -f /var/log/syslog | grep dhcpd

#verify di durin
service isc-dhcp-relay status