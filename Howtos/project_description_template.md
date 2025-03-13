---
layout: default_c
---
<small> See also: **project-setup.md** </small>


One can sse this template to describe how your project was created(which Docker files used and other configuration)

#### Legenda:

- ❗Careful
- 🔃 Change required, compared with the original template

<br>

## 1  External network

`[docker network create --subnet=192.168.51.0/28 php_network[]`
<br><br>

## 2. Used  Project Setup from : [\PHP Development Template Stack]

Installed customizing it in: **..** <br><br>

### 2.2 Updated Bind Mounts in Compose Files

**Warning**❗ <br>
'Bind mount' project folder may cause lots an lots of performance problems. For this reason there is only a bind **Shared-host** to be able to copy the container project directory

> Still using bind mount. Then make sure(on Windows) the path is not a relative path but a path with the full path. This prevents permissions errors(there is also a Docker desktop alternative solution, consult your search engine)

#### Used directory paths

- Project directory container: <br>
`[/usr/local/apache2/htdocs/symfony-apps/wiki-store]`
- Bind mount for backup or interaction: <br>
`[./app:/usr/local/apache2/htdocs]`
- Updated bind mount (after moving php-app to the main project directory): <br>
  - `[D:\] # Host` 🔃
  - `/shared-host # Container`

### 2.3 Network

[We use an external network for this template, cause the **plugin stack** ***MariaDB*** is also used (see 3)]

- Copied the .env file from MariaDB (see 2 below)
- Set `external` to **true**
- used FIXED_IP

### 2.4 build

 `docker-compose -f ...`
<br><br><hr>

## 3 Used  Project Setup from : Docker-Template-Plugin-Stacks\MariaDB

Host installation. Installed it into: **.\Wiki-store\docker-setup\prj-MariaDB**

### 3.1 Network

- Copied the Network settings from compose_apache_php_cont
- Set `external` to **true**
- used FIXED_IP2 and FIXED_IP3 

## 3.2 build 

 `docker-compose -f ...`

<br><br>

## 4 Resulting Sites & Configuration

- x
