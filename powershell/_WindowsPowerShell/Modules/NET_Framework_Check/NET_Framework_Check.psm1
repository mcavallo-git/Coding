#
#	PowerShell - Net Framework checking & Ice Cold Coca Cola
#		Query the registry to check for installed versions of .NET Framework
#
function NET_Framework_Check {
	Param(

		[String]$MainVersion = 4,

		[Switch]$Quiet

	)
	# ------------------------------------------------------------
	If ($False) { # RUN THIS SCRIPT:

		$ProtoBak=[System.Net.ServicePointManager]::SecurityProtocol; [System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; $ProgressPreference='SilentlyContinue'; Clear-DnsClientCache; Set-ExecutionPolicy "RemoteSigned" -Scope "CurrentUser" -Force; Try { Invoke-Expression ((Invoke-WebRequest -UseBasicParsing -TimeoutSec (7.5) -Uri ('https://raw.githubusercontent.com/mcavallo-git/Coding/master/powershell/_WindowsPowerShell/Modules/NET_Framework_Check/NET_Framework_Check.psm1') ).Content) } Catch {}; If (-Not (Get-Command -Name 'NET_Framework_Check' -ErrorAction 'SilentlyContinue')) { Import-Module ([String]::Format('{0}\Documents\GitHub\Coding\powershell\_WindowsPowerShell\Modules\NET_Framework_Check\NET_Framework_Check.psm1', ((Get-Variable -Name 'HOME').Value))); }; [System.Net.ServicePointManager]::SecurityProtocol=$ProtoBak;
		NET_Framework_Check;

	}	
	# ------------------------------------------------------------

	Clear-Host;

	$RegistryKey_NetFrameworks = "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP";

	$NetFrameworks = @{};
	$NetFrameworks['2.0'] = @{ Installed=$False; MinRelease=$Null; Version="-"; RegistryKey="$RegistryKey_NetFrameworks\v2.0*"; };
	$NetFrameworks['3.0'] = @{ Installed=$False; MinRelease=$Null; Version="-"; RegistryKey="$RegistryKey_NetFrameworks\v3.0"; };
	$NetFrameworks['3.5'] = @{ Installed=$False; MinRelease=$Null; Version="-"; RegistryKey="$RegistryKey_NetFrameworks\v3.5"; };
	$NetFrameworks['4.0'] = @{ Installed=$False; MinRelease=$Null; Version="-"; RegistryKey="$RegistryKey_NetFrameworks\v3.5"; };
	$NetFrameworks['4.0.0'] = @{ Installed=$False; MinRelease=378389; Version="-"; RegistryKey="$RegistryKey_NetFrameworks\v4\Full"; };
	$NetFrameworks['4.5.0'] = @{ Installed=$False; MinRelease=378389; Version="-"; RegistryKey="$RegistryKey_NetFrameworks\v4\Full"; };
	$NetFrameworks['4.5.1'] = @{ Installed=$False; MinRelease=378675; Version="-"; RegistryKey="$RegistryKey_NetFrameworks\v4\Full"; };
	$NetFrameworks['4.5.2'] = @{ Installed=$False; MinRelease=379893; Version="-"; RegistryKey="$RegistryKey_NetFrameworks\v4\Full"; };
	$NetFrameworks['4.6.0'] = @{ Installed=$False; MinRelease=393295; Version="-"; RegistryKey="$RegistryKey_NetFrameworks\v4\Full"; };
	$NetFrameworks['4.6.1'] = @{ Installed=$False; MinRelease=394254; Version="-"; RegistryKey="$RegistryKey_NetFrameworks\v4\Full"; };
	$NetFrameworks['4.6.2'] = @{ Installed=$False; MinRelease=394802; Version="-"; RegistryKey="$RegistryKey_NetFrameworks\v4\Full"; };
	$NetFrameworks['4.7.0'] = @{ Installed=$False; MinRelease=460798; Version="-"; RegistryKey="$RegistryKey_NetFrameworks\v4\Full"; };
	$NetFrameworks['4.7.1'] = @{ Installed=$False; MinRelease=461308; Version="-"; RegistryKey="$RegistryKey_NetFrameworks\v4\Full"; };
	$NetFrameworks['4.7.2'] = @{ Installed=$False; MinRelease=461808; Version="-"; RegistryKey="$RegistryKey_NetFrameworks\v4\Full"; };
	$NetFrameworks['4.8.0'] = @{ Installed=$False; MinRelease=528040; Version="-"; RegistryKey="$RegistryKey_NetFrameworks\v4\Full"; };

	Try {
		$VersionInstalled_4_0 = (Get-ItemPropertyValue -Path ("${RegistryKey_NetFrameworks}\v4\Client") -Name ("Version"));
		$ReleaseInstalled_4_0 = (Get-ItemPropertyValue -Path ("${RegistryKey_NetFrameworks}\v4\Client") -Name ("Release"));
	} Catch {
		$VersionInstalled_4_0 = $Null;
		$ReleaseInstalled_4_0 = $Null;
	}

	ForEach ($EachVer In ($NetFrameworks.Keys)) {

		If ($EachVer -Eq "2.0") { # ------------------------------------------------------------
			# .NET Framework v2.0
			Try {
				$NetFrameworks[$EachVer].Version = (Get-ChildItem ("${RegistryKey_NetFrameworks}") | Where-Object { $_.PSChildName -Like "v$EachVer*" } | Get-ItemPropertyValue -Name ("Version"));
			} Catch {
				$NetFrameworks[$EachVer].Version = "-";
			}
		} ElseIf ($EachVer -Eq "3.0") { # ------------------------------------------------------------
			# .NET Framework v3.0
			Try {
				$NetFrameworks[$EachVer].Version = (Get-ChildItem ("${RegistryKey_NetFrameworks}") | Where-Object { $_.PSChildName -Like "v$EachVer*" } | Get-ItemPropertyValue -Name ("Version"));
			} Catch {
				$NetFrameworks[$EachVer].Version = "-";
			}
		} ElseIf ($EachVer -Eq "3.5") { # ------------------------------------------------------------
			# .NET Framework v3.5
			Try {
				$NetFrameworks[$EachVer].Version = (Get-ChildItem ("${RegistryKey_NetFrameworks}") | Where-Object { $_.PSChildName -Like "v$EachVer*" } | Get-ItemPropertyValue -Name ("Version"));
			} Catch {
				$NetFrameworks[$EachVer].Version = "-";
			}
		} ElseIf ($EachVer.StartsWith("4.")) { # ------------------------------------------------------------
			# .NET Framework v4.0+ (4.0.x, 4.5.x, 4.6.x, 4.7.x, 4.8.x)
			Try {
				If (($VersionInstalled_4_0 -Ne $Null) -And ($ReleaseInstalled_4_0 -ge $NetFrameworks[$EachVer].MinRelease)) {
					$NetFrameworks[$EachVer].Version = $VersionInstalled_4_0;
				} Else {
					$NetFrameworks[$EachVer].Version = "-";
				}
			} Catch {
				$NetFrameworks[$EachVer].Version = "-";
			}
		}

		If ((($NetFrameworks[$EachVer].Version) -Eq "-") -Or (($NetFrameworks[$EachVer].Version) -Eq $Null)) {
			$NetFrameworks[$EachVer].Installed = $False;
		} Else {
			$NetFrameworks[$EachVer].Installed = $True;
		}


	}

	$Dashes = "------------------------------";
	$DashEquals = (($Dashes).Replace('-','='));
	$DashSpaces = (($Dashes).Replace('-',' '));
	$Color = "Cyan";
	Write-Host -ForegroundColor ("DarkGray") "";
	Write-Host -ForegroundColor ("Yellow") "  Microsoft .NET Framework -> Checking compatibility...";
	Write-Host -ForegroundColor ("DarkGray") "";
	Write-Host -ForegroundColor ("DarkGray") " |$DashEquals|$DashEquals|$DashEquals| ";
	Write-Host -ForegroundColor ("DarkGray") " |$DashSpaces|$DashSpaces|$DashSpaces| ";
	Write-Host -ForegroundColor ("DarkGray") -NoNewLine (" | ");<# Start of Line #>
	$Str=([String]("Version"));
	Write-Host -ForegroundColor ($Color) -NoNewLine (($Str)+(" "));
	Write-Host -ForegroundColor ("DarkGray") -NoNewLine ("".PadRight(($Dashes.Length-(3+($Str).Length)),"-"));
	Write-Host -ForegroundColor ("DarkGray") -NoNewLine (" | ");
	$Str=([String]("Compatible?"));
	Write-Host -ForegroundColor ($Color) -NoNewLine (($Str)+(" "));
	Write-Host -ForegroundColor ("DarkGray") -NoNewLine ("".PadRight(($Dashes.Length-(3+($Str).Length)),"-"));
	Write-Host -ForegroundColor ("DarkGray") -NoNewLine (" | ");
	$Str=([String]("Installed Version"));
	Write-Host -ForegroundColor ($Color) -NoNewLine (($Str)+(" "));
	Write-Host -ForegroundColor ("DarkGray") -NoNewLine ("".PadRight(($Dashes.Length-(3+($Str).Length)),"-"));
	Write-Host -ForegroundColor ("DarkGray") -NoNewLine (" | ");
	Write-Host -ForegroundColor ("DarkGray") -NoNewLine ("`n"); <# End of Line #>
	Write-Host -ForegroundColor ("DarkGray") " |$DashSpaces|$DashSpaces|$DashSpaces| ";
	Write-Host -ForegroundColor ("DarkGray") " |$DashEquals|$DashEquals|$DashEquals| ";
	Write-Host -ForegroundColor ("DarkGray") " |$DashSpaces|$DashSpaces|$DashSpaces| ";
	ForEach ($EachVer In ($NetFrameworks.Keys | Sort-Object)) {
		$Color = (&{If(($NetFrameworks[$EachVer].Installed) -Eq $True) { "Green" } Else { "Yellow" }});
		Write-Host -ForegroundColor ("DarkGray") -NoNewLine (" | "); <# Start of Line #>
		$Str=([String]($EachVer));
		Write-Host -ForegroundColor ($Color) -NoNewLine (($Str)+(" "));
		Write-Host -ForegroundColor ("DarkGray") -NoNewLine ("".PadRight(($Dashes.Length-(3+($Str).Length)),"-"));
		Write-Host -ForegroundColor ("DarkGray") -NoNewLine (" | ");
		$Str=([String]($NetFrameworks[$EachVer].Installed));
		Write-Host -ForegroundColor ($Color) -NoNewLine (($Str)+(" "));
		Write-Host -ForegroundColor ("DarkGray") -NoNewLine ("".PadRight(($Dashes.Length-(3+($Str).Length)),"-"));
		Write-Host -ForegroundColor ("DarkGray") -NoNewLine (" | ");
		$Str=([String]($NetFrameworks[$EachVer].Version));
		Write-Host -ForegroundColor ($Color) -NoNewLine (($Str)+(" "));
		Write-Host -ForegroundColor ("DarkGray") -NoNewLine ("".PadRight(($Dashes.Length-(3+($Str).Length)),"-"));
		Write-Host -ForegroundColor ("DarkGray") -NoNewLine (" | ");
		Write-Host -ForegroundColor ("DarkGray") -NoNewLine ("`n"); <# End of Line #>
		Write-Host -ForegroundColor ("DarkGray") " |$DashSpaces|$DashSpaces|$DashSpaces| ";
	}
	Write-Host -ForegroundColor ("DarkGray") " |$DashEquals|$DashEquals|$DashEquals|  ";
	Write-Host -ForegroundColor ("DarkGray") "";

	If ($MainVersion -eq 4) {

	}

	Return;

}

<# Only export the module if the caller is attempting to import it #>
If (($MyInvocation.GetType()) -Eq ("System.Management.Automation.InvocationInfo")) {
	Export-ModuleMember -Function "NET_Framework_Check";
}


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Clear-Host - Clears the display in the host program"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/functions/clear-host?view=powershell-5.1
#
#   docs.microsoft.com  |  "How to: Determine which .NET Framework versions are installed"  |  https://docs.microsoft.com/en-us/dotnet/framework/migration-guide/how-to-determine-which-versions-are-installed#ps_a
#
#   en.wikipedia.org  |  ".NET Framework version history"  |  https://en.wikipedia.org/wiki/.NET_Framework_version_history#.NET_Framework_1.0
#
#   smartdoc.zendesk.com  |  "How to check your .NET Framework version"  |  https://smartdoc.zendesk.com/hc/en-us/articles/205232308-How-to-check-your-NET-Framework-version
#
# ------------------------------------------------------------