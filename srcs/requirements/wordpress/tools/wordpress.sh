#!/bin/bash
sed -i "s/listen = \/run\/php\/php7.4-fpm.sock/listen = 0.0.0.0:9000/g" /etc/php/7.4/fpm/pool.d/www.conf
rm -rf *
if [ ! -f /var/www/html/wordpress/wp-config.php ]; then
	wp core download --allow-root
	wp config create --allow-root --dbname=${SQL_DATABASE} --dbuser=${SQL_USER} --dbpass=${SQL_ROOT_PASSWORD} --dbhost=mariadb:3306 --dbcharset="utf8" --dbcollate="utf8_general_ci" --path="/var/www/html/wordpress"
	echo ------------------------------------------
	wp core install --url=${WORDPRESS_URL} --title=${WORDPRESS_URL} --admin_user=${WORDPRESS_ADMIN} --admin_password=${WORDPRESS_PASSWORD} --admin_email=${WORDPRESS_EMAIL} --allow-root
	echo ------------------------------------------
	wp user create ${WORDPRESS_USER} ${WORDPRESS_USER_MAIL} --role=${WORDPRESS_USER_ROLE} --user_pass=${WORDPRESS_USER_PASSWORD} --allow-root
	wp plugin update --all --allow-root
else
	echo "Wordpress is already installed"
fi
chown -R www-data:www-data /var/www/html/wordpress
/usr/sbin/php-fpm7.4 -F
