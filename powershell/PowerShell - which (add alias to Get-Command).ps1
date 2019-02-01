# Get the current Environment "Path" Directories (Combined System + User Dirs)
$EnvPath = (${Env:Path}).Split(';');
