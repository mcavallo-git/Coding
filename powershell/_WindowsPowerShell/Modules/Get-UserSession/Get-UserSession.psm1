# ------------------------------------------------------------
If ($False) { # RUN THIS SCRIPT:


$ProtoBak=[System.Net.ServicePointManager]::SecurityProtocol; [System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; $ProgressPreference='SilentlyContinue'; Clear-DnsClientCache; Set-ExecutionPolicy "RemoteSigned" -Scope "CurrentUser" -Force; Try { Invoke-Expression ((Invoke-WebRequest -UseBasicParsing -TimeoutSec (7.5) -Uri ('https://raw.githubusercontent.com/mcavallo-git/Coding/main/powershell/_WindowsPowerShell/Modules/Get-UserSession/Get-UserSession.psm1') ).Content) } Catch {}; If (-Not (Get-Command -Name 'Get-UserSession' -ErrorAction 'SilentlyContinue')) { Import-Module ([String]::Format('{0}\Documents\GitHub\Coding\powershell\_WindowsPowerShell\Modules\Get-UserSession\Get-UserSession.psm1', ((Get-Variable -Name 'HOME').Value))); }; [System.Net.ServicePointManager]::SecurityProtocol=$ProtoBak; Get-UserSession | Format-Table;


}
# ------------------------------------------------------------
function Get-UserSession {
<#
.SYNOPSIS
	Retrieves all user sessions from local or remote computers(s)

.DESCRIPTION
	Retrieves all user sessions from local or remote computer(s).

	Note:   Requires query.exe in order to run
	Note:   This works against Windows Vista and later systems provided the following registry value is in place
			HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\AllowRemoteRPC = 1
	Note:   If query.exe takes longer than 15 seconds to return, an error is thrown and the next computername is processed.  Suppress this with -erroraction silentlycontinue
	Note:   If $sessions is empty, we return a warning saying no users.  Suppress this with -warningaction silentlycontinue

.PARAMETER computername
	Name of computer(s) to run session query against

.parameter parseIdleTime
	Parse idle time into a timespan object

.parameter timeout
	Seconds to wait before ending query.exe process.  Helpful in situations where query.exe hangs due to the state of the remote system.

.FUNCTIONALITY
	Computers

.EXAMPLE
	Get-usersession -computername "server1"

	Query all current user sessions on 'server1'

.EXAMPLE
	Get-UserSession -computername $servers -parseIdleTime | ?{$_.idletime -gt [timespan]"1:00"} | ft -AutoSize

	Query all servers in the array $servers, parse idle time, check for idle time greater than 1 hour.

.NOTES
	Thanks to Boe Prox for the ideas - http://learn-powershell.net/2010/11/01/quick-hit-find-currently-logged-on-users/

.LINK
	http://gallery.technet.microsoft.com/Get-UserSessions-Parse-b4c97837

#>
	[cmdletbinding()]
	Param(
		[Parameter(
			Position = 0,
			ValueFromPipeline = $True)]
		[string[]]$ComputerName = "localhost",

		[switch]$ParseIdleTime,

		[validaterange(0,120)]
		[int]$Timeout = 15
	)

	Process {

		ForEach($computer in $ComputerName) {

			#start query.exe using .net and cmd /c.  We do this to avoid cases where query.exe hangs

				#build temp file to store results.  Loop until we see the file
					Try {
						$Started = Get-Date
						$tempFile = [System.IO.Path]::GetTempFileName()

						Do{
							start-sleep -Milliseconds 300

							if( ((Get-Date) - $Started).totalseconds -gt 10) {
								Throw "Timed out waiting for temp file '$TempFile'"
							}
						}
						Until(Test-Path -Path $tempfile)

					} Catch {
						Write-Error "Error for '$Computer': $_"
						Continue

					}

				#Record date.  Start process to run query in cmd.  I use starttime independently of process starttime due to a few issues we ran into
					$Started = Get-Date
					$p = Start-Process -FilePath C:\windows\system32\cmd.exe -ArgumentList "/c query user /server:$computer > $tempfile" -WindowStyle hidden -passthru

				#we can't read in info or else it will freeze.  We cant run waitforexit until we read the standard output, or we run into issues...
				#handle timeouts on our own by watching hasexited
					$stopprocessing = $false
					do {

						#check if process has exited
							$hasExited = $p.HasExited

						#check if there is still a record of the process
							Try {
								$proc = Get-Process -id $p.id -ErrorAction stop
							} Catch {
								$proc = $null
							}

						#sleep a bit
							start-sleep -seconds .5

						#If we timed out and the process has not exited, kill the process
							if( ( (Get-Date) - $Started ).totalseconds -gt $timeout -and -not $hasExited -and $proc) {
								$p.kill()
								$stopprocessing = $true
								Remove-Item $tempfile -force
								Write-Error "$computer`: Query.exe took longer than $timeout seconds to execute"
							}
					} until($hasexited -or $stopProcessing -or -not $proc)

					if($stopprocessing) {
						Continue
					}

					#if we are still processing, read the output!
						try {
							$sessions = Get-Content $tempfile -ErrorAction stop
							Remove-Item $tempfile -force
						} catch {
							Write-Error "Could not process results for '$computer' in '$tempfile': $_"
							continue
						}

			#handle no results
			if($sessions){

				1..($sessions.count - 1) | Foreach-Object {

					#Start to build the custom object
					$temp = "" | Select ComputerName, Username, SessionName, Id, State, IdleTime, LogonTime
					$temp.ComputerName = $computer

					#The output of query.exe is dynamic.
					#strings should be 82 chars by default, but could reach higher depending on idle time.
					#we use arrays to handle the latter.

					if($sessions[$_].length -gt 5){

						#if the length is normal, parse substrings
						if($sessions[$_].length -le 82){
							$temp.Username = $sessions[$_].Substring(1,22).trim()
							$temp.SessionName = $sessions[$_].Substring(23,19).trim()
							$temp.Id = $sessions[$_].Substring(42,4).trim()
							$temp.State = $sessions[$_].Substring(46,8).trim()
							$temp.IdleTime = $sessions[$_].Substring(54,11).trim()
							$logonTimeLength = $sessions[$_].length - 65
							try {
								$temp.LogonTime = Get-Date $sessions[$_].Substring(65,$logonTimeLength).trim() -ErrorAction stop
							} catch {
								#Cleaning up code, investigate reason behind this.  Long way of saying $null....
								$temp.LogonTime = $sessions[$_].Substring(65,$logonTimeLength).trim() | Out-Null
							}

						} else {
						#Otherwise, create array and parse
							$array = $sessions[$_] -replace "\s+", " " -split " "
							$temp.Username = $array[1]

							#in some cases the array will be missing the session name.  array indices change
							if($array.count -lt 9){
								$temp.SessionName = ""
								$temp.Id = $array[2]
								$temp.State = $array[3]
								$temp.IdleTime = $array[4]
								try {
									$temp.LogonTime = Get-Date $($array[5] + " " + $array[6] + " " + $array[7]) -ErrorAction stop
								} catch {
									$temp.LogonTime = ($array[5] + " " + $array[6] + " " + $array[7]).trim()
								}
							} else{
								$temp.SessionName = $array[2]
								$temp.Id = $array[3]
								$temp.State = $array[4]
								$temp.IdleTime = $array[5]
								try {
									$temp.LogonTime = Get-Date $($array[6] + " " + $array[7] + " " + $array[8]) -ErrorAction stop
								} catch {
									$temp.LogonTime = ($array[6] + " " + $array[7] + " " + $array[8]).trim()
								}
							}
						}

						#if specified, parse idle time to timespan
						if ($parseIdleTime){
							$string = $temp.idletime
							#quick function to handle minutes or hours:minutes
							function Convert-ShortIdle {
								param($string)
								if ($string -match "\:"){
									[timespan]$string
								} else {
									New-TimeSpan -Minutes $string
								}
							}

							if($string -match "\+"){
								#to the left of + is days
								$days = New-TimeSpan -days ($string -split "\+")[0]
								$hourMin = Convert-ShortIdle ($string -split "\+")[1]
								$temp.idletime = $days + $hourMin
							} elseif($string -like "." -or $string -like "none"){
								#. means less than a minute
								$temp.idletime = [timespan]"0:00"
							} else {
								#hours and minutes
								$temp.idletime = Convert-ShortIdle $string
							}
						}

						#Output the result
						$temp
					}
				}
			} Else {
				Write-Warning "'$computer': No sessions found"
			}
		}
	}
}


<# Only export the module if the caller is attempting to import it #>
If (($MyInvocation.GetType()) -Eq ("System.Management.Automation.InvocationInfo")) {
	Export-ModuleMember -Function "Get-UserSession";
}


# ------------------------------------------------------------
#
# Citation(s)
#
#   gallery.technet.microsoft.com  |  "Script Get-UserSession - Parse query user results"  |  https://gallery.technet.microsoft.com/scriptcenter/Get-UserSessions-Parse-b4c97837
#
# ------------------------------------------------------------