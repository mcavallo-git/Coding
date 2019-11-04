Set-ExecutionPolicy "RemoteSigned" -Force;

Write-Host "Task - Sync local git repository to origin `"https://github.com/mcavallo-git/Coding.git`"..." -ForegroundColor Green;

If (Test-Path "~/Coding") {
	Set-Location "~/Coding";
	git reset --hard "origin/master";
	git pull;
} Else {
	Set-Location "~"; 
	git clone "https://github.com/mcavallo-git/Coding.git";
}

. "~/Coding/powershell/_WindowsPowerShell/Modules/ImportModules.ps1";

Write-Host "`nPass - PowerShell Modules Synchronized`n" -ForegroundColor Cyan;
