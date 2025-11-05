#erendis 
#!/bin/bash

echo "======================================"
echo "Setup DNS Master - Erendis (Soal 4)"
echo "======================================"

# Install BIND9
echo "Installing BIND9..."
apt-get update
apt-get install bind9 bind9utils dnsutils -y

# Backup konfigurasi
echo "Backing up configuration..."
cp /etc/bind/named.conf.local /etc/bind/named.conf.local.backup 2>/dev/null
cp /etc/bind/named.conf.options /etc/bind/named.conf.options.backup 2>/dev/null

# Konfigurasi named.conf.local
echo "Configuring named.conf.local..."
cat > /etc/bind/named.conf.local << 'EOF'
zone "k39.com" {
    type master;
    file "/etc/bind/jarkom/k39.com";
    allow-transfer { 10.83.3.4; }; // IP Amdir
};
EOF

# Konfigurasi named.conf.options
echo "Configuring named.conf.options..."
cat > /etc/bind/named.conf.options << 'EOF'
options {
    directory "/var/cache/bind";

    allow-query { any; };
    allow-transfer { 10.83.3.4; }; // IP Amdir

    auth-nxdomain no;
    listen-on-v6 { any; };
};
EOF

# Buat direktori zone
echo "Creating zone directory..."
mkdir -p /etc/bind/jarkom

# Buat zone file k39.com
echo "Creating zone file k39.com..."
cat > /etc/bind/jarkom/k39.com << 'EOF'
;
; BIND data file for k39.com
;
$TTL    604800
@       IN      SOA     k39.com. root.k39.com. (
                        2024103102      ; Serial
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

; A records for name servers
ns1     IN      A       10.83.3.3       ; Erendis
ns2     IN      A       10.83.3.4       ; Amdir

; A records for all important nodes
palantir    IN  A       10.83.4.3       ; Database Server
elros       IN  A       10.83.1.6       ; Load Balancer Laravel
pharazon    IN  A       10.83.2.3       ; Load Balancer PHP
elendil     IN  A       10.83.1.2       ; Laravel Worker-1
isildur     IN  A       10.83.1.3       ; Laravel Worker-2
anarion     IN  A       10.83.1.4       ; Laravel Worker-3
galadriel   IN  A       10.83.2.4       ; PHP Worker-1
celeborn    IN  A       10.83.2.5       ; PHP Worker-2
oropher     IN  A       10.83.2.6       ; PHP Worker-3
EOF

# Set permission
echo "Setting permissions..."
chown -R bind:bind /etc/bind/jarkom
chmod 644 /etc/bind/jarkom/k39.com

# Check syntax
echo "Checking zone file syntax..."
named-checkzone k39.com /etc/bind/jarkom/k39.com

if [ $? -ne 0 ]; then
    echo "ERROR: Zone file syntax error!"
    exit 1
fi

echo "Checking configuration syntax..."
named-checkconf

if [ $? -ne 0 ]; then
    echo "ERROR: Configuration syntax error!"
    exit 1
fi

# Stop any running named
echo "Stopping any running BIND9..."
pkill named 2>/dev/null
sleep 2

# Start BIND9
echo "Starting BIND9..."
named -u bind

# Wait a moment
sleep 3

# Check if running
if ps aux | grep -v grep | grep named > /dev/null; then
    echo "✓ BIND9 is running"
    ps aux | grep named | grep -v grep
else
    echo "✗ BIND9 failed to start"
    echo "Check logs for errors"
    exit 1
fi

# Update resolver
echo "Updating resolver..."
echo "nameserver 10.83.3.3" > /etc/resolv.conf

# Test DNS
echo ""
echo "======================================"
echo "Testing DNS Resolution..."
echo "======================================"
sleep 2

echo "Test 1: ping k39.com"
ping k39.com -c 2

echo ""
echo "Test 2: ping ns1.k39.com"
ping ns1.k39.com -c 2

echo ""
echo "Test 3: dig elendil.k39.com"
dig elendil.k39.com | grep -A 2 "ANSWER SECTION"

echo ""
echo "======================================"
echo "Setup DNS Master - Erendis COMPLETE!"
echo "======================================"





#amdir 
#!/bin/bash

echo "======================================"
echo "Setup DNS Slave - Amdir (Soal 4)"
echo "======================================"

# Install BIND9
echo "Installing BIND9..."
apt-get update
apt-get install bind9 bind9utils dnsutils -y

# Backup konfigurasi
echo "Backing up configuration..."
cp /etc/bind/named.conf.local /etc/bind/named.conf.local.backup 2>/dev/null
cp /etc/bind/named.conf.options /etc/bind/named.conf.options.backup 2>/dev/null

# Konfigurasi named.conf.local
echo "Configuring named.conf.local..."
cat > /etc/bind/named.conf.local << 'EOF'
zone "k39.com" {
    type slave;
    file "/var/lib/bind/k39.com";
    masters { 10.83.3.3; }; // IP Erendis
};
EOF

# Konfigurasi named.conf.options
echo "Configuring named.conf.options..."
cat > /etc/bind/named.conf.options << 'EOF'
options {
    directory "/var/cache/bind";

    allow-query { any; };

    auth-nxdomain no;
    listen-on-v6 { any; };
};
EOF

# Set permission untuk direktori slave
echo "Setting permissions..."
chown bind:bind /var/lib/bind
chmod 755 /var/lib/bind

# Check syntax
echo "Checking configuration syntax..."
named-checkconf

if [ $? -ne 0 ]; then
    echo "ERROR: Configuration syntax error!"
    exit 1
fi

# Stop any running named
echo "Stopping any running BIND9..."
pkill named 2>/dev/null
sleep 2

# Start BIND9
echo "Starting BIND9..."
named -u bind

# Wait for zone transfer
echo "Waiting for zone transfer..."
sleep 5

# Check if running
if ps aux | grep -v grep | grep named > /dev/null; then
    echo "✓ BIND9 is running"
    ps aux | grep named | grep -v grep
else
    echo "✗ BIND9 failed to start"
    echo "Check logs for errors"
    exit 1
fi

# Check zone transfer
echo ""
echo "======================================"
echo "Checking Zone Transfer..."
echo "======================================"

if [ -f /var/lib/bind/k39.com ]; then
    echo "✓ Zone file transferred successfully"
    ls -la /var/lib/bind/k39.com
else
    echo "⚠ Zone transfer not completed yet"
    echo "This might take a few moments..."
    echo "Check with: ls -la /var/lib/bind/"
fi

# Update resolver
echo "Updating resolver..."
echo "nameserver 10.83.3.4" > /etc/resolv.conf

# Test AXFR from master
echo ""
echo "Testing AXFR from master..."
dig @10.83.3.3 k39.com AXFR | head -20

# Test DNS
echo ""
echo "======================================"
echo "Testing DNS Resolution..."
echo "======================================"
sleep 2

echo "Test 1: ping k39.com"
ping k39.com -c 2

echo ""
echo "Test 2: ping ns2.k39.com"
ping ns2.k39.com -c 2

echo ""
echo "Test 3: dig elendil.k39.com"
dig elendil.k39.com | grep -A 2 "ANSWER SECTION"

echo ""
echo "======================================"
echo "Setup DNS Slave - Amdir COMPLETE!"
echo "======================================"