
$EnvSystem = @();
$EnvSystem += (Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment');
$EnvSystem;
$EnvSystem.GetType();
$EnvSystem | Measure-Object;

# ($EnvSystem | Measure-Object).Count;

# $EnvUser = @();
$EnvUser = Get-ItemProperty -Path 'Registry::HKEY_CURRENT_USER\Environment';
$EnvUser;
$EnvUser.GetType();

$EnvAll = @();
$EnvAll += $EnvSystem;
$EnvAll += $EnvUser;
$EnvAll;
$EnvAll.GetType();

$EnvAll.Path;
$EnvAll.Path.Split(';');

### GetType:
#
# $EnvAll.GetType().FullName;


### Indices
#
# 		$EnvSystem.ComSpec;
# 		$EnvSystem.OS;
# 		$EnvSystem.Path;
# 			$EnvSystem.Path.Split(';');
# 		$EnvSystem.TEMP;
# 		$EnvSystem.TMP;
# 		$EnvSystem.windir;
#
# 		$EnvUser.Path;
# 			$EnvUser.Path.Split(';');
# 		$EnvUser.TEMP;
# 		$EnvUser.TMP;
#