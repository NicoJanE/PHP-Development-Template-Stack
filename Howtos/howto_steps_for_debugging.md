---
layout: default_c
RefPages:
 - howto_create_a_dev_container
 - howto_create_a_swarm
 - howto_install_other_PHP_versions 
 - howto_steps_for_debugging
--- 

<small>
<br><br>
_This file is part of: **PHP Development Template Stack**_
_Copyright (c) 2024 Nico Jan Eelhart_
_This source code is licensed under the MIT License found in the  'LICENSE.md' file in the root directory of this source tree._
</small><br><br><br>

# Adding debug support.
When you want your application to support debugging, these are the instructions to install **XDebug** to work together with **Visual Studio Code**

## 1.1 How to get the right XDebug files
- ***php -v*** to get php version
- ***cat /etc/*-release*** Get distribution and version
- Install Xdebug(should be done, check! if incorrect repeat manually:
-- apt-get update
-- apt-get install software-properties-common
-- apt-get update
-- apt-get install php8.2-xdebug 
-- php --version ***Should now also state 'with Xdebug'*** then it is success!
-- Restart the docker container

----

## 1.2 Configure php.ini 
- Get active php.ini location 
-- http://localhost:8071/phpinfo.php and look for php.ini (currently 	/etc/php/8.2/fpm/php.ini)
- Add the following to the php.ini (on the bottom) use ***nano php.ini***

```
; Enable Xdebug extension module
zend_extension=xdebug.so

[xdebug]
xdebug.mode = debug, develop		; off, develop, gcstats, profile, trace diagnostics
xdebug.start_with_request = yes		; the above off is not enough to turn it off this also must be st to 'no' !
; For Windows/Mac
; xdebug.client_host = host.docker.internal  
; For Linux, replace with the actual host IP (hostname -i)
xdebug.client_host = 172.21.0.2 ; hostname -i

xdebug.client_port = 9003
xdebug.log = /tmp/xdebug.log
```
- Make sure the port 9003 is set in the docker file(by default it is, when changing the port change also in compose file!) ***ports: - "9003:9003" 
- Test if running with: http://localhost:8071/phpinfo.php *This may return a connection was reset* This means the debugger is running! to disable the debugger:
- In php.ini Set the 'xdebug.mode=off' 
- In php.ini Set the 'xdebug.start_with_request = no' 
when this is done debugging is ignored and you should see a response.

----

## 1.3 Config VSC
- add 'PHP Debug' extentsion
- Run debug -> create launch,json file
- Contents:
```
    // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
    "version": "0.2.0",
    "configurations": [

        {
            "name": "NJE Listen for Xdebug",
            "type": "php",
            "request": "launch",
            "port": 9003,
            "pathMappings": {
                "/usr/local/apache2/htdocs/public": "${workspaceFolder}"
            }
        }
```
