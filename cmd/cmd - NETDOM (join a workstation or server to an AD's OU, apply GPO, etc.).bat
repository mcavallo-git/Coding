REM cmd - NETDOM (join a workstation or server to an AD's OU, apply GPO, etc.)

NETDOM join %computername% /domain:%USERDNSDOMAIN% /reboot

REM ------------------------------------------------------------
REM
REM Citation(s)
REM
REM   www.dell.com  |  "Joining and removing a server from an Active Directory domain using Netdom.exe | Dell US"  |  https://www.dell.com/support/article/us/en/04/how10118/joining-and-removing-a-server-from-an-active-directory-domain-using-netdom-exe?lang=en
REM
REM ------------------------------------------------------------