# Symfony PHP

Assuming you have installed the container

## Installation

1. Navigate to the project directory or open this project site in the container, for example with VSC: ***/usr/local/apache2/htdocs/symfony-apps/wiki-store***
2. Document root is set to: ***/usr/local/apache2/htdocs/symfony-apps/wiki-store/public*** by default
3. Configuration files:
	- ***/usr/local/apache2/conf/extra/httpd-vhosts.conf*** <br>(document root)
	- ***/etc/php/8.2/cli/php.ini***
	- ***/etc/php/8.2/fpm/php-fpm.conf***
	- ***/var/log/php8.2-fpm.log*** FPM log
4. Sites:
	- `http://localhost:8071/phpinfo.php`
	- `http://localhost:8071`  -> Site I Symfony (This)
	- `http://localhost:8071/raw-app/`  -> Site II Raw Php	


<br>

>  **Composer** <br>	
>  Run `composer install` to install dependencies.
	install composer zie link: https://www.how2shout.com/linux/steps-for-installing-php-composer-on-debian-12-bookworm-linux/
	fix name in composer (lekker/watErStond)
	exec composer install
   This reads the composer.json file, to manage PHP dependencies;  name auto loading and others.	

<br>


## License

This project is licensed under the MIT License.