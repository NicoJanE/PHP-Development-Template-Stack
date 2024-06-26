_This file is part of: PHP Development Template Stack_
_Copyright (c) 2024 Nico Jan Eelhart_

_This source code is licensed under the MIT License found in the  'LICENSE.md' file in the root directory of this source tree._
<br><br>

# 1. Create and start a simple developer container
This describes how to start the PHP developer container. If you want to experiment with a swarm (create, initialize and run different containers) refer to the document: ***Howto_Create_A_Swarm.md*** 

## 1.1 Background context
You can skip this and directly refer to the "Start the container" section if you just want to start going.

Because the compose file is a bit different for a swarm and a simple container, there are two compose files:
- The ***compose_php_swarm.yml***	<br>for the Swarm used as described in 'Howto_Create_A_Swarm.md'
- And the ***compose_apache_php_cont.yml*** <br>For this simple container as described here

This has consequences for the calling of the: docker compose Command one has to use the -f flag to indicate the name of the compose file(be-aware that docker is picky about the order in which the command is specified)


Also because the **compose_apache_php_cont.yml** uses ***bind mount*** instead of a ***Volume*** we need to use a slightly different docker file (***Dockerfile_php_cont***) this is because the entrypoint calling is different. Also note that this Dockerfile_Apache_PHP_cont file is explicitly called in the: ***compose_apache_php_cont.yml***


Instead of this<br>
```
build:.
```


This is used:<br>
```     
build: 	    
context: .
dockerfile: Dockerfile_python_cont	    
```

 
## 1.2 To Create & Start the container(Docker Desktop)
To start the container in docker Desktop execute this command from the **[name]Service**  directory:  
```
docker  compose -f compose_apache_php_cont.yml up -d
```
To rebuild an existing container avoid caching issues and use:<br>
```
docker-compose -f compose_apache_php_cont.yml up -d --build --force-recreate
```

Test if running with: http://localhost:8071/phpinfo.php


### 1.2.1 Add PHPUnit to the image
Optional you can add the PHPunit test framework to the image, after executing the commands in the previous paragraph execute  this command: ( again in the **[name]Service**  directory)  
```                                       
PS D:\docker\Containers and swarm templates\PHP Development Template Stack\ApachePHPWebService> docker  compose -f compose_UnitTest_Addon.yml up -d  --remove-orphans --build --force-recreate
```
I had some issue with orphans why that's we that is included
After this you have to manual execute the command below. while it is also part of the file: 'Docker_UnitTest_Addon' it seems not to be executed!

```
RUN echo 'export PATH="/root/.config/composer/vendor/bin:$PATH"' >> ~/.bashrc \
    && . ~/.bashrc
```

When this is done the following command should return the phpunit version (without the above command it phpunit can not be found)

```
phpunit --version		# returns version phpunit
composer -V				# returns vcersio composer
``` 

Test if running with: http://localhost:8071/phpinfo.php

# 2. Develop and debug in Visual Studio Code
- Open VSC and press the docker Icon(left sidebar)
- Right Click on your container and choose "Attache Visual Studio Code" a new VSC Window opens that is mapped the container
- Choose: Open folder and select the folder ***/usr/local/apache2/htdocs***
- For debug installation/configuration see the file: ***Steps to add Debugging.md***
