function TrustAllCertsPolicy {
	Param(
	)
	# ------------------------------------------------------------
	If ($False) { # RUN THIS SCRIPT:


		<# Trust all HTTPS certificates received during the current PowerShell session (including out-of-the-box localhost HTTPS certs on IIS servers) #>
		$ProtoBak=[System.Net.ServicePointManager]::SecurityProtocol; [Net.ServicePointManager]::SecurityProtocol=[Net.SecurityProtocolType]::Tls12; Clear-DnsClientCache; Set-ExecutionPolicy "RemoteSigned" -Scope "CurrentUser" -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/mcavallo-git/Coding/master/powershell/_WindowsPowerShell/Modules/TrustAllCertsPolicy/TrustAllCertsPolicy.psm1')); [System.Net.ServicePointManager]::SecurityProtocol=$ProtoBak; TrustAllCertsPolicy;


	}
	# ------------------------------------------------------------

	# If ((RunningAsAdministrator) -Ne ($True)) {
	# 	PrivilegeEscalation -Command ("TrustAllCertsPolicy") {
	# } Else {

	<# Check whether-or-not the current PowerShell session is running with elevated privileges (as Administrator) #>
	$RunningAsAdmin = (([Security.Principal.WindowsPrincipal]([Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator"));
	If ($RunningAsAdmin -Eq $False) {
		<# Script is >> NOT << running as admin  -->  Check whether-or-not the current user is able to escalate their own PowerShell terminal to run with elevated privileges (as Administrator) #>
		$LocalAdmins = (([ADSI]"WinNT://./Administrators").psbase.Invoke('Members') | % {([ADSI]$_).InvokeGet('AdsPath')});
		$CurrentUser = (([Security.Principal.WindowsPrincipal]([Security.Principal.WindowsIdentity]::GetCurrent())).Identities.Name);
		$CurrentUserWinNT = ("WinNT://$($CurrentUser.Replace("\","/"))");
		If (($LocalAdmins.Contains($CurrentUser)) -Or ($LocalAdmins.Contains($CurrentUserWinNT))) {
			$CommandString = $MyInvocation.MyCommand.Name;
			$PSBoundParameters.Keys | ForEach-Object { $CommandString += " -$_"; If (@('String','Integer','Double').Contains($($PSBoundParameters[$_]).GetType().Name)) { $CommandString += " `"$($PSBoundParameters[$_])`""; } };
			Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -Command `"$($CommandString)`"" -Verb RunAs;
		} Else {
			Write-Output "`n`nError:  Insufficient privileges, unable to escalate (e.g. unable to run as admin)`n`n";
		}
	} Else {
		<# Script >> IS << running as Admin - Continue #>

<# Trust all HTTPS certificates received during the current PowerShell session (including out-of-the-box localhost HTTPS certs on IIS servers) #>
Add-Type @"
    using System.Net;
    using System.Security.Cryptography.X509Certificates;
    public class TrustAllCertsPolicy : ICertificatePolicy {
        public bool CheckValidationResult(
            ServicePoint srvPoint, X509Certificate certificate,
            WebRequest request, int certificateProblem) {
            return true;
        }
    }
"@;


		Write-Host -NoNewLine "`n`n  Do you wish to Trust all HTTPS certificates received during this PowerShell session? (y/n)`n`n" -BackgroundColor "Black" -ForegroundColor "Yellow";
		$KeyPress = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
		If ($KeyPress.Character -Eq "y") {
			Write-Host -NoNewLine "`n`n  Confirmed - Errors which are normally thrown for invalid HTTPS certificates will be ignored for the remainder of this session...`n`n" -BackgroundColor "Black" -ForegroundColor "Yellow";
			[System.Net.ServicePointManager]::CertificatePolicy = New-Object TrustAllCertsPolicy;
		}


	}

	Return;

}

<# Only export the module if the caller is attempting to import it #>
If (($MyInvocation.GetType()) -Eq ("System.Management.Automation.InvocationInfo")) {
	Export-ModuleMember -Function "TrustAllCertsPolicy" -ErrorAction "SilentlyContinue";
}



# ------------------------------------------------------------
#
# Citation(s)
#
#   stackoverflow.com  |  ".net - Powershell v3 Invoke-WebRequest HTTPS error - Stack Overflow"  |  https://stackoverflow.com/a/15841856
#
# ------------------------------------------------------------