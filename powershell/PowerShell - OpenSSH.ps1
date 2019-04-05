#
# if [ -z "$SSH_AGENT_PID" ]; then
# 	echo "Starting service:   ssh-agent";
# 	eval $(ssh-agent -s);
# fi;
#

# Require Elevated Permissions (Admin Privileges)
If (([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
	# User IS an admin --> Continue-on with running the script

	# ---------------------------------------------------------------------------------------------------------------------------------------------------
	#
	#	OpenSSH - Define service's name (to target)
	#
	# Define the service which should be 'always-on'
	$ServiceName = "ssh-agent";
	$ServiceDetails = (Get-Service -Name "$ServiceName");
	$ServiceDisplayName = ($ServiceDetails.DisplayName);
	#
	# ---------------------------------------------------------------------------------------------------------------------------------------------------
	#
	# Locate 'git.exe'
	$GitExeFilepath = (Get-Command -Name "git").Source;
	#
	# Find git's associated base-directory
	$GitBasedir = (Get-Item ($GitExeFilepath)).Directory.Parent.Parent.FullName;
	#
	# Find packaged module: openssh & update it's config-file
	$OpenSSH_ClientConfig = (($GitBasedir)+("/etc/ssh/ssh_config"));
	$OpenSSH_ServerConfig = (($GitBasedir)+("/etc/ssh/sshd_config"));
	#
	# Configure the OpenSSH-server to no-longer default to using the AuthorizedKeys file, which defaults to ".ssh/authorized_keys"
	((Get-Content -path "$OpenSSH_ServerConfig" -Raw) -replace 'AuthorizedKeysFile','#AuthorizedKeysFile') | Set-Content -Path "$OpenSSH_ServerConfig";

	# ---------------------------------------------------------------------------------------------------------------------------------------------------
	#
	# OpenSSH Service
	#
	#  --> Moving-forwards, ensure that the targeted service starts on-boot
	If (($ServiceDetails.StartType) -ne "Automatic") {
		Write-Host (("`n`nUpdating service `"$ServiceDisplayName`" - Changing startup-type from `"")+($ServiceDetails.StartType)+"`" to `"Automatic`"");
		Set-Service -Name $ServiceName -StartupType "Automatic";
	} Else {
		Write-Host ("`n`nNo update required for startup-type --> Service `"$ServiceDisplayName`" already has it's value set to `"Automatic`"");
	}

	# Also, start the service right-now, so we don't have to wait for the next boot or ask the user to restart
	$ServiceDetails = (Get-Service -Name "$ServiceName");
	If (($ServiceDetails.Status) -ne "Running") {
		Write-Host (("`n`nStarting service `"$ServiceDisplayName`" (currently, service is `"")+($ServiceDetails.Status)+("`")"));
		Start-Service -Name "$ServiceName";
	} Else {
		Write-Host ("`n`nNo startup required --> Service `"$ServiceDisplayName`" already has status `"Running`"");
	}

	cd "$HOME\Documents\Github\tester";

	# git clone "git@...";

	$confirmation = Read-Host ("`n`nExit by pressing Enter ");

	Exit;

# cd "$HOME\Documents\Github\tester";

# ssh -i "$HOME\.ssh\devops\mcavallo\azure.devops.mcavallo.private.created.2019.04.03.pem" -p "9418" "git@ssh.dev.azure.com";

# . "$HOME/Desktop/OpenSSH.ps1";




} Else { # Restart the script w/ Admin rights
	
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`" $PSCommandArgs" -Verb RunAs;
	
	$confirmation = Read-Host ("`n`n  Continue by pressing Enter");

}