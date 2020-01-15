# 
# NET_Framework_Install
#  |
#  |--> Installs all of the .NET Frameworks seen below
# 

function NET_Framework_Install {
	Param(
	)
	
	# ------------------------------------------------------------
	# As a one-liner:

	# Install the following .NET Frameworks: [ 2019x64, 2019x86, 2017x64, 2017x86, 2015x64, 2015x86, 2010x64, 2010x86, 2008x64, 2008x86 ]
	Write-Host "Installing the following .NET Frameworks: [ 4.8, 4.0, 3.5 ] ..."; $URL="http://go.microsoft.com/fwlink/?LinkId=2085155"; $FN="${Env:Temp}\Install_.NET-Framework-4.8.exe"; Write-Host "Downloading/Installing `"${URL}`"..."; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart")); $URL="https://download.microsoft.com/download/1/B/E/1BE39E79-7E39-46A3-96FF-047F95396215/dotNetFx40_Full_setup.exe"; $FN="${Env:Temp}\Install_.NET-Framework-4.0.exe"; Write-Host "Downloading/Installing `"${URL}`"..."; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart")); $URL="http://download.microsoft.com/download/2/0/E/20E90413-712F-438C-988E-FDAA79A8AC3D/dotnetfx35.exe"; $FN="${Env:Temp}\Install_.NET-Framework-3.5.exe"; Write-Host "Downloading/Installing `"${URL}`"..."; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart"));

	Write-Host "Installing the following Microsoft Visual C++ Redistributables: [ 2019x64, 2019x86, 2017x64, 2017x86, 2015x64, 2015x86, 2010x64, 2010x86, 2008x64, 2008x86 ] ...";
	[System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]'Tls11,Tls12'; $URL="https://aka.ms/vs/16/release/VC_redist.x86.exe"; $FN="${Env:Temp}\Install_.NET-Framework-2019.002.exe"; Write-Host "Downloading/Installing `"${URL}`"..."; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart")); $URL="https://aka.ms/vs/16/release/VC_redist.x64.exe"; $FN="${Env:Temp}\Install_.NET-Framework-2019.002.exe"; Write-Host "Downloading/Installing `"${URL}`"..."; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart")); $URL="https://go.microsoft.com/fwlink/?LinkId=746571"; $FN="${Env:Temp}\Install_.NET-Framework-2017.001.exe"; Write-Host "Downloading/Installing `"${URL}`"..."; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart")); $URL="https://go.microsoft.com/fwlink/?LinkId=746571"; $FN="${Env:Temp}\Install_.NET-Framework-2017.002.exe"; Write-Host "Downloading/Installing `"${URL}`"..."; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart")); $URL="https://www.microsoft.com/en-pk/download/details.aspx?id=48145"; $FN="${Env:Temp}\Install_.NET-Framework-2015.001.exe"; Write-Host "Downloading/Installing `"${URL}`"..."; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart")); $URL="https://www.microsoft.com/en-us/download/details.aspx?id=53587"; $FN="${Env:Temp}\Install_.NET-Framework-2015.002.exe"; Write-Host "Downloading/Installing `"${URL}`"..."; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart")); $URL="https://www.microsoft.com/en-pk/download/details.aspx?id=8328"; $FN="${Env:Temp}\Install_.NET-Framework-2010.001.exe"; Write-Host "Downloading/Installing `"${URL}`"..."; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart")); $URL="https://www.microsoft.com/en-us/download/details.aspx?id=26999"; $FN="${Env:Temp}\Install_.NET-Framework-2010.002.exe"; Write-Host "Downloading/Installing `"${URL}`"..."; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart")); $URL="https://www.microsoft.com/en-us/download/details.aspx?id=29"; $FN="${Env:Temp}\Install_.NET-Framework-2008.001.exe"; Write-Host "Downloading/Installing `"${URL}`"..."; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart")); $URL="https://www.microsoft.com/en-us/download/details.aspx?id=15336"; $FN="${Env:Temp}\Install_.NET-Framework-2008.002.exe"; Write-Host "Downloading/Installing `"${URL}`"..."; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart")); $URL="https://www.microsoft.com/en-us/download/details.aspx?id=26368"; $FN="${Env:Temp}\Install_.NET-Framework-2008.003.exe"; Write-Host "Downloading/Installing `"${URL}`"..."; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart"));
	
	# ------------------------------------------------------------
	# Broken-up into separate .NET Runtime installs:
	
	<# Force TLS 1.1 / TLS 1.2 (as windows uses to SSL 3.0 / TLS 1.0 by-default on a fresh format ) #> 
	[System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]'Tls11,Tls12';

	<# .NET Framework 4.8 #>
	$URL="http://go.microsoft.com/fwlink/?LinkId=2085155"; $FN="${Env:Temp}\Install_.NET-Framework-4.8.exe"; Write-Host "Downloading/Installing `"${URL}`"..."; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart"));
	<# .NET Framework 4.0 #>
	$URL="https://download.microsoft.com/download/1/B/E/1BE39E79-7E39-46A3-96FF-047F95396215/dotNetFx40_Full_setup.exe"; $FN="${Env:Temp}\Install_.NET-Framework-4.0.exe"; Write-Host "Downloading/Installing `"${URL}`"..."; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart"));
	<# .NET Framework 3.5 #>
	$URL="http://download.microsoft.com/download/2/0/E/20E90413-712F-438C-988E-FDAA79A8AC3D/dotnetfx35.exe"; $FN="${Env:Temp}\Install_.NET-Framework-3.5.exe"; Write-Host "Downloading/Installing `"${URL}`"..."; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart"));

	<# Microsoft Visual C++ Redistributable for Visual Studio 2015, 2017 and 2019 #>
	$URL="https://aka.ms/vs/16/release/vc_redist.x86.exe"; $FN="${Env:Temp}\Install_.NET-Framework-2019.002.exe"; Write-Host "Downloading/Installing `"${URL}`"..."; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart"));
	$URL="https://aka.ms/vs/16/release/VC_redist.x64.exe"; $FN="${Env:Temp}\Install_.NET-Framework-2019.002.exe"; Write-Host "Downloading/Installing `"${URL}`"..."; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart"));

	<# Microsoft Visual C++ Redistributable for Visual Studio 2015, 2017 and 2019 #>
	$URL="https://my.visualstudio.com/Downloads?pid=1452"; $FN="${Env:Temp}\Install_.NET-Framework-2019.002.exe"; Write-Host "Downloading/Installing `"${URL}`"..."; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart"));
	$URL="https://aka.ms/vs/16/release/VC_redist.x64.exe"; $FN="${Env:Temp}\Install_.NET-Framework-2019.002.exe"; Write-Host "Downloading/Installing `"${URL}`"..."; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart"));

	<# 2010 #>
	$URL="https://www.microsoft.com/en-pk/download/details.aspx?id=8328"; $FN="${Env:Temp}\Install_.NET-Framework-2010.001.exe"; Write-Host "Downloading/Installing `"${URL}`"..."; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart"));
	$URL="https://www.microsoft.com/en-us/download/details.aspx?id=26999"; $FN="${Env:Temp}\Install_.NET-Framework-2010.002.exe"; Write-Host "Downloading/Installing `"${URL}`"..."; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart"));

	<# 2008 #>
	$URL="https://www.microsoft.com/en-us/download/details.aspx?id=29"; $FN="${Env:Temp}\Install_.NET-Framework-2008.001.exe"; Write-Host "Downloading/Installing `"${URL}`"..."; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart"));
	$URL="https://www.microsoft.com/en-us/download/details.aspx?id=15336"; $FN="${Env:Temp}\Install_.NET-Framework-2008.002.exe"; Write-Host "Downloading/Installing `"${URL}`"..."; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart"));
	$URL="https://www.microsoft.com/en-us/download/details.aspx?id=26368"; $FN="${Env:Temp}\Install_.NET-Framework-2008.003.exe"; Write-Host "Downloading/Installing `"${URL}`"..."; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart"));

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