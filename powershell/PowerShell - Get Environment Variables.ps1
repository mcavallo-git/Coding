# Show all environment variables via Powershell
Get-ChildItem Env:

# Get Single Environment variable (via powershell)
Write-Host $Env:Username;


# PowerShell - which (add alias to Get-Command)
"`nNew-Alias which Get-Command" | Add-Content ${Profile};



$EnvSystem = @();
$EnvSystem += Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment';
$EnvUser = @();
$EnvUser += Get-ItemProperty -Path 'Registry::HKEY_CURRENT_USER\Environment';
# $EnvSystem.ComSpec;
# $EnvSystem.OS;
# $EnvSystem.Path;
# 	$EnvSystem.Path.Split(';');
# $EnvSystem.TEMP;
# $EnvSystem.TMP;
# $EnvSystem.windir;

$EnvUser = @();
$EnvUser += Get-ItemProperty -Path 'Registry::HKEY_CURRENT_USER\Environment';
# $EnvUser.Path;
# 	$EnvUser.Path.Split(';');
# $EnvUser.TEMP;
# $EnvUser.TMP;

$EnvAll = @();
$EnvAll += $EnvSystem;
$EnvAll += $EnvUser;
$EnvAll.GetType().FullName;

foreach($i in $EnvSystem.Keys)
{
	$EnvSystem[$i];
}
    # $Applications[$i] = @{
    #     Colour = $i
    #     Prod = 'SrvProd05'
    #     QA   = 'SrvQA02'
    #     Dev  = 'SrvDev12'
    # }
}
foreach(${Key} in $EnvSystem.Keys)
{
	if (${Key} in $testInfo.Keys.GetEnumerator())
    $pet # Print each Key
    $pets.$pet # Print value of each Key
}

### Split up the path into an array
#${Var} = (${Env:Path}).Split(';');


### Get Var-Type:
# $EnvAll.GetType().FullName;