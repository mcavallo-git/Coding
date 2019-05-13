# -------------------------------------------------------------------------------------------------------------------------------------------------------------------------- #

#  Azure Portal - Cloud Shell Sync
#
#   --|> SYNC THIS SCRIPT ( Step 1 of 2 ): Log into the Azure Cloud Shell at [ https://shell.azure.com ]
#
if ($false) {
#
#   --|> SYNC THIS SCRIPT ( Step 2 of 2 ): With the following line of code: Copy it, Paste it into Azure's Cloud Shell, Run it by hitting *Enter* after Paste

Set-Location -Path ($Home); Remove-Item ("./boneal_public") -Force -Recurse -ErrorAction SilentlyContinue; git clone "https://github.com/bonealnet/boneal_public.git"; . "./boneal_public/powershell/_WindowsPowerShell/Modules/ImportModules.ps1";

}

# -------------------------------------------------------------------------------------------------------------------------------------------------------------------------- #

$psm1 = @{};
$psm1.verbosity = 0;

# -------------------------------------------------------------------------------------------------------------------------------------------------------------------------- #

## Determine if we just ran this script (before updating it) or not
If ($Env:UpdatedCodebase -eq $null) {
	$psm1.iteration = 1;
} Else {
	$psm1.iteration = 2;
}

# -------------------------------------------------------------------------------------------------------------------------------------------------------------------------- #

# Detect the current runtime operating-system
#  --> Note that "Powershell Core" began at version 6.0 (for Linux & MacOS), therefore any version
#      of PowerShell before v6.0 must be a [ Non-PowerShell-Core Windows ] environment
$ReadOnlyVars = (Get-Variable | Where-Object {$_.Options -like '*ReadOnly*'}).Name;
If ( -not ($ReadOnlyVars -match ("IsCoreCLR"))) {

	# $IsCoreCLR
	$SetVal = If($IsCoreCLR -ne $null){$IsCoreCLR}ElseIf(($PSVersionTable.PSVersion.Major) -lt 6){$false}Else{$true};
	Set-Variable -Name "IsCoreCLR" -Scope "Global" -Visibility "Public" -Option "ReadOnly, AllScope" -Value $SetVal;

	# $IsLinux
	$SetVal = If($IsLinux -ne $null){$IsLinux} ElseIf((Test-Path "/bin") -And (-Not (Test-Path "/Library"))){$true} Else{$false};
	Set-Variable -Name "IsLinux" -Scope "Global" -Visibility "Public" -Option "ReadOnly, AllScope" -Value $SetVal;

	# $IsMacOS
	$SetVal = If($IsMacOS -ne $null){$IsMacOS} ElseIf((Test-Path "/Library") -And ($IsLinux -eq $false)){$true} Else{$false};
	Set-Variable -Name "IsMacOS" -Scope "Global" -Visibility "Public" -Option "ReadOnly, AllScope" -Value $SetVal;
	
	# $IsWindows
	$SetVal = If($IsWindows -ne $null){$IsWindows} ElseIf(($IsCoreCLR -eq $false) -or (($IsLinux -eq $false) -And ($IsMacOS -eq $false))){$true} Else{$false};
	Set-Variable -Name "IsWindows" -Scope "Global" -Visibility "Public" -Option "ReadOnly, AllScope" -Value $SetVal;

}

# -------------------------------------------------------------------------------------------------------------------------------------------------------------------------- #

## Array of Modules to download from the "PowerShell Gallery" (repository of modules, similar to "apt-get" in Ubuntu, or "yum" in CentOS)
$PSGalleryModules = @("platyPS");
If ($psm1.iteration -eq 1) {
	Write-Host (("`nTask - ImportModules (Pass ")+($psm1.iteration)+("/2) - Syncing Gallery Module(s)...")) -ForegroundColor green;
	Foreach ($EachGalleryModule In ($PSGalleryModules)) {
		If (!(Get-Module -ListAvailable -Name ($EachGalleryModule))) {
			Install-Module -Name ($EachGalleryModule) -Scope CurrentUser -Force;
		}
		Import-Module ($EachGalleryModule);
		$import_exit_code = If($?){0}Else{1};
		If ($import_exit_code -ne 0) {
			# Failed Module Import
			Write-Host (("Fail - Exit-Code [ ") + ($import_exit_code) + (" ] returned from Import-Module: ") + ($EachGalleryModule));
			Start-Sleep -Seconds 60;
			Exit 1;
		} Else {
			# Successful Module Import
			Write-Host (("Pass - Module Imported (cached onto RAM): ") + ($EachGalleryModule));
		}
	}
} ElseIf ($psm1.iteration -eq 2) {
	Write-Host (("`nTask - ImportModules (Pass ")+($psm1.iteration)+("/2) - Importing Git-Repository Module(s)...")) -ForegroundColor green;
}

# -------------------------------------------------------------------------------------------------------------------------------------------------------------------------- #

$ThisScript          = @{};
$ThisScript.Dirname  = ($PSScriptRoot);
$ThisScript.Path     = ($MyInvocation);
$ThisScript.Command  = (($ThisScript.Path).MyCommand);
$ThisScript.Basename = (($ThisScript.Command).Name);
# $ThisScript | Format-List;

# -------------------------------------------------------------------------------------------------------------------------------------------------------------------------- #
#
# Ensure that [Powershell's Modules directory] exists
#

# Get [ the list of all PS_Modules directories ]
Set-Location -Path ("/");
$PSMod_SplitChar = If (($Env:PSModulePath.Split(';')) -eq ($Env:PSModulePath)) { ':' } Else { ';' };
$PSMod_Lines = ($Env:PSModulePath).Split($PSMod_SplitChar);
# Get the [ unique PS_Modules directory associated with this user ] from [ the list of all PS_Modules directories ]
$PSMod_Dir = $PSMod_Lines -match ((("^")+($Home)).Replace("\", "\\"));
# Get Parent directories which the [ unique PS_Modules directory associated with this user ] is dependen-on
$PSModDir_SplitChar = If (($PSMod_Dir.Split('/')) -eq ($PSMod_Dir)) { '\' } Else { '/' };
$PSMod_HomeDir = $PSMod_Dir.Replace((($Home)+($PSModDir_SplitChar)),"");
$PSMod_ParentDirs = $PSMod_HomeDir.Split($PSModDir_SplitChar);
# Create parent-directories which are [ required ancestors to the PowerShell Modules' directory ] but are currently [ non-existent ]
$psm1.fullpath = $Home;
For ($i=0; $i -lt $PSMod_ParentDirs.length; $i++) {
	$psm1.fullpath += (($PSModDir_SplitChar)+($PSMod_ParentDirs[$i]));
	If ((Test-Path -PathType Container -Path (($psm1.fullpath)+($PSModDir_SplitChar))) -eq $false) {
		# Directory doesn't exist - create it
		If ($psm1.verbosity -ne 0) { Write-Host (("Task - Create parent-directory for Modules: ")+($psm1.fullpath)); }
		New-Item -ItemType "Directory" -Path (($psm1.fullpath)+($PSModDir_SplitChar)) | Out-Null;
	} Else {
		# Directory exists - skip it
		If ($psm1.verbosity -ne 0) { Write-Host (("Skip - Parent-directory for Modules already exists: ")+($psm1.fullpath)); }
	}
}
If ($psm1.verbosity -ne 0) { Write-Host (("Info - PowerShell Modules directory's fullpath: ")+($psm1.fullpath)); }

# -------------------------------------------------------------------------------------------------------------------------------------------------------------------------- #
#
# Update each module from the Git-Repository
#

$psm1.git_source = ($PSScriptRoot);
$psm1.git_source_exists = Test-Path -PathType Container -Path ($psm1.git_source); 

If ($psm1.git_source_exists -eq $false) {

	If ($psm1.verbosity -ne 0) { Write-Host (("Fail - Missing [git source directory]: ") + ($psm1.git_source)); }
	Start-Sleep -Seconds 60;
	Exit 1;

}

If ($psm1.verbosity -ne 0) { Write-Host (("Pass - Found [Updated Modules directory]: ") + ($psm1.git_source)); }

# Git Modules (along with their respectively named directories) to copy into a given machine's PowerShell Modules Directory
$psm1.git_modules = Get-ChildItem -Path (($psm1.git_source)+("/*")) -Recurse;

Foreach ($file In ($psm1.git_modules)) {
	If ($psm1.verbosity -ne 0) { Write-Host (" "); }

	# Remove Module's Cache from RAM (to avoid [ working on modules which are cached in RAM ], [ duplicated modules from previous-revisions ], [ etc. ])
	If (Get-Module -Name ($file.BaseName)) {
		Remove-Module ($file.BaseName);
		If ($psm1.verbosity -ne 0) { Write-Host (("Task - Removing Module (from RAM-Cache): ") + ($file.BaseName)); }
		If (Get-Module -Name ($file.BaseName)) {
			If ($psm1.verbosity -ne 0) { Write-Host (("Fail - Unable to remove Module (from RAM-Cache): ") + ($file.BaseName)); }
		} Else {
			If ($psm1.verbosity -ne 0) { Write-Host (("Pass - Removed Module (from RAM-Cache): ") + ($file.BaseName)); }
		}
	}
	
	$path_source = $file.FullName;

	$path_destination = $path_source.Replace($psm1.git_source, $psm1.fullpath);

	$path_destination_exists = Test-Path -Path ($path_destination);

	$source_is_file = Test-Path -PathType Leaf -Path ($path_source);
	$source_is_dir = Test-Path -PathType Container -Path ($path_source);

	If ($source_is_dir -eq $true) {

		# Directories - Create any not-found in Destination
		If ($path_destination_exists -eq $false) {
			
			# Create directory
			If ($psm1.verbosity -ne 0) { Write-Host (("Task - Create directory for Module: ") + ($file.BaseName)+("")); }

			New-Item -ItemType "Directory" -Path (($path_destination)+("/")) | Out-Null;

			$path_destination_exists = Test-Path -PathType Container -Path ($path_destination);

			If ($path_destination_exists -eq $false) {

				# Error - Unable to create directory
				If ($psm1.verbosity -ne 0) { Write-Host (("Fail - Unable to create directory for Module: ") + ($file.BaseName)); }
				Start-Sleep -Seconds 60;
				Exit 1;

			} Else {

				# Directory successfully created
				If ($psm1.verbosity -ne 0) { Write-Host (("Pass - Directory created for Module: ") + ($file.BaseName)); }

			}

		} Else {

			# Directory already exists
			If ($psm1.verbosity -ne 0) { Write-Host (("Skip - Directory already exists for Module: ") + ($file.BaseName)+("")); }

		}

	} ElseIf ($source_is_file -eq $false) {

		# Item which is neither a file nor a directory
		If ($psm1.verbosity -ne 0) { Write-Host (("Skip - Invalid item (non-file, non-directory): ") + ($path_source)+("")); }

	} Else {

		# Item which is a file
		If ($path_destination_exists -eq $false) {
			
			# Create the destination if it doesn't exist, yet
			If ($psm1.verbosity -ne 0) { Write-Host (("Task - Creating Module: ") + ($file.BaseName)); }

			Copy-Item -Path ($path_source) -Destination ($path_destination) -Force;

			$path_destination_exists = Test-Path -PathType Leaf -Path ($path_destination);
			
			# Check for failure to copy item(s)
			If ($path_destination_exists -eq $false) {

				# Error - Unable to create Module
				If ($psm1.verbosity -ne 0) { Write-Host (("Fail - Unable to create Module: ") + ($file.BaseName)); }
				Start-Sleep -Seconds 60;
				Exit 1;

			} Else {

				# Module successfully created
				If ($psm1.verbosity -ne 0) { Write-Host (("Pass - Module created: ") + ($file.BaseName)); }

			}

		} Else {

			# Files - Copy / Update any not-found in Destination
			$path_source_last_write = [datetime](Get-ItemProperty -Path $path_source -Name LastWriteTime).lastwritetime;
			$path_destination_last_write = [datetime](Get-ItemProperty -Path $path_destination -Name LastWriteTime).lastwritetime;

			If ($path_source_last_write -gt $path_destination_last_write) {

				# If the source file has a new revision, then update the destination file with said changes
				If ($psm1.verbosity -ne 0) { Write-Host (("Task - Updating Module: ") + ($file.BaseName)); }

				Copy-Item -Path ($path_source) -Destination ($path_destination) -Force;

				$path_destination_exists = Test-Path -PathType Leaf -Path ($path_destination);

				# Check for failure to copy item(s)
				If ($path_destination_exists -eq $false) {

					# Error - Couldn't update/overwrite a file, etc.
					If ($psm1.verbosity -ne 0) { Write-Host (("Fail - Unable to be update Module: ") + ($file.BaseName)); }
					Start-Sleep -Seconds 60;
					Exit 1;

				} Else {

					# File copied from source to destination successfully
					If ($psm1.verbosity -ne 0) { Write-Host (("Pass - Module updated: ") + ($file.BaseName)); }
				}
			} Else {

				# No updates necessary
				If ($psm1.verbosity -ne 0) { Write-Host (("Pass - Module already up-to-date: ") + ($file.BaseName)); }

			}
		}

		$psm1.ImportModules = @{};
		$psm1.ImportModules.Dirname = ($PSScriptRoot);
		$psm1.ImportModules.Basename = ($MyInvocation.MyCommand.Name);

		If (($file.Name) -eq ($psm1.ImportModules.Basename)) {
			# Dont let a file include itself... that causes infinite loops~!
			If ($psm1.verbosity -ne 0) {
				Write-Host (("Skip - Avoiding self-import: ") + ($file.BaseName));
			}

		} Else {
			
			$RequiredModules_FirstIteration = @("EnsureCommandExists","GitCloneRepo","ProfilePrep");

			# If [ we've already updated the codebase (iteration 2) ] or [ we are on a module which is required to update the codebase ]
			If (($Env:UpdatedCodebase -eq $true) -or (($RequiredModules_FirstIteration -match ($file.BaseName)) -eq ($file.BaseName))) {

				# Import the Module now that it is located in a valid Modules-directory (unless environment is configured otherwise)
				If ($psm1.verbosity -ne 0) { Write-Host (("Task - Importing Module (caching onto RAM): ") + ($file.BaseName)); }
				
				Import-Module ($path_destination);

				$import_exit_code = If($?){0}Else{1};
				
				If ($import_exit_code -ne 0) {

					# Failed Module Import
					Write-Host (("Fail - Exit-Code [ ") + ($import_exit_code) + (" ] returned from Import-Module: ") + ($file.BaseName));
					Start-Sleep -Seconds 60;
					Exit 1;

				} Else {
					# Successful Module Import
					Write-Host (("Pass - Module imported (cached onto RAM): ") + ($file.BaseName));

				}
			}
		}
	}
}

$CommandExists = @{};

If ($Env:UpdatedCodebase -eq $null) {

	# Iteration 1/2: Upon login, before [ updating from git-repo ]

	$CheckCommand_git = `
		EnsureCommandExists `
			-Name "git" `
			-OnErrorShowUrl "https://git-scm.com/downloads" `
			-Quiet;


	$RepoUpdate = `
		GitCloneRepo `
			-Url "https://github.com/bonealnet/boneal_public" `
			-LocalDirname (($Home));

	$Env:UpdatedCodebase = $true;
	
	Set-Location -Path ($Home);

	. "./boneal_public/powershell/_WindowsPowerShell/Modules/ImportModules.ps1";


} Else {

	# Iteration 2/2 - Upon login, after [ updating from git-repo ], which applies [ Modules to be used throughout the user's session ]

	ProfilePrep `
		-OverwriteProfile `
		-Quiet;

	$CheckCommand_dotnet = `
		EnsureCommandExists `
			-Name "dotnet" `
			-OnErrorShowUrl "https://dotnet.microsoft.com/download/archives" `
			-Quiet;

	$Env:UpdatedCodebase = $null;
	
}

# Write-Host " ";
