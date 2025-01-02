---
layout: default_c
RefPages:
 - howto_create_a_dev_container
--- 

<small>
<br>
_This file is part of: **PHP Development Template Stack**_
_Copyright (c) 2025 Nico Jan Eelhart_
_This source code is licensed under the MIT License found in the  'LICENSE.md' file in the root directory of this source tree._(_last update: 02 jan. 2025_)
</small>
<br><br>

# Quick Setup
This is the quick setup for the ***PHP developer stack container*** consists of a **Base Container** and several **Sub Containers**. **The Base Container** is required for any **Sub Container**. The **Sub Containers** contain the development environments for the template application projects running on Linux.

#### Available container

| ***Container name***                | ***Description*** |
|:-----------------                   |:----------------|
| compose_apache_php_cont             | The basic container     
| compose_UnitTest_Addon.yml          | Adds composer abd PHP unit test |
| compose_apache_php_swarm            | Creates the container as a swarm, example of swarm   |



### Setup steps
These are the quick setup steps for the ***PHP developer stack container***.
If you have previously installed this (or a similar) container, you can use these setup step, otherwise please first read the main documentation page [howto_create_a_dev_container](Howtos/howto_create_a_dev_container.md).


1) **Create docker base PHP container**{: style="color:green; "} <br>
Enter the sub directory ***./ApachePHPWebService***. Open a command prompt and  use the following to create the basic docker base container, on which the sub-containers depends on
 <pre class="nje-cmd-one-line">docker-compose -f compose_apache_php_cont.yml up -d --build --force-recreate --remove-orphans </pre>
 
 <span class="nje-ident"></span> *Expected results:*{: style="color: green;font-size:12px; "} 
 <small>
 This will create a basic PHP project structure which you can develop future local in the host or in the container it self
 <br><span class="nje-ident" style="--nje-number-of-spaces: 40px;"></span>**&#9830;** In docker a new service called: **apachephpwebservice**, <br>
 <span class="nje-ident" style="--nje-number-of-spaces: 55px;"></span> &#176; Start it!
 <br><span class="nje-ident" style="--nje-number-of-spaces: 40px;"></span>**&#9830;** [This](http://localhost:8071/phpinfo.php) page should display the **PHP info page**
 <br><span class="nje-ident" style="--nje-number-of-spaces: 40px;"></span>**&#9830;** [This](http://localhost:8071) page should display the **PHP application start page**
 <br><span class="nje-ident" style="--nje-number-of-spaces: 40px;"></span>**&#9830;** Web application page **source** can be found at: ***/usr/local/apache2/htdocs/***
 <br><span class="nje-ident" style="--nje-number-of-spaces: 55px;"></span> &#176; a bind mount to that folder, local, can be found in the ./ApachePHPWebService/app/
 <br><span class="nje-ident" style="--nje-number-of-spaces: 40px;"></span>**&#9830;** A general bind mount folder, local, can be found at: ***/usr/local/ApachePHPWebService/shared-host***
 <br><span class="nje-ident" style="--nje-number-of-spaces: 55px;"></span> &#176; Which is known at the server as: **/shared-host**
 </small> 

2) **Create sub-container: PHP package manager & PHP UnitTest**{: style="color:green; "} <br>
Adds the **composer** package  manager and the PHP Unit tests framework. Enter the sub directory ***./ApachePHPWebService*** and open a command prompt and use the following command
<pre class="nje-cmd-one-line">docker  compose -f compose_UnitTest_Addon.yml up -d  --remove-orphans --build --force-recreate --remove-orphans  </pre>

 <span class="nje-ident"></span> *Expected results:*{: style="color: green;font-size:12px; "} 
 <small>
 <br><span class="nje-ident" style="--nje-number-of-spaces: 40px;"></span>**&#9830;** Open a CLI in the container and execute:
 <pre class="nje-cmd-one-line-sm-ident" style="--nje-ident: 60px;">phpunit --version		# Should return version of Phpunit</pre>
 <pre class="nje-cmd-one-line-sm-ident" style="--nje-ident: 60px; --nje-vmove: 5px;">composer -V		        # Should return version of Composer</pre>
 <br>


3) **Configure and start the sub container in Visual Studio Code (VSC)**{: style="color:green; "}<br>
After this you should be able to open the container in VSC and start developing, you can do this local or by attaching to the container in VSC

**VSC In the container**
- Open VSC 
- Select the Docker tab and select the container ***'apachephpwebservice-webserver-apache-php'*** right click 'attach Visual Studio Code'
- In VSC choose: 'open folder' and select the directory **'/usr/local/apache2/htdocs'***, This should open your PHP project in the container

**VSC local**
- Open VSC 
- In VSC choose: 'open folder' and select your project directory this will open your PHP project locally.



> **More information!**{: style="color:#5491fa;font-size:13px; "} <br>
<small>
See the main documentation page [how to create a development container](howto_create_a_dev_container). Which explains the installation of the *Base Container* and any available *Sub Containers* in more details.
</small>

