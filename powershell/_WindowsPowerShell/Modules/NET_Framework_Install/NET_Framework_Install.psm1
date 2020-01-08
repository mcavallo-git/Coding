# 
# NET_Framework_Install
#  |
#  |--> Installs all of the .NET Frameworks seen below
# 

function NET_Framework_Install {
	Param(
	)

	# 2019
	Write-Host "Installing  [ Microsoft Visual C++ 2015-2019 Redistributable (x86), (x64) ]...";
	$URL="https://aka.ms/vs/16/release/VC_redist.x86.exe"; $FN="${Env:Temp}\Install_.NET-Framework-2019.001.exe"; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart"));
	$URL="https://aka.ms/vs/16/release/VC_redist.x64.exe"; $FN="${Env:Temp}\Install_.NET-Framework-2019.001.exe"; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart"));


	# 2017
	Write-Host "Installing  [ Microsoft Visual C++ 2017 Redistributable (x86), (x64) ]...";
	$URL="https://go.microsoft.com/fwlink/?LinkId=746571"; $FN="${Env:Temp}\Install_.NET-Framework-2019.001.exe"; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart"));
	$URL="https://go.microsoft.com/fwlink/?LinkId=746571"; $FN="${Env:Temp}\Install_.NET-Framework-2019.001.exe"; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart"));


	# 2015
	Write-Host "Installing  [ Microsoft Visual C++ 2015 Redistributable (x86), (x64) ]...";
	$URL="https://www.microsoft.com/en-pk/download/details.aspx?id=48145"; $FN="${Env:Temp}\Install_.NET-Framework-2019.001.exe"; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart"));
	$URL="https://www.microsoft.com/en-us/download/details.aspx?id=53587"; $FN="${Env:Temp}\Install_.NET-Framework-2019.001.exe"; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart"));


	# 2013
	# Write-Host "Installing  [ Microsoft Visual C++ 2013 Redistributable ]...";
	# $URL="https://support.microsoft.com/en-us/help/4032938/update-for-visual-c-2013-redistributable-package"; $FN="${Env:Temp}\Install_.NET-Framework-2019.001.exe"; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart"));


	# 2010
	Write-Host "Installing  [ Microsoft Visual C++ 2010 Redistributable (x86), (x64) ]...";
	$URL="https://www.microsoft.com/en-pk/download/details.aspx?id=8328"; $FN="${Env:Temp}\Install_.NET-Framework-2019.001.exe"; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart"));
	$URL="https://www.microsoft.com/en-us/download/details.aspx?id=26999"; $FN="${Env:Temp}\Install_.NET-Framework-2019.001.exe"; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart"));


	# 2008
	Write-Host "Installing  [ Microsoft Visual C++ 2008 Redistributable (x86), (x64) ]...";
	$URL="https://www.microsoft.com/en-us/download/details.aspx?id=29"; $FN="${Env:Temp}\Install_.NET-Framework-2019.001.exe"; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart"));
	$URL="https://www.microsoft.com/en-us/download/details.aspx?id=15336"; $FN="${Env:Temp}\Install_.NET-Framework-2019.001.exe"; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart"));
	$URL="https://www.microsoft.com/en-us/download/details.aspx?id=26368"; $FN="${Env:Temp}\Install_.NET-Framework-2019.001.exe"; $(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${URL}").GetResponse().ResponseUri.AbsoluteUri),$FN); Start-Process -Filepath ($FN) -ArgumentList (@("/q","/norestart"));

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