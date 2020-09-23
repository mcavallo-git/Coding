

$FilepathToRead = "${Home}\Desktop\test.txt";


# OUTPUT AS ARRAY OF STRINGS (to walk line-by-line)
$GetContent_Output = Get-Content -Path ("$FilepathToRead");


# OUTPUT AS ARRAY OF CHARACTERS (single string including newline characters)
$ReadAllText_Output = [IO.File]::ReadAllText("${FilepathToRead}");




# ------------------------------------------------------------
#
# Citation(s)
#
#   stackoverflow.com  |  "PowerShell: Store Entire Text File Contents in Variable - Stack Overflow"  |  https://stackoverflow.com/a/7976784
#
# ------------------------------------------------------------