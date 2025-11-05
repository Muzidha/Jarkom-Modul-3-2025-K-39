#!/bin/bash
echo "======================================"
echo " Setup Load Balancer Elros (Soal 10) "
echo " Nginx Reverse Proxy + Round Robin  "
echo "======================================"

DOMAIN="elros.k39.com"

echo "[1] Install nginx"
apt-get update -y
apt-get install -y nginx

echo "[2] Creating upstream config..."

cat > /etc/nginx/conf.d/kesatria_numenor.conf << 'EOF'
upstream kesatria_numenor {
    server 10.83.1.2;   # Elendil
    server 10.83.1.3;   # Isildur
    server 10.83.1.4;   # Anarion
}
EOF

echo "[3] Setting reverse proxy server block..."

cat > /etc/nginx/sites-available/numenor.conf << EOF
server {
    listen 80;
    server_name $DOMAIN;

    access_log /var/log/nginx/numenor_access.log;
    error_log  /var/log/nginx/numenor_error.log;

    location / {
        proxy_pass http://kesatria_numenor;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }
}
EOF

echo "[4] Activating site..."
ln -sf /etc/nginx/sites-available/numenor.conf /etc/nginx/sites-enabled/numenor.conf
rm -f /etc/nginx/sites-enabled/default

echo "[5] Restarting Nginx (SysV)..."
service nginx restart

echo "======================================"
echo " ✅ Reverse Proxy Setup Completed "
echo "======================================"
echo "Elros now load balances to:"
echo " - Elendil"
echo " - Isildur"
echo " - Anarion"
echo ""
echo "Test:"
echo "curl http://$DOMAIN"
echo "curl http://$DOMAIN/api/airing"
echo ""
echo "Check logs:"
echo "tail -f /var/log/nginx/numenor_access.log"
echo "======================================"
