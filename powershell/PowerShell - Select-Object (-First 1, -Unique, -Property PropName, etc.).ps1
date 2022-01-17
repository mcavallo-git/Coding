# ------------------------------------------------------------
# PowerShell - Select-Object (-First 1, -Unique, -Property PropName, etc.)
# ------------------------------------------------------------
#
# Select-Object -First N;
#

@(1,2,3,4) | Select-Object -First 2;
    # Outputs:
    # 1
    # 2


# ------------------------------
#
# Select-Object -Unique;
#

@(1,2,2,3,3,3,4,4,4,4) | Select-Object -Unique;
    # Outputs:
    # 1
    # 2
    # 3
    # 4


# ------------------------------
#
# Select-Object -ExpandProperty "_____";
#

Get-Process | Where-Object { (($_.Name -Like '*powershell*') -Or ($_.Name -Like '*pwsh*')); } | Select-Object -ExpandProperty "Id";
    # Outputs:
    # pid (one or more for running powershell/pwsh terminals)


# ------------------------------------------------------------
#
#	Citation(s)
#
#   docs.microsoft.com  |  "Select-Object (Microsoft.PowerShell.Utility) - PowerShell | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/select-object
#
# ------------------------------------------------------------