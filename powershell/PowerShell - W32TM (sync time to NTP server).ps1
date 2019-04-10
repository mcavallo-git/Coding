#		--------------------------------------------------------------------------------------------------------------------------------
#
#		W32TM  :::  Windows Time Service
#		|
#		|--> Set a workstation to sync to one or more NTP 'peers' (syntactically-correct name for an NTP server relative to W32TM)
#


$OnComplete_AwaitKeypress = $false;


$BeforeUpdate_CheckTimeDelta = $true;


$AfterUpdate_CheckTimeDelta = $true;


$NtpPeers = @();
$NtpPeers += "time.google.com";
$NtpPeers += "pool.ntp.org";
$NtpPeers += "time.windows.com";


#		--------------------------------------------------------------------------------------------------------------------------------


$Ntp_SetSyncInterval_3600s=",0x9";


$ManualPeerList=[String]::Join(" ",($NtpPeers | ForEach-Object {"$_$Ntp_SetSyncInterval_3600s"}));


If ($BeforeUpdate_CheckTimeDelta -eq $true) {
	ForEach ($EachPeer In $NtpPeers) {
		$DeltaTimeToPeer = (W32TM /stripchart /computer:$EachPeer /dataonly /samples:1)[3].Split(' ')[1];
		Write-Host (("[Before Update to NTP-Config]  Delta to `"$EachPeer`" = ")+($DeltaTimeToPeer));
	}
}


#		--------------------------------------------------------------------------------------------------------------------------------


NET STOP W32TIME;
#  |
#  |-->  Stop the Windows Time Service


W32TM /config /syncfromflags:manual /manualpeerlist:"$ManualPeerList";
#  |
#  |-->  /syncfromflags  ->  "Sets what sources the NTP client should synchronize from"
#  |-->  /manualpeerlist  ->  "Set the manual peer list to peers, which is a space-delimited list of Domain Name System (DNS) and/or IP addresses"


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


#		--------------------------------------------------------------------------------------------------------------------------------

If ($AfterUpdate_CheckTimeDelta -eq $true) {
	ForEach ($EachPeer In $NtpPeers) {
		$DeltaTimeToPeer = (W32TM /stripchart /computer:$EachPeer /dataonly /samples:1)[3].Split(' ')[1];
		Write-Host (("[After Update to NTP-Config]  Delta to `"$EachPeer`" = ")+($DeltaTimeToPeer));
	}
}


If ($WaitForKeypress -eq $true) {
	Write-Host -NoNewLine "`n`n-->  Press any key to exit... ";
	$AwaitKeypress = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
}


Exit;
