# ------------------------------------------------------------
#
# PowerShell - Base64 encode/encoding & decode/decoding strings
#
# ------------------------------------------------------------
#
# ENCODING
#

# Base64 encode (Using the UTF8 character set)
$secret_plaintext="0123456789
ABCDEFGHIJKLMNOPQRSTUVWXYZ
abcdefghijklmnopqrstuvwxyz
`~!@#$%^&()-_=+\|;:";
$secret_base64=([Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes(${secret_plaintext})));
Write-Host ${secret_base64};


# Base64 encode (Using the UTF8 character set) - OneLiner (for quick one-offs/debugging)
[Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes("0123456789
ABCDEFGHIJKLMNOPQRSTUVWXYZ
abcdefghijklmnopqrstuvwxyz
`~!@#$%^&()-_=+\|;:"));

# ------------------------------------------------------------
#
# DECODING
#


# Base64 decode (using the UTF8 character set)
$secret_base64="MDEyMzQ1Njc4OQpBQkNERUZHSElKS0xNTk9QUVJTVFVWV1hZWgphYmNkZWZnaGlqa2xtbm9wcXJzdHV2d3h5egp+IUAjJCVeJigpLV89K1x8Ozo=";
$secret_plaintext=([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String(${secret_base64})));
Write-Host ${secret_plaintext};


# Base64 decode (using the UTF8 character set) - OneLiner (for quick one-offs/debugging)
[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("MDEyMzQ1Njc4OQpBQkNERUZHSElKS0xNTk9QUVJTVFVWV1hZWgphYmNkZWZnaGlqa2xtbm9wcXJzdHV2d3h5egp+IUAjJCVeJigpLV89K1x8Ozo="));


# ------------------------------------------------------------
#
# Citation(s)
#
#   adsecurity.org  |  "How to Enable or Disable Reading List in Google Chrome"  |  https://adsecurity.org/?p=478
#
# ------------------------------------------------------------