apt update
apt install -y lsb-release apt-transport-https ca-certificates wget
wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list
deb https://packages.sury.org/php/ trixie main

apt update
apt install php8.0-mbstring php8.0-xml php8.0-cli php8.0-common php8.0-intl php8.0-opcache php8.0-readline php8.0-mysql php8.0-fpm php8.0-curl unzip wget -y
apt install nginx -y

wget https://getcomposer.org/download/2.0.13/composer.phar
chmod +x composer.phar
mv composer.phar /usr/bin/composer

apt install git -y

mkdir -p /var/www
cd /var/www

git clone https://github.com/elshiraphine/laravel-simple-rest-api.git

cd laravel-k39
composer install

php artisan migrate:fresh
php artisan db:seed --class=AiringsTableSeederphp
php artisan key:generate

#test
ls /var/www/laravel-k39
cat .env | grep DB_
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=laravel
DB_USERNAME=root
DB_PASSWORD=

php -v
composer -v



