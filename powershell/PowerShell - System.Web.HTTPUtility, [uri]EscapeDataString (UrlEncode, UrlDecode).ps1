# ------------------------------------------------------------
# PowerShell - System.Web.HTTPUtility, [uri]-EscapeDataString (UrlEncode, UrlDecode).ps1
# ------------------------------------------------------------
#
# URL Encode  -  [uri]::EscapeDataString
#
[uri]::EscapeDataString("https://example.com");  # Output "https%3a%2f%2fexample.com"

#
# URL Encode  -  [System.Web.HTTPUtility]
#
[System.Web.HTTPUtility]::UrlEncode("https://example.com");  # Output "https%3a%2f%2fexample.com"  ⚠️ Note: System.Web.HTTPUtility doesn't seem to convert parenthesis to their respective URL encoded characters


# ------------------------------------------------------------
#
# URL Decode  -  [System.Web.HTTPUtility]
#
[System.Web.HTTPUtility]::UrlDecode("https%3a%2f%2fexample.com");  # Output:  https://example.com


# ------------------------------------------------------------
#
# Citation(s)
#
#   learn.microsoft.com  |  "HttpUtility.UrlEncode Method (System.Web) | Microsoft Learn"  |  https://learn.microsoft.com/en-us/dotnet/api/system.web.httputility.urlencode?view=net-6.0
#
#   ridicurious.com  |  "URL Encode and Decode with PowerShell | RidiCurious.com"  |  https://ridicurious.com/2017/05/26/url-encode-decode/
#
# ------------------------------------------------------------