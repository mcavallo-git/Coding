# ------------------------------------------------------------
# @UserCanEscalatePrivileges
#   |--> Determine if the Runtime-User is part of the "Administrators" Local UserGroup
#
Function UserCanEscalatePrivileges {
	Param(

	)
	# ------------------------------------------------------------
	If ($False) { # RUN THIS SCRIPT:

		$ProtoBak=[System.Net.ServicePointManager]::SecurityProtocol; [System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; $ProgressPreference='SilentlyContinue'; Clear-DnsClientCache; Set-ExecutionPolicy "RemoteSigned" -Scope "CurrentUser" -Force; Try { Invoke-Expression ((Invoke-WebRequest -UseBasicParsing -TimeoutSec (7.5) -Uri ('https://raw.githubusercontent.com/mcavallo-git/Coding/master/powershell/_WindowsPowerShell/Modules/UserCanEscalatePrivileges/UserCanEscalatePrivileges.psm1') ).Content) } Catch {}; If (-Not (Get-Command -Name 'UserCanEscalatePrivileges' -ErrorAction 'SilentlyContinue')) { Import-Module ([String]::Format('{0}\Documents\GitHub\Coding\powershell\_WindowsPowerShell\Modules\UserCanEscalatePrivileges\UserCanEscalatePrivileges.psm1', ((Get-Variable -Name 'HOME').Value))); }; [System.Net.ServicePointManager]::SecurityProtocol=$ProtoBak;

	}
	#------------------------------------------------------------
	$ReturnedVal = $Null;

	# Check whether-or-not the current user is able to escalate their own PowerShell terminal to run with elevated privileges (as Administrator)
	$LocalAdmins = (([ADSI]"WinNT://./Administrators").psbase.Invoke('Members') | % {([ADSI]$_).InvokeGet('AdsPath')});
	$CurrentUser = (([Security.Principal.WindowsPrincipal]([Security.Principal.WindowsIdentity]::GetCurrent())).Identities.Name);
	$CurrentUserWinNT = ("WinNT://$($CurrentUser.Replace("\","/"))");
	# Make final (returned) determination of whether the user is able to "Run as Admin" or not
	If (($LocalAdmins.Contains($CurrentUser)) -Or ($LocalAdmins.Contains($CurrentUserWinNT))) {
		$ReturnedVal = $True;
	} Else {
		$ReturnedVal = $False;
	}

	If ($False) { # Expanded/Broken-Up - Same functionality as above but calls have been expanded to show more obvious/intuitive functionality of the runtime command(s)
		
		### Get Local Admins - Built-in PowerShell Method
		# $LocalAdmins = ((Get-LocalGroupMember -Name "Administrators").Name);
		###  |--> NOTE:  Updated script to use the ADSI methods (below), as the Get-LocalGroupMember method acts finnicky for AD-connected devies whilst no available AD controller exists to query off-of
		#
		
		### Get Local Admins - ADSI, Method 1
		# $LocalAdmins = (@(([ADSI]"WinNT://./Administrators").psbase.Invoke('Members') | % { $_.GetType().InvokeMember('AdsPath','GetProperty',$null,$($_),$null) }) -match '^WinNT');
		#
		
		# Get Local Admins - ADSI, Method 2
		$LocalAdmins = (([ADSI]"WinNT://./Administrators").psbase.Invoke('Members') | % {([ADSI]$_).InvokeGet('AdsPath')});
		#
		
		# Get Current User
		$CurrentUser = (([Security.Principal.WindowsPrincipal]([Security.Principal.WindowsIdentity]::GetCurrent())).Identities.Name);
		$CurrentUserWinNT = ("WinNT://$($CurrentUser.Replace("\","/"))");
		#
		
		# Make final (returned) determination of whether the user is able to "Run as Admin" or not
		If (($LocalAdmins.Contains($CurrentUser)) -Or ($LocalAdmins.Contains($CurrentUserWinNT))) {
			$ReturnedVal = $True;
		} Else {
			$ReturnedVal = $False;
		}

	}

	Return $ReturnedVal;

}

<# Only export the module if the caller is attempting to import it #>
If (($MyInvocation.GetType()) -Eq ("System.Management.Automation.InvocationInfo")) {
	Export-ModuleMember -Function "UserCanEscalatePrivileges";
}


# ------------------------------------------------------------
#
#	Citation(s)
#
#		docs.microsoft.com  |  "WindowsPrincipal Class (System.Security.Principal) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/dotnet/api/system.security.principal.windowsprincipal
#
#		docs.microsoft.com  |  "WindowsPrincipal.Identity Property (System.Security.Principal) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/dotnet/api/system.security.principal.windowsprincipal.identity
#
#		github.com  |  "Windows 10 Initial Setup Script"  |  https://github.com/Disassembler0/Win10-Initial-Setup-Script
#
#		p0w3rsh3ll.wordpress.com  |  "Any (documented) ADSI changes in PowerShell 5.0?"  |  https://p0w3rsh3ll.wordpress.com/2016/06/14/any-documented-adsi-changes-in-powershell-5-0/
#
# ------------------------------------------------------------