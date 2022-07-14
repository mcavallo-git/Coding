If ($True) {
	
$DASH_NL="------------------------------------------------------------`n";

<# Docker - Ensure Docker Desktop is running #>
If ($null -eq (Get-Process -Name "Docker Desktop" -ErrorAction "SilentlyContinue")) {
Write-Host "${DASH_NL}[ $(Get-Date -Format 'yyyy-MM-ddTHH:mm:sszzz') ] Starting Docker Desktop...";
Start-Process -Filepath ("C:\Program Files\Docker\Docker\Docker Desktop.exe") -ArgumentList (@("restart","${ServiceName}")) -PassThru;
Start-Sleep -Seconds 60;
}

<# Docker - Kill containers #>
Write-Host "${DASH_NL}[ $(Get-Date -Format 'yyyy-MM-ddTHH:mm:sszzz') ] Killing Docker containers...";
docker rm --force $(docker stop $(docker ps --all --quiet));

<# Docker - Kill images #>
Write-Host "${DASH_NL}[ $(Get-Date -Format 'yyyy-MM-ddTHH:mm:sszzz') ] Killing Docker images...";
docker rmi --force $(docker images --all --quiet);

<# Docker - Kill networks #>
Write-Host "${DASH_NL}[ $(Get-Date -Format 'yyyy-MM-ddTHH:mm:sszzz') ] Killing Docker networks...";
docker network rm $((docker network ls --format='{{.ID}}  {{.Name}}') | Where-Object { (@("bridge","host","none") -contains (("${_}" -Split "  ")[1])) -Eq $False} | ForEach-Object {("${_}" -Split "  ")[0]}) 2> $Null;

<# Docker - Kill volumes #>
Write-Host "${DASH_NL}[ $(Get-Date -Format 'yyyy-MM-ddTHH:mm:sszzz') ] Killing Docker volumes...";
docker volume rm $(docker volume ls --quiet);

}