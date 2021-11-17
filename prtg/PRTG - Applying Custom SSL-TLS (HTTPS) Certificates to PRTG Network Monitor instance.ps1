# ------------------------------------------------------------
#
# PRTG SSL/TLS certificates must be in PEM (Privacy-Enhanced Mail) certificate format
#

If ($True) {

	$PRTG_PROGRAM_DIR_32BIT="${env:ProgramFiles}\PRTG Network Monitor";
	$PRTG_PROGRAM_DIR_64BIT="${env:ProgramFiles(x86)}\PRTG Network Monitor";
	If (Test-Path -PathType "Container" -Path ("${PRTG_PROGRAM_DIR_32BIT}")) {
		$PRTG_CERTS_DIR="${PRTG_PROGRAM_DIR_32BIT}\cert";
	} ElseIf (Test-Path -PathType "Container" -Path ("${PRTG_PROGRAM_DIR_64BIT}")) {
		$PRTG_CERTS_DIR="${PRTG_PROGRAM_DIR_64BIT}\cert";
	}

	If (("${PRTG_CERTS_DIR}" -Eq "") -Or ((Test-Path -PathType "Container" -Path ("${PRTG_CERTS_DIR}")) -Eq $False)) {
		Write-Host "";
		Write-Host "ERROR  -  PRTG's certificates directory not found to exist at either the following standard locations:";
		Write-Host "   `"${PRTG_PROGRAM_DIR_32BIT}\cert`"";
		Write-Host "      or";
		Write-Host "   `"${PRTG_PROGRAM_DIR_64BIT}\cert`"";
		Write-Host "";
		Write-Host "Exiting...";

	} Else {

		# Import Module 'RunningAsAdministrator'
		If (-Not (Get-Command -Name 'RunningAsAdministrator' -ErrorAction 'SilentlyContinue')) {
			[System.Net.ServicePointManager]::SecurityProtocol=([System.Net.ServicePointManager]::SecurityProtocol -bor [System.Net.SecurityProtocolType]::Tls12); $ProgressPreference='SilentlyContinue'; Clear-DnsClientCache; Set-ExecutionPolicy 'RemoteSigned' -Scope 'CurrentUser' -Force; Try { Invoke-Expression ((Invoke-WebRequest -UseBasicParsing -TimeoutSec (7.5) -Uri ('https://raw.githubusercontent.com/mcavallo-git/Coding/master/powershell/_WindowsPowerShell/Modules/RunningAsAdministrator/RunningAsAdministrator.psm1') ).Content) } Catch {};
		}

		# Require Escalated Privileges
		If ((RunningAsAdministrator) -NE ($True)) {

			Write-Host "";
			Write-Host "ERROR  -  Requires elevated permissions - Please re-run as Administrator";

		} Else {

			$TIMESTAMP=(Get-Date -Format 'yyyyMMddTHHmmss');
			$STEP_NUM=0;

			# ------------------------------
			# Backup existing PRTG certificates directory
			Write-Host "";
			Write-Host "Backing up existing PRTG certificates directory to `"${PRTG_CERTS_DIR}.bak.${TIMESTAMP}`"..." -NoNewLine;
			Copy-Item -Path ("${PRTG_CERTS_DIR}") -Destination ("${PRTG_CERTS_DIR}.bak.${TIMESTAMP}") -Force -Recurse;

			# ------------------------------
			# Certificate (1 of 3 SSL/TLS files)
			$TYPE_OF_CERT="Certificate";
			$PRTG_CERT="prtg.crt";
			$LETS_ENCRYPT_CERT="cert.pem";
			# Direct user for where to place their cert file(s)
			Write-Host "";
			Write-Host "Step $(${STEP_NUM}++;${STEP_NUM};):  Copy your PEM-formatted SSL/TLS " -NoNewLine;
			Write-Host "${TYPE_OF_CERT}" -NoNewLine -ForegroundColor "Yellow";
			Write-Host " file (`"" -NoNewLine;
			Write-Host "${LETS_ENCRYPT_CERT}" -NoNewLine -ForegroundColor "Yellow";
			Write-Host "`" for Let's Encrypt certs) to filepath `"" -NoNewLine;
			Write-Host "${PRTG_CERTS_DIR}\${PRTG_CERT}" -NoNewLine -ForegroundColor "Yellow";
			Write-Host "`" ";

			# ------------------------------
			# Private Key (1 of 3 SSL/TLS files)
			$TYPE_OF_CERT="Private Key";
			$PRTG_CERT="prtg.key";
			$LETS_ENCRYPT_CERT="privkey.pem";
			# Direct user for where to place their cert file(s)
			Write-Host "";
			Write-Host "Step $(${STEP_NUM}++;${STEP_NUM};):  Copy your PEM-formatted SSL/TLS " -NoNewLine;
			Write-Host "${TYPE_OF_CERT}" -NoNewLine -ForegroundColor "Yellow";
			Write-Host " file (`"" -NoNewLine;
			Write-Host "${LETS_ENCRYPT_CERT}" -NoNewLine -ForegroundColor "Yellow";
			Write-Host "`" for Let's Encrypt certs) to filepath `"" -NoNewLine;
			Write-Host "${PRTG_CERTS_DIR}\${PRTG_CERT}" -NoNewLine -ForegroundColor "Yellow";
			Write-Host "`" ";

			# ------------------------------
			# Public Root Certificate(s) for Certificate Issuer (1 of 3 SSL/TLS files)
			$TYPE_OF_CERT="CABundle";
			$PRTG_CERT="root.pem";
			$LETS_ENCRYPT_CERT="chain.pem";
			# Direct user for where to place their cert file(s)
			Write-Host "";
			Write-Host "Step $(${STEP_NUM}++;${STEP_NUM};):  Copy your PEM-formatted SSL/TLS " -NoNewLine;
			Write-Host "${TYPE_OF_CERT}" -NoNewLine -ForegroundColor "Yellow";
			Write-Host " file (`"" -NoNewLine;
			Write-Host "${LETS_ENCRYPT_CERT}" -NoNewLine -ForegroundColor "Yellow";
			Write-Host "`" for Let's Encrypt certs) to filepath `"" -NoNewLine;
			Write-Host "${PRTG_CERTS_DIR}\${PRTG_CERT}" -NoNewLine -ForegroundColor "Yellow";
			Write-Host "`" ";

			# ------------------------------
			# Open the PRTG certificates directory to assist user in placing their SSL/TLS files
			explorer.exe "${PRTG_CERTS_DIR}";

			# ------------------------------

		}

	}

	Write-Host "";

}


# ------------------------------------------------------------
#
# Citation(s)
#
#   www.paessler.com  |  "Data Storage | PRTG Manual"  |  https://www.paessler.com/manuals/prtg/data_storage#program
#
#   www.paessler.com  |  "Using Your Own SSL Certificate with the PRTG Web Server | PRTG Manual"  |  https://www.paessler.com/manuals/prtg/using_your_own_ssl_certificate
#
# ------------------------------------------------------------