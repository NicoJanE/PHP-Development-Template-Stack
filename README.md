# PHP Development  <span style="color: #409EFF; font-size: 0.6em; font-style: italic;"> -  Docker & Swarm Container</span>

![MIT License](https://img.shields.io/badge/License-MIT-green) ![Commercial Services Available](https://img.shields.io/badge/Services-Optional-blue)

## Introduction

This is a **Docker Template Stack (DTS) container for PHP projects**. It provides a complete development and containerization solution for PHP-based applications.

### What's Included:

- **Debian-based container** with Apache, PHP, and PHP-FPM (CGI gateway)
- **Testing and development tools**: PHPUnit, Symfony, and Codeception (optional)
- **Debugging capabilities**: Full Xdebug configuration and instructions
- **Multi-version PHP support**: Easy installation of alternative PHP versions side by side
- **Docker Swarm support**: Deploy and manage multiple container instances across a cluster
- **Sample application**: A basic PHP web service available in `/ApachePHPWebService/app`

## Project Structure

- **ApachePHPWebService/** - Container definition and Apache/PHP configuration
- **Howtos/** - Step-by-step guides for common tasks and setup procedures
- **workdir/** - Bind-mount directory for your project files (use lowercase for Linux compatibility)

## Setup and Get Started

Use this container for local development and testing of PHP projects.
- **[Quick Setup](./Howtos/quick-setup.md)** - Fast start guide to get up and running ([local](./Howtos/quick-setup.md) or [remote](https://nicojane.github.io/PHP-Development-Template-Stack/Howtos/quick-setup))
- **[Complete Development Container Guide](./Howtos/howto_create_a_dev_container.md)** - Detailed instructions for creating a full development container ([local](./Howtos/howto_create_a_dev_container.md) or [remote](https://nicojane.github.io/PHP-Development-Template-Stack/))

You can customize this template to document your specific project setup. This is particularly useful when your project consists of multiple Docker services or requires specific configuration settings.

Other Docker Template Stack containers are available at: [Docker Template Stacks Home](https://nicojane.github.io/Docker-Template-Stacks-Home/)



<details closed>  
  <summary class="clickable-summary">
  <span  class="summary-icon"></span> 
  Side note: Preview the markdown files(.md)
  </summary> 	<!-- On same line is failure, Don't indent the following Markdown lines!  -->

> <br>
> 
> ### Preview the markdown files(.md)
>
>To preview the Markdown (MD) files in this project, one of the best solutions is to open these files in Visual Studio Code (VSC) and install the plugin: **Markdown Preview GitHub Styling** (Tested with version 2.04). Other plugins, or plugins for other programs, may not always work correctly with the file links in the documentation. I use the file link syntax supported by GitHub (Jekyll), which is also compatible with the above-mentioned plugin.
>
> To display the Preview screen in VSC: 
>- Ensure that you are **not** working in ***Restricted mode***.
>- Click on the "file.md" tab and choose: "Open preview." 
>- Alternatively, you can click the 'Open Preview to the Side' button at the top right. 
>
><br>
<a href="https://github.com/mjbvz/vscode-github-markdown-preview-style" target="_blank">Click here for more information on the Markdown Preview GitHub Styling plugin</a>
</details>

<br>
<small> <i><b>License</b><br>This file is part of: <b>PHP Development Template Stack</b>  Copyright (c) 2025-2026 Nico Jan Eelhart.This repository is <a href="MIT-license.md">MIT licensed</a>and free to use. For optional commercial support, customization, training, or long-term maintenance, see <a href="COMMERCIAL.md">COMMERCIAL.md</a></i>
</small>

<br><br>
<p align="center">─── ✦ ───</p>
