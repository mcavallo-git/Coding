# ------------------------------------------------------------
#
# PowerShell - Query the registry to check for installed versions of .NET Framework (4.5 and higher)
#
# ------------------------------------------------------------

$NetFrameworks = @{};
$NetFrameworks['2.0'] = @{ Installed=$False; MinRelease=$Null; Version=$Null; };
$NetFrameworks['3.0'] = @{ Installed=$False; MinRelease=$Null; Version=$Null; };
$NetFrameworks['3.5'] = @{ Installed=$False; MinRelease=$Null; Version=$Null; };
$NetFrameworks['4.5.0'] = @{ Installed=$False; MinRelease=378389; Version=$Null; };
$NetFrameworks['4.5.1'] = @{ Installed=$False; MinRelease=378675; Version=$Null; };
$NetFrameworks['4.5.2'] = @{ Installed=$False; MinRelease=379893; Version=$Null; };
$NetFrameworks['4.6.0'] = @{ Installed=$False; MinRelease=393295; Version=$Null; };
$NetFrameworks['4.6.1'] = @{ Installed=$False; MinRelease=394254; Version=$Null; };
$NetFrameworks['4.6.2'] = @{ Installed=$False; MinRelease=394802; Version=$Null; };
$NetFrameworks['4.7.0'] = @{ Installed=$False; MinRelease=460798; Version=$Null; };
$NetFrameworks['4.7.1'] = @{ Installed=$False; MinRelease=461308; Version=$Null; };
$NetFrameworks['4.7.2'] = @{ Installed=$False; MinRelease=461808; Version=$Null; };
$NetFrameworks['4.8.0'] = @{ Installed=$False; MinRelease=528040; Version=$Null; };

$i=0;
$WriteHosts = @{};
$WriteHosts[$i++] = "";
$WriteHosts[$i++] = " Installed?  |  .NET Framework";
$WriteHosts[$i++] = "- - - - - - - - - - - - - - - - - -";
ForEach ($EachKey In (Get-ChildItem "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\" | Where-Object { $_.PSChildName -Like "v*" })) {
	ForEach ($EachVersion In ($NetFrameworks.Keys)) {
		If ($NetFrameworks[$EachVersion].Release -Eq $Null) {
			<# Older version(s) of .NET Framework ( < 4.0 ) #>
			Try {
				If ($EachKey.PSChildName.StartsWith("v$($EachVersion)")) {
					$NetFrameworks[$EachVersion].Installed = $True;
					$NetFrameworks[$EachVersion].Version = Get-ItemPropertyValue -Path ("Registry::$($EachKey.Name)\") -Name ("Version") -ErrorAction ("SilentlyContinue");
				}
			} Catch {
			}
		} Else {
			<# Newer version(s) of .NET Framework ( > 4.0 ) #>
			Try {
				$EachRelease = Get-ItemPropertyValue -Path ("Registry::$($EachKey.Name)\Full\") -Name ("Release") -ErrorAction ("SilentlyContinue");
				If ($EachRelease -Ge $NetFrameworks[$EachVersion].MinRelease) {
					$NetFrameworks[$EachVersion].Installed = $True;
				}
			} Catch {
			}
		}
	}
}


$WriteHost = "`n";
$WriteHost += "`n Installed?  |  .NET Framework";
$WriteHost += "`n- - - - - - - - - - - - - - - - - -";
ForEach($EachVersion In ($NetFrameworks.Keys | Sort-Object)) {
	$BooleanToString = (&{If($NetFrameworks[$EachVersion].Installed) {"True "} Else {"False"}});
	$WriteHost += "`n      $BooleanToString  |  $EachVersion";
}
$WriteHost += "`n";

Write-Host ($WriteHost);

Start-Sleep 60;

# ------------------------------------------------------------
#	Citation(s)
#
#	docs.microsoft.com  |  How to: Determine which .NET Framework versions are installed  |  https://docs.microsoft.com/en-us/dotnet/framework/migration-guide/how-to-determine-which-versions-are-installed#ps_a
#
# smartdoc.zendesk.com  |  "How to check your .NET Framework version"  |  https://smartdoc.zendesk.com/hc/en-us/articles/205232308-How-to-check-your-NET-Framework-version
#
# ------------------------------------------------------------