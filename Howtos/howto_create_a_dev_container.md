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
</small>
<br><br>

## 1. Create and start a PHP developer container
This section describes how to create and start the Docker PHP container. If you want to experiment with a swarm (create, initialize, and run different containers), refer to the document: [***How to Create a Swarm***](howto_create_a_swarm)



<details>  
  <summary class="clickable-summary">
  <span  class="summary-icon"></span> 
  **Side note**: Docker call syntax
  </summary> 	<!-- On same line is failure, Don't indent the following Markdown lines!  -->  
>### Docker call syntax 
<small> (***Skip this if you known docker basics***) </small><br>
**Take note: Docker calling context**
Because we use Docker files (Dockerfile and compose) with descriptive names, for example, **Dockerfile_Nodejs_React_Cont** instead of plain **Dockerfile**, this has an impact on the way Docker commands are run and called. For example, with a plain **Dockerfile**, we would use this command to call the Docker file in the **Docker Compose** file:
<br>
```
context: .
dockerfile: Dockefile
```
In our case, we cannot use the default name but have to specify the name we gave, thus:<br>
```     
build: 	    
context: .
dockerfile: Dockerfile_Nodejs_React_Cont	    
```
 The same applies for using the build command. With the default Dockerfile, you can use this:
```
 docker build 
 # This will assume a file: Dockerfile is available
```
With the named file, we have to use
```
 docker build -f MyDockerFileNameHere
```
The same applies for running the Compose file (use **-f** option)
</details>





### 1.1 The basic PHP container setup
This section creates and start the PHP container in docker Desktop.
**To Setup** creat and start the PHP container in docker Desktop execute this command from the **ApachePHPWebService**  directory:  

<pre class="nje-cmd-multi-line">
docker  compose -f compose_apache_php_cont.yml up -d

# To rebuild an existing container avoid caching issues, you can use:
docker-compose -f compose_apache_php_cont.yml up -d --build --force-recreate
</pre>

#### Results & running the sample app
Test the container by executing the following tasks

<small style="display: block; margin-left: 22px; font-size: 13px; color-scheme: light dark; background-color: Canvas; ">
  <b><i>Available default websites, after container creation:</i></b><br> </small>
<small style="display: block; margin-bottom: 0px;margin-left: 22px; font-size: 14px; background-color: CanvasText; color: Canvas; padding: 8px; border-radius: 4px;">
  &#9830; [http://localhost:8071/phpinfo.php](http://localhost:8071/phpinfo.php) <br>
  &#9830; [http://localhost:8071/index.php](http://localhost:8071/index.php)
</small> 
<br>

<small style="display: block; margin-left: 22px; font-size: 13px; color-scheme: light dark; background-color: Canvas; ">
  <b><i>Location of files (current 'Document Root') in container:</i></b><br> 
</small>
<small style="display: block; margin-bottom: 0px;margin-left: 22px; font-size: 14px; background-color: CanvasText; color: Canvas; padding: 8px; border-radius: 4px;">
  &#9830; /usr/local/apache2/htdocs/public <br>
</small> 
<br>

<small style="display: block; margin-left: 50px; font-size: 13px; color-scheme: light dark; background-color: Canvas; ">
  <b><i>Update Document Root in:</i></b><br> 
</small>
<small style="display: block; margin-bottom: 0px;margin-left: 50px; font-size: 14px;background-color: CanvasText; color: Canvas;; padding: 8px; border-radius: 4px;">
  &#176; /usr/local/apache2/conf/extra/httpd-vhosts.conf <br>
  &#176; Tip: For a second site enter the setting in httpd-vhosts.conf and add a alias `Alias /test2 /usr/local/apache2/htdocs/test2/public` <br>
</small> 
<br>

<small style="display: block; margin-left: 50px; font-size: 13px; color-scheme: light dark; background-color: Canvas; ">
  <b><i>Set www-data owner andfile permissions in:</i></b><br> 
</small>
<small style="display: block; margin-bottom: 0px;margin-left: 50px; font-size: 14px;background-color: CanvasText; color: Canvas;; padding: 8px; border-radius: 4px;">
  &#176; chown -R www-data ./htdocs <br>
  &#176; chmod -R 755 ./htdocs <br>
</small> 
<br>




<small style="display: block; margin-left: 22px; font-size: 13px; color-scheme: light dark; background-color: Canvas; ">
  <b><i>mount bind location in Windows host:</i></b><br> 
</small>
<small style="display: block; margin-bottom: 0px;margin-left: 22px; font-size: 14px; background-color: CanvasText; color: Canvas; padding: 8px; border-radius: 4px;">
  &#9830; ..\ApachePHPWebService\app <br>
</small> 
<br>

#### Symfony 
Symfony is included, start project:
- symfony new project-name
- Update the **Document root** to the ***public*** directory of the new created project directory.
- Copy the `/usr/local/apache2/htdocs/.htaccess` file to the new public root directory and make sure the www-data owner and permissions are set (restart)
- For more information about Symfony, see [here](https://symfony.com/) 

<br><br>


### 1.2 Add PHPUnit to the image (sub-container)
Optional you can add the PHPunit test framework to the image, after executing the commands in the previous paragraph execute  this command: ( again in the **[name]Service**  directory)  
<br>
<pre class="nje-cmd-one-line">
docker  compose -f compose_UnitTest_Addon.yml up -d  --remove-orphans --build --force-recreate
</pre>

##### Results & running the sample app
When this is done the following commands(in the container) should return the phpunit and composer versions 

<small style="display: block; margin-left: 2px; font-size: 13px; background-color: #ffffff; "><b><i>Expected commands results</i></b><br> </small>
<pre class="nje-cmd-multi-line">
phpunit --version		# returns version phpunit
composer -V			# returns vcersio composer
# In case the phpunit --version command returns not found, do this
RUN echo 'export PATH="/root/.config/composer/vendor/bin:$PATH"' >> ~/.bashrc \
    && . ~/.bashrc
</pre>



<small style="display: block; margin-left: 2px; font-size: 13px; background-color: #ffffff; "><b><i>Expected running Website</i></b><br> </small>
<small style="display: block; margin-bottom: 0px;margin-left: 0px; font-size: 14px; background-color: #f0f0f0; padding: 8px; border-radius: 4px;">
&#9830; [http://localhost:8071/phpinfo.php](http://localhost:8071/phpinfo.php) <br>
&#9830; [http://localhost:8071/index.php](http://localhost:8071/index.php)    
</small> 

<br>

### 1.3 Create sub-container: Add Python front-end using pySide6 (Qt)
Optional you can add the **Python** Qt based front-end **pySides6** to the image, after executing the commands in the previous paragraph execute  this command: ( again in the **[name]Service**  directory)  
<br>
<pre class="nje-cmd-one-line">
docker  compose -f compose_python_frontend_addon.yml up -d  --remove-orphans --build --force-recreate 
</pre>

<small style="display: block; margin-left: 2px; font-size: 13px; background-color: #ffffff; "><b><i>Expected results</i></b><br> </small>
<pre class="nje-cmd-multi-line">
python3 --version && pip3 show PySide6  # Should display Python and pyside information
</pre>
</small> 

<br>

## 2. Develop and debug in Visual Studio Code
- Open VSC and press the docker Icon(left sidebar)
- Right Click on your container and choose "Attache Visual Studio Code" a new VSC Window opens that is mapped the container
- Choose: Open folder and select the folder ***/usr/local/apache2/htdocs***
- For debug installation/configuration see the howto file: [howto_steps_for_debugging](howto_steps_for_debugging)

<hr>
<br>

## Appendix 1 Create other template from this template.

<details>  
  <summary class="clickable-summary">
  <span  class="summary-icon"></span> 
  **Side note**: Create Project from Template
  </summary> 	<!-- On same line is failure, Don't indent the following Markdown lines!  -->
When You want to customize this template for your own template you can use the following rough procedure
>### Create Project from Template
>>  <small> ***Skipp this if you known how to deal with copy\customize docker files*** </small> <br>
>
> To adapt the template directory for your project, follow these steps. This guide assumes you’re using the React stack; if you’re working with a different stack (e.g., PHP, Rust), simply replace “React” with the stack name your are using.s
> 1. Copy the whole directory to your project name:
`copy "React Development Template Stack" MyReactStack` <br> <br>
> 1. within your **MyReactStack** open the ***[name]Service*** directory <br><br>
*Warning*{: style="color: red;font-size:13px; "} <small>When using multiple containers, it's a good idea to rename the directory (for example, by adding a number) before proceeding. Otherwise, the containers will be grouped together, which is generally helpful, but this can lead to caching issues in certain container stacks, such as React. These issues may manifest as the same directories appearing in the container from a previous instance after running the **compose_nodejs_react_cont.yml** command. Caching problems can be quite troublesome in some Docker stack configurations</small> <br><br>
> 3. Customize the Dockerfiles: Since most Docker Compose setups involve a parent-child relationship (i.e., chaining), a change in one Dockerfile may require updates to all related files. Follow these steps:<br><br>
3.1  In the first compose_\* file change the **services name** to an appropriate name: <br>
```services:
webserver-nodejs-react:  # Change this ```<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <!-- sorry for this --> 	
<small> <sup>*</sup>Always use lowercase!</small> <br><br>
3.2 The above **service name** may appear more than once in the same file, update these service names as well! <br><br>
3.3 Changes the **service name**  from step 3.1 in the other **compose_\* files**  <br><br>
3.4 Check the compose_\* files when it contain a **image name** than update this to your own image name:<br>
`` build:`` <br>
``     context: .  ``<br>
``     dockerfile: Dockerfile_Nodejs_React_Cont`` <br>
``       image: eelhart/react-base:latest      `` <br>
``		# Update above. i.e: [yourname/react-prjx]`` <br><br>
3.5 This **image name** may appear in other compose_\* files and other Dockerfile_\* files, updates these image names as well.
>
> 4 Lastly, update the ports to ensure that each host port is unique across all running containers. In your Docker Compose file, you might see this configuration: <br>
``ports:`` <br>
``target: 3001        # Container port.`` <br> 
`` published: 3002    # Host port, Make SURE it is unique    `` <br>
<br><small> Alternatively, the syntax might look like this (achieving the same result): </small><br>
`` ports:`` <br>
`` - "3002:3001"      # host:container`` <br><br>
> **Make sure that Host port: 3002 is not used by any other docker container or other services on your host!**
<br> <br>
</details>
<br>

