#erendis 
#!/bin/bash

echo "======================================"
echo "Setup DNS Master - Erendis (Soal 5)"
echo "CNAME, PTR, dan TXT Records"
echo "======================================"

# Update zone file k39.com dengan CNAME dan TXT records
echo "Updating zone file k39.com..."
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

# Set permission
chown bind:bind /etc/bind/jarkom/k39.com
chmod 644 /etc/bind/jarkom/k39.com

# Check syntax zone file
echo "Checking zone file syntax..."
named-checkzone k39.com /etc/bind/jarkom/k39.com

if [ $? -ne 0 ]; then
    echo "✗ Zone file syntax error!"
    exit 1
fi

# Tambahkan reverse zone ke named.conf.local
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

# Buat reverse zone file
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

# Set permission reverse zone
chown bind:bind /etc/bind/jarkom/3.83.10.in-addr.arpa
chmod 644 /etc/bind/jarkom/3.83.10.in-addr.arpa

# Check syntax reverse zone
echo "Checking reverse zone syntax..."
named-checkzone 3.83.10.in-addr.arpa /etc/bind/jarkom/3.83.10.in-addr.arpa

if [ $? -ne 0 ]; then
    echo "✗ Reverse zone syntax error!"
    exit 1
fi

# Check configuration
echo "Checking configuration..."
named-checkconf

if [ $? -ne 0 ]; then
    echo "✗ Configuration error!"
    exit 1
fi

# Restart BIND9
echo "Restarting BIND9..."
pkill named 2>/dev/null
sleep 2
named -u bind
sleep 3

# Check if running
if ps aux | grep -v grep | grep named > /dev/null; then
    echo "✓ BIND9 is running"
    ps aux | grep named | grep -v grep
else
    echo "✗ BIND9 failed to start"
    exit 1
fi

# Update resolver
echo "nameserver 10.83.3.3" > /etc/resolv.conf

# Testing
echo ""
echo "======================================"
echo "Testing Configuration..."
echo "======================================"

echo ""
echo "=== Test 1: CNAME www.k39.com ==="
dig www.k39.com | grep -A 3 "ANSWER SECTION"

echo ""
echo "=== Test 2: TXT cincinsauron ==="
dig cincinsauron.k39.com TXT | grep -A 2 "ANSWER SECTION"

echo ""
echo "=== Test 3: TXT aliansiterakhir ==="
dig aliansiterakhir.k39.com TXT | grep -A 2 "ANSWER SECTION"

echo ""
echo "=== Test 4: A record cincinsauron ==="
dig cincinsauron.k39.com A | grep -A 2 "ANSWER SECTION"

echo ""
echo "=== Test 5: A record aliansiterakhir ==="
dig aliansiterakhir.k39.com A | grep -A 2 "ANSWER SECTION"

echo ""
echo "=== Test 6: Reverse DNS 10.83.3.3 ==="
dig -x 10.83.3.3 | grep -A 2 "ANSWER SECTION"

echo ""
echo "=== Test 7: Reverse DNS 10.83.3.4 ==="
dig -x 10.83.3.4 | grep -A 2 "ANSWER SECTION"

echo ""
echo "======================================"
echo "Setup Erendis (Soal 5) COMPLETE!"
echo "======================================"


#amdir 
#!/bin/bash

echo "======================================"
echo "Setup DNS Slave - Amdir (Soal 5)"
echo "Zone Transfer untuk CNAME, PTR, TXT"
echo "======================================"

# Konfigurasi named.conf.local dengan forward dan reverse zone
echo "Configuring named.conf.local..."
cat > /etc/bind/named.conf.local << 'EOF'
zone "k39.com" {
    type slave;
    file "/var/lib/bind/k39.com";
    masters { 10.83.3.3; };
};

zone "3.83.10.in-addr.arpa" {
    type slave;
    file "/var/lib/bind/3.83.10.in-addr.arpa";
    masters { 10.83.3.3; };
};
EOF

# Check syntax
echo "Checking configuration..."
named-checkconf

if [ $? -ne 0 ]; then
    echo "✗ Configuration error!"
    exit 1
fi

# Set permission
chown bind:bind /var/lib/bind
chmod 755 /var/lib/bind

# Restart BIND9
echo "Restarting BIND9..."
pkill named 2>/dev/null
sleep 2
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
    exit 1
fi

# Check zone files
echo ""
echo "======================================"
echo "Checking Zone Transfer..."
echo "======================================"

if [ -f /var/lib/bind/k39.com ]; then
    echo "✓ Forward zone (k39.com) transferred"
    ls -lh /var/lib/bind/k39.com
else
    echo "✗ Forward zone transfer failed"
fi

if [ -f /var/lib/bind/3.83.10.in-addr.arpa ]; then
    echo "✓ Reverse zone (3.83.10.in-addr.arpa) transferred"
    ls -lh /var/lib/bind/3.83.10.in-addr.arpa
else
    echo "✗ Reverse zone transfer failed"
fi

# Update resolver
echo "nameserver 10.83.3.4" > /etc/resolv.conf

# Test AXFR from master
echo ""
echo "=== Testing AXFR from Master ==="
dig @10.83.3.3 k39.com AXFR | head -25

# Testing
echo ""
echo "======================================"
echo "Testing Configuration..."
echo "======================================"

echo ""
echo "=== Test 1: CNAME www.k39.com ==="
dig www.k39.com | grep -A 3 "ANSWER SECTION"

echo ""
echo "=== Test 2: TXT cincinsauron ==="
dig cincinsauron.k39.com TXT | grep -A 2 "ANSWER SECTION"

echo ""
echo "=== Test 3: TXT aliansiterakhir ==="
dig aliansiterakhir.k39.com TXT | grep -A 2 "ANSWER SECTION"

echo ""
echo "=== Test 4: A record cincinsauron ==="
dig cincinsauron.k39.com A | grep -A 2 "ANSWER SECTION"

echo ""
echo "=== Test 5: A record aliansiterakhir ==="
dig aliansiterakhir.k39.com A | grep -A 2 "ANSWER SECTION"

echo ""
echo "=== Test 6: Reverse DNS 10.83.3.3 ==="
dig -x 10.83.3.3 | grep -A 2 "ANSWER SECTION"

echo ""
echo "=== Test 7: Reverse DNS 10.83.3.4 ==="
dig -x 10.83.3.4 | grep -A 2 "ANSWER SECTION"

echo ""
echo "======================================"
echo "Setup Amdir (Soal 5) COMPLETE!"
echo "======================================"


