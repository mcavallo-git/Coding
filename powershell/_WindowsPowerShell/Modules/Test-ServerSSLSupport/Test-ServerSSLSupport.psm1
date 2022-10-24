# ------------------------------------------------------------
#
#	PowerShell - Test-ServerSSLSupport
#		|
#		|--> Author:  Vadims Podāns @ https://www.sysadmins.lv
#		|
#		|--> Description:  PowerShell script that accepts a list of web URLs and tests each host with a list of SSL protocols: SSLv2, SSLv3, TLS 1.0, TLS 1.1 and TLS 1.2
#		|
#		|--> Example(s):  Test-ServerSSLSupport -HostName "localhost"
#		                  Test-ServerSSLSupport -HostName "www.github.com"
#
# ------------------------------------------------------------

Function Test-ServerSSLSupport {
	[CmdletBinding()]
	Param (
		[Parameter(Mandatory = $true, ValueFromPipeline = $true)]
		[ValidateNotNullOrEmpty()]
		[String]$HostName,
		[UInt16]$Port = 443
	)
	Process {
		# ------------------------------------------------------------
		If ($False) { # RUN THIS SCRIPT:

			$ProtoBak=[System.Net.ServicePointManager]::SecurityProtocol; [System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; $ProgressPreference='SilentlyContinue'; Clear-DnsClientCache; Set-ExecutionPolicy "RemoteSigned" -Scope "CurrentUser" -Force; Try { Invoke-Expression ((Invoke-WebRequest -UseBasicParsing -TimeoutSec (7.5) -Uri ('https://raw.githubusercontent.com/mcavallo-git/Coding/main/powershell/_WindowsPowerShell/Modules/Test-ServerSSLSupport/Test-ServerSSLSupport.psm1') ).Content) } Catch {}; If (-Not (Get-Command -Name 'Test-ServerSSLSupport' -ErrorAction 'SilentlyContinue')) { Import-Module ([String]::Format('{0}\Documents\GitHub\Coding\powershell\_WindowsPowerShell\Modules\Test-ServerSSLSupport\Test-ServerSSLSupport.psm1', ((Get-Variable -Name 'HOME').Value))); }; [System.Net.ServicePointManager]::SecurityProtocol=$ProtoBak;
			Test-ServerSSLSupport -Hostname "www.github.com";

		}
		# ------------------------------------------------------------
		$RetValue = New-Object psobject -Property @{
			Host = $HostName
			Port = $Port
			SSLv2 = $false
			SSLv3 = $false
			TLSv1_0 = $false
			TLSv1_1 = $false
			TLSv1_2 = $false
			KeyExhange = $null
			HashAlgorithm = $null
		}
		"ssl2", "ssl3", "tls", "tls11", "tls12" | %{
			$TcpClient = New-Object Net.Sockets.TcpClient
			$TcpClient.Connect($RetValue.Host, $RetValue.Port)
			$SslStream = New-Object Net.Security.SslStream $TcpClient.GetStream(),
				$true,
				([System.Net.Security.RemoteCertificateValidationCallback]{ $true })
			$SslStream.ReadTimeout = 15000
			$SslStream.WriteTimeout = 15000
			try {
				$SslStream.AuthenticateAsClient($RetValue.Host,$null,$_,$false)
				$RetValue.KeyExhange = $SslStream.KeyExchangeAlgorithm
				$RetValue.HashAlgorithm = $SslStream.HashAlgorithm
				$status = $true
			} catch {
				$status = $false
			}
			switch ($_) {
				"ssl2" {$RetValue.SSLv2 = $status}
				"ssl3" {$RetValue.SSLv3 = $status}
				"tls" {$RetValue.TLSv1_0 = $status}
				"tls11" {$RetValue.TLSv1_1 = $status}
				"tls12" {$RetValue.TLSv1_2 = $status}
			}
			# dispose objects to prevent memory leaks
			$TcpClient.Dispose()
			$SslStream.Dispose()
		}
		Return $RetValue
	}
}

<# Only export the module if the caller is attempting to import it #>
If (($MyInvocation.GetType()) -Eq ("System.Management.Automation.InvocationInfo")) {
	Export-ModuleMember -Function "Test-ServerSSLSupport";
}


# ------------------------------------------------------------
#
# Citation(s)
#
#   www.sysadmins.lv  |  "Test web server SSL/TLS protocol support with PowerShell - PKI Extensions"  |  https://www.sysadmins.lv/blog-en/test-web-server-ssltls-protocol-support-with-powershell.aspx
#
# ------------------------------------------------------------