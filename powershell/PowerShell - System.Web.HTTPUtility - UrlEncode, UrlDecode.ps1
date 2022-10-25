# ------------------------------------------------------------
# PowerShell - System.Web.HTTPUtility - UrlEncode, UrlDecode.ps1
# ------------------------------------------------------------
#
# URL Encode
#
[System.Web.HTTPUtility]::UrlEncode("https://example.com");
# Outputs:  https%3a%2f%2fexample.com


# ------------------------------------------------------------
#
# URL Decode
#
[System.Web.HTTPUtility]::UrlDecode("https%3a%2f%2fexample.com");
# Outputs:  https://example.com


# ------------------------------------------------------------
#
# Citation(s)
#
#   learn.microsoft.com  |  "HttpUtility.UrlEncode Method (System.Web) | Microsoft Learn"  |  https://learn.microsoft.com/en-us/dotnet/api/system.web.httputility.urlencode?view=net-6.0
#
#   ridicurious.com  |  "URL Encode and Decode with PowerShell | RidiCurious.com"  |  https://ridicurious.com/2017/05/26/url-encode-decode/
#
# ------------------------------------------------------------