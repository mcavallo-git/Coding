# ------------------------------------------------------------
# PowerShell - Add-VpnConnection
# ------------------------------------------------------------


$NewVpnConnection=( `
	Add-VpnConnection `
		-Name "VPN Connection Nickname" `
		-ServerAddress "127.0.0.1" `
		-TunnelType "PPTP" `
		-EncryptionLevel "Required" `
		-AuthenticationMethod MSChapv2 `
		-UseWinlogonCredential `
		-SplitTunneling `
		-AllUserConnection `
		-RememberCredential `
		-PassThru `
);
$NewVpnConnection



# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Add-VpnConnection (VpnClient) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/vpnclient/add-vpnconnection
#
# ------------------------------------------------------------