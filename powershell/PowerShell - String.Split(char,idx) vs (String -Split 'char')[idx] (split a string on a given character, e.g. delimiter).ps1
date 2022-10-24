

# PowerShell - Split a string on a given character (delimter)

("1|2|3|4|5".Split("|"))[2]; # Get the 3rd element


("1|2|3|4|5".Split("|"))[-1];


# ------------------------------------------------------------
# 
# Get the last substring out of a string delimited by a given character
#


# AFTER QUICK TESTING (below) THE OPTIMAL METHOD TO USE IS:
("repo/origin/main" -Split "/")[-1];


If ($True) {

# These should all return the same value

("repo/origin/main".Split("/",-1)); # !!! ERROR - Split() can't handle negative indicies
("repo/origin/main".Split("/"))[-1];
("repo/origin/main" -Split "/")[-1];
("origin/main".Split("/",-1)); # !!! ERROR - Split() can't handle negative indicies
("origin/main".Split("/"))[-1];
("origin/main" -Split "/")[-1];
("repo/origin/main".Split("/",-1)); # !!! ERROR - Split() can't handle negative indicies
("".Split("/"))[-1];
("" -Split "/")[-1];
($Null.Split("/"))[-1]; # !!! ERROR - .Split() method doesn't exist for $Null
($Null -Split "/")[-1];

}


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "About Split - Explains how to use the Split operator to split one or more strings into substrings"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_split?view=powershell-5.1
#
#   docs.microsoft.com  |  "String.Split Method (System) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/dotnet/api/system.string.split?redirectedfrom=MSDN&view=netframework-4.8#System_String_Split_System_Char___System_Int32_
#
# ------------------------------------------------------------