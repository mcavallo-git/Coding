# ------------------------------------------------------------
# PowerShell - Convert line endings (LF to CRLF, CRLF to LF)
# ------------------------------------------------------------

# Convert LF to CRLF
$FilePath="${HOME}\Desktop\example.lf"; $LF="$([char]10)"; $CR="$([char]13)"; (Get-Content -Raw -Path ("${FilePath}")) -replace "${LF}","${CR}${LF}" | Set-Content -Path ("${FilePath}");


# Convert CRLF to LF
$FilePath="${HOME}\Desktop\example.crlf"; $LF="$([char]10)"; $CR="$([char]13)"; (Get-Content -Raw -Path ("${FilePath}")) -replace "${CR}${LF}","${LF}" | Set-Content -Path ("${FilePath}");


# ------------------------------------------------------------
#
# Citation(s)
#
#   forums.powershell.org  |  "How to convert a file LF to CRLF - PowerShell Help - PowerShell Forums"  |  https://forums.powershell.org/t/how-to-convert-a-file-lf-to-crlf/13148/5
#
# ------------------------------------------------------------