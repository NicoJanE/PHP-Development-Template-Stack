---
layout: default_c
---

# PHP Development   <span style="color: #409EFF; font-size: 0.6em; font-style: italic;"> -  Docker & Swarm Container</span>
<span style="color: #409EFF; font-size: 0.95em; font-style: italic; margin-top: -14px; display: block;">Project Setup</span>

![MIT License](https://img.shields.io/badge/License-MIT-green) ![Commercial Services Available](https://img.shields.io/badge/Services-Optional-blue)

## Introduction

This will describe the best way to setup a PHP project

### 1. Set Up Your Project Directory

Assuming you have a project directory **'my-project'**.

1.1 Copy the required stack directories into a subdirectory called docker-setup inside your project directory in the host.<br>
**Example:**

- `my-project/docker-setup/mariaDB`
- `my-project/docker-setup/php-stack`

1.2 Create a folder in the Host where your Project backup files will reside

- `my-project/shared-host`
This is where the backup files will land when executing:
`./docker-setup/php-stack/vscode/tools/_backup` within the container

### 2.1  Update Bind Mounts in Compose Files

When using bind mounts, you could consider the method below for your project directoy, **but be aware** that bind mount to Windows Host folders, could\will mean trouble sooner or later, see the **Warnings** section below. The less trouble free solution, in my experience, is to copy the project (template) into the container and make sure that you can easily copy it to an dedicated backup bind mount share.

**Set project directory as a bind mount** (care full)

- If any of the stacks have a bind mount in the compose, change it to refer to a sub directory in my-project using a **absolute path** 
If any stack uses a **bind mount** in its `compose.yml`, update it to reference a subdirectory inside `my-project` using an **absolute path**.

**Example Update(when using bind mounts):**

-  Original bind mount (inside php-stack/compose.yml): 
`./app:/usr/local/apache2/htdocs ` <br> <br>
- Updated bind mount (after moving php-app to the main project directory): <br>
 `"D:\\Php\\Projects\\Mine\\my-project\\php-app:/usr/local/apache2/htdocs"`

> 🔹 **Make sure to MOVE** the `php-app` **directory** to the new location, as it likely contains important settings and template files.

<br>

>❗**Warnings**, *regarding bind mounts*
>  - Relative bind mount paths,  may give permission issues and WSL issues!
>  - Even when a bind mount project folder is setup correct, you may experience serious performance problem. One example of that is ***PHP Symphony***. A project that should load in the Windows Host browser in les than a 0.5 second may tak between 8 and 10 seconds for every change made! 

## 2.1  External network & Plugin stacks

The plugin stacks are developed in depend and can be added to a custom stack definition, by using a external network and some additional settings in the compose file. See for documentation the compose file of the stack: **\Docker-Template-Plugin-Stacks\MariaDB**

## 3. Build and Start Each Stack

- Run docker `compose up -d` for each stack and consult the **README.md** file for additional instructions.

<span style="color: #6d757dff; font-size: 13px; font-style: italic;">
<i><b>License</b><br>This file is part of: **PHP Development Template Stack**  Copyright (c) 2025-2026 Nico Jan Eelhart.This repository is [MIT licensed](../MIT-license.md) and free to use. For optional commercial support, customization, training, or long-term maintenance, see [COMMERCIAL.md](../COMMERCIAL.md).</i>
</span>

<br><br>
<p align="center">─── ✦ ───</p>