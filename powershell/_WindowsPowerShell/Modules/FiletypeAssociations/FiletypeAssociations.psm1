#
#	PowerShell - FiletypeAssociations
#		|
#		|--> Description:  Control Windows' default Filetype Associations through the Group Policy Editor & an XML config settings file-sync
#		|
#		|--> Example:     PowerShell -Command ("FiletypeAssociations")
#
Function FiletypeAssociations() {
	Param(
		[Switch]$Quiet,
		[Switch]$Pull
	)

	If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
		# Script is NOT running as admin
		#  > Attempt to open an admin terminal with the same command-line arguments as the current
		Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`" $PSCommandArgs" -Verb RunAs;

	} ElseIf ($PSBoundParameters.ContainsKey('Pull') -Eq $False) {
		# Script IS running as Admin - Continue
		Write-Host "";
		Write-Host "Error:  Call with argument  [ -Pull  ] to update from repo" -ForegroundColor "Red";
		Write-Host "";
	
	} Else {
		# Script IS running as Admin - Continue
		Write-Host "";
		Write-Host "Info:  Script running with Admin rights - Continuing...";

		# ------------------------------------------------------------
		#
		# Place a shortcut to the VS Code Workspace redirector within VS Code's Program Files directory
		#   |--> Adds the Workspace redirector to the current $PATH (without requiring a reboot, relog, etc.)
		#
		If ((Test-Path ("${Env:ProgramFiles}\Microsoft VS Code\bin\VSCode-Workspace.vbs")) -Eq $False) {
			CMD /C 'MKLINK "%ProgramFiles%\Microsoft VS Code\bin\VSCode-Workspace.vbs" "%USERPROFILE%\Documents\GitHub\Coding\visual basic\VSCode-Redirect.vbs"'
		}
		# ------------------------------------------------------------
		#
		# Approach:  Create and point the OS to a filetype associations config-file (.xml format) which can be be updated on-the-fly (as-needed)
		#
		$DefaultAssociations_Windows="${Env:SystemRoot}\System32\DefaultAssociations.xml";


		# Install the "PolicyFileEditor" module (if not found in local environment)
		If (!(Get-Module -ListAvailable -Name ("PolicyFileEditor"))) {
			Install-Module -Name ("PolicyFileEditor") -Scope ("CurrentUser") -Force;
		}


		# Pull updated filetype associations settings
		$DefaultAssociations_Source="${Home}\Documents\GitHub\Coding\windows\Filetype-Associations\DefaultAssociations.xml";
		If ((Test-Path ("${DefaultAssociations_Source}")) -Eq $False) {
			$Download_RemoteUrl = "https://raw.githubusercontent.com/mcavallo-git/Coding/master/windows/Filetype-Associations/DefaultAssociations.xml";
			$Download_LocalPath = "${Env:Temp}\DefaultAssociations.xml";
			$(New-Object Net.WebClient).DownloadFile("${Download_RemoteUrl}", "${Download_LocalPath}");
			$DefaultAssociations_Source = "${Download_LocalPath}";
		}


		# Export current workstation's filetype associations to a file on the current user's desktop, then open it
		$ExportSettings = $False;
		If ($ExportSettings -Eq $True) {
			Dism /Online /Export-DefaultAppAssociations:${DefaultAssociations_Source}
			Notepad "${DefaultAssociations_Source}"
		}


		If ((Test-Path ("${DefaultAssociations_Windows}")) -Eq $True) {
			# Backup existing Filetype Associations config-file  [ DefaultAssociations.xml ]
			$TimestampFilename = (Get-Date -UFormat "%Y%m%d-%H%M%S");
			$CopySource = "${DefaultAssociations_Windows}";
			$CopyDestination = "${Env:SystemRoot}\System32\DefaultAssociations.${TimestampFilename}.xml";
			Write-Host "";
			Write-Host "Info:  (Backup Config) Copying file `"${CopySource}`" to path `"${CopyDestination}`" ...";
			Copy-Item `
			-Path ("${CopySource}") `
			-Destination ("${CopyDestination}") `
			-Force;
		}

		# Update the Filetype Associations config-file  [ DefaultAssociations.xml ]
		$CopySource = "${DefaultAssociations_Source}";
		$CopyDestination = "${DefaultAssociations_Windows}";
		Write-Host "";
		Write-Host "Info:  (Update Config) Copying file `"${CopySource}`" to path `"${CopyDestination}`" ...";
		Copy-Item `
		-Path ("${CopySource}") `
		-Destination ("${CopyDestination}") `
		-Force;


		### !! Todo/To-Do/To Do:  Update the filetype associations config-file for a given set of filetype associations
		# $OpenExtensionsWith="'$($Env:windir)\System32\wscript.exe' '$($Env:ProgramFiles)\Microsoft VS Code\bin\VSCode-Workspace.vbs' '%1'"; # Open a given extension using the VS Code Workspace redirection utility
		### $OpenExtensionWith='"C:\Program Files\Microsoft VS Code\Code.exe" "%1"'; # Open a given extension using the main VS Code runtime


		###
		### Manually set Filetype Associations config-file path
		###  > Open  [ Local Group Policy Editor ], e.g.  [ gpedit.msc ] 
		###   > Computer Configuration
		###    > Administrative Templates
		###     > Windows Components
		###      > File Explorer
		###       > Set a default associations configuration file
		###
		Write-Host "";
		Write-Host "Info:  Enabling Group Policy Administrative Template `"Set a default associations configuration file`" to value `"${DefaultAssociations_Windows}`" ...";
		Set-PolicyFileEntry `
		-Path ("${Env:SystemRoot}\System32\GroupPolicy\Machine\Registry.pol") `
		-Key ("Software\Policies\Microsoft\Windows\System") `
		-ValueName ("DefaultAssociationsConfiguration") `
		-Data ("${DefaultAssociations_Windows}") `
		-Type ("String");


		# ### EXAMPLE(S) FROM POWERSHELL GALLERY
		# Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key Software\Policies\Something -ValueName SomeValue -Data '0x12345' -Type DWord
		# Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key Software\Policies\Something -ValueName SomeValue -Data 'Hello, World!' -Type String -NoGptIniUpdate
		# Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key Software\Policies\Something -ValueName SomeValue -Data 'Hello, World!' -Type String


		Write-Host "";
		Write-Host -NoNewLine "Info:  Script complete - You may need to ";
		Write-Host -NoNewLine "Logout/Login" -ForegroundColor "Yellow";
		Write-Host -NoNewLine " or ";
		Write-Host -NoNewLine "Reboot" -ForegroundColor "Yellow";
		Write-Host -NoNewLine " to fully apply updated fileType associations`n";
		Write-Host "";


		# ------------------------------------------------------------
		#
		# Approach (Heavy/Non-ideal):  Manually Copy-Paste the Registry.pol file's directory & contents (contains all Local Group Policy Editor settings)
		#  > Not exactly what I'd call "solution", but rather more of a "workaround" (but if you'll literally never need to setup a single filetype association again in your life, go for it)
		#    > All file-extensions must be setup manually, through Windows, the first time, then that Registry.pol file exported / copied to every attached Computer to apply the same settings onto
		#     > Also, when updating the extensions, you must set them manually in Windows' OS (every time), export the file (again), then copy it to all other associated PCs (again)
		#
		If ($False) {
			Copy-Item "C:\Windows\System32\GroupPolicy" "${HOME}\Desktop\."; ### Transfer to other computer --> Paste over its "C:\Windows\System32\GroupPolicy" directory
		}

		# ------------------------------------------------------------
		#
		# !! DEPRECATED !! (KEPT FOR REFERENCE ON WHAT NOT TO DO)
		# Approach: REGEDIT/REGISTRY-KEY-HACK METHOD
		# !! DOESN'T WORK
		# !! INFO:  GROUP POLICY OBJECTS (GPOs) NEVER PULL FROM THE REGISTRY - THEY ONLY PUSH TO THE REGISTRY (~EVERY 90-MIN)
		# !!        THIS IS EVIDENT FROM A PUSH-PERSPECTIVE - IF YOU UPDATE A GPO MANUALLY, THEN CHECK THE CORRESPONDING REGISTRY KEY, YOU'LL SEE THE CHANGE MADE IN A 1-1 FASHION
		# !!        HOWEVER, IF YOU MAKE A CHANGE IN THE REGISTRY, THEN WAIT FOR SOME TIME/RESTART THE PC / ETC., YOU WON'T SEE THE CHANGE REFLECTED IN GROUP POLICY EDITOR
		#
		If ($False) {
			# !! DEPRECATED !! (KEPT FOR REFERENCE ON WHAT NOT TO DO)
			# Key:    HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\System
			# Prop:   DefaultAssociationsConfiguration
			# Val:    C:\Windows\System32\DefaultAssociations.xml  (DEFAULT-VALUE)
			# Type:   String  (REG_SZ)
			Get-ItemProperty -Path ("Registry::HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\System") -Name ("DefaultAssociationsConfiguration");
			New-ItemProperty -Path ("Registry::HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\System") -Name ("DefaultAssociationsConfiguration") -PropertyType ("String") -Value ("C:\Windows\System32\defaultassociations.xml") -Force;
			Start-Process "C:\Windows\system32\gpupdate.exe";
			# !! DEPRECATED !! (KEPT FOR REFERENCE ON WHAT NOT TO DO)
			#
			# HKEY_CLASSES_ROOT\.svg
			#   |--> (Default) = [ .svg_auto_file ]  (REG_SZ)
			# HKEY_CLASSES_ROOT\.svg_auto_file\shell\open\command
			#   |--> (Default) = [ "C:\Program Files\Microsoft VS Code\Code.exe" "%1" ]  (REG_SZ)
			#
			# !! DEPRECATED !! (KEPT FOR REFERENCE ON WHAT NOT TO DO)
			#
			# HKEY_CLASSES_ROOT\Applications\Code.exe\DefaultIcon
			#   |--> (Default) = [ C:\Program Files\Microsoft VS Code\resources\app\resources\win32\default.ico ]  (REG_SZ)
			# HKEY_CLASSES_ROOT\Applications\Code.exe\shell\open\command
			#   |--> (Default) = [ "C:\Program Files\Microsoft VS Code\Code.exe" "%1" ]  (REG_SZ)
			#
			# !! DEPRECATED !! (KEPT FOR REFERENCE ON WHAT NOT TO DO)
			#
			# HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.svg\UserChoice
			#   |--> Hash = [ HASHED_PASSWORD ]  (REG_SZ)
			#   |--> ProgId = [ .svg_auto_file ]  (REG_SZ)
			#
			# !! DEPRECATED !! (KEPT FOR REFERENCE ON WHAT NOT TO DO)
			#
			# $UserSID = (&{If(Get-Command "whoami" -ErrorAction "SilentlyContinue") { (whoami /user /fo table /nh).Split(" ")[1] } Else { $Null }});
			# HKEY_USERS\${UserSID}\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.svg\UserChoice
			#   |--> Hash = [ HASHED_PASSWORD ]  (REG_SZ)
			#   |--> ProgId = [ .svg_auto_file ]  (REG_SZ)
			# HKEY_USERS\S-1-5-21-3546239101-1148623116-693846799-1001\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.svg\UserChoice
			#   |--> Hash = [ HASHED_PASSWORD ]  (REG_SZ)
			#   |--> ProgId = [ .svg_auto_file ]  (REG_SZ)
			#
			# !! DEPRECATED !! (KEPT FOR REFERENCE ON WHAT NOT TO DO)
			#
			# $UserSID = (&{If(Get-Command "whoami" -ErrorAction "SilentlyContinue") { (whoami /user /fo table /nh).Split(" ")[1] } Else { $Null }});
			# HKEY_USERS\${UserSID}_Classes\.svg
			#   |--> (Default) = [ .svg_auto_file ]  (REG_SZ)
			# HKEY_USERS\${UserSID}_Classes\.svg_auto_file\shell\open\command
			#   |--> (Default) = [ "C:\Program Files\Microsoft VS Code\Code.exe" "%1" ]  (REG_SZ)
			#
			# !! DEPRECATED !! (KEPT FOR REFERENCE ON WHAT NOT TO DO)
			#
			# HKEY_LOCAL_MACHINE\SOFTWARE\Classes\.svg\OpenWithProgIDs
			#
			# !! DEPRECATED !! (KEPT FOR REFERENCE ON WHAT NOT TO DO)
			#
		}
	}

	# ------------------------------------------------------------
	#	### "Press any key to continue..."
	Write-Host -NoNewLine "`n`n$($MyInvocation.MyCommand.Name) - Press any key to continue...  `n`n" -ForegroundColor "Yellow" -BackgroundColor "Black";
	$KeyPress = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');

	Return;

}
Export-ModuleMember -Function "FiletypeAssociations";
# Install-Module -Name "FiletypeAssociations"


# ------------------------------------------------------------
#
# Citation(s)
#
#		blogs.technet.microsoft.com  |  "Windows 8: Associate a file Type or protocol with a specific app using GPO (e.g:default mail client for MailTo protocol) – Behind Windows Setup & Deployment"  |  https://blogs.technet.microsoft.com/mrmlcgn/2013/02/26/windows-8-associate-a-file-type-or-protocol-with-a-specific-app-using-gpo-e-gdefault-mail-client-for-mailto-protocol/
#
#   docs.microsoft.com  |  "Copy-Item - Copies an item from one location to another"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/copy-item
#
#		docs.microsoft.com  |  "RegistryKey Class"  |  https://docs.microsoft.com/en-us/dotnet/api/microsoft.win32.registrykey
#
#   renenyffenegger.ch  |  "Registry: HKEY_CLASSES_ROOT\ProgId"  |  https://renenyffenegger.ch/notes/Windows/registry/tree/HKEY_CLASSES_ROOT/ProgId/index
#
#   social.technet.microsoft.com  |  "Can you use PowerShell to change Group Policies?"  |  https://social.technet.microsoft.com/Forums/windows/en-US/624fa355-54cb-4798-9876-02eb927849a4/can-you-use-powershell-to-change-group-policies?forum=winserverpowershell
#
#		stackoverflow.com  |  "Get file type description for file extensions"  |  https://stackoverflow.com/a/27646804
#
#		superuser.com  |  "How to associate a file with a program in Windows via CMD [duplicate]"  |  https://superuser.com/a/362080
#
#		superuser.com  |  "Why gpedit and the corresponding registry entries are not synchronized?"  |  https://superuser.com/a/1192458
#
#   www.powershellgallery.com  |  "PowerShell Gallery | Commands.ps1 3.0.0"  |  httpshttps://www.powershellgallery.com/packages/PolicyFileEditor/3.0.0/Content/Commands.ps1
#
#   www.powershellgallery.com  |  "PowerShell Gallery | PolicyFileEditor 3.0.1"  |  https://www.powershellgallery.com/packages/PolicyFileEditor
#
# ------------------------------------------------------------