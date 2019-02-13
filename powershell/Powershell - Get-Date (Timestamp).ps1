
$Timestamp = (Get-Date -UFormat "%Y%m%d%H%M%S");
Write-Host ${Timestamp};

$Timestamp_UTC = (Get-Date -UFormat "%Y%m%d%H%M%S%Z");
Write-Host ${Timestamp_UTC};
