_This file is part of: PHP Development Template Stack_
_Copyright (c) 2024 Nico Jan Eelhart_

_This source code is licensed under the MIT License found in the  'LICENSE.md' file in the root directory of this source tree._
<br>

# Creation of the Apache 2.4 with PHP 8.2 and PHP-FPM image.
Start with Apache 2.4.59 image: httpd:bookworm which is a Debian 12 Bookworm Linux image

1. ***Create the container with:***
```docker-compose -f compose_php_cont.yml up -d --build --force-recreate```
<br>Besides the Apache2 software we also install the following:
- nano
- PHP 8.2
- PHP -FPM a fast CGI Process Manager for PHP extensions
These are installed because the ***compose_php_cont.yml*** calls the ***Docker Apache_cont*** which has a install section were these are, yes, installed (see comment along INSTALL in the docker file).<br><br> You can use the following commands in the container to check the installation
```cat /etc/os-release  # Get version info```
```apcahe2 -v			# Get Apache version```
```apache2 status 		# running, error...```

2. ***Apache2 config and PHP-FPM configuration***
<br><br>2.1 Enable Apache2 modules/libraries
Get default ***httpd.conf*** file from apcahe2 and place it in the Service(app) directory. Make sure the following modules are ***enabled*** (needed for PHP-FPM) (The libraries should be part of the Apache2 release), there are also commands available but we just manually change the config file(always restart Apache after a change)
```LoadModule proxy_module modules/mod_proxy.so```
```LoadModule proxy_fcgi_module modules/mod_proxy_fcgi.so```
```LoadModule setenvif_module modules/mod_setenvif.so			# Was already enabled```
<br><br>2.2 In the copied ***httpd.conf*** file enable this line:
``` Include conf/extra/httpd-vhosts.conf ```
This enables virtual host which we going to create for our website, it will be configured here with PHP-FPM. One of the  advantages is that all configuration is done in the Virtual Host(VH). You can create multiple VH's even on the same port as long the  ***servername*** is different, anyway the file must contain this (read the comments in the file)
```
<VirtualHost *:80>
    ServerName localhost
    DocumentRoot /usr/local/apache2/htdocs/public
    <FilesMatch \.php$>
		# Check were your socked is running here with: ls -l /run/php/php8.2-fpm.sock
		# it is part of the FPM config file: nano /etc/php/8.2/fpm/pool.d/www.conf
		# In that file a line like: listen = /run/php/php8.2-fpm.sock
		# holds the directory, if this is different change the line below accordingly 
        SetHandler "proxy:unix:/run/php/php8.2-fpm.sock|fcgi://localhost/"
    </FilesMatch>
   <Directory /usr/local/apache2/htdocs/public>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
```
3. Test
**Call: http://localhost:8071/index.php**
**Call: http://localhost:8071/index.html**

<br><br>
## File responsibilities
In step 1 'Create the container with'  the compose_php_cont.yml is called which calls the docker file 'Dockerfile_php_cont'

### Responsibilities
- 	Compose file<br>
	The compose file, calls\takes care of: 
	- The docker file(see below), 
	- Sets up the network, ports 
	- The volumes. The volumes are bind volumes which are part of the project on the host, so these files can be changed on the host and in the container. In this container we bind to:
		- the **httpd.conf file** for Apache settings, 
		- the **httpd-vhosts.conf** to setup our virtual host for the App,
		- the **start.sh** This is the important container startup script, it start Apache(httpd) and the PHP-FPM CGI manager to handle PHP extensions in our website. both are running in the background
		- and last we bind to the **app** folder(into htdocs) were these document files are and the docker files and the whole App directory.
	- It make sure the **start.sh** script is **executed** when container starts(entrypoint) <br><br>
-	Docker file<br>
	The Docker file(Dockerfile_Apache_cont), calls\takes care of
	- pulls in the httpd bookworm (Debian 12)image
	- After the above image is setup, it installs the additional required software(PHP, php-fpm and others)
	- Defines the host ports which are exposed

