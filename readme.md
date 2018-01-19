# Docker OXID eShop 6
This setup bootstraps an dockerized developer environment for [OXID eShop 6](https://github.com/OXID-eSales/oxideshop_ce).

**Currently WIP !!**

## Overview

- Apache 2.4 container PHP 7.1 ([Dockerfile](container/apache_php7/Dockerfile))
- MySQL 5.7 container ([Dockerfile](https://github.com/docker-library/mysql/blob/883703dfb30d9c197e0059a669c4bb64d55f6e0d/5.7/Dockerfile))
- MailHog container ([Dockerfile](https://github.com/mailhog/MailHog/blob/master/Dockerfile))
- phpMyAdmin container ([Dockerfile](https://hub.docker.com/r/phpmyadmin/phpmyadmin/~/dockerfile/))
- OXID composer project [dev-b-6.0-ce] ([6.0.0](https://github.com/OXID-eSales/oxideshop_ce/blob/v6.0.0/composer.json))
- OXID demo data

## Quickstart
1. Install [docker enginge](https://docs.docker.com/engine/installation/)
2. Fire up container
```bash
# clone repository:
git clone https://github.com/ivoba-oxid/docker-oxid6.git docker_oxid6
cd docker_oxid6/docker
# create containers and log into web container
./docker.sh -l
```
You probably have to add the domain to your /etc/hosts

    127.0.0.1       oxid6.localhost

## Configuration
### Installation
- Creating oxid project takes round about 5 minutes. It´s finished when docker log shows `OXID bootstrap completed!`).
- Shop: `http://oxid6.localhost`
- Shop admin `http://oxid6.localhost/admin/`, credentials: `admin / admin`
- MailHog: `http://oxid6.localhost:8025`
- phpMyAdmin: `http://oxid6.localhost:8080`


### Data
- Data (`www` and `mysql`) is storend on host: `data` directory

### Credentials
- You can change all credentials (domain, ports, database, ...) in `.env` file.

### OXID demo data
- Normally oxid demo data will be installed automatically.
- If you need a project without demo data, set `OXID_DEMODATA=false` in `.env` file.

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
