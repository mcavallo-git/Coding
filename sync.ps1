<# Start-Process PowerShell.exe $(New-Object Net.WebClient).DownloadString('https://sync.mcavallo.com/ps') -Verb RunAs; #>

Set-ExecutionPolicy "RemoteSigned" -Force;

Write-Host "Info : Syncing local git repository to origin `"https://github.com/mcavallo-git/Coding.git`"..." -ForegroundColor Green;

If ( ${HOME} -Eq ${Null} ) {
	$HOME = ((Resolve-Path "~").Path);
}

If (Test-Path "${HOME}/Coding") {
	Set-Location "${HOME}/Coding";
	git reset --hard "origin/master";
	git pull;
} Else {
	Set-Location "${HOME}"; 
	git clone "https://github.com/mcavallo-git/Coding.git";
	$SSH_KEY_REMOTE="https://raw.githubusercontent.com/mcavallo-git/Coding/master/.shared-deploy-key.pem";
	$SSH_KEY_LOCAL="${HOME}/Coding/.git/.shared-deploy-key.pem";
	New-Item -ItemType "File" -Path ("${SSH_KEY_LOCAL}") -Value ($(New-Object Net.WebClient).DownloadString("${SSH_KEY_REMOTE}")) | Out-Null;
	Set-Location "${HOME}/Coding";
	git config --local --replace-all "core.sshcommand" "ssh -i `"${SSH_KEY_LOCAL}`"";
	# git config --local --replace-all "user.name" "${Env:USERNAME}@${Env:COMPUTERNAME}";
	# git config --local --replace-all "user.email" "email@email.email";
}

. "${HOME}/Coding/powershell/_WindowsPowerShell/Modules/ImportModules.ps1";

Write-Host "`nInfo: PowerShell Modules Synchronized`n" -ForegroundColor Cyan;
