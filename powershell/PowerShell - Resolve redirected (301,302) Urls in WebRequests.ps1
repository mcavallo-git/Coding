# ------------------------------------------------------------
# PowerShell - Resolve redirected Urls (301, 302, System.Net.HttpWebRequest)
# ------------------------------------------------------------

# General Syntax - Resolve a URL
[System.Net.HttpWebRequest]::Create("__URL_TO_RESOLVE__").GetResponse().ResponseUri.AbsoluteUri;


# ------------------------------

# Ex) Resolve the URL pointing to version "10.1.22621.755" of the "Windows Development SDK" (Software Development Kit)
[System.Net.HttpWebRequest]::Create("https://go.microsoft.com/fwlink/p/?linkid=2196241").GetResponse().ResponseUri.AbsoluteUri;

# Ex) Resolve the URL pointing to the latest version for "kubectl" (Kubernetes CLI utility)
[System.Net.HttpWebRequest]::Create("https://dl.k8s.io/release/stable.txt").GetResponse().ResponseUri.AbsoluteUri;


# ------------------------------------------------------------
#
# Citation(s)
#
#   stackoverflow.com  |  "url redirection - Powershell determine new URL of a permanently moved (redirected) resource - Stack Overflow"  |  https://stackoverflow.com/a/45593554
#
# ------------------------------------------------------------