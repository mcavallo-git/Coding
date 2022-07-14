# ------------------------------------------------------------
#
#	PowerShell - TestHostCertificate
#		|
#		|--> Description:  Pulls the details of the https-cert (if any) attached to a given hostname
#		|
#		|--> Example:     PowerShell -Command ("TestHostCertificate 'https://google.com';")
#
# ------------------------------------------------------------

Function TestHostCertificate() {
	Param(
		[Switch]$NoSchemaPrepend,
		[Parameter(Position=0, ValueFromRemainingArguments)]$DomainsToCheck
	)
	# ------------------------------------------------------------
	If ($False) { # RUN THIS SCRIPT:


		$ProtoBak=[System.Net.ServicePointManager]::SecurityProtocol; [System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; $ProgressPreference='SilentlyContinue'; Clear-DnsClientCache; Set-ExecutionPolicy "RemoteSigned" -Scope "CurrentUser" -Force; Try { Invoke-Expression ((Invoke-WebRequest -UseBasicParsing -TimeoutSec (7.5) -Uri ('https://raw.githubusercontent.com/mcavallo-git/Coding/master/powershell/_WindowsPowerShell/Modules/TestHostCertificate/TestHostCertificate.psm1') ).Content) } Catch {}; If (-Not (Get-Command -Name 'TestHostCertificate' -ErrorAction 'SilentlyContinue')) { Import-Module ([String]::Format('{0}\Documents\GitHub\Coding\powershell\_WindowsPowerShell\Modules\TestHostCertificate\TestHostCertificate.psm1', ((Get-Variable -Name 'HOME').Value))); }; [System.Net.ServicePointManager]::SecurityProtocol=$ProtoBak;
		TestHostCertificate "https://google.com";


	}
	# ------------------------------------------------------------

	$AllowSchemaPrepend = (-Not $PSBoundParameters.ContainsKey('NoSchemaPrepend'));

	$Demo_DomainsToCheck = @(
		"https://google.com/",
		"https://microsoft.com/",
		"https://docs.microsoft.com/"
	);

	<# If user didn't pass any domains to this script, then demo some test-domains to test the certificates of #>
	If ($null -eq $DomainsToCheck) {
		$DomainsToCheck = ${Demo_DomainsToCheck};
	}

	$HttpWebRequest_AllowAutoRedirect = $False; <# Boolean -> True=[ Follow 301/302/etc. redirects ], False=[ Get the certificate from the first domain reached (without following any 301/302/etc. redirects) ] #>

	$HttpWebRequest_KeepAlive = $False; <# Boolean -> True=[ Keep HTTP connections open for the default duration of 2-minutes before closing the socket ], False=[ Close the socket immediately after retrieving the requested data ] #>

	$HttpWebRequest_Timeout = 3000; <# Integer -> Web request timeout (in milliseconds), e.g. abort the web request if it takes longer than this duration #>

	$ValidDaysRemaining_WarningLimit = 30; <# Integer -> Warn the user if the certificate expires before this many days (from now) #>

	[System.Net.ServicePointManager]::ServerCertificateValidationCallback = { $True }; <# Disable certificate validation (ignore SSL warnings) #>

	$HttpWebRequests = @{};
	$HttpWebResponses = @{};

	For ($i=0; ($i -LT $DomainsToCheck.Count); $i++) {
		$EachDomain = ($DomainsToCheck[${i}]);

		Write-Output "";
		Write-Output "------------------------------------------------------------";

		<# Autocorrect domains without colons ":" in their url strings (unless disabled) #>
		If (($EachDomain -Match ":") -Eq $False) {
			If ($AllowSchemaPrepend -Eq $True) {
				$PrependSchema = "https://"
				Write-Output "";
				Write-Output "Info:  Modifying query from  `"${EachDomain}`"  to  `"${PrependSchema}${EachDomain}`"  (no colon found for schema in request string, disable this functionality by passing -NoSchemaPrepend)";
				${EachDomain} = "${PrependSchema}${EachDomain}";
			}
		}

		Try {
			Write-Output "";
			Write-Output "Requesting SSL Certificate from `"$EachDomain`" ...  ";
			($HttpWebRequests.$i) = [System.Net.HttpWebRequest]::Create($EachDomain);
			($HttpWebRequests.$i).AllowAutoRedirect = $HttpWebRequest_AllowAutoRedirect;
			($HttpWebRequests.$i).KeepAlive = $HttpWebRequest_KeepAlive;
			($HttpWebRequests.$i).ReadWriteTimeout = $HttpWebRequest_Timeout;
			($HttpWebRequests.$i).Timeout = $HttpWebRequest_Timeout;
			($HttpWebResponses.$i) = (($HttpWebRequests.$i).GetResponse());
			# ($HttpWebResponses.$i).Close();
			($HttpWebResponses.$i).Dispose();
		} Catch {
			Write-Host "";
			Write-Host ($_) -ForegroundColor "Magenta";
			($HttpWebRequests.$i).Abort();
		};

		If ($HttpWebRequests -NE $Null) {
			$DomainCertificate = (($HttpWebRequests.$i).ServicePoint.Certificate);
			$certName = $DomainCertificate.GetName();
			$certThumbprint = $DomainCertificate.GetCertHashString();
			$certEffectiveDate = $DomainCertificate.GetEffectiveDateString();
			$certIssuer = $DomainCertificate.GetIssuerName();
			$certExpDateStr = $DomainCertificate.GetExpirationDateString();
			$certExpDateObj = [DateTime]::Parse($certExpDateStr, $Null);

			[Int]$ValidDaysRemaining = ($certExpDateObj - $(Get-Date)).Days;

			<# Show the certificate's 'days til expiration' and 'expiration datetime' #>
			Write-Output "";
			Write-Output "Certificate Expiration Date = [ $certExpDateStr ]  <-- [ $ValidDaysRemaining ] days away";
			Write-Output "Certificate Effective Date = [ $certEffectiveDate ]";
			Write-Output "Certificate Name = [ $certName ]";
			Write-Output "Certificate Thumbprint = [ $certThumbprint ]";
			Write-Output "Certificate Issuer = [ $certIssuer ]";
		}

	}

	Write-Output "";
	Write-Output "------------------------------------------------------------";

	Return;

}

<# Only export the module if the caller is attempting to import it #>
If (($MyInvocation.GetType()) -Eq ("System.Management.Automation.InvocationInfo")) {
	Export-ModuleMember -Function "TestHostCertificate";
}


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "DateTime.Parse Method (System) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/dotnet/api/system.datetime.parse?view=netframework-4.8
#
#   docs.microsoft.com  |  "DateTime.ParseExact Method (System) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/dotnet/api/system.datetime.parseexact?view=netframework-4.8
#
#   docs.microsoft.com  |  "HttpWebRequest Class (System.Net) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/dotnet/api/system.net.httpwebrequest?view=netframework-4.8
#
#   docs.microsoft.com  |  "HttpWebRequest.KeepAlive Property (System.Net) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/dotnet/api/system.net.httpwebrequest.keepalive?view=netframework-4.8
#
#   docs.microsoft.com  |  "HttpWebRequest.MaximumAutomaticRedirections Property (System.Net) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/dotnet/api/system.net.httpwebrequest.maximumautomaticredirections?view=netframework-4.8
#
#   docs.microsoft.com  |  "ServicePointManager.ServerCertificateValidationCallback Property (System.Net) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/dotnet/api/system.net.servicepointmanager.servercertificatevalidationcallback?view=netframework-4.8
#
#   stackoverflow.com  |  ".net - Is there a correct way to dispose of a httpwebrequest? - Stack Overflow"  |  https://stackoverflow.com/a/42241479
#
#   stackoverflow.com  |  "C# HttpWebRequest times out after two server 500 errors - Stack Overflow"  |  https://stackoverflow.com/q/4033159
#
#   woshub.com  |  "Checking SSL/TLS Certificate Expiration Date with PowerShell | Windows OS Hub"  |  https://woshub.com/check-ssl-tls-certificate-expiration-date-powershell/
#
#   www.reddit.com  |  "Using Invoke-WebRequest with -Outfile while preserving filename : PowerShell"  |  https://www.reddit.com/r/PowerShell/comments/5h0zmw/using_invokewebrequest_with_outfile_while/
#
#   www.tutorialspoint.com  |  "How to get website SSL certificate validity dates with PowerShell?"  |  https://www.tutorialspoint.com/how-to-get-website-ssl-certificate-validity-dates-with-powershell
#
# ------------------------------------------------------------