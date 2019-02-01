# PowerShell - which (add alias to Get-Command)
"`nNew-Alias which Get-Command" | Add-Content ${Profile};


# ${Split-Path} = (${Env:Path}).Split(';');

${Env-System} = (Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).path;


${Env-User} = Get-ItemProperty -Path 'Registry::HKEY_CURRENT_USER\Environment';




# Split up the path into an array
${Split-Path} = (${Env:Path}).Split(';');

