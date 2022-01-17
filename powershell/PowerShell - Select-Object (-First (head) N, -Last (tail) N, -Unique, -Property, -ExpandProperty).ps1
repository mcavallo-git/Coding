# ------------------------------------------------------------
# PowerShell - Select-Object (-First (head) N, -Last (tail) N, -Unique, -Property, -ExpandProperty)
# ------------------------------------------------------------
#
# Select-Object -First N;
#  |
#  |--> Similar to 'head -n N' in Linux
#
#

@(1,2,3,4,5) | Select-Object -First 2;
    # Outputs:
    # 1
    # 2


# ------------------------------------------------------------
#
# Select-Object -Last N;
#  |
#  |--> Similar to 'tail -n N' in Linux
#
#

@(1,2,3,4,5) | Select-Object -Last 2;
    # Outputs:
    # 4
    # 5


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
# Select-Object -Proerty "_____";
#

Get-PSDrive -PSProvider "FileSystem" | Select-Object -Property "Root";
    # Outputs:
    #
    # Root
    # ----
    # C:\


# ------------------------------
#
# Select-Object -ExpandProperty "_____";
#

Get-Process | Where-Object { (($_.Name -Like '*powershell*') -Or ($_.Name -Like '*pwsh*')); } | Select-Object -ExpandProperty "Id";
    # Outputs:
    # pid  (one or more integers corresponding to running powershell/pwsh terminals)


# ------------------------------------------------------------
#
#	Citation(s)
#
#   docs.microsoft.com  |  "Select-Object (Microsoft.PowerShell.Utility) - PowerShell | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/select-object
#
# ------------------------------------------------------------