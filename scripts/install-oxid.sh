#!/usr/bin/env zsh
set -e
set -o allexport
source ./docker/.env
set +o allexport

MYSQL_HOST=mysql.${HOSTNAME}

# bootstrap oxid files/project
if [ ! -f /var/www/html/source/config.inc.php ]
then
	composer create-project --no-dev oxid-esales/oxideshop-project ${HOSTNAME} ${OXID_VERSION}
  mv ${HOSTNAME}/*(D) /var/www/html/
	rm -rf ${HOSTNAME}
	mv /var/www/config.inc.php /var/www/html/source/config.inc.php
	# chown -R www-data:www-data /var/www/html/source/
	chmod 777 /var/www/html/source/log /var/www/html/source/tmp
	echo "***OXID project installed***"
else
	echo "---OXID already installed---"
fi

# bootstrap oxid database/demodata
echo "Setting up database"
MYSQL_CHECKDATA=`mysql -h ${MYSQL_HOST} -u ${MYSQL_USER} -p${MYSQL_PASSWORD} ${MYSQL_DATABASE} --skip-column-names -e "SHOW TABLES FROM ${MYSQL_DATABASE} LIKE 'oxconfig';"`
if [ "${MYSQL_CHECKDATA}" = "" ]
then
    mysql -h ${MYSQL_HOST} -u ${MYSQL_USER} -p${MYSQL_PASSWORD} ${MYSQL_DATABASE} < /var/www/html/source/Setup/Sql/database_schema.sql
    mysql -h ${MYSQL_HOST} -u ${MYSQL_USER} -p${MYSQL_PASSWORD} ${MYSQL_DATABASE} -e "UPDATE oxshops SET OXSMTP = 'mail.server:1025', OXSMTPUSER = '', OXSMTPPWD = '' WHERE oxid = 1;"
		echo "***Database created***"
    echo -n "Demodata? (y/n)? "
    read answer

    if [ "$answer" != "${answer#[Yy]}" ] ;then
          mysql -h ${MYSQL_HOST} -u ${MYSQL_USER} -p${MYSQL_PASSWORD} ${MYSQL_DATABASE} < /var/www/html/vendor/oxid-esales/oxideshop-demodata-ce/src/demodata.sql
          rm -rf /var/www/html/source/Setup/
					echo "***Demodata inserted***"
    fi
    /var/www/html/vendor/bin/oe-eshop-db_views_regenerate
else
	echo "---Database already exists---"
fi
echo "***Setup complete***"
