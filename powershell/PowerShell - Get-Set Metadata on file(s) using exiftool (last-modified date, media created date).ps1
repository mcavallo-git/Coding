# ------------------------------------------------------------
#
# PowerShell - Get-Set Metadata on File(s) (last-modified date)
#

# Find files (in the current directory) matching "*.mov" and mirror their creation & modified dates onto a neighboring "*.mp4" file with the same basename
If ($True) {
  $FromExtension = "mov";
  $ToExtension = "mp4";
  Get-ChildItem -File | Where-Object { ($_.Name -Like "*.${FromExtension}") } | ForEach-Object {
    $Basename=($_.BaseName);
    $LastAccessTime=($_.LastAccessTime);
    $LastWriteTime=($_.LastWriteTime);
    $MediaCreatedDate=(exiftool -s -s -s -createdate "${Basename}.${FromExtension}");
    Write-Host "Syncing creationg & modified dates from `"${Basename}.${FromExtension}`" to `"${Basename}.${ToExtension}`"";
    exiftool -overwrite_original -createdate="${MediaCreatedDate}" "${Basename}.${ToExtension}";
    Get-ChildItem "${Basename}.${ToExtension}" | % {
      $_.LastWriteTime = ${LastWriteTime};
      $_.LastAccessTime = ${LastAccessTime};
    };
  };
}


# ------------------------------------------------------------
#
# Citation(s)
#
#   superuser.com  |  "Changing last modified date or time via PowerShell - Super User"  |  https://superuser.com/a/1294610
#
# ------------------------------------------------------------