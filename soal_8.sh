#!/bin/bash

echo "======================================"
echo "Setup Laravel Worker - Database & Nginx (Soal 8)"
echo "======================================"

# Deteksi hostname untuk menentukan port
HOSTNAME=$(hostname)
case $HOSTNAME in
    "Elendil"|"elendil")
        PORT=8001
        DOMAIN="elendil.k39.com"
        ;;
    "Isildur"|"isildur")
        PORT=8002
        DOMAIN="isildur.k39.com"
        ;;
    "Anarion"|"anarion")
        PORT=8003
        DOMAIN="anarion.k39.com"
        ;;
    *)
        echo "Unknown hostname: $HOSTNAME"
        echo "Please set PORT and DOMAIN manually"
        exit 1
        ;;
esac

echo "Configuring for: $HOSTNAME"
echo "Port: $PORT"
echo "Domain: $DOMAIN"
echo ""

# Konfigurasi .env untuk koneksi database
echo "Configuring .env file..."
cd /var/www/laravel-simple-rest-api

cat > .env << EOF
APP_NAME=Laravel
APP_ENV=local
APP_KEY=base64:$(php artisan key:generate --show)
APP_DEBUG=true
APP_URL=http://$DOMAIN

LOG_CHANNEL=stack
LOG_DEPRECATIONS_CHANNEL=null
LOG_LEVEL=debug

DB_CONNECTION=mysql
DB_HOST=10.83.4.3
DB_PORT=3306
DB_DATABASE=dbjarkom
DB_USERNAME=userjarkom
DB_PASSWORD=passwordjarkom

BROADCAST_DRIVER=log
CACHE_DRIVER=file
FILESYSTEM_DISK=local
QUEUE_CONNECTION=sync
SESSION_DRIVER=file
SESSION_LIFETIME=120

MEMCACHED_HOST=127.0.0.1

REDIS_HOST=127.0.0.1
REDIS_PASSWORD=null
REDIS_PORT=6379

MAIL_MAILER=smtp
MAIL_HOST=mailpit
MAIL_PORT=1025
MAIL_USERNAME=null
MAIL_PASSWORD=null
MAIL_ENCRYPTION=null
MAIL_FROM_ADDRESS="hello@example.com"
MAIL_FROM_NAME="\${APP_NAME}"

AWS_ACCESS_KEY_ID=
AWS_SECRET_ACCESS_KEY=
AWS_DEFAULT_REGION=us-east-1
AWS_BUCKET=
AWS_USE_PATH_STYLE_ENDPOINT=false

PUSHER_APP_ID=
PUSHER_APP_KEY=
PUSHER_APP_SECRET=
PUSHER_HOST=
PUSHER_PORT=443
PUSHER_SCHEME=https
PUSHER_APP_CLUSTER=mt1

VITE_APP_NAME="\${APP_NAME}"
VITE_PUSHER_APP_KEY="\${PUSHER_APP_KEY}"
VITE_PUSHER_HOST="\${PUSHER_HOST}"
VITE_PUSHER_PORT="\${PUSHER_PORT}"
VITE_PUSHER_SCHEME="\${PUSHER_SCHEME}"
VITE_PUSHER_APP_CLUSTER="\${PUSHER_APP_CLUSTER}"
EOF

echo "✓ .env file configured"

# Set permissions
chown www-data:www-data .env
chmod 644 .env

# Konfigurasi Nginx
echo ""
echo "Configuring Nginx..."

cat > /etc/nginx/sites-available/laravel << EOF
server {
    listen $PORT;
    server_name $DOMAIN;

    root /var/www/laravel-simple-rest-api/public;
    index index.php index.html index.htm;

    # Blokir akses via IP
    if (\$host !~* ^$DOMAIN$) {
        return 444;
    }

    location / {
        try_files \$uri \$uri/ /index.php?\$query_string;
    }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php8.4-fpm.sock;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
        include fastcgi_params;
    }

    location ~ /\.ht {
        deny all;
    }

    error_log /var/log/nginx/laravel_error.log;
    access_log /var/log/nginx/laravel_access.log;
}
EOF

# Enable site
ln -sf /etc/nginx/sites-available/laravel /etc/nginx/sites-enabled/

# Remove default site
rm -f /etc/nginx/sites-enabled/default

# Test Nginx configuration
echo ""
echo "Testing Nginx configuration..."
nginx -t

if [ $? -ne 0 ]; then
    echo "✗ Nginx configuration error!"
    exit 1
fi

# Restart services
echo ""
echo "Restarting services..."
service php8.4-fpm restart
service nginx restart

# Check services
echo ""
echo "Checking services status..."
if service php8.4-fpm status | grep -q "active (running)"; then
    echo "✓ PHP-FPM is running"
else
    echo "✗ PHP-FPM failed to start"
fi

if service nginx status | grep -q "active (running)"; then
    echo "✓ Nginx is running"
else
    echo "✗ Nginx failed to start"
fi

# Jalankan migrasi dan seeding HANYA di Elendil
if [ "$HOSTNAME" = "Elendil" ] || [ "$HOSTNAME" = "elendil" ]; then
    echo ""
    echo "======================================"
    echo "Running Migrations and Seeding from Elendil"
    echo "======================================"
    
    cd /var/www/laravel-simple-rest-api
    
    # Clear cache
    php artisan config:clear
    php artisan cache:clear
    
    # Run migrations
    echo "Running migrations..."
    php artisan migrate:fresh --force
    
    if [ $? -eq 0 ]; then
        echo "✓ Migrations completed successfully"
    else
        echo "✗ Migrations failed"
        echo "Check database connection!"
    fi
    
    # Run seeding
    echo ""
    echo "Running seeding..."
    php artisan db:seed --force
    
    if [ $? -eq 0 ]; then
        echo "✓ Seeding completed successfully"
    else
        echo "✗ Seeding failed"
    fi
else
    echo ""
    echo "⚠ Migrations and seeding should be run from Elendil only"
fi

echo ""
echo "======================================"
echo "Configuration Summary"
echo "======================================"
echo "Node: $HOSTNAME"
echo "Domain: $DOMAIN"
echo "Port: $PORT"
echo "Database Host: 10.83.4.3 (Palantir)"
echo "Database Name: dbjarkom"
echo "Database User: userjarkom"
echo "Laravel Path: /var/www/laravel-simple-rest-api"
echo ""
echo "======================================"
echo "Setup Laravel Worker (Soal 8) COMPLETE!"
echo "======================================"
echo ""
echo "Testing Commands:"
echo "1. Local test: curl http://localhost:$PORT"
echo "2. From client: lynx http://$DOMAIN"
echo "3. Test API: curl http://$DOMAIN/api/airing"
echo "4. Test IP block: curl http://10.83.x.x:$PORT (should fail)"
echo "======================================"