# ------------------------------------------------------------

# PowerShell - Download File from URL (to the Desktop)

$Download_RemoteUrl = "https://github.com/winsw/winsw/releases/download/v2.7.0/WinSW.NET4.exe";
$Download_LocalPath = "${Home}\Desktop\NGINX-Service.exe";
$(New-Object Net.WebClient).DownloadFile(([System.Net.HttpWebRequest]::Create("${Download_RemoteUrl}").GetResponse().ResponseUri.AbsoluteUri),$Download_LocalPath);


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "WebClient.DownloadFile Method - Downloads the resource with the specified URI to a local file"  |  https://docs.microsoft.com/en-us/dotnet/api/system.net.webclient.downloadfile
#
# ------------------------------------------------------------