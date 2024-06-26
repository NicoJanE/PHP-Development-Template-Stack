_This file is part of: PHP Development Template Stack_
_Copyright (c) 2024 Nico Jan Eelhart_

_This source code is licensed under the MIT License found in the  'LICENSE.md' file in the root directory of this source tree._
<br><br>

# What
This describes how to create a Docker Swarm of this PHP container. These instructions are intended for developers how wants to experiment and learn how to deal with a Docker Swarm. To create and use a development container see the document: ***howto_create_A_dev_container.md***

# Create Multipass docker VM infrastructure(X (5) VMs) and Initialize the Swarm.
We use Multipass for the different Virtual machines to hold the Docker Swarm.
1. Make sure Multipass is installed, see: https://multipass.run/
1. ***command***: ***./CreateDockerNodes.ps*** to create the, entered number of multipass Nodes (let's assume 5)
1. Get the IP from one of the nodes (multipass ls)
1. mount and copy ***shared-container-files***
The docker **compose_apache_php_swarm.yml** need to have access to the shared files. For this reason we need to mount the whole service directory(ApachePHPWebService) on the host to: /mnt/host on the container. After that the /mnt/host file will be copied to **/home/ubuntu/src/appname-service** directory from where the docker compose file can read the files. **Note that** the compose file is unable to access the /mnt/host/ files and directories.<br> For the described process we have another script which will do this for all our created Multipass VNode's:<br>
***command***: ***./mountcopy.ps1***  # run this! <br>
Related and used command'
 ``` multipass mount "C:\path\to\your\folder" VNode1:/mnt/host. ```
 ``` multipass set  local.privileged-mounts=true (if needed, in case of no permission)```
 <br>
1. Open the VM 'VNode1' in a shell<br> ***command***: multipass shell VNode1
1. Initialize the Swarm in the 1e Node.<br> ***command***: docker swarm init --advertise-addr IP(see 2)
1. Get MANGAER and WORKER token  <br>***command***: docker swarm join-token manager. <br>***command***: docker swarm join-token worker.<br> Copy it.
1. exit VNode1 and <br>***command***: multipass shell VNode2
1. Make the 2e Node and 3rd also MANAGER(and all other required) .<br> ***command***: Past the copied ***command***. <br> ***command***: docker node ls  (From ADMIN Node to check)
1. Do the same,as in step 8, but now for the nodes that must act as WORKER, in this case use the worker token(see step 7). worker nodes will actually run your application(s)


# Make & Publish an Image
This step will create and image used for the service of the Swarm. We need to create it in the Docker registry, so that it can be pulled later by the Swarm service.

## Create Image  
In this sample we use the Python image defined in the directory:"PythonWebService" but you can also use and other directory with other files.

***Assuming your in the root directory: PythonWebService ***
1. Make sure a (basic) (PHP) application is available in \app
2. a **Dockerfile_Apache_PHP_cont** file should be available
3. ***command***: docker build -t [yourname]/apachephpweb -f Dockerfile_Apache_PHP_cont .
Don't forget the . 
option add the --no-cache option to force  a rebuild
  ***command***: docker build --no-cache -t eelhartn/apachephpweb -f Dockerfile_Apache_PHP_cont .
4. ***command***: docker images # it should be there

## Publish 
You can skip this and use me image(eelhartn/apachephpweb) or continue, and create your own image and use that later on. 
First publish it to the Docker Hub, this must be done so we can pull the image in the multipass VM manager node(s).
1. ***command***: docker login with your docker login
2. ***command***: docker image push [yourname]/apachephpweb
***Be aware*** the image is ***public*** by default, to make it private go to the web interface!
	

# Use the Published image to deploy the Stack
    ^Note: Stack is another term for compose in case of a Docker Swarm^		

To deploy the stack we need to have the **PhpWebService\app** directorie and the **PhpWebService\compose_apache_php_swarm.yml** available on the multipass virtual machine MANAGER nodes!
Make sure the script ***mountcopy.ps1*** has run,  this will make sure  the app and shared files are available in:``` /home/ubuntu/src/ ``` at the node.
1. Check that the key differences(required for a Swarm) in the compose_apache_php_swarm.yml are made, which are (should already be done):
	- Most importantly there is NO **build** property but instead a **image** property that point to our image stored in the Docker hub
	- Check also other none Swarm required properties, so that those make sense: service name, command(start-up app), ports... <br><br>
1. When you did **not skip 'Create image'**  you will need tho change the image property in the file: ***compose_apache_php_swarm.yml*** so that it refers to your image!
1. Login to docker Hub and make sure that the referenced image (compose_apache_python_swarm.yml) is public! 
2. Execute the following commando's from the *directory:*<br> ***command***: ```cd /home/ubuntu/src/appname-service/``` from a manager VNode<br>***command***: ```docker stack deploy -c compose_apache_php_swarm.yml MyWebApp``` <br>
This will use the compose_apache_php_swarm.yml file to retrieve the deployed image from the docker Hub and create a service MyWebApp<br><br>
Checks:	<br>***command***: docker stack ls<br> ***command***: docker stack ps MyWebApp<br>      ***command***: docker stack services MyWebApp<br>***command***: docker service logs [service name previous CMD] # In case of errors<br><br>
To Open a docker shell in the stack use
***command***: docker ps								# Get the Container ID of (NOT from Master VNode! ?? us another admin node)
***command***: docker exec -it [container ID] bash		# shell<br><br>
**Now try if your lucky** (otherwise proceed with 'Test the installation' below)
Enter(use ```multipass ls for``` ip addresses): <br> - [a VM IP address]:8071\index.html<br> - [a VM IP address]:8071\index.php<br> - [a VM IP address]:8071\phpinfo.php
<br> *In my experienance when you get 'the forbidden' return page there are problems with the network between the host and the VM's*


# Test the installation
Because our Swarm has some layers of complexity(host machine, VM's in the host, and a docker image in each VM, networking and others)
we have to test the result in different stages
### 1. Inside a docker image contained in a VM, check running state
Enter the docker Container
- Open a shell to a manager VM (BUT NOT the master\leader!)
- **command**: ```docker ps``` 		# get the container ID
- **command**: ```docker exec -it [container ID] bash```		# inside the docker running Apache and PHP
Now you can use the following command to check the state:
- **command**: ```netstat -tuln | grep ':80'``` # when returns listing Apache 2 is working
- **command**: ``` php --version```	# Okay when returns version
- **command**: ``` /run/php/php8.2-fpm.sock```	# if returns it own location PHP-FPM is successful installed
- **command**: ``` tail -f /var/log/apache2/access.log```	# Check acces errors
- **command**: ```apt-get update```
- **command**: ```apt-get install curl```	# needed for next
- **command**: ```curl -f http://localhost:80/index.html```	# should return page, note internal it's port 80 external 8071
- **command**: ```curl -f http://localhost:80/phpinfo.php```	# should return page, note internal it's port 80 external 8071. if so **INSTALLATION OKAY**
### 2. In any docker image, tests
Here we first need to install curl: 
- **command**: curl -f http://localhost:8071/index.html || exit 1
if the above command returns the html page Apache2 is working for HTML
- **command**: curl -f http://localhost:8071/phpinfo.php || exit 1
If return value PHP is **INSTALLATION OKAY** and reachable from the VM host
- **command**: curl -f http://localhost:8071/index.php || exit 1
if the above command returns the PHP page Apache2 is working for PHP. When this is the case the installation is okay, the only thing what can go wrong is the network connection between the VM and host
**+++if the phpinfo.php work, and this not, there is an error in the PHP app or app setup+++** (COMPOSE?)
- **command**: ping [ip host] If this fails the nstaal is ok but you can ot reach the host so web page will not be displayed on the host. While this is irritating I consider this outside the scope of this project
### 3. In the host, test accessibility  
When a command like: [a VM IP address]:8071\index.html is not working in the host, the last ping command probably also failed. Again, while this is irritating I consider this outside the scope of this project. But any way here are some checks you could begin with:
- **command**: Start a (host) browser ad type any VNode *** IP-address:8071/index.html***		# this fails I guess otherwise you would not be here (for completeness it's here) 
- **command**: ping a [VM ip addr]
- Try the following Power-Shell script, make sure to enter a VM IP address:
```
try {
		$response = Invoke-WebRequest -Uri http://72.28.207.1:8071/index.html
		Write-Output $response.Content
	} catch {
		Write-Output "Failed to connect"
	}
```
<br>

## Errors
- The error 'Rejected' means most of the time that the image could not be found(misspell or private?? not logged in docker?) But be aware that the command: 'docker stack ps MyWebApp' could return old info, so also check if the Website runs!
- Restart a Multipass VM node will reassign a new IP and break the swarm! (use Fixed IP, but how?) 
 <br>
 
#### Notes
This installation method use the declarative method to create the Swarm. this means 
- No Dockerfile is used
- The compose file has a few changes(because the dockerfile is not used)
- More information see my personal WIKI: http://pcne:8080/en/Personal/Docker/Create_A_Swarm_ 


