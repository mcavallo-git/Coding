function TrustAllCertsPolicy {
	Param(
	)
	# ------------------------------------------------------------
	If ($False) { # RUN THIS SCRIPT:


		<# Trust all HTTPS certificates received during the current PowerShell session (including out-of-the-box localhost HTTPS certs on IIS servers) #>
		$ProtoBak=[System.Net.ServicePointManager]::SecurityProtocol; [System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; $ProgressPreference='SilentlyContinue'; Clear-DnsClientCache; Set-ExecutionPolicy "RemoteSigned" -Scope "CurrentUser" -Force; Try { Invoke-Expression ((Invoke-WebRequest -UseBasicParsing -TimeoutSec (7.5) -Uri ('https://raw.githubusercontent.com/mcavallo-git/Coding/master/powershell/_WindowsPowerShell/Modules/TrustAllCertsPolicy/TrustAllCertsPolicy.psm1') ).Content) } Catch {}; If (-Not (Get-Command -Name 'TrustAllCertsPolicy' -ErrorAction 'SilentlyContinue')) { Import-Module ([String]::Format('{0}\Documents\GitHub\Coding\powershell\_WindowsPowerShell\Modules\TrustAllCertsPolicy\TrustAllCertsPolicy.psm1', ((Get-Variable -Name 'HOME').Value))); }; [System.Net.ServicePointManager]::SecurityProtocol=$ProtoBak; TrustAllCertsPolicy;


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



		Write-Host -NoNewLine "`n`n  Do you wish to Trust all HTTPS certificates received during this PowerShell session?  (press 'y' to confirm)" -BackgroundColor "Black" -ForegroundColor "Yellow";
		$KeyPress = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
		If ($KeyPress.Character -Eq "y") {
			Write-Host -NoNewLine "   Confirmed - Errors which are normally thrown for invalid HTTPS certificates will be ignored for the remainder of this session...`n`n" -BackgroundColor "Black" -ForegroundColor "Teal";

<# Trust all HTTPS certificates received during the current PowerShell session (including out-of-the-box localhost HTTPS certs on IIS servers) #>

<#
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
[System.Net.ServicePointManager]::CertificatePolicy = New-Object TrustAllCertsPolicy;
#>

If (-Not ([System.Management.Automation.PSTypeName]'ServerCertificateValidationCallback').Type) {

$certCallback=@"
    using System;
    using System.Net;
    using System.Net.Security;
    using System.Security.Cryptography.X509Certificates;
    public class ServerCertificateValidationCallback
    {
        public static void Ignore()
        {
            if(ServicePointManager.ServerCertificateValidationCallback ==null)
            {
                ServicePointManager.ServerCertificateValidationCallback += 
                    delegate
                    (
                        Object obj, 
                        X509Certificate certificate, 
                        X509Chain chain, 
                        SslPolicyErrors errors
                    )
                    {
                        return true;
                    };
            }
        }
    }
"@;
Add-Type $certCallback;
}

$AllProtocols = [System.Net.SecurityProtocolType]'Ssl3,Tls,Tls11,Tls12';
[System.Net.ServicePointManager]::SecurityProtocol = $AllProtocols;

[ServerCertificateValidationCallback]::Ignore();

		} Else {
			Write-Host -NoNewLine "   Denied - Exiting...`n`n" -BackgroundColor "Black" -ForegroundColor "Gray";
		}


	}
	Start-Sleep 10
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
#   stackoverflow.com  |  ".net - Powershell v3 Invoke-WebRequest HTTPS error - Stack Overflow"  |  https://stackoverflow.com/a/46254549
#
#   stackoverflow.com  |  ".net - Powershell v3 Invoke-WebRequest HTTPS error - Stack Overflow"  |  https://stackoverflow.com/a/15841856
#
# ------------------------------------------------------------