#!/usr/bin/env bash
set -e

# bootstrap oxid files/project
if [ ! -f /var/www/html/source/config.inc.php ]
then
	composer create-project --keep-vcs oxid-esales/oxideshop-project . ${OXID_VERSION}
	mv /var/www/config.inc.php /var/www/html/source/config.inc.php
	chown -R www-data:www-data /var/www/html/source/
	chmod 777 /var/www/html/source/log /var/www/html/source/tmp
	echo "#####################################"
	echo "##### OXID bootstrap completed! #####"
	echo "#####################################"
fi
