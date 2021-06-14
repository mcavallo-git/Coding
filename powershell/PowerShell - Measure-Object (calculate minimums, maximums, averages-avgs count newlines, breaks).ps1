# ------------------------------------------------------------
#
#
#   PowerShell - Measure-Object (calculate minimums, maximums, averages-avgs count newlines, breaks).ps1
#
# ------------------------------------------------------------

# Get Average / Minimum / Maximum of a dataset

@(1,2,3,4,5,6,7,8,9) | Measure-Object -Average -Maximum -Minimum;


# ------------------------------------------------------------

# Get Number of Newlines in a dataset
("Line1
Line2
Line3" | Measure-Object -Line).Lines


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Measure-Object (Microsoft.PowerShell.Utility) - PowerShell | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/measure-object?view=powershell-5.1
#
# ------------------------------------------------------------