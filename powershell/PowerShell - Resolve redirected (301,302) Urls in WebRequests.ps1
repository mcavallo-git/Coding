
$Win0SDK_Url = "https://go.microsoft.com/fwlink/p/?linkid=2083338&clcid=0x409";

[System.Net.HttpWebRequest]::Create("${Win0SDK_Url}").GetResponse().ResponseUri.AbsoluteUri;


# ------------------------------------------------------------
# 
# Citation(s)
# 
# https://stackoverflow.com/a/45593554
# 
# ------------------------------------------------------------