
$psm1 = @{};

$psm1.verbosity = 0;

$psm1.dirname = (($HOME)+("\Documents\WindowsPowerShell"));

$psm1.basename = "Modules";

$psm1.fullpath = (($psm1.dirname) + ("\") + ($psm1.basename));

# Ensure that [Powershell's default Modules directory] exists
$psm1.exists = Test-Path -PathType Container -Path ($psm1.fullpath); 
If ($psm1.exists -eq $true) {
	If ($psm1.verbosity -ne 0) { Write-Host (("Pass - Found [Powershell's default Modules directory]: ") + ($psm1.fullpath)) }

} Else {

	# Ensure that [the directory one-level-above] [Powershell's default Modules directory] exists
	If ($psm1.dirname_exists -eq $true) {
		If ($psm1.verbosity -ne 0) { Write-Host (("Pass - Found [the directory one-level-above] [Powershell's default Modules directory]: ") + ($psm1.dirname)); }

	} Else {

		# Attempt to create [the directory one-level-above] [Powershell's default Modules directory]
		New-Item -ItemType "Directory" -Path (($psm1.dirname)+("\"));
		$psm1.dirname_exists = Test-Path -PathType Container -Path ($psm1.dirname);
		If ($psm1.dirname_exists -eq $true) {
			If ($psm1.verbosity -ne 0) { Write-Host (("Pass - Created [the directory one-level-above] [Powershell's default Modules directory]: ") + ($psm1.dirname)); }
		} Else {
			If ($psm1.verbosity -ne 0) { Write-Host (("Fail - Unable to create [the directory one-level-above] [Powershell's default Modules directory]: ") + ($psm1.dirname)); }
			Start-Sleep -Seconds 60;
			Exit 1;
		}
	}

	# Attempt to create [Powershell's default Modules directory]
	New-Item -ItemType "Directory" -Path (($psm1.fullpath)+("\"));
	$psm1.exists = Test-Path -PathType Container -Path ($psm1.fullpath);
	If ($psm1.exists -eq $true) {
		If ($psm1.verbosity -ne 0) { Write-Host (("Pass - Created [Powershell's default Modules directory]: ") + ($psm1.fullpath)); }
	} Else {
		If ($psm1.verbosity -ne 0) { Write-Host (("Fail - Unable to create [Powershell's default Modules directory]: ") + ($psm1.fullpath)); }
		Start-Sleep -Seconds 60;
		Exit 1;
	}

}

$psm1.git_source = ($PSScriptRoot);
$psm1.git_source_exists = Test-Path -PathType Container -Path ($psm1.git_source); 

If ($psm1.git_source_exists -eq $false) {

	If ($psm1.verbosity -ne 0) { Write-Host (("Fail - Missing [git source directory]: ") + ($psm1.git_source)); }
	Start-Sleep -Seconds 60;
	Exit 1;

} Else {

	If ($psm1.verbosity -ne 0) { Write-Host (("Pass - Found [Updated Modules directory]: ") + ($psm1.git_source)); }

	# Git Modules (along with their respectively named directories) to copy into a given machine's PowerShell Modules Directory
	$psm1.git_modules = Get-ChildItem -Path (($psm1.git_source)+("\*")) -Recurse;
	
	Foreach ($file In ($psm1.git_modules)) {
		If ($psm1.verbosity -ne 0) { Write-Host ("`n"); }

		# Remove module first (to avoid duplicates fromr evisioning, copying-over while in memory, etc.)
		If (Get-Module -Name ($file.BaseName)) {
			Remove-Module ($file.BaseName);
			If ($psm1.verbosity -ne 0) { Write-Host (("Task - Removing Old Module: ") + ($file.BaseName)); }
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
				If ($psm1.verbosity -ne 0) { Write-Host (("Task - Creating Directory: ") + ($file.BaseName)+("")); }

				New-Item -ItemType "Directory" -Path (($path_destination)+("\"));

				$path_destination_exists = Test-Path -PathType Container -Path ($path_destination);

				If ($path_destination_exists -eq $false) {

					# Error - Unable to create directory
					If ($psm1.verbosity -ne 0) { Write-Host (("Fail - Unable to Create Directory: ") + ($file.BaseName)); }
					Start-Sleep -Seconds 60;
					Exit 1;

				} Else {

					# Directory successfully created
					If ($psm1.verbosity -ne 0) { Write-Host (("Pass - Directory Created: ") + ($file.BaseName)); }

				}

			} Else {

				# Directory already exists
				If ($psm1.verbosity -ne 0) { Write-Host (("Skip - Directory already exists in destination: ") + ($file.BaseName)+("")); }

			}

		} ElseIf ($source_is_file -eq $false) {

			# Object which is neither a file nor a directory
			If ($psm1.verbosity -ne 0) { Write-Host (("Skip - Invalid Item (non-file, non-directory): ") + ($path_source)+("")); }

		} Else {

			If ($path_destination_exists -eq $false) {
				
				# Create the destination if it doesn't exist, yet
				If ($psm1.verbosity -ne 0) { Write-Host (("Task - Creating Module: ") + ($file.BaseName)); }

				Copy-Item -Path ($path_source) -Destination ($path_destination) -Force;

				$path_destination_exists = Test-Path -PathType Leaf -Path ($path_destination);
				
				# Check for failure to copy item(s)
				If ($path_destination_exists -eq $false) {

					# Error - Unable to create Module
					If ($psm1.verbosity -ne 0) { Write-Host (("Fail - Unable to be Create Module: ") + ($file.BaseName)); }
					Start-Sleep -Seconds 60;
					Exit 1;

				} Else {

					# Module successfully created
					If ($psm1.verbosity -ne 0) { Write-Host (("Pass - Module Created: ") + ($file.BaseName)); }

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
						If ($psm1.verbosity -ne 0) { Write-Host (("Fail - Unable to be Update Module: ") + ($file.BaseName)); }
						Start-Sleep -Seconds 60;
						Exit 1;

					} Else {

						# File copied from source to destination successfully
						If ($psm1.verbosity -ne 0) { Write-Host (("Pass - Module Updated: ") + ($file.BaseName)); }
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
					Write-Host (("Skip - Avoid Import to currently running script (to avoid infinite loops): ") + ($file.BaseName));
				}

			} Else {
				
				# Import the Module now that it is located in a valid Modules-directory (unless environment is configured otherwise)
				If ($psm1.verbosity -ne 0) { Write-Host (("Task - Importing Module: ") + ($file.BaseName)); }
				
				Import-Module ($path_destination);

				$import_exit_code = If($?){0}Else{1};
				
				If ($import_exit_code -ne 0) {

					# Failed Module Import
					Write-Host (("Fail - Exit-Code [ ") + ($import_exit_code) + (" ] returned from Import-Module: ") + ($file.BaseName));
					Start-Sleep -Seconds 60;
					Exit 1;

				} Else {
					# Successful Module Import
					Write-Host (("Pass - Module Imported: ") + ($file.BaseName));

				}
			}

			# Invoke-Expression $file.BaseName;

		}

		# Start-Sleep -Milliseconds 5000;

	}
	
	ProfilePrep;
	# Invoke-Expression "ProfilePrep";

	Write-Host " ";

}