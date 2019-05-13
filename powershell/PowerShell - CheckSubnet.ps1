function CheckSubnet ([string]$addr1, [string]$addr2)
{
	# Separate the network address and lenght
	$network1, [int]$subnetlen1 = $addr1.Split('/');
	$network2, [int]$subnetlen2 = $addr2.Split('/');
	# Convert network address to binary
	[uint32] $unetwork1 = NetworkToBinary $network1;
	[uint32] $unetwork2 = NetworkToBinary $network2;
	# Check If subnet length exists and is less then 32(/32 is host, single ip so no calculation needed) If so convert to binary
	If($subnetlen1 -lt 32){
		[uint32] $mask1 = SubToBinary $subnetlen1;
	}
	If($subnetlen2 -lt 32){
		[uint32] $mask2 = SubToBinary $subnetlen2;
	}
	# Compare the results
	If ($mask1 -and $mask2) {
		# If both inputs are subnets check which is smaller and check If it belongs in the larger one
		If ($mask1 -lt $mask2) {
			return CheckSubnetToNetwork $unetwork1 $mask1 $unetwork2;
		} Else {
			return CheckNetworkToSubnet $unetwork2 $mask2 $unetwork1;
		}
	} ElseIf ($mask1) { # If second input is address and first input is subnet check If it belongs
		return CheckSubnetToNetwork $unetwork1 $mask1 $unetwork2;
	} ElseIf ($mask2) {
		# If first input is address and second input is subnet check If it belongs
		return CheckNetworkToSubnet $unetwork2 $mask2 $unetwork1;
	} Else {
		# If both inputs are ip check If they match
		CheckNetworkToNetwork $unetwork1 $unetwork2;
	}
}

function CheckNetworkToSubnet ([uint32]$un2, [uint32]$ma2, [uint32]$un1)
{
	$ReturnArray = "" | Select-Object -Property Condition,Direction
	If ($un2 -eq ($ma2 -band $un1)) {
		$ReturnArray.Condition = $True;
		$ReturnArray.Direction = "Addr1ToAddr2";
		return $ReturnArray;
	} Else {
		$ReturnArray.Condition = $False;
		$ReturnArray.Direction = "Addr1ToAddr2";
		return $ReturnArray;
	}
}

function CheckSubnetToNetwork ([uint32]$un1, [uint32]$ma1, [uint32]$un2)
{
	$ReturnArray = "" | Select-Object -Property Condition,Direction
	If ($un1 -eq ($ma1 -band $un2)) {
		$ReturnArray.Condition = $True;
		$ReturnArray.Direction = "Addr2ToAddr1";
		return $ReturnArray;
	} Else {
		$ReturnArray.Condition = $False;
		$ReturnArray.Direction = "Addr2ToAddr1";
		return $ReturnArray;
	}
}

function CheckNetworkToNetwork ([uint32]$un1, [uint32]$un2)
{
	$ReturnArray = "" | Select-Object -Property Condition,Direction;
	If ($un1 -eq $un2) {
		$ReturnArray.Condition = $True;
		$ReturnArray.Direction = "Addr1ToAddr2";
		return $ReturnArray
	} Else {
		$ReturnArray.Condition = $False;
		$ReturnArray.Direction = "Addr1ToAddr2";
		return $ReturnArray;
	}
}

function SubToBinary ([int]$sub)
{
	return ((-bnot [uint32]0) -shl (32 - $sub));
}

function NetworkToBinary ($network)
{
	$a = [uint32[]]$network.split('.');
	return (($a[0] -shl 24) + ($a[1] -shl 16) + ($a[2] -shl 8) + $a[3]);
}

function IpInSubnet ([string]$addr1, [string]$addr2)
{
	return (CheckSubnet ($addr1) ($addr2)).Condition;
}

# Test-Case:  Is   [ 10.165.255.166 ]   in   [ 10.165.255.0/24 ]   ?
# Expecting:  $True
IpInSubnet "10.165.255.166" "10.165.255.0/24";

# Test-Case:  Is   [ 172.168.0.45 ]   in   [ 172.168.0.0/16 ]   ?
# Expecting:  $True
IpInSubnet "172.168.0.45/32" "172.168.0.0/16";

# Test-Case:  Is   [ 10.0.0.65 ]   in   [ 10.0.0.32/27 ]   ?
# Expecting:  $False
IpInSubnet "192.168.0.65/32" "192.168.0.32/27";

#
#	Citation(s)
#
# Thanks to [ http://www.gi-architects.co.uk/2016/02/powershell-check-If-ip-or-subnet-matchesfits ]
#
