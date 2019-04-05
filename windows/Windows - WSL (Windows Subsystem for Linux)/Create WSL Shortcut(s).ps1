

$Distro_DirsAbove = "$HOME\AppData\Local\Packages";
$Distro_DirsBelow = "\LocalState\rootfs";

$Haystack_LocalDirs = (Resolve-Path -Path "$HOME\AppData\Local\Packages\*\LocalState\rootfs").Path;

$Needle_LinuxDistros = @{
	Alpine    = @("Alpine", "AlpineWSL");
	Debian    = @("TheDebianProject", "DebianGNULinux", "Debian","GNU");
	Kali      = @("Kali","KaliLinux");
	openSUSE  = @("openSUSE","SUSE.openSUSE","SUSE.openSUSELeap");
	SUSE      = @("SUSE.SUSE","SUSE.SUSELinuxEnterpriseServer");
	Ubuntu    = @("Ubuntu","UbuntuonWindows","CanonicalGroupLimited")
};

# Write-Host "`$Needle_LinuxDistros :";
# $Needle_LinuxDistros;

$Regex_LinuxDistros = @{
	Alpine    = "[a-z0-9]{13}\.(Alpine)WSL_[a-z0-9]{13}";
	openSUSE  = "[0-9]{5}SUSE.(openSUSE)Leap[0-9\.]{4}_[a-z0-9]{13}";
	SUSE      = "[0-9]{5}SUSE.(SUSE)LinuxEnterpriseServer[0-9SP]{5}_[a-z0-9]{13}";
	Ubuntu    = "CanonicalGroupLimited\.(Ubuntu)[\d\.]{0,6}onWindows_[a-z0-9]{13}";
	Kali      = "(Kali)Linux\.[A-Z0-9]{13}_[a-z0-9]{13}";
	Debian    = "TheDebianProject\.(DebianGNU)Linux_[a-z0-9]{13}";
};

# CanonicalGroupLimited.Ubuntu18.04onWindows_79rhkp1fndgsc
# CanonicalGroupLimited.Ubuntu18.04onWindows_79rhkp1fndgsc

# Write-Host "`$Regex_LinuxDistros :";
# $Regex_LinuxDistros;

$LocalDistros_Resolved = @();

ForEach ($EachLocalDir In $Haystack_LocalDirs) {


	Write-Host "`$EachLocalDir :";
	$EachLocalDir;

	$Distro_Basename = ($EachLocalDir.Split('\'))[-3];
	
	ForEach ($EachDistro In ($Regex_LinuxDistros.GetEnumerator())) {
		
		$Distro_Name = $EachDistro.Name;

		$RegexTest = $EachDistro.Value;

		If (($Distro_Basename -match $RegexTest) -eq $true) {
			
			$LocalDistros_Resolved += @{
				Shortcut_Location = (($PSScriptRoot)+("/Linux Files (")+($Distro_Name)+(").lnk"));
				Shortcut_Target = "${EachLocalDir}";
				Shortcut_Arguments = "";
				Shortcut_WorkingDir = "%cd%";
			}
		}
	}
}

ForEach ($EachResolvedArr In $LocalDistros_Resolved) {

	$NewShortcut = (New-Object -ComObject WScript.Shell).CreateShortcut($EachResolvedArr.Shortcut_Location);
	$NewShortcut.TargetPath=($EachResolvedArr.Shortcut_Target);
	$NewShortcut.Arguments=($EachResolvedArr.Shortcut_Arguments );
	$NewShortcut.WorkingDirectory=($EachResolvedArr.Shortcut_WorkingDir);
	$NewShortcut.Save();
	$NewShortcut.FullName; # Show the filepath of the newly-created shortcut

}
