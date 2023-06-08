# ------------------------------------------------------------
#
#
#   PowerShell - Measure-Object (calculate minimums, maximums, averages-avgs count newlines, breaks).ps1
#
# ------------------------------------------------------------


# Get the [ Average, Minimum & Maximum ] values of a dataset
@(1,2,3,4,5,6,7,8,9) | Measure-Object -Average -Maximum -Minimum;


# Get the [ Average ] value of a dataset
@(1,2,3,4,5,6,7,8,9) | Measure-Object -Average | Select-Object -ExpandProperty "Average";


# Get the [ Minimum ] value of a dataset
@(1,2,3,4,5,6,7,8,9) | Measure-Object -Minimum | Select-Object -ExpandProperty "Minimum";


# Get the [ Maximum ] value of a dataset
@(1,2,3,4,5,6,7,8,9) | Measure-Object -Maximum | Select-Object -ExpandProperty "Maximum";


# ------------------------------------------------------------


# Get number of [ Lines, Words & Characters ] in a string
"Line1`nLine2`nLine3" | Measure-Object -Line -Word -Character;


# Get number of [ Lines ] in a string
"Line1`nLine2`nLine3" | Measure-Object -Line | Select-Object -ExpandProperty "Lines";


# Get number of [ Words ] in a string
"Line1 First`nLine2 Second`nLine3 Third" | Measure-Object -Word | Select-Object -ExpandProperty "Words";


# Get number of [ Characters ] in a string
"Line1`nLine2`nLine3" | Measure-Object -Character | Select-Object -ExpandProperty "Characters";


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Measure-Object (Microsoft.PowerShell.Utility) - PowerShell | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/measure-object?view=powershell-5.1
#
# ------------------------------------------------------------