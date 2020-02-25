
<# Pulled from citation (below) #>

# ------------------------------------------------------------
# Q:
#   Is there any variable I can write out to my log file that would give me some information about how the script was launched as I have no idea how it is being ran.


# ------------------------------------------------------------
# A:
#   Yep, $MyInvocation. You might want to use something like:

      $MyInvocation | Export-CLIXML -Path $SomeCalculatedPath;

#    Using serialized output is important as export-csv, out-file, and other methods won't give you the nested properties under this object.


# ------------------------------------------------------------
#
# Citation(s)
#
#   arstechnica.com  |  "Powershell script determine how it was launched? - Ars Technica OpenForum"  |  https://arstechnica.com/civis/viewtopic.php?p=28144729&sid=c035f5f7447a5e7d9a9263198ed63d28#p28144729
#
# ------------------------------------------------------------