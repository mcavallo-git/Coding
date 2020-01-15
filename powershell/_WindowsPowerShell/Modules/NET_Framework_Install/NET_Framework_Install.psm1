# ------------------------------------------------------------
#
#	PowerShell Module
#		|
#		|--> Name:
#		|      NET_Framework_Install
#		|
#		|--> Description:
#		|      Installs all of the .NET Frameworks seen below
#		|
#		|--> URL:
#		|      https://raw.githubusercontent.com/mcavallo-git/Coding/master/powershell/_WindowsPowerShell/Modules/NET_Framework_Install/NET_Framework_Install.psm1
#		|
#		|--> Example Call(s):
#		       NET_Framework_Install
#
# ------------------------------------------------------------
function NET_Framework_Install {
	Param(
	)
	
	# ------------------------------------------------------------
	# As a one-liner:

	# Install Microsoft .NET Frameworks (in-order): [ 3.5 ], [ 4.0 ], [ 4.8 ] ...";
	Write-Host "`n`nInstalling the following .NET Frameworks (in-order): [ 3.5 ], [ 4.0 ], [ 4.8 ] ...`n`n"; [System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]'Tls11,Tls12'; $URL="http://download.microsoft.com/download/2/0/E/20E90413-712F-438C-988E-FDAA79A8AC3D/dotnetfx35.exe"; $FN="${Env:Temp}\Install_.NET-Framework-3.5.exe"; Write-Host "Downloading/Installing `"${URL}`" (Microsoft .NET Framework 3.5)..."; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart")); $URL="https://download.microsoft.com/download/1/B/E/1BE39E79-7E39-46A3-96FF-047F95396215/dotNetFx40_Full_setup.exe"; $FN="${Env:Temp}\Install_.NET-Framework-4.0.exe"; Write-Host "Downloading/Installing `"${URL}`" (Microsoft .NET Framework 4.0)..."; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart")); $URL="http://go.microsoft.com/fwlink/?LinkId=2085155"; $FN="${Env:Temp}\Install_.NET-Framework-4.8.exe"; Write-Host "Downloading/Installing `"${URL}`" (Microsoft .NET Framework 4.8)..."; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart"));

	# Install Microsoft Visual C++ Redistributables (in-order): [ 2008x86 ], [ 2008x64 ], [ 2008-SP1 ] [ 2010x86 ] , [ 2010x64 ], [ 2015,2017,2019x86 ], [ 2015,2017,2019x64 ]
	Write-Host "`n`nInstalling the following Microsoft Visual C++ Redistributables (in-order): [ 2008x86 ], [ 2008x64 ], [ 2008-SP1 ] [ 2010x86 ] , [ 2010x64 ], [ 2015,2017,2019x86 ], [ 2015,2017,2019x64 ] ...`n`n"; [System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]'Tls11,Tls12'; $URL="https://download.microsoft.com/download/1/1/1/1116b75a-9ec3-481a-a3c8-1777b5381140/vcredist_x86.exe"; $FN="${Env:Temp}\Install_.NET-Framework-2008.$(Get-Date -UFormat '%Y%m%d-%H%M%S').exe"; Write-Host "Downloading/Installing `"${URL}`" (Microsoft Visual C++ 2008 Redistributable - x86)..."; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart")); $URL="https://download.microsoft.com/download/d/2/4/d242c3fb-da5a-4542-ad66-f9661d0a8d19/vcredist_x64.exe"; $FN="${Env:Temp}\Install_.NET-Framework-2008.$(Get-Date -UFormat '%Y%m%d-%H%M%S').exe"; Write-Host "Downloading/Installing `"${URL}`" (Microsoft Visual C++ 2008 Redistributable - x64)..."; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart")); $URL="https://download.microsoft.com/download/5/D/8/5D8C65CB-C849-4025-8E95-C3966CAFD8AE/vcredist_x86.exe"; $FN="${Env:Temp}\Install_.NET-Framework-2008.$(Get-Date -UFormat '%Y%m%d-%H%M%S').exe"; Write-Host "Downloading/Installing `"${URL}`" (Microsoft Visual C++ 2008 Redistributable - SP1)..."; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart")); $URL="https://download.microsoft.com/download/1/6/5/165255E7-1014-4D0A-B094-B6A430A6BFFC/vcredist_x86.exe"; $FN="${Env:Temp}\Install_.NET-Framework-2010.$(Get-Date -UFormat '%Y%m%d-%H%M%S').exe"; Write-Host "Downloading/Installing `"${URL}`" (Microsoft Visual C++ 2010 Redistributable - x86)..."; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart")); $URL="https://download.microsoft.com/download/1/6/5/165255E7-1014-4D0A-B094-B6A430A6BFFC/vcredist_x64.exe"; $FN="${Env:Temp}\Install_.NET-Framework-2010.$(Get-Date -UFormat '%Y%m%d-%H%M%S').exe"; Write-Host "Downloading/Installing `"${URL}`" (Microsoft Visual C++ 2010 Redistributable - x64)..."; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart")); $URL="https://aka.ms/vs/16/release/vc_redist.x86.exe"; $FN="${Env:Temp}\Install_.NET-Framework-2019.$(Get-Date -UFormat '%Y%m%d-%H%M%S').exe"; Write-Host "Downloading/Installing `"${URL}`" (Microsoft Visual C++ 2015-2019 Redistributable - x86)..."; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart")); $URL="https://aka.ms/vs/16/release/VC_redist.x64.exe"; $FN="${Env:Temp}\Install_.NET-Framework-2019.$(Get-Date -UFormat '%Y%m%d-%H%M%S').exe"; Write-Host "Downloading/Installing `"${URL}`" (Microsoft Visual C++ 2015-2019 Redistributable - x64)..."; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart"));

	# ------------------------------------------------------------
	# Broken-up into separate .NET Runtime installs:

	If ($True) {
		
		<# Force TLS 1.1 / TLS 1.2 (as windows uses to SSL 3.0 / TLS 1.0 by-default on a fresh format ) #> 
		[System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]'Tls11,Tls12';

		# ------------------------------------------------------------
		#
		# Microsoft .NET Frameworks
		#


		$URL="http://download.microsoft.com/download/2/0/E/20E90413-712F-438C-988E-FDAA79A8AC3D/dotnetfx35.exe"; $FN="${Env:Temp}\Install_.NET-Framework-3.5.exe"; Write-Host "Downloading/Installing `"${URL}`" (Microsoft .NET Framework 3.5)..."; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart"));
		$URL="https://download.microsoft.com/download/1/B/E/1BE39E79-7E39-46A3-96FF-047F95396215/dotNetFx40_Full_setup.exe"; $FN="${Env:Temp}\Install_.NET-Framework-4.0.exe"; Write-Host "Downloading/Installing `"${URL}`" (Microsoft .NET Framework 4.0)..."; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart"));
		$URL="http://go.microsoft.com/fwlink/?LinkId=2085155"; $FN="${Env:Temp}\Install_.NET-Framework-4.8.exe"; Write-Host "Downloading/Installing `"${URL}`" (Microsoft .NET Framework 4.8)..."; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart"));

		# via NiNite
		# $URL="https://ninite.com/.net4.8/ninite.exe"; $FN="${Env:Temp}\Install_.NET-Framework-4.8.$(Get-Date -UFormat '%Y%m%d-%H%M%S').exe"; Write-Host "Downloading/Installing `"${URL}`"..."; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart"));
		# $URL="https://ninite.com/.net4.0/ninite.exe"; $FN="${Env:Temp}\Install_.NET-Framework-4.0.$(Get-Date -UFormat '%Y%m%d-%H%M%S').exe"; Write-Host "Downloading/Installing `"${URL}`"..."; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart"));
		# $URL="https://ninite.com/.net3.5/ninite.exe"; $FN="${Env:Temp}\Install_.NET-Framework-3.5.$(Get-Date -UFormat '%Y%m%d-%H%M%S').exe"; Write-Host "Downloading/Installing `"${URL}`"..."; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart"));

		# ------------------------------------------------------------
		#
		# Microsoft Visual C++ Redistributables
		#
		

		# <# Microsoft Visual C++ Redistributable 2008 #>
		# $URL="https://www.microsoft.com/en-us/download/details.aspx?id=29"; $FN="${Env:Temp}\Install_.NET-Framework-2008.$(Get-Date -UFormat '%Y%m%d-%H%M%S').exe"; Write-Host "Downloading/Installing `"${URL}`" (Microsoft Visual C++ 2008 Redistributable - x86)..."; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart"));
		# $URL="https://www.microsoft.com/en-us/download/details.aspx?id=15336"; $FN="${Env:Temp}\Install_.NET-Framework-2008.$(Get-Date -UFormat '%Y%m%d-%H%M%S').exe"; Write-Host "Downloading/Installing `"${URL}`" (Microsoft Visual C++ 2008 Redistributable - x64)..."; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart"));
		# $URL="https://www.microsoft.com/en-us/download/details.aspx?id=26368"; $FN="${Env:Temp}\Install_.NET-Framework-2008.$(Get-Date -UFormat '%Y%m%d-%H%M%S').exe"; Write-Host "Downloading/Installing `"${URL}`" (Microsoft Visual C++ 2008 Redistributable - SP1)..."; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart"));

		<# Microsoft Visual C++ Redistributable 2008 #>
		$URL="https://download.microsoft.com/download/1/1/1/1116b75a-9ec3-481a-a3c8-1777b5381140/vcredist_x86.exe"; $FN="${Env:Temp}\Install_.NET-Framework-2008.$(Get-Date -UFormat '%Y%m%d-%H%M%S').exe"; Write-Host "Downloading/Installing `"${URL}`" (Microsoft Visual C++ 2008 Redistributable - x86)..."; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart"));
		$URL="https://download.microsoft.com/download/d/2/4/d242c3fb-da5a-4542-ad66-f9661d0a8d19/vcredist_x64.exe"; $FN="${Env:Temp}\Install_.NET-Framework-2008.$(Get-Date -UFormat '%Y%m%d-%H%M%S').exe"; Write-Host "Downloading/Installing `"${URL}`" (Microsoft Visual C++ 2008 Redistributable - x64)..."; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart"));
		$URL="https://download.microsoft.com/download/5/D/8/5D8C65CB-C849-4025-8E95-C3966CAFD8AE/vcredist_x86.exe"; $FN="${Env:Temp}\Install_.NET-Framework-2008.$(Get-Date -UFormat '%Y%m%d-%H%M%S').exe"; Write-Host "Downloading/Installing `"${URL}`" (Microsoft Visual C++ 2008 Redistributable - SP1)..."; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart"));

		# <# Microsoft Visual C++ Redistributable 2010 #>
		# $URL="https://www.microsoft.com/en-pk/download/details.aspx?id=8328"; $FN="${Env:Temp}\Install_.NET-Framework-2010.$(Get-Date -UFormat '%Y%m%d-%H%M%S').exe"; Write-Host "Downloading/Installing `"${URL}`" (Microsoft Visual C++ 2010 Redistributable - x86)..."; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart"));
		# $URL="https://www.microsoft.com/en-us/download/details.aspx?id=26999"; $FN="${Env:Temp}\Install_.NET-Framework-2010.$(Get-Date -UFormat '%Y%m%d-%H%M%S').exe"; Write-Host "Downloading/Installing `"${URL}`" (Microsoft Visual C++ 2010 Redistributable - x64)..."; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart"));

		<# Microsoft Visual C++ Redistributable 2010 #>
		$URL="https://download.microsoft.com/download/1/6/5/165255E7-1014-4D0A-B094-B6A430A6BFFC/vcredist_x86.exe"; $FN="${Env:Temp}\Install_.NET-Framework-2010.$(Get-Date -UFormat '%Y%m%d-%H%M%S').exe"; Write-Host "Downloading/Installing `"${URL}`" (Microsoft Visual C++ 2010 Redistributable - x86)..."; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart"));
		$URL="https://download.microsoft.com/download/1/6/5/165255E7-1014-4D0A-B094-B6A430A6BFFC/vcredist_x64.exe"; $FN="${Env:Temp}\Install_.NET-Framework-2010.$(Get-Date -UFormat '%Y%m%d-%H%M%S').exe"; Write-Host "Downloading/Installing `"${URL}`" (Microsoft Visual C++ 2010 Redistributable - x64)..."; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart"));


		# <# Microsoft Visual C++ 2015-2019 Redistributable #>
		# $URL="https://aka.ms/vs/16/release/vc_redist.x86.exe"; $FN="${Env:Temp}\Install_.NET-Framework-2019.$(Get-Date -UFormat '%Y%m%d-%H%M%S').exe"; Write-Host "Downloading/Installing `"${URL}`" (Microsoft Visual C++ 2015-2019 Redistributable - x86)..."; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart"));
		# $URL="https://aka.ms/vs/16/release/VC_redist.x64.exe"; $FN="${Env:Temp}\Install_.NET-Framework-2019.$(Get-Date -UFormat '%Y%m%d-%H%M%S').exe"; Write-Host "Downloading/Installing `"${URL}`" (Microsoft Visual C++ 2015-2019 Redistributable - x64)..."; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart"));

		<# Microsoft Visual C++ 2015-2019 Redistributable #>
		$URL="https://aka.ms/vs/16/release/vc_redist.x86.exe"; $FN="${Env:Temp}\Install_.NET-Framework-2019.$(Get-Date -UFormat '%Y%m%d-%H%M%S').exe"; Write-Host "Downloading/Installing `"${URL}`" (Microsoft Visual C++ 2015-2019 Redistributable - x86)..."; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart"));
		$URL="https://aka.ms/vs/16/release/VC_redist.x64.exe"; $FN="${Env:Temp}\Install_.NET-Framework-2019.$(Get-Date -UFormat '%Y%m%d-%H%M%S').exe"; Write-Host "Downloading/Installing `"${URL}`" (Microsoft Visual C++ 2015-2019 Redistributable - x64)..."; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart"));

	}

	Return;

}
Export-ModuleMember -Function "NET_Framework_Install";


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Start-Process"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/start-process?view=powershell-6
#
#   dotnet.microsoft.com  |  "Download .NET (Linux, macOS, and Windows)"  |  https://dotnet.microsoft.com/download
#
#   en.wikipedia.org  |  ".NET Framework version history - Wikipedia"  |  https://en.wikipedia.org/wiki/.NET_Framework_version_history
#
#   support.microsoft.com  |  "The latest supported Visual C++ downloads"  |  https://support.microsoft.com/en-us/help/2977003/the-latest-supported-visual-c-downloads
#
#   www.itechtics.com  |  "Download Microsoft Visual C++ Redistributable (All Versions)"  |  https://www.itechtics.com/microsoft-visual-c-redistributable-versions-direct-download-links/
#
# ------------------------------------------------------------