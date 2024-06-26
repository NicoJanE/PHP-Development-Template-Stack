_This file is part of: PHP Development Template Stack_
_Copyright (c) 2024 Nico Jan Eelhart_

_This source code is licensed under the MIT License found in the  'LICENSE.md' file in the root directory of this source tree._
<br>

 
# What
This is a template Docker development/Swarm container for PHP developers. Originally intended for my personal use, so a warning: this project may contain some additional related documentation instructions and remarks which were for my own documentation, so some subjects may be overstated. However, it may also be useful for others. It contains:


1. Debian container with: Apache, PHP, PHP-FPM(CGI gateway), PHPUnit, Codeception.

1. Instructions for adding additional PHP versions

1. Instructions for creating a development container 
Use this for creating and starting a local container, for development and test work. It tries to use as much as possible the same configuration files as the swarm definition, currently only:***none :)*** 

1. Instructions for configuring PHP debugging (Xdebug)

1. Instructions to create an (optional) Swarm, this involves: 
-- Installing Multipass, see: https://multipass.run/ 
-- Creating multiple Virtual Machines with Multipass need for the swarm  
-- Initializing the swarm and defining the VMs as docker Manager or docker Worker
-- Making a Image required for the swarm
-- Publishing the image to a registry (Docker Hub)
-- Deploy the swarm service (pulling the image from docker hub)


# Where more information
More documents can be found in the 'Howto" directory. it contains:
1. Swarm document: ***howto_create_a_swarm.md*** 
2. Development container document: ***howto_create_A_dev_container.md*** 
3. Instructions to install and use other PHP versions: ***howto_install_other_PHP_versions***
4. Instructions to configure/install debugging see: ***howto_steps_for_debugging.md***
5. Instructions for creating this image see: ***howto_this_image_is_created.md***


# General usage suggestion
This is a Template example defined in the ***\docker\Containers and swarm templates\\*** folder. The idea is to copy this folder to the local development programming language folder as an template and customize it there. In sub (project) folders you can then make copies of the above defined templates and create the programs

Example :

|language| Copy form      | To Template Location | Project location|
|--------| -------------- | -------------------- |-----------------|
|PHP     | \docker\Create Swarm With PhpMysqlService | \Php\\_docker-template\ | \Php\Projects\ProjectX |
|Python  | \docker\Create Swarm With PyFlaskService | \Python\\_docker-template\ | \Python\Projects\ProjectY |

<br><br>
^Version: 1.03 official release 1 version June 19 2024^
^Note: Original location of template: ***"\docker\Create Swarm With PhpMysqlService"***^