Get-Service | Where-Object { ($_.DisplayName -Like '*PRTG*') } | ForEach-Object { Write-Host "Restarting service `"$($_.DisplayName)`"..."; $_ | Restart-Service; }; `
