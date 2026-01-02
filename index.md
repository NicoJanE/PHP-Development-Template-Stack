---
layout: default_c
RefPages:
 - howto_create_a_dev_container
 - howto_create_a_swarm
 - howto_install_other_PHP_versions
 - howto_steps_for_debugging
--- 
 
# PHP Development  <span style="color: #409EFF; font-size: 0.6em; font-style: italic;"> -  Docker & Swarm Container</span>

![MIT License](https://img.shields.io/badge/License-MIT-green) ![Commercial Services Available](https://img.shields.io/badge/Services-Optional-blue)

## Introduction

This is a template Docker development and Swarm container for PHP developers. To get started with this container for your PHP project (including Composer and PHPUnit), see the [quick setup reference](Howtos/quick-setup).


1. **Debian container** with Apache, PHP, PHP-FPM (CGI gateway), PHPUnit, Symfony, and Codeception (***TODO: AddOn***)
1. **Instructions for adding additional PHP versions**
1. **Instructions for creating a development container** - Use this to create and start a local container for development and testing.
1. **Instructions for configuring PHP debugging** (Xdebug)
1. **Instructions for creating an optional Swarm**, which involves: 

- Install Multipass (see [Multipass](https://multipass.run/))
- Create multiple virtual machines with Multipass (required for the swarm)
- Initialize the swarm and define VMs as Docker Manager or Docker Worker nodes
- Create a Docker image for the swarm
- Publish the image to a registry (Docker Hub)
- Deploy the swarm service (pulling the image from Docker Hub)

You can use this container to develop your PHP based application, a simple sample application is available in the directory: \ApachePHPWebService\app. Or use it to test the docker swarm functionality.

> **For the first stable release, use the release/1.0 template branch**

## Where to Start

More documents can be found in the `Howtos` directory. It contains:

1. [How to create a development container](./Howtos/howto_create_a_dev_container) - Set up your local development environment
2. [How to create a Swarm](./Howtos/howto_create_a_swarm) - Deploy multiple container instances
3. [How to install other PHP versions](./Howtos/howto_install_other_PHP_versions) - Add alternative PHP versions
4. [How to configure debugging](./Howtos/howto_steps_for_debugging) - Set up Xdebug and debugging tools
5. Document root adjustments in: /usr/local/apache2/conf/extra/httpd-vhosts.conf
<br>

<span style="color: #6d757dff; font-size: 13px; font-style: italic;">
<i><b>License</b><br>This file is part of: **PHP Development Template Stack**  Copyright (c) 2025-2026 Nico Jan Eelhart.This repository is [MIT licensed](MIT-license.md) and free to use. For optional commercial support, customization, training, or long-term maintenance, see [COMMERCIAL.md](COMMERCIAL.md).</i>
</span>

<br><br>
<p align="center">─── ✦ ───</p>
