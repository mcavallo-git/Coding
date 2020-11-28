
If ($True) {

	$DomainsToCheck = @(
		"https://mcavallo.com/",
		"https://cava.lol/"
	);

	$HttpWebRequest_AllowAutoRedirect = $False; <# Boolean -> True=[ Follow 301/302/etc. redirects ], False=[ Get domain certificate without redirects ] #>

	# $HttpWebRequest_KeepAlive = $False; <# Boolean -> True=[ Keep HTTP connections open for the default duration of 2-minutes before closing the socket ], False=[ Close the socket immediately after retrieving the requested data ] #>
	
	$HttpWebRequest_MaximumAutomaticRedirections = 1; <# Integer -> The maximum number of redirects that the request follows #>

	$HttpWebRequest_Timeout = 3000; <# Integer -> Web request timeout (in milliseconds), e.g. abort the web request if it takes longer than this duration #>

	$ValidDaysRemaining_WarningLimit = 30; <# Integer -> Warn the user if the certificate expires before this many days (from now) #>

	[System.Net.ServicePointManager]::ServerCertificateValidationCallback = { $True }; <# Disable certificate validation (ignore SSL warnings) #>

	$HttpWebRequests = @{};
	$HttpWebResponses = @{};

	# ForEach ($EachDomain In $DomainsToCheck) {
	For ($i=0; ($i -LT $DomainsToCheck.Count); $i++) {
		$EachDomain = ($DomainsToCheck[${i}]);

		Write-Output "------------------------------------------------------------";

		# Write-Host "`$DomainsToCheck[${i}] = ${DomainsToCheck}";

		Write-Output "Requesting SSL Certificate from `"$EachDomain`" ...  ";

		($HttpWebRequests.$i) = [System.Net.HttpWebRequest]::Create($EachDomain);
		($HttpWebRequests.$i).AllowAutoRedirect = $HttpWebRequest_AllowAutoRedirect;
		($HttpWebRequests.$i).KeepAlive = $HttpWebRequest_KeepAlive;
		($HttpWebRequests.$i).MaximumAutomaticRedirections = $HttpWebRequest_MaximumAutomaticRedirections;
		($HttpWebRequests.$i).Timeout = $HttpWebRequest_Timeout;

		Try {
			($HttpWebResponses.$i) = (($HttpWebRequests.$i).GetResponse());
			# ($HttpWebResponses.$i).Close();
		} Catch {
			Write-Host ($_) -ForegroundColor "Magenta";
		};

		$DomainCertificate = (($HttpWebRequests.$i).ServicePoint.Certificate);
		$ExpDate_String = $DomainCertificate.GetExpirationDateString();
		$ExpDate_Obj = [DateTime]::Parse($ExpDate_String, $Null);
		[Int]$ValidDaysRemaining = ($ExpDate_Obj - $(Get-Date)).Days;

		# Write-Output "Expiration DateTime=[ $($ExpDate_Obj.ToString()) ]";
		Write-Output "Certificate expires in [ $ValidDaysRemaining ] days (expiration timestamp is [ $($ExpDate_Obj.ToString()) ]).";
		If ($ValidDaysRemaining -LE $ValidDaysRemaining_WarningLimit) {
			$certName = $DomainCertificate.GetName();
			$certThumbprint = $DomainCertificate.GetCertHashString();
			$certEffectiveDate = $DomainCertificate.GetEffectiveDateString();
			$certIssuer = $DomainCertificate.GetIssuerName();
			Write-Output Details:`n`nCert name: $certName`Cert thumbprint: $certThumbprint`nCert effective date: $certEffectiveDate`nCert issuer: $certIssuer;
		}

		# ($HttpWebRequests.$i) = $Null;
		# ($HttpWebResponses.$i) = $Null;
		# Remove-Variable ("HttpWebRequests.$i");  <# Delete the value held by the variable AND the variable reference itself. #>

	}

	Write-Output "------------------------------------------------------------";

}


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "DateTime.Parse Method (System) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/dotnet/api/system.datetime.parse?view=netframework-4.8
#
#   docs.microsoft.com  |  "DateTime.ParseExact Method (System) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/dotnet/api/system.datetime.parseexact?view=netframework-4.8
#
#   docs.microsoft.com  |  "HttpWebRequest.KeepAlive Property (System.Net) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/dotnet/api/system.net.httpwebrequest.keepalive?view=netframework-4.8
#
#   docs.microsoft.com  |  "HttpWebRequest.MaximumAutomaticRedirections Property (System.Net) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/dotnet/api/system.net.httpwebrequest.maximumautomaticredirections?view=netframework-4.8
#
#   docs.microsoft.com  |  "ServicePointManager.ServerCertificateValidationCallback Property (System.Net) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/dotnet/api/system.net.servicepointmanager.servercertificatevalidationcallback?view=netframework-4.8
#
#   stackoverflow.com  |  ".net - Is there a correct way to dispose of a httpwebrequest? - Stack Overflow"  |  https://stackoverflow.com/a/42241479
#
#   woshub.com  |  "Checking SSL/TLS Certificate Expiration Date with PowerShell | Windows OS Hub"  |  https://woshub.com/check-ssl-tls-certificate-expiration-date-powershell/
#
#   www.reddit.com  |  "Using Invoke-WebRequest with -Outfile while preserving filename : PowerShell"  |  https://www.reddit.com/r/PowerShell/comments/5h0zmw/using_invokewebrequest_with_outfile_while/
#
#   www.tutorialspoint.com  |  "How to get website SSL certificate validity dates with PowerShell?"  |  https://www.tutorialspoint.com/how-to-get-website-ssl-certificate-validity-dates-with-powershell
#
# ------------------------------------------------------------