# Docker OXID eShop 6.2
This setup bootstraps an dockerized developer environment for [OXID eShop 6](https://github.com/OXID-eSales/oxideshop_ce).

***only for dev purposes***

## Overview

- Apache 2.4 container PHP 7.4 ([Dockerfile](container/apache_php7/Dockerfile))
- MySQL 5.7 container ([Dockerfile](https://github.com/docker-library/mysql/blob/883703dfb30d9c197e0059a669c4bb64d55f6e0d/5.7/Dockerfile))
- MailHog container ([Dockerfile](https://github.com/mailhog/MailHog/blob/master/Dockerfile))
- phpMyAdmin container ([Dockerfile](https://hub.docker.com/r/phpmyadmin/phpmyadmin/~/dockerfile/))
- OXID composer project [dev-b-6.2-ce] ([6.2.0](https://github.com/OXID-eSales/oxideshop_ce/blob/v6.2.0/composer.json))
- OXID demo data

## Quickstart
1. Create your project folder
```bash
mkdir myproject
cd myproject
```
2. Clone project to docker directory in your project.
```bash
# clone repository:
git clone --depth=1 https://github.com/ivoba-oxid/docker-oxid6.git ./docker && rm -rf ./docker/.git
```
3. Copy and edit the .env file for your needs
```bash
cp docker/.env.dist docker/.env
```
4. Startup containers
```bash
cd docker
# create containers and log into web container
./docker.sh -l
```
5. Install Oxid Shop from inside the container
```bash
./docker/scripts/install-oxid.sh
```
6. Run OXID shop
- Shop: `http://localhost:8012` or whatever port is set in APACHE_PORT
- Shop admin `http://localhost:8012/admin/`, credentials: `admin / admin`
- MailHog: `http://localhost:8025`
- phpMyAdmin: `http://localhost:8080`

## Usage

For development start up the containers:

    cd docker
    ./docker.sh -l

You will be automatically logged in to the PHP container.  
Then you can run all cli commands inside the container.  
For example all composer commands when installing new modules or oxid commands like `vendor/bin/oe-console oe:module:activate`.  
You will not run into permission problems then.  

## Enabling xDebug in phpStorm
- Add Configuration
- PHP Remote Debug
- IDE key: XDEBUG_IDEA
- Server: add new server:  
  localhost:8012 - Xdebug  
  use path mappings, Absolute path on the server: var/www/html
- In phpStorm: Start listening for PHP Debug Connections
- In browser: start debug session by adding the XDEBUG_IDEA param to URL or cookie.
   
### Data
- Data (`www` and `mysql`) is stored on host: `docker/data` directory

### Credentials
- You can change all credentials (domain, ports, database, ...) in `docker/.env` file.

### Todo
- zsh oxid shortcuts
- https

## License

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.


## Credits

	This setup is based on:  

- https://github.com/proudcommerce/docker-oxid6
- https://github.com/nerdpress-org/docker-sf3
