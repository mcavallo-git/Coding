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
	Write-Host "Installing the following .NET Frameworks: [ 2019x64, 2019x86, 2017x64, 2017x86, 2015x64, 2015x86, 2010x64, 2010x86, 2008x64, 2008x86 ] ..."; [System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]'Tls11,Tls12'; $URL="https://aka.ms/vs/16/release/VC_redist.x86.exe"; $FN="${Env:Temp}\Install_.NET-Framework-2019.002.exe"; Write-Host "Downloading/Installing `"${URL}`"..."; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart")); $URL="https://aka.ms/vs/16/release/VC_redist.x64.exe"; $FN="${Env:Temp}\Install_.NET-Framework-2019.002.exe"; Write-Host "Downloading/Installing `"${URL}`"..."; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart")); $URL="https://go.microsoft.com/fwlink/?LinkId=746571"; $FN="${Env:Temp}\Install_.NET-Framework-2017.001.exe"; Write-Host "Downloading/Installing `"${URL}`"..."; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart")); $URL="https://go.microsoft.com/fwlink/?LinkId=746571"; $FN="${Env:Temp}\Install_.NET-Framework-2017.002.exe"; Write-Host "Downloading/Installing `"${URL}`"..."; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart")); $URL="https://www.microsoft.com/en-pk/download/details.aspx?id=48145"; $FN="${Env:Temp}\Install_.NET-Framework-2015.001.exe"; Write-Host "Downloading/Installing `"${URL}`"..."; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart")); $URL="https://www.microsoft.com/en-us/download/details.aspx?id=53587"; $FN="${Env:Temp}\Install_.NET-Framework-2015.002.exe"; Write-Host "Downloading/Installing `"${URL}`"..."; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart")); $URL="https://www.microsoft.com/en-pk/download/details.aspx?id=8328"; $FN="${Env:Temp}\Install_.NET-Framework-2010.001.exe"; Write-Host "Downloading/Installing `"${URL}`"..."; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart")); $URL="https://www.microsoft.com/en-us/download/details.aspx?id=26999"; $FN="${Env:Temp}\Install_.NET-Framework-2010.002.exe"; Write-Host "Downloading/Installing `"${URL}`"..."; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart")); $URL="https://www.microsoft.com/en-us/download/details.aspx?id=29"; $FN="${Env:Temp}\Install_.NET-Framework-2008.001.exe"; Write-Host "Downloading/Installing `"${URL}`"..."; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart")); $URL="https://www.microsoft.com/en-us/download/details.aspx?id=15336"; $FN="${Env:Temp}\Install_.NET-Framework-2008.002.exe"; Write-Host "Downloading/Installing `"${URL}`"..."; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart")); $URL="https://www.microsoft.com/en-us/download/details.aspx?id=26368"; $FN="${Env:Temp}\Install_.NET-Framework-2008.003.exe"; Write-Host "Downloading/Installing `"${URL}`"..."; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart"));
	
	# ------------------------------------------------------------
	# Broken-up into separate .NET Runtime installs:
	
	<# Force TLS 1.1 / TLS 1.2 (as windows uses to SSL 3.0 / TLS 1.0 by-default on a fresh format ) #> 
	[System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]'Tls11,Tls12';

	<# 2019 #>
	$URL="https://aka.ms/vs/16/release/VC_redist.x86.exe"; $FN="${Env:Temp}\Install_.NET-Framework-2019.002.exe"; Write-Host "Downloading/Installing `"${URL}`"..."; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart"));
	$URL="https://aka.ms/vs/16/release/VC_redist.x64.exe"; $FN="${Env:Temp}\Install_.NET-Framework-2019.002.exe"; Write-Host "Downloading/Installing `"${URL}`"..."; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart"));

	<# 2017 #>
	$URL="https://go.microsoft.com/fwlink/?LinkId=746571"; $FN="${Env:Temp}\Install_.NET-Framework-2017.001.exe"; Write-Host "Downloading/Installing `"${URL}`"..."; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart"));
	$URL="https://go.microsoft.com/fwlink/?LinkId=746571"; $FN="${Env:Temp}\Install_.NET-Framework-2017.002.exe"; Write-Host "Downloading/Installing `"${URL}`"..."; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart"));

	<# 2015 #>
	$URL="https://www.microsoft.com/en-pk/download/details.aspx?id=48145"; $FN="${Env:Temp}\Install_.NET-Framework-2015.001.exe"; Write-Host "Downloading/Installing `"${URL}`"..."; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart"));
	$URL="https://www.microsoft.com/en-us/download/details.aspx?id=53587"; $FN="${Env:Temp}\Install_.NET-Framework-2015.002.exe"; Write-Host "Downloading/Installing `"${URL}`"..."; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart"));

	<# 2013 #>
	<# $URL="https://support.microsoft.com/en-us/help/4032938/update-for-visual-c-2013-redistributable-package"; $FN="${Env:Temp}\Install_.NET-Framework-2013.001.exe"; Write-Host "Downloading/Installing `"${URL}`"..."; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart")); #>

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
# Citation(s)
#
#   docs.microsoft.com  |  "Start-Process"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/start-process?view=powershell-6

#   www.itechtics.com  |  "Download Microsoft Visual C++ Redistributable (All Versions)"  |  https://www.itechtics.com/microsoft-visual-c-redistributable-versions-direct-download-links/
#
# ------------------------------------------------------------