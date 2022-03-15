#!/bin/bash
wget "https://launchpad.net/libmemcached/1.0/1.0.18/+download/libmemcached-1.0.18.tar.gz"
tar -zxf libmemcached-1.0.18.tar.gz
cd libmemcached-1.0.18
sudo mkdir /opt//bitnami/common
sudo chmod 777 /opt/bitnami/common/
./configure --prefix=/opt/bitnami/common/
make
sudo make install
export PHP_AUTOCONF=/usr/bin/autoconf
export PHP_PREFIX=/opt/bitnami/php
cd ~/
git clone https://github.com/php-memcached-dev/php-memcached.git
cd php-memcached
git checkout php7
/opt/bitnami/php/bin/phpize
sudo apt-get install pkg-config
./configure --enable-memcached --with-libmemcached-dir=/opt/bitnami/common --with-php-config=/opt/bitnami/php/bin/php-config --disable-memcached-sasl
make
sudo make install
echo 'extension=memcached.so' | sudo tee -a /opt/bitnami/php/etc/php.ini
php -m | grep memcached
