# This file is part of: PHP Development Template Stack 
# Copyright (c) 2024 Nico Jan Eelhart
#
# This source code is licensed under the MIT License found in the  'LICENSE.md' file in the root directory of this source tree.
#

# Import-Module TerminalLayout                 # alternative 'Dot sourcing': . .\TerminalLayout
# Get-Command -Module '.\TerminalLayout'       # Helper Show list of items exported
# Get-Module -ListAvailable                    # displays all modules available in the module path: $ENV:PSModulePath
# Get-Module 'TerminalLayout'                  # displays all modules available in the module path: $ENV:PSModulePath
#		- WARNING In Vs Code you must restart your session if you make changes in a module file!



# ****************************************************************************************************************************
#
#	Purpose:	x
#						multipass launch -c 3 -m 4G --network ip=<desired_ip_address> docker --name VNode1
#	
# ****************************************************************************************************************************




# Display some initial information
# -------------------------------------------------------------------------------------------------------- 
function DisplayTitleHeader()
{
  & cmd /c cls
  Write-Host "`t`t`t`t Create X Multipass Virtual machines for Docker Swarm`t`n`n " -NoNewline -ForegroundColor Green    
}


function InputContainerName()
{      
  Write-Host "`n`tEnter number of Multipass VMs to create " -NoNewline
  Write-Host "" "red"
  [int] $Userinput = Read-Host 
  if (($Userinput -isnot [int])) 
	{ Throw 'You did not provide a number as input' }

  Write-Host  
  return $Userinput
}


function CreateMultipassNode()
{
	param([int] $i)

	for($j=1; $j -le $i; $j++) 
	{
		$name = "VNode$j"			# DON'T Use underscore in the name! 
		$cmd_Pref = "-c 3 -m 4G"	# set basic config for VM, 4G is minimum!	
		Write-Host ("`n`tExecuting:'multipass launch $cmd_Pref docker --name $name'") "green"		
		#& cmd /c "multipass launch docker --name $name"		
		$command = "multipass launch $cmd_Pref docker --name $name"
		Start-Process cmd -ArgumentList "/c $command" -Wait				
	}
	
	# List the Nodes
	Write-Host
	Write-Host "`n`n`tDone these are the current available multipass VM Hosts:`n`n"
	$command = "multipass ls"	
	& cmd /c "$command"
	
}



# MAIN ENTRY POINT
# **************************************************************************************************************************************
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process

DisplayTitleHeader
$iNumber = InputContainerName
Write-Host "`tYou want to create " 
Write-Host " $iNumber Vms. The first is called: VMNode1  `n`n`n`t" "green"
Write-Host

CreateMultipassNode($iNumber)


#  multipass delete VMNode1 VMNode2 VMNode3
#  multipass purge

Write-Host "`n`nPress any key to continue...";
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');


