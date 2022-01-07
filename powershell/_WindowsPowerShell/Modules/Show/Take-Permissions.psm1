function TakePermissions {
	param(

		$rootKey,

		$key,

		[System.Security.Principal.SecurityIdentifier]
		$sid = 'S-1-5-32-545',  # Users (built-in group)

		$recurse = $True

	)
	#
	# Developed for PowerShell v4.0
	#

	If ((RunningAsAdministrator) -Ne ($True)) {

		PrivilegeEscalation -Command ("SyncRegistry");
	
	} Else {
			
		switch -regex ($rootKey) {
			'HKCU|HKEY_CURRENT_USER'	{ $rootKey = 'CurrentUser' }
			'HKLM|HKEY_LOCAL_MACHINE'   { $rootKey = 'LocalMachine' }
			'HKCR|HKEY_CLASSES_ROOT'	{ $rootKey = 'ClassesRoot' }
			'HKCC|HKEY_CURRENT_CONFIG'  { $rootKey = 'CurrentConfig' }
			'HKU|HKEY_USERS'			{ $rootKey = 'Users' }
		}

		### Step 1 - escalate current process's privilege
		# get SeTakeOwnership, SeBackup and SeRestore privileges before executes next lines, script needs Admin privilege
		$import = '[DllImport("ntdll.dll")] public static extern int RtlAdjustPrivilege(ulong a, bool b, bool c, ref bool d);'
		$ntdll = Add-Type -Member $import -Name NtDll -PassThru
		$privileges = @{ SeTakeOwnership = 9; SeBackup =  17; SeRestore = 18 }
		foreach ($i in $privileges.Values) {
			$null = $ntdll::RtlAdjustPrivilege($i, 1, 0, [ref]0)
		}

		function Take-KeyPermissions {
			param($rootKey, $key, $sid, $recurse, $recurseLevel = 0)

			### Step 2 - get ownerships of key - it works only for current key
			$regKey = [Microsoft.Win32.Registry]::$rootKey.OpenSubKey($key, 'ReadWriteSubTree', 'TakeOwnership')
			$acl = New-Object System.Security.AccessControl.RegistrySecurity
			$acl.SetOwner($sid)
			$regKey.SetAccessControl($acl)

			### Step 3 - enable inheritance of permissions (not ownership) for current key from parent
			$acl.SetAccessRuleProtection($false, $false)
			$regKey.SetAccessControl($acl)

			### Step 4 - only for top-level key, change permissions for current key and propagate it for subkeys
			# to enable propagations for subkeys, it needs to execute Steps 2-3 for each subkey (Step 5)
			if ($recurseLevel -eq 0) {
				$regKey = $regKey.OpenSubKey('', 'ReadWriteSubTree', 'ChangePermissions')
				$rule = New-Object System.Security.AccessControl.RegistryAccessRule($sid, 'FullControl', 'ContainerInherit', 'None', 'Allow')
				$acl.ResetAccessRule($rule)
				$regKey.SetAccessControl($acl)
			}

			### Step 5 - recursively repeat steps 2-5 for subkeys
			if ($recurse) {
				foreach($subKey in $regKey.OpenSubKey('').GetSubKeyNames()) {
					Take-KeyPermissions $rootKey ($key+'\'+$subKey) $sid $recurse ($recurseLevel+1)
				}
			}
		}

		# Only kick off the command if the key actually exists
		If ((Test-Path -Path ("${rootKey}")) -eq $True) {
			Take-KeyPermissions $rootKey $key $sid $recurse
		}

	}

}

<# Only export the module if the caller is attempting to import it #>
If (($MyInvocation.GetType()) -Eq ("System.Management.Automation.InvocationInfo")) {
	Export-ModuleMember -Function "TakePermissions";
}


# ------------------------------------------------------------
#
# Citation(s)
#
#   stackoverflow.com  |  "How do I take ownership of a registry key via Powershell?"  |  https://stackoverflow.com/a/35843420
#
#   shrekpoint.blogspot.com  |  "Taking ownership of DCOM registry objects using PowerShell"  |  https://shrekpoint.blogspot.com/2012/08/taking-ownership-of-dcom-registry.html
#
#   remkoweijnen.nl  |  "Take ownership of a registry key in PowerShell"  |  https://www.remkoweijnen.nl/blog/2012/01/16/take-ownership-of-a-registry-key-in-powershell/
#
#   powertoe.wordpress.com  |  "Changing Permissions in the Registry"  |  https://powertoe.wordpress.com/2010/08/28/controlling-registry-acl-permissions-with-powershell/
#
# ------------------------------------------------------------