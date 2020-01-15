<# ------------------------------------------------------------ #>

<#   Start-Process PowerShell.exe $(New-Object Net.WebClient).DownloadString("https://sync-ps.mcavallo.com/$((Date).Ticks).ps1") -Verb RunAs;   #>

<# ------------------------------------------------------------ #>

If (("AllSigned","Default","Restricted","Undefined") -contains (Get-ExecutionPolicy)) {
	Set-ExecutionPolicy "RemoteSigned" -Force;
}

Write-Host "Info:  Loading personal and system profiles...`n" -ForegroundColor Gray;

Write-Host "Info:  Local PowerShell Version: $(($($PSVersionTable.PSVersion.Major))+($($PSVersionTable.PSVersion.Minor)/10))`n" -ForegroundColor Gray;

<# ------------------------------------------------------------ #>

$AliasName="grep"; $AliasCommand="Select-String";
Write-Host "Info:  Checking for Alias `"${AliasName}`"..." -ForegroundColor Gray;
If ( (Get-Alias).Name -Contains "${AliasName}" ) {
	If ( ((Get-Alias -Name "${AliasName}").ResolvedCommand.Name) -Ne ("${AliasCommand}")) {
		Remove-Item "alias:\${AliasName}";
		New-Alias -Name "${AliasName}" -Value "${AliasCommand}";
	}
} Else {
	New-Alias -Name "${AliasName}" -Value "${AliasCommand}";
}

$AliasName="which"; $AliasCommand="Get-Command";
Write-Host "Info:  Checking for Alias `"${AliasName}`"..." -ForegroundColor Gray;
If ( (Get-Alias).Name -Contains "${AliasName}" ) {
	If ( ((Get-Alias -Name "${AliasName}").ResolvedCommand.Name) -Ne ("${AliasCommand}")) {
		Remove-Item "alias:\${AliasName}";
		New-Alias -Name "${AliasName}" -Value "${AliasCommand}";
	}
} Else {
	New-Alias -Name "${AliasName}" -Value "${AliasCommand}";
}

<# ------------------------------------------------------------ #>

Write-Host "Info:  Syncing local git repository to origin `"https://github.com/mcavallo-git/Coding.git`"..." -ForegroundColor Green;

If ( ${HOME} -Eq ${Null} ) {
	$HOME = ((Resolve-Path "~").Path);
}

$REPO_DIR_WIN32 = "${HOME}\Coding";

If (Test-Path "${REPO_DIR_WIN32}") {

	Set-Location "${REPO_DIR_WIN32}";

	git reset --hard "origin/master";

	git pull;

} Else {

	$Env:EMAIL = "email@email.emailo";
	$Env:GIT_SSH_COMMAND = "ssh -i \`"${SSH_KEY_LOCAL_LINUX}\`" -o StrictHostKeyChecking=no";
	$Env:NAME = "${Env:USERNAME}@${Env:COMPUTERNAME}";

	Set-Location "${HOME}";

	git clone "git@github.com:mcavallo-git/Coding.git";
	# git clone "https://github.com/mcavallo-git/Coding.git";

	$SSH_KEY_REMOTE="https://raw.githubusercontent.com/mcavallo-git/Coding/master/.shared-deploy-key.pem";

	$SSH_KEY_LOCAL_WIN32="${HOME}\.ssh\git\.shared-deploy-key.pem";
	$SSH_KEY_LOCAL_LINUX=(("/")+(((${SSH_KEY_LOCAL_WIN32} -Replace "\\","/") -Replace ":","")));

	New-Item -ItemType "File" -Path ("${SSH_KEY_LOCAL_WIN32}") -Value ($(New-Object Net.WebClient).DownloadString("${SSH_KEY_REMOTE}")) -Force | Out-Null;

	Set-Location "${REPO_DIR_WIN32}";

	git config --local --replace-all "core.sshcommand" "$($Env:GIT_SSH_COMMAND)";

	git config --local --replace-all "user.name" "$($Env:NAME)";

	git config --local --replace-all "user.email" "$($Env:EMAIL)";

}


. "${HOME}\Coding\powershell\_WindowsPowerShell\Modules\ImportModules.ps1";

Write-Host "`nInfo:  PowerShell Modules Synchronized`n" -ForegroundColor Cyan;

Set-Location "${HOME}";
