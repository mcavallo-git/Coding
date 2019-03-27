# Get the current Environment "Path" Directories (Combined System + User Dirs) & store them in the variable $EnvPath
$EnvPath = (${Env:Path}).Split(';');


# Show all PATH items (to the console)
(${Env:Path}).Split(';');
