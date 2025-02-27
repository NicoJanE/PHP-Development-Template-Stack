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
<br>
 
# What
This is a template Docker development/Swarm container for PHP developers. When you want to use this as a development template, for your docker PHP project (including composer and PHPUnit) you can use the following [quick setup reference](Howtos/quick-setup)


1. Debian container with: Apache, PHP, PHP-FPM (CGI gateway), PHPUnit, Symfony,  Codeception (***TODO  AddOn***)
1. Instructions for adding additional PHP versions
1. Instructions for creating a development container. 
Use this for creating and starting a local container, for development and test work. 
1. Instructions for configuring PHP debugging (Xdebug)
1. Instructions to create an (optional) Swarm, this involves: 
- Installing Multipass, see [Multipass](https://multipass.run/) 
- Creating multiple Virtual Machines with Multipass (needed for the swarm) 
- Initializing the swarm and defining the VMs as docker Manager or docker Worker
- Making an Image required for the swarm
- Publishing the image to a registry (Docker Hub)
- Deploy the swarm service (pulling the image from docker hub)

You can use this container to develop your PHP based application, a simple sample application is available in the directory: \ApachePHPWebService\app. Or use it to test the docker swarm functionality.

> **For the first stable release, use the release/1.0 template branch**



# Where more information
More documents can be found in the 'Howto" directory. it contains:
1. Development container document: open [how to create a development container](./Howtos/howto_create_a_dev_container) 
2. Swarm document: open [how to create a swarm of this container](./Howtos/howto_create_a_swarm)
3. Instructions to install and use other PHP versions: open [how to install other PHP versions](./Howtos/howto_install_other_PHP_versions)
4. Instructions to configure/install debugging see: [how to include debugging](./Howtos/howto_steps_for_debugging)
5. Document root adjustments in: /usr/local/apache2/conf/extra/httpd-vhosts.conf
<br>

<details closed>  
  <summary class="clickable-summary">
  <span  class="summary-icon"></span> 
  **Side note**: Personal maintenance instructions
  </summary> 	<!-- On same line is failure, Don't indent the following Markdown lines!  -->
  
>### Personal maintenance instructions
>The template containers are **maintained** only in the **DTS**. I copy these to a project directory and customize them there for the project. If the customization is generic, I will merge it into the DTS template project
>
> <small style="display: block; margin-bottom: -18px;"><b><i>Personal project structure</i></b></small> 
>
>  <small> **Docker-Template-Stacks (DTS)**</small> | <small> **Project Location** </small> | 
> :-------------- | :-------------------- |
> <small>DTS\PHP Development Template Stack\\ </small> | <small> \Php\Projects\projectX  </small>
> <small>DTS\Rust Template Stack\\ </small> 	| <small> \Rust\Projects\ProjectY </small>
>
><br>
> *Update:*{: style="color: Grey;font-size:13px; "} <small> these template central!</small>
</details>

<!--
<br><br><br>
# Table of content
* Table of Contents
{:toc}
-->
