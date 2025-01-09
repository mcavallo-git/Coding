# ------------------------------------------------------------
#
# PowerShell - Get-Set Metadata on File(s) (last-modified date)
#

# Find files (in the current directory) matching "*.mov" and mirror their creation & modified dates onto a neighboring "*.mp4" file with the same basename
Get-ChildItem -File | Where-Object { ($_.Name -Like "*.mov") } | ForEach-Object {
  $Basename=($_.BaseName);
  $LastAccessTime=($_.LastAccessTime);
  $LastWriteTime=($_.LastWriteTime);
  $MediaCreatedDate=(exiftool -s -s -s -createdate "${Basename}.mov");
  Write-Host "Syncing creationg & modified dates from `"${Basename}.mov`" to `"${Basename}.mp4`"";
  exiftool -overwrite_original -createdate="${MediaCreatedDate}" "${Basename}.mp4";
  Get-ChildItem "${Basename}.mp4" | % {
    $_.LastWriteTime = ${LastWriteTime};
    $_.LastAccessTime = ${LastAccessTime};
  };
};


# ------------------------------------------------------------
#
# Citation(s)
#
#   superuser.com  |  "Changing last modified date or time via PowerShell - Super User"  |  https://superuser.com/a/1294610
#
# ------------------------------------------------------------