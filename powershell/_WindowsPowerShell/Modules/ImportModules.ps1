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

$psm1 = @{};
$psm1.verbosity = 0;

# ------------------------------------------------------------

## Determine if we just ran this script (before updating it) or not
If ($Env:UpdatedCodebase -eq $null) {
	$psm1.iteration = 1;
} Else {
	$psm1.iteration = 2;
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

## Array of Modules to download from the "PowerShell Gallery" (repository of modules, similar to "apt-get" in Ubuntu, or "yum" in CentOS)
$PSGalleryModules = @("platyPS");
If ($psm1.iteration -eq 1) {
	Write-Host "`n$([IO.Path]::GetFileNameWithoutExtension($MyInvocation.MyCommand.Name)) - Task: Import powershell modules (pass $($psm1.iteration)/2, - microsoft gallery modules)" -ForegroundColor green;
	Foreach ($EachGalleryModule In ($PSGalleryModules)) {
		If (!(Get-Module -ListAvailable -Name ($EachGalleryModule))) {
			Install-Module -Name ($EachGalleryModule) -Scope CurrentUser -Force;
		}
		Import-Module ($EachGalleryModule);
		$import_exit_code = If($?){0}Else{1};
		If ($import_exit_code -ne 0) {
			# Failed Module Import
			Write-Host "$([IO.Path]::GetFileNameWithoutExtension($MyInvocation.MyCommand.Name)) - Fail: Exit-Code [ $($import_exit_code) ] returned from Import-Module: $EachGalleryModule";
			Start-Sleep -Seconds 60;
			Exit 1;
		} Else {
			# Successful Module Import
			Write-Host "$([IO.Path]::GetFileNameWithoutExtension($MyInvocation.MyCommand.Name)) - Pass: Module Imported (cached onto RAM): $EachGalleryModule";
		}
	}
} ElseIf ($psm1.iteration -eq 2) {
	Write-Host "`n$([IO.Path]::GetFileNameWithoutExtension($MyInvocation.MyCommand.Name)) - Task: Import powershell modules (pass $($psm1.iteration)/2, - git repository modules)" -ForegroundColor green;
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
		If ($psm1.verbosity -ne 0) { Write-Host "$([IO.Path]::GetFileNameWithoutExtension($MyInvocation.MyCommand.Name)) - Task: Create parent-directory for Modules: $($psm1.fullpath)"; }
		New-Item -ItemType "Directory" -Path (($psm1.fullpath)+($PSModDir_SplitChar)) | Out-Null;
	} Else {
		# Directory exists - skip it
		If ($psm1.verbosity -ne 0) { Write-Host "$([IO.Path]::GetFileNameWithoutExtension($MyInvocation.MyCommand.Name)) - Skip: Parent-directory for Modules already exists: $($psm1.fullpath)"; }
	}
}
If ($psm1.verbosity -ne 0) { Write-Host "$([IO.Path]::GetFileNameWithoutExtension($MyInvocation.MyCommand.Name)) - Info: PowerShell Modules directory's fullpath: $($psm1.fullpath)"; }

# ------------------------------------------------------------
#
# Update each module from the git repository
#

If ((Test-Path -PathType Container -Path ($PSScriptRoot)) -Eq $false) {

	If ($psm1.verbosity -ne 0) {
		Write-Host "$([IO.Path]::GetFileNameWithoutExtension($MyInvocation.MyCommand.Name)) - Fail: Missing git source directory: ${PSScriptRoot}";
	}
	Start-Sleep -Seconds 60;
	Exit 1;

}

If ($psm1.verbosity -ne 0) {
	Write-Host "$([IO.Path]::GetFileNameWithoutExtension($MyInvocation.MyCommand.Name)) - Pass: Located powershell modules directory: ${PSScriptRoot}";
}

# Git Modules (along with their respectively named directories) to copy into a given machine's PowerShell Modules Directory
Write-Host "Searching `"${PSScriptRoot}`" for PowerShell Modules...";
$PowerShellModulesArr = (Get-ChildItem -Path "${PSScriptRoot}" -Filter "*.psm1" -Depth (256) -File -Recurse -Force -ErrorAction "SilentlyContinue");

Foreach ($EachModule In $PowerShellModulesArr) {
	If ($psm1.verbosity -ne 0) { Write-Host " "; }

	# Remove Module's Cache from RAM (to avoid [ working on modules which are cached in RAM ], [ duplicated modules from previous-revisions ], [ etc. ])
	If (Get-Module -Name ($EachModule.Name)) {
		Remove-Module ($EachModule.Name);
		If ($psm1.verbosity -ne 0) { Write-Host "$([IO.Path]::GetFileNameWithoutExtension($MyInvocation.MyCommand.Name)) - Task: Removing Module (from RAM-Cache): $($EachModule.Name)"; }
		If (Get-Module -Name ($EachModule.Name)) {
			If ($psm1.verbosity -ne 0) { Write-Host "$([IO.Path]::GetFileNameWithoutExtension($MyInvocation.MyCommand.Name)) - Fail: Unable to remove Module (from RAM-Cache): $($EachModule.Name)"; }
		} Else {
			If ($psm1.verbosity -ne 0) { Write-Host "$([IO.Path]::GetFileNameWithoutExtension($MyInvocation.MyCommand.Name)) - Pass: Removed Module (from RAM-Cache): $($EachModule.Name)"; }
		}
	}
	
	$ModuleFile = $EachModule.FullName;
	$ModuleDirectory = $EachModule.Directory.FullName;

	$StartupModuleFile = $ModuleFile.Replace(${PSScriptRoot}, $psm1.fullpath);
	$StartupModuleDirectory = $ModuleDirectory.Replace(${PSScriptRoot}, $psm1.fullpath);

	# Module parent-directory - Create if not-found in destination
	If ((Test-Path -Path ($StartupModuleDirectory)) -eq $false) {
		
		# Create directory
		If ($psm1.verbosity -ne 0) { Write-Host "$([IO.Path]::GetFileNameWithoutExtension($MyInvocation.MyCommand.Name)) - Task: Create directory for Module: $($EachModule.Name)"; }

		New-Item -ItemType "Directory" -Path (($StartupModuleDirectory)+("/")) | Out-Null;

		If ((Test-Path -Path ($StartupModuleDirectory)) -eq $false) {

			# Error - Unable to create directory
			If ($psm1.verbosity -ne 0) { Write-Host "$([IO.Path]::GetFileNameWithoutExtension($MyInvocation.MyCommand.Name)) - Fail: Unable to create directory for Module: $($EachModule.Name)"; }
			Start-Sleep -Seconds 60;
			Exit 1;

		} Else {

			# Directory successfully created
			If ($psm1.verbosity -ne 0) { Write-Host "$([IO.Path]::GetFileNameWithoutExtension($MyInvocation.MyCommand.Name)) - Pass: Directory created for Module: $($EachModule.Name)"; }

		}

	}

	# Item which is a file
	If ((Test-Path -Path ($StartupModuleFile)) -eq $false) {
		
		# Create the destination if it doesn't exist, yet
		If ($psm1.verbosity -ne 0) { Write-Host "$([IO.Path]::GetFileNameWithoutExtension($MyInvocation.MyCommand.Name)) - Task: Copy Module: $($EachModule.Name)"; }
		Copy-Item -Path ($ModuleFile) -Destination ($StartupModuleFile) -Force;
		
		# Check for failure to copy item(s)
		If ((Test-Path -Path ($StartupModuleFile)) -eq $false) {

			# Error - Unable to create Module
			If ($psm1.verbosity -ne 0) { Write-Host "$([IO.Path]::GetFileNameWithoutExtension($MyInvocation.MyCommand.Name)) - Fail: Unable to copy Module: $($EachModule.Name)"; }
			Start-Sleep -Seconds 60;
			Exit 1;

		} Else {

			# Module successfully created
			If ($psm1.verbosity -ne 0) { Write-Host "$([IO.Path]::GetFileNameWithoutExtension($MyInvocation.MyCommand.Name)) - Pass: Module copied: $($EachModule.Name)"; }

		}

	} Else {

		# Files - Copy / Update any not-found in Destination
		$path_source_last_write = [datetime](Get-ItemProperty -Path $ModuleFile -Name LastWriteTime).lastwritetime;
		$path_destination_last_write = [datetime](Get-ItemProperty -Path $StartupModuleFile -Name LastWriteTime).lastwritetime;

		If ($path_source_last_write -gt $path_destination_last_write) {

			# If the source file has a new revision, then update the destination file with said changes
			If ($psm1.verbosity -ne 0) { Write-Host "$([IO.Path]::GetFileNameWithoutExtension($MyInvocation.MyCommand.Name)) - Task: Updating Module: $($EachModule.Name)"; }

			Copy-Item -Path ($ModuleFile) -Destination ($StartupModuleFile) -Force;

			# Check for failure to copy item(s)
			If ((Test-Path -Path ($StartupModuleFile)) -eq $false) {

				# Error - Couldn't update/overwrite a file, etc.
				If ($psm1.verbosity -ne 0) {
					Write-Host "$([IO.Path]::GetFileNameWithoutExtension($MyInvocation.MyCommand.Name)) - Fail: Unable to be update Module: $($EachModule.Name)";
				}
				Start-Sleep -Seconds 60;
				Exit 1;

			} Else {

				# File copied from source to destination successfully
				If ($psm1.verbosity -ne 0) {
					Write-Host "$([IO.Path]::GetFileNameWithoutExtension($MyInvocation.MyCommand.Name)) - Pass: Module updated: $($EachModule.Name)";
				}
			}
		} Else {

			# No updates necessary
			If ($psm1.verbosity -ne 0) {
				Write-Host "$([IO.Path]::GetFileNameWithoutExtension($MyInvocation.MyCommand.Name)) - Pass: Module already up-to-date: $($EachModule.Name)";
			}

		}
	}

	$psm1.ImportModules = @{};
	$psm1.ImportModules.Dirname = ($PSScriptRoot);
	$psm1.ImportModules.Basename = ($MyInvocation.MyCommand.Name);

	If (($EachModule.Name) -eq ($psm1.ImportModules.Basename)) {
		# Dont let a file include itself... that causes infinite loops~!
		If ($psm1.verbosity -ne 0) {
			Write-Host "$([IO.Path]::GetFileNameWithoutExtension($MyInvocation.MyCommand.Name)) - Skip: Avoiding self-import: $($EachModule.Name)";
		}

	} Else {
		
		$RequiredModules_FirstIteration = @("EnsureCommandExists","GitCloneRepo","ProfileSync");

		# If [ we've already updated the codebase (iteration 2) ] or [ we are on a module which is required to update the codebase ]
		If (($Env:UpdatedCodebase -eq $true) -or (($RequiredModules_FirstIteration -match ($EachModule.Name)) -eq ($EachModule.Name))) {

			# Import the Module now that it is located in a valid Modules-directory (unless environment is configured otherwise)
			If ($psm1.verbosity -ne 0) {
				Write-Host "$([IO.Path]::GetFileNameWithoutExtension($MyInvocation.MyCommand.Name)) - Task: Importing Module (caching onto RAM): $($EachModule.Name)";
			}
			
			Import-Module ($StartupModuleFile);
			# Import-Module ($StartupModuleFile) -Verbose;

			$import_exit_code = If($?){0}Else{1};
			
			If ($import_exit_code -ne 0) {

				# Failed Module Import
				Write-Host "$([IO.Path]::GetFileNameWithoutExtension($MyInvocation.MyCommand.Name)) - Fail: Exit-Code [$import_exit_code] returned from Import-Module: $($EachModule.Name)";
				Start-Sleep -Seconds 60;
				Exit 1;

			} Else {
				# Successful Module Import
				Write-Host "$([IO.Path]::GetFileNameWithoutExtension($MyInvocation.MyCommand.Name)) - Pass: Module imported (cached onto RAM): $($EachModule.Name)";

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

	$CommandExists.dotnet = `
		EnsureCommandExists `
			-Name ("dotnet") `
			-OnErrorShowUrl ("https://dotnet.microsoft.com/download/archives") `
			-Quiet;

	$Env:UpdatedCodebase = $null;
	
}

# Write-Host " ";
