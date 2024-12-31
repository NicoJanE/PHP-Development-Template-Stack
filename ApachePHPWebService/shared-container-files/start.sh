#!/bin/bash
#
# This file is part of: PHP Development Template Stack 
# Copyright (c) 2024 Nico Jan Eelhart
#
# This source code is licensed under the MIT License found in the  'LICENSE.md' file in the root directory of this source tree.
#
echo "Starting and running the script for running Apache2 with PHP in the background"

/usr/sbin/php-fpm8.2 -F & 
# Use other PHP version FPM
# /usr/sbin/php-fpm5.6 -F & 

# No clue why 'apache2ctl 'is not in the image anymore :(
    # /usr/sbin/apache2ctl -f /usr/local/apache2/conf/httpd.conf -D FOREGROUND\n

# WARNING
# Must run in foreground to be primary process in docker!, otherwise communication between PHP-FPM and Apache may break
/usr/local/apache2/bin/httpd -f /usr/local/apache2/conf/httpd.conf -D FOREGROUND


echo "Apache2 PHP startup script is executing"
