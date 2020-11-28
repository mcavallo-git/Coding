
If ($True) {

	$ValidDaysRemaining_WarningLimit = 30;

	$TimeoutMs = 10000;

	$DomainsToCheck = @(
		"https://google.com/"
	);

	[System.Net.ServicePointManager]::ServerCertificateValidationCallback = { $True }; <# Disable certificate validation #>

	ForEach ($EachDomain In $DomainsToCheck) {
		
		Write-Host "Checking domain `"$EachDomain`" ..." -f Green;

		$HttpWebRequest = [Net.HttpWebRequest]::Create($EachDomain);

		$HttpWebRequest.Timeout = $TimeoutMs;

		Try { $HttpWebRequest.GetResponse() | Out-Null } Catch { Write-Host URL check error $EachDomain`: $_ -f Red };

		$ExpDate_String = $HttpWebRequest.ServicePoint.Certificate.GetExpirationDateString();

		$ExpDate_Obj = [DateTime]::ParseExact($ExpDate_String, "dd/MM/yyyy HH:mm:ss", $Null);

		[Int]$ValidDaysRemaining = ($ExpDate_Obj - $(Get-Date)).Days;

		If ($ValidDaysRemaining -GT $ValidDaysRemaining_WarningLimit) {
			Write-Host "The certificate for domain `"$EachDomain`" expires in [ $ValidDaysRemaining ] days." -f Green;
			Write-Host $ExpDate_Obj -f Green;
		} Else {
			$certName = $HttpWebRequest.ServicePoint.Certificate.GetName();
			$certThumbprint = $HttpWebRequest.ServicePoint.Certificate.GetCertHashString();
			$certEffectiveDate = $HttpWebRequest.ServicePoint.Certificate.GetEffectiveDateString();
			$certIssuer = $HttpWebRequest.ServicePoint.Certificate.GetIssuerName();
			Write-Host "The certificate for domain `"$EachDomain`" expires in [ $ValidDaysRemaining ] days." -f Yellow;
			Write-Host $ExpDate_Obj -f Yellow;
			Write-Host Details:`n`nCert name: $certName`Cert thumbprint: $certThumbprint`nCert effective date: $certEffectiveDate`nCert issuer: $certIssuer -f Yellow;
		}

		Write-Host "------------------------------------------------------------" `n;

	}

}


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "ServicePointManager.ServerCertificateValidationCallback Property (System.Net) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/dotnet/api/system.net.servicepointmanager.servercertificatevalidationcallback?view=netframework-4.8
#
#   woshub.com  |  "Checking SSL/TLS Certificate Expiration Date with PowerShell | Windows OS Hub"  |  https://woshub.com/check-ssl-tls-certificate-expiration-date-powershell/
#
#   www.tutorialspoint.com  |  "How to get website SSL certificate validity dates with PowerShell?"  |  https://www.tutorialspoint.com/how-to-get-website-ssl-certificate-validity-dates-with-powershell
#
# ------------------------------------------------------------