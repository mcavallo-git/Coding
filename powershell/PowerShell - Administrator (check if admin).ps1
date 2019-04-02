
# Check if runtime user has Administrator rights

$IsAdmin = $null;
If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
	$IsAdmin = $false;
} Else {
	$IsAdmin = $true;
}

Write-Host (("`$IsAdmin: ")+($IsAdmin));
