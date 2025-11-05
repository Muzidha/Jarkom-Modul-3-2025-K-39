#!/bin/bash

echo "======================================"
echo "Setup Database Server - Palantir (Soal 8)"
echo "======================================"

# Update system
echo "Updating system..."
apt-get update

# Install MariaDB
echo "Installing MariaDB Server..."
apt-get install -y mariadb-server

# Start MariaDB
echo "Starting MariaDB..."
service mysql start

# Check status
if service mysql status | grep -q "active (running)"; then
    echo "✓ MariaDB is running"
else
    echo "✗ MariaDB failed to start"
    exit 1
fi

# Konfigurasi MariaDB untuk allow remote connections
echo ""
echo "Configuring MariaDB for remote connections..."

# Backup konfigurasi
cp /etc/mysql/mariadb.conf.d/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf.backup 2>/dev/null

# Edit bind-address
sed -i 's/bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf

echo "✓ MariaDB configured to listen on all interfaces"

# Restart MariaDB
echo "Restarting MariaDB..."
service mysql restart

# Buat database dan user
echo ""
echo "Creating database and user..."

mysql -u root << EOF
-- Create database
CREATE DATABASE IF NOT EXISTS dbjarkom;

-- Create user and grant privileges
CREATE USER IF NOT EXISTS 'userjarkom'@'%' IDENTIFIED BY 'passwordjarkom';
GRANT ALL PRIVILEGES ON dbjarkom.* TO 'userjarkom'@'%';

-- Grant privileges untuk localhost juga
CREATE USER IF NOT EXISTS 'userjarkom'@'localhost' IDENTIFIED BY 'passwordjarkom';
GRANT ALL PRIVILEGES ON dbjarkom.* TO 'userjarkom'@'localhost';

-- Flush privileges
FLUSH PRIVILEGES;

-- Show databases
SHOW DATABASES;

-- Show grants
SHOW GRANTS FOR 'userjarkom'@'%';
EOF

if [ $? -eq 0 ]; then
    echo "✓ Database and user created successfully"
else
    echo "✗ Failed to create database and user"
    exit 1
fi

echo ""
echo "======================================"
echo "Configuration Summary"
echo "======================================"
echo "Database Server: Palantir (10.83.4.3)"
echo "Database Name: dbjarkom"
echo "Database User: userjarkom"
echo "Database Password: passwordjarkom"
echo "Bind Address: 0.0.0.0 (all interfaces)"
echo ""
echo "======================================"
echo "Setup Database Server COMPLETE!"
echo "======================================"
echo ""
echo "Testing Commands:"
echo "1. Local test: mysql -u userjarkom -ppasswordjarkom dbjarkom"
echo "2. Remote test from worker: mysql -h 10.83.4.3 -u userjarkom -ppasswordjarkom dbjarkom"
echo "3. Check listening port: netstat -tlnp | grep 3306"
echo "======================================"