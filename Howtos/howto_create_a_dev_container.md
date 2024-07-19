---
layout: default_c
RefPages:
 - howto_create_a_dev_container
 - howto_create_a_swarm
 - howto_install_other_PHP_versions
 - howto_steps_for_debugging
--- 


<small>
_This file is part of: **PHP Development Template Stack**_
_Copyright (c) 2024 Nico Jan Eelhart_
_This source code is licensed under the MIT License found in the  'LICENSE.md' file in the root directory of this source tree._
</small>
<br><br><br>

# 1. Create and start a simple developer container
This section describes how to start the PHP developer container. If you want to experiment with a swarm (create, initialize, and run different containers), refer to the document: [***How to Create a Swarm***](Howto_Create_A_Swarm)


> #### Background context
>Because the compose file is a bit different for a swarm and a simple container, there are two compose files:
>- The ***compose_php_swarm.yml***	<br>for the Swarm used as described in 'Howto_Create_A_Swarm.md'
>- And the ***compose_apache_php_cont.yml*** <br>For this simple container as described here
>
>This affects the docker compose command; you need to use the -f flag to specify the compose file's name (note that Docker is picky about >the order in which the command is specified).
>
>
>Also, because the **compose_apache_php_cont.yml** uses ***bind mount*** instead of a ***Volume***, we need to use a slightly different Dockerfile (***Dockerfile_php_cont***). This is because the entrypoint calling is different. Note that this Dockerfile is explicitly called in the ***compose_apache_php_cont.yml***.
>

>
> ```
> # Instead of this
> build:.
>
> # This is used
> context: .
> dockerfile: Dockerfile_python_cont	    
>```

 
## 1.1 To Create & Start the container (Docker Desktop)
To start the container in docker Desktop execute this command from the **ApachePHPWebService**  directory:  
```
docker  compose -f compose_apache_php_cont.yml up -d
# To rebuild an existing container avoid caching issues, you can use:
docker-compose -f compose_apache_php_cont.yml up -d --build --force-recreate
```

**Test if running with:**
-	[http://localhost:8071/phpinfo.php](http://localhost:8071/phpinfo.php)
-	[http://localhost:8071/index.php](http://localhost:8071/index.php) 

**Location of files in container**
Files can be found
- */usr/local/apache2/htdocs/public*{: style="color: #2879d0; "}
- */usr/local/apache2/htdocs/public*{: style="color: #2879d0; "}

**mount bind location on host**
- *..\ApachePHPWebService\app*{: style="color: #2879d0; "}

----

### 1.2.1 Add PHPUnit to the image (Add-on)
Optional you can add the PHPunit test framework to the image, after executing the commands in the previous paragraph execute  this command: ( again in the **[name]Service**  directory)  
```                                       
docker  compose -f compose_UnitTest_Addon.yml up -d  --remove-orphans --build --force-recreate
```


When this is done the following commands(in the container) should return the phpunit and composer versions 

```
phpunit --version		# returns version phpunit
composer -V			# returns vcersio composer
``` 

```
# In case the phpunit --version command returns not found, do this
RUN echo 'export PATH="/root/.config/composer/vendor/bin:$PATH"' >> ~/.bashrc \
    && . ~/.bashrc
```

**Test if running with:**
-	[http://localhost:8071/phpinfo.php](http://localhost:8071/phpinfo.php)
-	[http://localhost:8071/index.php](http://localhost:8071/index.php) 

----

# 2. Develop and debug in Visual Studio Code
- Open VSC and press the docker Icon(left sidebar)
- Right Click on your container and choose "Attache Visual Studio Code" a new VSC Window opens that is mapped the container
- Choose: Open folder and select the folder ***/usr/local/apache2/htdocs***
- For debug installation/configuration see the howto file: [howto_steps_for_debugging](howto_steps_for_debugging)
