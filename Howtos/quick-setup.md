---
layout: default_c
RefPages:
 - howto_create_a_dev_container
--- 

# PHP Development   <span style="color: #409EFF; font-size: 0.6em; font-style: italic;"> -  Docker & Swarm Container</span>
<span style="color: #409EFF; font-size: 0.95em; font-style: italic; margin-top: -30px; display: block;">Quick Setup Guide</span>

![MIT License](https://img.shields.io/badge/License-MIT-green) ![Commercial Services Available](https://img.shields.io/badge/Services-Optional-blue)


## Introduction


This is the quick setup for the ***PHP developer stack container*** consists of a **Base Container** and several **Sub Containers**. **The Base Container** is required for any **Sub Container**. The **Sub Containers** contain the development environments for the template application projects running on Linux.

#### Available container

| ***Container name***                | ***Description*** |
|:-----------------                   |:----------------|
| compose_apache_php_cont             | The basic container, includes Symfony     
| compose_UnitTest_Addon.yml          | Adds composer abd PHP unit test |
| compose_apache_php_swarm            | Creates the container as a swarm, example of swarm   |



### 1 Setup steps

These are the quick setup steps for the ***PHP developer stack container***.
If you have previously installed this (or a similar) container, you can use these setup step, otherwise please first read the main documentation page [howto_create_a_dev_container](Howtos/howto_create_a_dev_container.md).

>**Consider Project setup and external network** <br>
>If your application requires other independent Docker containers (such as a database), consider using an **external network**. This allows your Docker Compose setup to communicate with other standalone containers within the same network.
For an example, see my document ***project-setup.md***, which covers this in detail. Additionally, my GitHub repository includes a section with specialized Docker templates, which I have named **Docker-Template-Plugin-Stacks**. (**todo soon**)

<br>

1) **Create docker base PHP container**{: style="color:green; "} <br>
Enter the sub directory ***./ApachePHPWebService***. Open a command prompt and  use the following to create the basic docker base container, on which the sub-containers depends on
 <pre class="nje-cmd-one-line">docker-compose -f compose_apache_php_cont.yml up -d --build --force-recreate --remove-orphans </pre>
 
 <span class="nje-ident"></span> *Expected results:*{: style="color: green;font-size:12px; "} 
 <small>
 This will create a basic PHP project structure which you can develop future local in the host or in the container it self
 <br><span class="nje-ident" style="--nje-number-of-spaces: 40px;"></span>**&#9830;** In docker a new service called: **apachephpwebservice**, <br>
 <span class="nje-ident" style="--nje-number-of-spaces: 55px;"></span> &#176; Start it!
 <br><span class="nje-ident" style="--nje-number-of-spaces: 40px;"></span>**&#9830;** [This](http://localhost:8071/phpinfo.php) page should display the **PHP info page**
 <br><span class="nje-ident" style="--nje-number-of-spaces: 40px;"></span>**&#9830;** [This](http://localhost:8071) page should display the **PHP Symfony application(Website I)** In case of an **error** you have to run `composer install` **first** from: **/htdocs/symfony-apps/wiki-store**
 <br><span class="nje-ident" style="--nje-number-of-spaces: 40px;"></span>**&#9830;** [This](http://localhost:8071/raw-app) page should display the **PHP Raw app (website II)**
 <br><span class="nje-ident" style="--nje-number-of-spaces: 40px;"></span>**&#9830;** The Apache2 **Document root** can be adjusted here: ***/usr/local/apache2/conf/extra/httpd-vhosts.conf***
 <br><span class="nje-ident" style="--nje-number-of-spaces: 55px;"></span>**&#176;** Current **document root/source** at: ***/usr/local/apache2/htdocs/***
 <br><span class="nje-ident" style="--nje-number-of-spaces: 55px;"></span>**&#176;** make sure it has the www-data owner and permissions `chown -R www-data ./htdocs` and `chmod -R 755 ./htdocs`
 <br><span class="nje-ident" style="--nje-number-of-spaces: 55px;"></span>**&#176;** To create a project use: `symfony new projectname` and set  the Document root to the public directory created, and set the www-data owner and permissions.
 <br><span class="nje-ident" style="--nje-number-of-spaces: 55px;"></span>**&#176; After that copy the `/usr/local/apache2/htdocs/.htaccess` file to the new public root directory (restart)
 <br><span class="nje-ident" style="--nje-number-of-spaces: 55px;"></span> &#176; a bind mount to that folder, local, can be found in the ./ApachePHPWebService/app/
 <br><span class="nje-ident" style="--nje-number-of-spaces: 40px;"></span>**&#9830; A general bind mount folder, local, can be found at: ***/usr/local/ApachePHPWebService/shared-host*** Which is known at the server as: **/shared-host**
 </small> 
<br> <br>

>  Additional Docker commands for your convience 
> - Container info:<br> `docker ps`
> - Stop the container:<br> `docker stop [container id]`
> - Start the container:<br> `docker compose -f compose.yaml up -d `
> - Error and access log: <br>`docker logs -f <container id>	`
> - Filter Log:<br> `docker logs -f <container id 2>&1 | grep "error" `


<br><br>

2) **Create sub-container: PHP package manager & PHP UnitTest**{: style="color:green; "} <br>
Adds the **composer** package  manager and the PHP Unit tests framework. Enter the sub directory ***./ApachePHPWebService*** and open a command prompt and use the following command
<pre class="nje-cmd-one-line">docker  compose -f compose_UnitTest_Addon.yml up -d  --remove-orphans --build --force-recreate --remove-orphans  </pre>

 <span class="nje-ident"></span> *Expected results:*{: style="color: green;font-size:12px; "} 
 <small>
 <br><span class="nje-ident" style="--nje-number-of-spaces: 40px;"></span>**&#9830;** Open a CLI in the container and execute:
 <pre class="nje-cmd-one-line-sm-ident" style="--nje-ident: 60px;">phpunit --version		# Should return version of Phpunit</pre>
 <pre class="nje-cmd-one-line-sm-ident" style="--nje-ident: 60px; --nje-vmove: 5px;">composer -V		        # Should return version of Composer</pre>
  </small>
<br>

3) **Create sub-container: Add Python front-end using pySide6 (Qt)**{: style="color:green; "} <br>
Adds Python with PySide 6 (Qt Based to the container)
Enter the sub directory ***./ApachePHPWebService*** and open a command prompt and use the following command
<pre class="nje-cmd-one-line">docker  compose -f compose_python_frontend_addon.yml up -d  --remove-orphans --build --force-recreate  </pre>

<span class="nje-ident"></span> *Expected results:*{: style="color: green;font-size:12px; "} 
 <small>
 <br><span class="nje-ident" style="--nje-number-of-spaces: 40px;"></span>**&#9830;** Open a CLI in the container and execute:
 <pre class="nje-cmd-one-line-sm-ident" style="--nje-ident: 60px;">python3 --version && pip3 show PySide6  # Should display Python and pyside information</pre>
 </small>
 <br>





4) **Configure and start the sub container in Visual Studio Code (VSC)**{: style="color:green; "}<br>
After this you should be able to open the container in VSC and start developing, you can do this local or by attaching to the container in VSC

**VSC In the container**
- Open VSC 
- Select the Docker tab and select the container ***'apachephpwebservice-webserver-apache-php'*** right click 'attach Visual Studio Code'
- In VSC choose: 'open folder' and select the directory **'/usr/local/apache2/htdocs'***, This should open your PHP project in the container
- You can create a new symphony project with `symfony new my_api_project`, make sure to set the **Document root** to the public folder of the new created project, probably you also need a .htaccess file. 

**VSC local**
- Open VSC 
- In VSC choose: 'open folder' and select your project directory this will open your PHP project locally.



> **More information!**{: style="color:#5491fa;font-size:13px; "} <br>
<small>
See the main documentation page [how to create a development container](howto_create_a_dev_container). Which explains the installation of the *Base Container* and any available *Sub Containers* in more details.
</small>
<br>

<span style="color: #6d757dff; font-size: 13px; font-style: italic;">
<i><b>License</b><br>This file is part of: **PHP Development Template Stack**  Copyright (c) 2025-2026 Nico Jan Eelhart.This repository is [MIT licensed](../MIT-license.md) and free to use. For optional commercial support, customization, training, or long-term maintenance, see [COMMERCIAL.md](../COMMERCIAL.md).</i>
</span>

<br><br>
<p align="center">─── ✦ ───</p>
