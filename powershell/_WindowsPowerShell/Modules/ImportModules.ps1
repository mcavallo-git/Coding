# ------------------------------------------------------------
#  PowerShell Modules Sync
# ------------------------------------------------------------
#
$GithubOwner="mcavallo-git";
$GithubRepo="Coding";
#
if ($false) {
	#
	#	Enable Auto-Sync to GitHub.com
	#		--|> Copy-Paste the following line of code to sync to your PowerShell of choice
	#		--|> Note: Built for compatibility between Windows, Linux (e.g. PowerShell Core), & Browser-based (e.g. Azure's Cloud Shell) Terminals
	#
	$GithubOwner="mcavallo-git"; $GithubRepo="Coding"; If (Test-Path "${HOME}/${GithubRepo}") { Set-Location "${HOME}/${GithubRepo}"; git reset --hard "origin/master"; git pull; } Else { Set-Location "${HOME}"; git clone "https://github.com/${GithubOwner}/${GithubRepo}.git"; } . "${HOME}/${GithubRepo}/powershell/_WindowsPowerShell/Modules/ImportModules.ps1";
}
#
# ------------------------------------------------------------

$PSM1 = @{};
# $PSM1.Verbosity = 0;
$PSM1.Verbosity = 1;
$PSM1.InvocationBasename = ([IO.Path]::GetFileNameWithoutExtension($MyInvocation.MyCommand.Name));

# ------------------------------------------------------------

## Determine if we just ran this script (before updating it) or not
If ($Env:UpdatedCodebase -eq $null) {
	$PSM1.Iteration = 1;
} Else {
	$PSM1.Iteration = 2;
}

# ------------------------------------------------------------

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

# ------------------------------------------------------------
## Install the NuGet "PowerShell Gallery"
If ((Get-PackageProvider -Name "NuGet") -Eq $Null) {
	Install-PackageProvider -Name "NuGet" -Force;
}

## Array of Modules to download from the "PowerShell Gallery" (repository of modules, similar to "apt-get" in Ubuntu, or "yum" in CentOS)
$PSGalleryModules = @("platyPS", "PSWindowsUpdate");
If ($PSM1.Iteration -eq 1) {
	Write-Host "`n$($PSM1.InvocationBasename) - Task: Import powershell modules (pass $($PSM1.Iteration)/2, - microsoft gallery modules)" -ForegroundColor Gray;
	Foreach ($EachGalleryModule In ($PSGalleryModules)) {
		If (!(Get-Module -ListAvailable -Name ($EachGalleryModule))) {
			Install-Module -Name ($EachGalleryModule) -Scope CurrentUser -Force;
		}
		Import-Module ($EachGalleryModule);
		$import_exit_code = If($?){0}Else{1};
		If ($import_exit_code -ne 0) {
			# Failed Module Import
			Write-Host "$($PSM1.InvocationBasename) - Fail: Exit-Code [ $($import_exit_code) ] returned from Import-Module: $EachGalleryModule" -ForegroundColor Yellow;
			# Start-Sleep -Seconds 60;
			# Exit 1;

		} Else {
			# Successful Module Import
			Write-Host "$($PSM1.InvocationBasename) - Pass: Module Imported (cached onto RAM): $EachGalleryModule" -ForegroundColor Cyan;
		}
	}
} ElseIf ($PSM1.Iteration -eq 2) {
	Write-Host "`n$($PSM1.InvocationBasename) - Task: Import powershell modules (pass $($PSM1.Iteration)/2, - git repository modules)" -ForegroundColor Gray;
}

# ------------------------------------------------------------

$ThisScript          = @{};
$ThisScript.Dirname  = ($PSScriptRoot);
$ThisScript.Path     = ($MyInvocation);
$ThisScript.Command  = (($ThisScript.Path).MyCommand);
$ThisScript.Basename = (($ThisScript.Command).Name);
# $ThisScript | Format-List;

# ------------------------------------------------------------
#
# Ensure that [Powershell's Modules directory] exists
#

# Get [ the list of all PS_Modules directories ]
Set-Location -Path ("/");
$PSMod_SplitChar = If (($Env:PSModulePath.Split(';')) -eq ($Env:PSModulePath)) { ':' } Else { ';' };
$PSMod_Lines = ($Env:PSModulePath).Split($PSMod_SplitChar);

# Get the [ unique PS_Modules directory associated with this user ] from [ the list of all PS_Modules directories ]
$PSMod_Dir = $PSMod_Lines -match ((("^")+(${HOME})).Replace("\", "\\"));

# Get Parent directories which the [ unique PS_Modules directory associated with this user ] is dependent-on
$PSModDir_SplitChar = If (($PSMod_Dir.Split('/')) -eq ($PSMod_Dir)) { '\' } Else { '/' };
$PSMod_HomeDir = $PSMod_Dir.Replace(((${HOME})+($PSModDir_SplitChar)),"");
$PSMod_ParentDirs = $PSMod_HomeDir.Split($PSModDir_SplitChar);

# Create parent-directories which are [ required ancestors to the PowerShell Modules' directory ] but are currently [ non-existent ]
$PSM1.fullpath = ${HOME};
For ($i=0; $i -lt $PSMod_ParentDirs.length; $i++) {
	$PSM1.fullpath += (($PSModDir_SplitChar)+($PSMod_ParentDirs[$i]));
	If ((Test-Path -PathType Container -Path (($PSM1.fullpath)+($PSModDir_SplitChar))) -eq $false) {
		# Directory doesn't exist - create it
		If ($PSM1.Verbosity -ne 0) {
			Write-Host "$($PSM1.InvocationBasename) - Task: Create parent-directory for Modules: $($PSM1.fullpath)" -ForegroundColor Gray;
		}
		New-Item -ItemType "Directory" -Path (($PSM1.fullpath)+($PSModDir_SplitChar)) | Out-Null;
	} Else {
		# Directory exists - skip it
		If ($PSM1.Verbosity -ne 0) {
			Write-Host "$($PSM1.InvocationBasename) - Skip: Parent-directory for Modules already exists: $($PSM1.fullpath)";
		}
	}
}
If ($PSM1.Verbosity -ne 0) {
	Write-Host "$($PSM1.InvocationBasename) - Info: PowerShell Modules directory's fullpath: $($PSM1.fullpath)";
}

# Ensure that the User-Specific PowerShell Modules Directory exists
If ((Test-Path -PathType Container -Path ($PSScriptRoot)) -Eq $false) {

	# Directory NOT found
	If ($PSM1.Verbosity -ne 0) {
		Write-Host "$($PSM1.InvocationBasename) - Fail: Missing git source directory: ${PSScriptRoot}" -ForegroundColor Yellow;
	}
	# Start-Sleep -Seconds 60;
	# Exit 1;

} Else {

	# Directory found
	If ($PSM1.Verbosity -ne 0) {
		Write-Host "$($PSM1.InvocationBasename) - Pass: Located powershell modules directory: ${PSScriptRoot}" -ForegroundColor Cyan;
	}

}

# ------------------------------------------------------------
#
# Update each module from the git repository
#

# Git-Reposity's -> Find all PowerShell Modules (along with their respectively named directories) to copy into a given machine's PowerShell Modules Directory
If ($PSM1.Verbosity -ne 0) {
	Write-Host "$($PSM1.InvocationBasename) - Task: Searching `"${PSScriptRoot}`" for PowerShell Modules..." -ForegroundColor Gray;
}

$PowerShellModulesArr = (Get-ChildItem -Path "${PSScriptRoot}" -Filter "*.psm1" -Depth (256) -File -Recurse -Force -ErrorAction "SilentlyContinue");

Foreach ($EachModule In $PowerShellModulesArr) {

	If ($PSM1.Verbosity -ne 0) {
		Write-Host " ";
	}

	$EachBasename_NoExt = ([IO.Path]::GetFileNameWithoutExtension($EachModule.Name));

	# Check if each Module's unique-name already exists in current PowerShell session
	If (Get-Module -Name ($EachModule.Name)) {
		# Remove Module's from current PowerShell session (clears it from being cached in Memory, e.g. RAM)
		Remove-Module ($EachModule.Name);
		If ($PSM1.Verbosity -ne 0) {
			Write-Host "$($PSM1.InvocationBasename) - Task: Removing Module (from RAM-Cache): ${EachBasename_NoExt}" -ForegroundColor Gray;
		}
		If (Get-Module -Name ($EachModule.Name)) {
			If ($PSM1.Verbosity -ne 0) {
				Write-Host "$($PSM1.InvocationBasename) - Fail: Unable to remove Module (from RAM-Cache): ${EachBasename_NoExt}" -ForegroundColor Yellow;
			}
		} Else {
			If ($PSM1.Verbosity -ne 0) {
				Write-Host "$($PSM1.InvocationBasename) - Pass: Removed Module (from RAM-Cache): ${EachBasename_NoExt}" -ForegroundColor Cyan;
			}
		}
	}
	
	$ModuleFile = $EachModule.FullName;
	$ModuleDirectory = $EachModule.Directory.FullName;

	$StartupModuleFile = $ModuleFile.Replace(${PSScriptRoot}, $PSM1.fullpath);
	$StartupModuleDirectory = $ModuleDirectory.Replace(${PSScriptRoot}, $PSM1.fullpath);

	# Module parent-directory - Create if not-found in destination
	If ((Test-Path -Path ($StartupModuleDirectory)) -eq $false) {
		
		# Create directory
		If ($PSM1.Verbosity -ne 0) {
			Write-Host "$($PSM1.InvocationBasename) - Task: Create directory for Module: ${EachBasename_NoExt}" -ForegroundColor Gray;
		}

		New-Item -ItemType "Directory" -Path (($StartupModuleDirectory)+("/")) | Out-Null;

		If ((Test-Path -Path ($StartupModuleDirectory)) -eq $false) {

			# Error: Unable to create directory
			If ($PSM1.Verbosity -ne 0) {
				Write-Host "$($PSM1.InvocationBasename) - Fail: Unable to create directory for Module: ${EachBasename_NoExt}" -ForegroundColor Yellow;
			}
			# Start-Sleep -Seconds 60;
			# Exit 1;

		} Else {

			# Directory successfully created
			If ($PSM1.Verbosity -ne 0) {
				Write-Host "$($PSM1.InvocationBasename) - Pass: Directory created for Module: ${EachBasename_NoExt}" -ForegroundColor Cyan;
			}

		}

	}

	# Item which is a file
	If ((Test-Path -Path ($StartupModuleFile)) -eq $false) {
		
		# Create the destination if it doesn't exist, yet
		If ($PSM1.Verbosity -ne 0) {
			Write-Host "$($PSM1.InvocationBasename) - Task: Copy Module: ${EachBasename_NoExt}" -ForegroundColor Gray;
		}
		Copy-Item -Path ($ModuleFile) -Destination ($StartupModuleFile) -Force;
		
		# Check for failure to copy item(s)
		If ((Test-Path -Path ($StartupModuleFile)) -eq $false) {

			# Error: Unable to create Module
			If ($PSM1.Verbosity -ne 0) {
				Write-Host "$($PSM1.InvocationBasename) - Fail: Unable to copy Module: ${EachBasename_NoExt}" -ForegroundColor Yellow;
			}
			# Start-Sleep -Seconds 60;
			# Exit 1;

		} Else {

			# Module successfully created
			If ($PSM1.Verbosity -ne 0) {
				Write-Host "$($PSM1.InvocationBasename) - Pass: Module copied: ${EachBasename_NoExt}" -ForegroundColor Cyan;
			}

		}

	} Else {

		# Files - Copy / Update any not-found in Destination
		$path_source_last_write = [datetime](Get-ItemProperty -Path $ModuleFile -Name LastWriteTime).lastwritetime;
		$path_destination_last_write = [datetime](Get-ItemProperty -Path $StartupModuleFile -Name LastWriteTime).lastwritetime;

		If ($path_source_last_write -gt $path_destination_last_write) {

			# If the source file has a new revision, then update the destination file with said changes
			If ($PSM1.Verbosity -ne 0) {
				Write-Host "$($PSM1.InvocationBasename) - Task: Updating Module: ${EachBasename_NoExt}" -ForegroundColor Gray;
			}

			Copy-Item -Path ($ModuleFile) -Destination ($StartupModuleFile) -Force;

			# Check for failure to copy item(s)
			If ((Test-Path -Path ($StartupModuleFile)) -eq $false) {

				# Error: Couldn't update/overwrite a file, etc.
				If ($PSM1.Verbosity -ne 0) {
					Write-Host "$($PSM1.InvocationBasename) - Fail: Unable to be update Module: ${EachBasename_NoExt}" -ForegroundColor Yellow;
				}
				# Start-Sleep -Seconds 60;
				# Exit 1;

			} Else {
				# File copied from source to destination successfully
				If ($PSM1.Verbosity -ne 0) {
					Write-Host "$($PSM1.InvocationBasename) - Pass: Module updated: ${EachBasename_NoExt}" -ForegroundColor Cyan;
				}
			}
		} Else {
			# No updates necessary
			If ($PSM1.Verbosity -ne 0) {
				Write-Host "$($PSM1.InvocationBasename) - Pass: Module already up-to-date: ${EachBasename_NoExt}" -ForegroundColor Cyan;
			}
		}
	}

	#
	# $PSM1.ImportModules = @{};
	# $PSM1.ImportModules.Dirname = ($PSScriptRoot);
	# $PSM1.ImportModules.Basename = ($MyInvocation.MyCommand.Name);
	#

	If (($EachModule.Name) -eq ($MyInvocation.MyCommand.Name)) {
		# Dont let a file include itself... that causes infinite loops~!
		If ($PSM1.Verbosity -ne 0) {
			Write-Host "$($PSM1.InvocationBasename) - Skip: Avoiding self-import: ${EachBasename_NoExt}";
		}

	} Else {
		
		$RequiredModules_FirstIteration = @("EnsureCommandExists","GitCloneRepo","ProfileSync");

		# If [ we've already updated the codebase (iteration 2) ] or [ we are on a module which is required to update the codebase ]
		If (($Env:UpdatedCodebase -Eq $True) -Or (($RequiredModules_FirstIteration -Match ($EachModule.Name)) -Eq ($EachModule.Name))) {

			# Import the Module now that it is located in a valid Modules-directory (unless environment is configured otherwise)
			If ($PSM1.Verbosity -Ne 0) {
				Write-Host "$($PSM1.InvocationBasename) - Task: Importing Module (caching onto RAM): ${EachBasename_NoExt}" -ForegroundColor Gray;
			}
			
			Import-Module ($StartupModuleFile);
			$import_exit_code = If($?){0}Else{1};
			
			If ($import_exit_code -Ne 0) {
				# Failed Module Import
				Write-Host "$($PSM1.InvocationBasename) - Fail: Unable to import module `"${EachBasename_NoExt}`"" -ForegroundColor Yellow;
				# Start-Sleep -Seconds 60;
				# Exit 1;

			} Else {
				# Successful Module Import
				Write-Host "$($PSM1.InvocationBasename) - Pass: Module imported (cached onto RAM): ${EachBasename_NoExt}" -ForegroundColor Cyan;

			}
		}
	}
}

$CommandExists = @{};

If ($Env:UpdatedCodebase -eq $null) {

	# Iteration 1/2: Upon login, before [ updating from git-repo ]

	$CommandExists.git = `
		EnsureCommandExists `
			-Name ("git") `
			-OnErrorShowUrl ("https://git-scm.com/downloads") `
			-Quiet;


	$RepoUpdate = `
		GitCloneRepo `
			-Url ("https://github.com/${GithubOwner}/${GithubRepo}") `
			-LocalDirname ("${HOME}");

	$Env:UpdatedCodebase = $true;
	
	Set-Location ("${HOME}");

	. "./${GithubRepo}/powershell/_WindowsPowerShell/Modules/ImportModules.ps1";


} Else {

	# Iteration 2/2 - Upon login, after [ updating from git-repo ], which applies [ Modules to be used throughout the user's session ]

	ProfileSync `
		-OverwriteProfile `
		-GithubOwner (${GithubOwner}) `
		-GithubRepo (${GithubRepo}) `
		-Quiet;

	If ( $False -Eq $True ) {
		# # Do not require .NET Core by default as-of 2019-10-01_04-27-48
		$CommandExists.dotnet = `
			EnsureCommandExists `
				-Name ("dotnet") `
				-OnErrorShowUrl ("https://dotnet.microsoft.com/download/archives") `
				-Quiet;
	
	}

	$Env:UpdatedCodebase = $null;
	
}

# Write-Host " ";
