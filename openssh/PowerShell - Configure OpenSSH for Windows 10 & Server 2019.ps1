# ------------------------------------------------------------
#
# OpenSSH - Configuring the default shell for OpenSSH in Windows
#
New-ItemProperty -Path "HKLM:\SOFTWARE\OpenSSH" -Name DefaultShell -Value "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -PropertyType String -Force;

#
#
# OpenSSH - Windows Configurations in sshd_config
#
Write-Output "Microsoft states: `"In Windows, sshd reads configuration data from %programdata%\ssh\sshd_config by default, or a different configuration file may be specified by launching sshd.exe with the -f parameter. If the file is absent, sshd generates one with the default configuration when the service is started.`"";



# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "OpenSSH Server Configuration for Windows | Microsoft Docs"  |  https://docs.microsoft.com/en-us/windows-server/administration/openssh/openssh_server_configuration#:~:text=In%20Windows%2C%20sshd%20reads%20configuration,exe%20with%20the%20%2Df%20parameter.
#
# ------------------------------------------------------------