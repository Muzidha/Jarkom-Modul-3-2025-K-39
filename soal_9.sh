#!/bin/bash
#isildur anarion
echo "======================================"
echo " Setup Queue Worker (Soal 9)"
echo "======================================"

PROJECT_DIR="/var/www/laravel-simple-rest-api"
QUEUE_SERVICE="/etc/init.d/laravel-queue"

echo "[1] Install requirements..."
apt-get update -y
apt-get install -y supervisor lynx curl

echo "[2] Setting up supervisor for Laravel queue..."
cat > /etc/supervisor/conf.d/laravel-worker.conf << 'EOF'
[program:laravel-worker]
command=/usr/bin/php /var/www/laravel-simple-rest-api/artisan queue:work --sleep=3 --tries=3
directory=/var/www/laravel-simple-rest-api
autostart=true
autorestart=true
stderr_logfile=/var/log/laravel-worker.err.log
stdout_logfile=/var/log/laravel-worker.out.log
user=www-data
stopasgroup=true
killasgroup=true
EOF

echo "[3] Restarting supervisor..."
service supervisor restart

echo "[4] Creating manual queue service script (SysV init)..."

cat > $QUEUE_SERVICE << 'EOF'
#!/bin/sh
### BEGIN INIT INFO
# Provides:          laravel-queue
# Required-Start:    $network $local_fs
# Required-Stop:     $network $local_fs
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Description:       Laravel Queue Worker
### END INIT INFO

case "$1" in
 start)
   echo "Starting Laravel queue worker..."
   su -s /bin/sh www-data -c "php /var/www/laravel-simple-rest-api/artisan queue:work --sleep=3 --tries=3 &"
   ;;
 stop)
   echo "Stopping Laravel queue worker..."
   pkill -f "queue:work"
   ;;
 restart)
   $0 stop
   sleep 2
   $0 start
   ;;
 *)
   echo "Usage: /etc/init.d/laravel-queue {start|stop|restart}"
   exit 1
   ;;
esac
exit 0
EOF

chmod +x $QUEUE_SERVICE
update-rc.d laravel-queue defaults

echo "[5] Starting Queue Worker Service..."
service laravel-queue restart

echo "======================================"
echo " ✅ Queue Worker Setup Complete"
echo "======================================"
echo "Test queue worker with:"
echo "php artisan queue:push TestJob"
echo ""
echo "Use check:"
echo "ps aux | grep queue"
echo ""
echo "Test API access from Worker:"
echo "curl http://<Elendil-IP>/api/airing"
echo "lynx http://<Elendil-IP>"
echo "======================================"
