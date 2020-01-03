# ------------------------------------------------------------
#
#		W32TM  :::  Windows Time Service
#		|
#		|--> Set a workstation to sync to one or more NTP 'peers' (syntactically-correct name for an NTP server relative to W32TM)
#


$OnComplete_AwaitKeypress = $false;


$BeforeUpdate_CheckTimeDelta = $true;


$AfterUpdate_CheckTimeDelta = $true;


$NtpPeers = @();
$NtpPeers += "time.nist.gov";
$NtpPeers += "time.google.com";
$NtpPeers += "north-america.pool.ntp.org";
$NtpPeers += "time.windows.com";


# ------------------------------------------------------------


$Ntp_SetSyncInterval_3600s=",0x9";


$ManualPeerList=[String]::Join(" ",($NtpPeers | ForEach-Object {"$_$Ntp_SetSyncInterval_3600s"}));
$ManualPeerList="time.nist.gov,0x9 time.google.com,0x9 north-america.pool.ntp.org,0x9 time.windows.com,0x9";


If ($BeforeUpdate_CheckTimeDelta -eq $true) {
	Write-Host "`n`n  Before Update to NTP-Config...`n   |";
	ForEach ($EachPeer In $NtpPeers) {
		$DeltaTimeToPeer = (W32TM /stripchart /computer:$EachPeer /dataonly /samples:1)[3].Split(' ')[1];
		Write-Host (("   |-->   Delta to `"$EachPeer`" = ")+($DeltaTimeToPeer));
	}
	Write-Host "`n`n";
}


# ------------------------------------------------------------



NET STOP W32TIME;
#  |
#  |-->  Stop the Windows Time Service



W32TM /config /manualpeerlist:"$ManualPeerList" /syncfromflags:manual;
W32TM /config /manualpeerlist:"time.nist.gov,0x9 time.google.com,0x9 north-america.pool.ntp.org,0x9 time.windows.com,0x9" /syncfromflags:manual;
#  |
#  |-->  /syncfromflags   -->  "Sets what sources the NTP client should synchronize from"
#  |-->  /manualpeerlist  -->  "Set the manual peer list to peers, which is a space-delimited list of Domain Name System (DNS) and/or IP addresses"


NET START W32TIME;
#  |
#  |-->  Start the Windows Time Service



W32TM /config /update;
#  |
#  |-->  /update  -->  "Notify the time service that the configuration has changed, causing the changes to take effect"



W32TM /resync /rediscover;
#  |
#  |-->  /resync  -->  "Tell a computer that it should resynchronize its clock as soon as possible, discarding all accumulated error stats"
#  |-->  /rediscover  -->  "Redetect the network configuration and rediscover network sources; Then, resynchronize"

# ------------------------------------------------------------
If ($False) { # Some workstations may be unable to resolve the "FQDN,0x9" syntax - if-so, then use this, instead:


NET STOP W32TIME;
W32TM /config /manualpeerlist:"time.nist.gov time.google.com north-america.pool.ntp.org time.windows.com" /syncfromflags:manual;
NET START W32TIME;
W32TM /config /update;
W32TM /resync /rediscover;


}
# ------------------------------------------------------------
#
#		Or if an all-in-one command is desired:
#
#

# In an Admin PowerShell prompt, enter:

NET STOP W32TIME; W32TM /config /manualpeerlist:"time.nist.gov,0x9 time.google.com,0x9 north-america.pool.ntp.org,0x9 time.windows.com,0x9" /syncfromflags:manual; NET START W32TIME; W32TM /config /update; W32TM /resync /rediscover;

#
#
# ------------------------------------------------------------

If ($AfterUpdate_CheckTimeDelta -eq $true) {
	Write-Host "`n`n  After Update to NTP-Config...`n   |";
	ForEach ($EachPeer In $NtpPeers) {
		$DeltaTimeToPeer = (W32TM /stripchart /computer:$EachPeer /dataonly /samples:1)[3].Split(' ')[1];
		Write-Host (("   |-->   Delta to `"$EachPeer`" = ")+($DeltaTimeToPeer));
	}
	Write-Host "`n`n";
}


If ($WaitForKeypress -eq $true) {
	Write-Host -NoNewLine "`n`n-->  Press any key to exit... ";
	$AwaitKeypress = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
}


Exit;

# ------------------------------------------------------------
#
#	Citation(s)
#
#		Google Public NTP (developers.google.com) | 
#			"Configuring Clients" | https://developers.google.com/time/guides
#
# ------------------------------------------------------------