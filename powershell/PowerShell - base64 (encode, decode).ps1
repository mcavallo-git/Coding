
#  ENCODE  :::  Base64 - Encode/Encoding a String (via PowerShell):
$secret_plaintext = "Some secret, i.e. a password, token, etc.";
$secret_base64 = [Convert]::ToBase64String([System.Text.Encoding]::Unicode.GetBytes(${secret_plaintext}));
Write-Host ${secret_base64};


#  DECODE  :::  Base64 - Decode/Decoding a String (via PowerShell):
$secret_base64 = "UwBvAG0AZQAgAHMAZQBjAHIAZQB0ACwAIABpAC4AZQAuACAAYQAgAHAAYQBzAHMAdwBvAHIAZAAsACAAdABvAGsAZQBuACwAIABlAHQAYwAuAA==";
$secret_plaintext = [System.Text.Encoding]::Unicode.GetString([System.Convert]::FromBase64String(${secret_base64}))
Write-Host ${secret_plaintext};


#  CITATION  :::  "Simple Obfuscation with PowerShell using Base64 Encoding" - https://adsecurity.org/?p=478
