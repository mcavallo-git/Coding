

# Show all PATH items (to the console)
(${Env:Path}).Split(';');


# Get the current Environment "Path" Directories (Combined System + User Dirs) & store them in the variable $EnvPath
$EnvPath = (${Env:Path}).Split(';');


# Search the PATH for results matching a given string
(${Env:Path}).Split(';') | Select-String 'git';

