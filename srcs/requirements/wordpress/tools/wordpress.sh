# !/bin/bash
#
#sed -i "s/listen = \/run\/php\/php7.4-fpm.sock/listen = 0.0.0.0:9000/g" /etc/php/7.4/fpm/pool.d/www.conf

if [ ! -d "/var/www/html/wordpress" ]; then
	mkdir -p /var/www/html/wordpress
	chmod 777 -R /var/www/html/wordpress
fi

cd /var/www/html/wordpress
rm -rf /var/www/html/wordpress/*
#if [ ! -f /var/www/html/wordpress/wp-config.php ]; then

wp core download --allow-root

wp config create --allow-root --dbname=${SQL_DATABASE} --dbuser=${SQL_USER} --dbpass=${SQL_PASSWORD} --dbhost=mariadb:3306 --dbcharset="utf8" --dbcollate="utf8_general_ci" --path="/var/www/html/wordpress/"

echo ------------------------------------------

wp core install --allow-root --url=${WORDPRESS_URL} --title=${WORDPRESS_URL} --admin_user=${WORDPRESS_ADMIN} --admin_password=${WORDPRESS_PASSWORD} --admin_email=${WORDPRESS_MAIL}

echo ------------------------------------------

wp user create --allow-root ${WORDPRESS_USER} ${WORDPRESS_USER_MAIL} --role=${WORDPRESS_USER_ROLE} --user_pass=${WORDPRESS_USER_PASSWORD}

wp --allow-root theme install astra --activate

wp --allow-root plugin update --all

ln -s $(find /usr/sbin -name 'php-fpm*') /usr/bin/php-fpm

#else

#echo "Wordpress is already installed"

#fi
#chown -R www-data:www-data /var/www/html/wordpress

exec /usr/bin/php-fpm -F
