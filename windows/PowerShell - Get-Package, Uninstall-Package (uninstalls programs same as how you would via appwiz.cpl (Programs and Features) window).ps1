
# Uninstall Multiple Packages via PowerShell

@(
"AI Suite 3", 
"AMD Software", 
"AMD_Chipset_Drivers", 
"ARMOURY CRATE Lite Service", 
"ASUS Framework Service", 
"AURA", 
"AURA lighting effect add-on", 
"AURA lighting effect add-on x64", 
"AURA Service", 
"GALAX GAMER RGB", 
"ROG Live Service"
) | ForEach-Object {
	Get-Package -Name "${_}" -EA:0 | Uninstall-Package;
}


# ------------------------------------------------------------
#
# Citation(s)
#
#   community.spiceworks.com  |  "[SOLVED] uninstall a program via powershell - Spiceworks"  |  https://community.spiceworks.com/topic/1966595-uninstall-a-program-via-powershell?page=1#entry-6649944
#
#   docs.microsoft.com  |  "Get-Package (PackageManagement) - PowerShell | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/packagemanagement/get-package?view=powershell-5.1
#
#   docs.microsoft.com  |  "Uninstall-Package (PackageManagement) - PowerShell | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/packagemanagement/uninstall-package?view=powershell-5.1
#
# ------------------------------------------------------------