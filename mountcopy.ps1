# This file is part of: PHP Development Template Stack 
# Copyright (c) 2024 Nico Jan Eelhart
#
# This source code is licensed under the MIT License found in the  'LICENSE.md' file in the root directory of this source tree.
#



# Define the folder path on Windows and the target path on the VM			   
$folderPath = "D:\Php\_Docker-templates\Create Swarm With PhpMysqlService 2.0\ApachePHPWebService"
$mountPoint = "/mnt/host"
$sharedDir	= "/shared-container-files"

# This combination is the target/destination of the folders
$targetPath = "/home/ubuntu/src"
$targetDir  = "/appname-service"

clear
#  Sanity check(s)
if (-not (Test-Path -Path $folderPath -PathType Container) ) {
	Write-Host "`n`nERROR!:`nDirectory: $folderPath`nDOES NOT EXIST!`n`nFix variable: `$folderPath, leaving...`n`n`n"
	exit 1
}


Write-Host "`n`n`n`n`n`n- Start mounting.`n`tThe folder: $folderPath`n`tTo:$mountPoint`n"
Write-Host "- Then the files and directories are copied form the mount to: $targetPath$targetDir" 
Write-Host "`tThis is done so the docker compose file can read the file (it can't read a mounted Dir)`n`n " 

# Get the list of running VM names
Write-Host "RUNNING..."
$vms = multipass list --format csv | ConvertFrom-Csv | Where-Object { $_.State -eq "Running" } | Select-Object -ExpandProperty Name
Write-Host "Available VM Hosts: $vms (multipass preparing done) `n"


# Loop through each VM to mount the folder and copy files
foreach ($vm in $vms) {
	If($vm -eq "primary")
		{continue} 
	
	Write-Host "For Host: $vm"	
    
	# 1.1 Mount the host folder to the VM
	$par=$vm+":"+$mountPoint
    multipass mount $folderPath $par
	Write-Host "CMD exec: multipass mount CMD: mount $folderPath $par"
		
    # 2. Make sub directory
    $CreateDirCMD = "sudo mkdir -p $targetPath$targetDir "
	Write-Host "CMD exec: multipass exec $vm -- bash -c $CreateDirCMD"
	multipass exec $vm -- bash -c "$CreateDirCMD"	

    # 3. Construct the command to copy files within the VM to the above sub directory
    $copyCommand = "sudo cp -r $mountPoint/* $targetPath$targetDir"
	Write-Host "CMD exec: multipass exec $vm -- bash -c $copyCommand"
	multipass exec $vm -- bash -c "$copyCommand"
	Write-Host "`n"
	
	# 3.2 Make start up script executable (Another example what can not be done in mounted dir)
	$ExeCMD = "sudo chmod +x  $targetPath$targetDir$sharedDir/start.sh"
	Write-Host "CMD exec: multipass exec $vm -- bash -c $ExeCMD"
	multipass exec $vm -- bash -c "$ExeCMD"	
	
}



# Wait for a key press before closing
Write-Host "`n`nDone! press anykey`n`n"
$x = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")


