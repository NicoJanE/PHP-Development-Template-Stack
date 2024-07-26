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
<br><br>
<br>
 
# What
This is a template Docker development/Swarm container for PHP developers. Originally intended for my personal use, so a warning: this project may contain some additional related documentation instructions and remarks which were for my own documentation, so some subjects may be overstated. However, it may also be useful for others. It contains:


1. Debian container with: Apache, PHP, PHP-FPM (CGI gateway), PHPUnit, Codeception (***TODO  AddOn***).

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


# Where more information
More documents can be found in the 'Howto" directory. it contains:
1. Development container document: open [how to create a development container](./Howtos/howto_create_A_dev_container) 
2. Swarm document: open [how to create a swarm of this container](./Howtos/howto_create_a_swarm)
3. Instructions to install and use other PHP versions: open [how to install other PHP versions](./Howtos/howto_install_other_PHP_versions)
4. Instructions to configure/install debugging see: [how to include debugging](./Howtos/howto_steps_for_debugging)
<br>

----

### Me personal folder concept structure
The containers are **maintained only here**. After creation or updating of the container, the container is copy to the program language folder inside the   **\_docker-template** folder. From there it can be used in projects, example:

<small style="display: block; margin-bottom: -18px;"><b><i>Folder concept</i></b></small>

|**language**| **Copy to Template Location** | **Us at Project Location**|
|:--------| :-------------- | :-------------------- |
|PHP    | \Php\\_docker-template\ 		| \Php\Projects\projectX |
|Python  | \Python\\_docker-template\ 	| \Python\Projects\ProjectY |

<small><i>Check the version of the template in the 'README.md' (root)</i></small> <br><br>


> *Remark:*{: style="color: Grey;font-size:13px; "} <br>
> <small>Of course, you may change the container docker templates files for specific reasons but do this than in the specific project folder! When a change is generic it should be added (merged) into the development container here</small>


<!--
<br><br><br>
# Table of content
* Table of Contents
{:toc}
-->
