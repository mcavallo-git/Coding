# ------------------------------------------------------------
#
# PowerShell - Get-Set Metadata on file(s) using exiftool (last-modified date, media created date)
#
# ------------------------------------------------------------

# exiftool - Get metadata from file
$FN="Filename"; exiftool -a -G1 -s "${FN}";


# ------------------------------

# exiftool - Bulk set date-created (expects files to be in terminal's working directory)
If ($True) {
  $FN="1950 - Filename"; $YY="1950"; $MM="06"; $DD="01"; Get-ChildItem "${FN}" | % { $_.LastWriteTime = "${MM}/${DD}/${YY} 12:00:00"; }; exiftool "-FileCreateDate<FileModifyDate" "-FileModifyDate<FileModifyDate" "-CreateDate=" "-ModifyDate=" "${FN}";
  $FN="1960 - Filename"; $YY="1960"; $MM="06"; $DD="01"; Get-ChildItem "${FN}" | % { $_.LastWriteTime = "${MM}/${DD}/${YY} 12:00:00"; }; exiftool "-FileCreateDate<FileModifyDate" "-FileModifyDate<FileModifyDate" "-CreateDate=" "-ModifyDate=" "${FN}";
  $FN="1970 - Filename"; $YY="1970"; $MM="06"; $DD="01"; Get-ChildItem "${FN}" | % { $_.LastWriteTime = "${MM}/${DD}/${YY} 12:00:00"; }; exiftool "-FileCreateDate<FileModifyDate" "-FileModifyDate<FileModifyDate" "-CreateDate=" "-ModifyDate=" "${FN}";
  $FN="1980 - Filename"; $YY="1980"; $MM="06"; $DD="01"; Get-ChildItem "${FN}" | % { $_.LastWriteTime = "${MM}/${DD}/${YY} 12:00:00"; }; exiftool "-FileCreateDate<FileModifyDate" "-FileModifyDate<FileModifyDate" "-CreateDate=" "-ModifyDate=" "${FN}";
  $FN="1990 - Filename"; $YY="1990"; $MM="06"; $DD="01"; Get-ChildItem "${FN}" | % { $_.LastWriteTime = "${MM}/${DD}/${YY} 12:00:00"; }; exiftool "-FileCreateDate<FileModifyDate" "-FileModifyDate<FileModifyDate" "-CreateDate=" "-ModifyDate=" "${FN}";
  $FN="2000 - Filename"; $YY="2000"; $MM="06"; $DD="01"; Get-ChildItem "${FN}" | % { $_.LastWriteTime = "${MM}/${DD}/${YY} 12:00:00"; }; exiftool "-FileCreateDate<FileModifyDate" "-FileModifyDate<FileModifyDate" "-CreateDate=" "-ModifyDate=" "${FN}";
}


# ------------------------------

# exiftool - Match dates between filetypes (same name)
#  |-> Finds files (in the current directory) matching "*.mov" and mirror their creation & modified dates onto a neighboring "*.mp4" file with the same basename
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