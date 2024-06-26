_This file is part of: PHP Development Template Stack_
_Copyright (c) 2024 Nico Jan Eelhart_

_This source code is licensed under the MIT License found in the  'LICENSE.md' file in the root directory of this source tree._
<br><br>

# Add other PHP versions into this container
In the docker file ***Dockerfile_Apache_PHP_cont*** we have include the PHP repository for other PHP versions, see the comment:
- '2) INCLUDE repositories for other PHP versions' in that file.

Here the step are described to install another PHP version which depends on that repository. Note that we also need the related PHP fpm package.


## Requirements
- A running container created with the Docker compos file: **compose_apache_php_cont.yml** (which uses: 'Dockerfile_Apache_PHP_cont'). See file: ***howto_create_A_dev_container.md***
- The bind mounted folders which should be there when you have a running container.

## Steps to install an additional PHP version
Let's assume you want to add PHP 5.6 (that's old, time to upgrade your site perhaps) to the container.
- Check if the version is in the repository
```apt-cache search php5.6```
- Install it, if the above command returns it
```apt update  && apt install -y php5.6 php5.6-fpm```
- Update the ***start.sh*** shell script, this is mounted (bind) in the folder 'shared-container-files' at the host, you can therefor update in the Host or in the container (for the location see the docker file: Dockerfile_Apache_PHP_cont) Edit the file(Unix EOL) and make sure the line with:
-- **/usr/sbin/php-fpm8.2 -F &** is changed  to:
-- **/usr/sbin/php-fpm5.6 -F &** (change the numbers to to the version you require) <br><br>
- Update the ***httpd-vhosts.conf*** shell script, this is mounted (bind) in the folder 'shared-container-files' at the host. Edit the file(Unix EOL) and make sure the line with:
-- **SetHandler "proxy:unix:/run/php/php8.2-fpm.sock|fcgi://localhost/"** is changed to:
-- **SetHandler "proxy:unix:/run/php/php5.6-fpm.sock|fcgi://localhost/"** 
(You could 1e check if the file: /run/php/php5.6-fpm.sock this should be done by the php5.6-fpm package) <br><br>
- While this should be enough you can also execute the following command, to make sure the shell command 'php -v' will return(and thus uses) your installed version
```update-alternatives --set php /usr/bin/php5.6 # use which php5.6 to find this location```   
- Restart the container (restart Apache2 is not sufficient!)   


Test: http://localhost:8071/phpinfo.php

<br>

^_Tested with PHP 8.2 and PHP 5.6, Versions in between are not tested but should work, although it's PHP, so 'you never can tell'_^ 