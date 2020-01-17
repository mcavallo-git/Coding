@ECHO OFF

EXIT

REM ------------------------------------------------------------

REM Check via cmd - shows users who you can reach & change passwords-of
net user


REM Reset a user's password
net user [TargetUsername] [NewPassword]


REM EXAMPLE: Reset user w/ name "ExampleUsername" to have password "ExampleNewPassword1!"
net user "ExampleUsername" ExampleNewPassword1!

REM ------------------------------------------------------------

REM List local user(s)
net user
REM List AD (domain) user(s)
net user /domain

REM Show verbose information regarding one, specific user
net user %USERNAME%
net user %USERNAME% /domain

REM Show members of a given AD (domain) group
net group /domain
net group /domain "Domain Admins"

EXIT

REM ------------------------------------------------------------
REM
REM	Citation(s)
REM
REM   docs.microsoft.com  |  "Net group | Microsoft Docs"  |  https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/cc754051(v%3Dws.11)
REM
REM   docs.microsoft.com  |  "Net user | Microsoft Docs"  |  https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/cc771865(v%3Dws.11)
REM
REM   www.makeuseof.com  |  "How to Change the Windows User Password via Command Line"  |  https://www.makeuseof.com/tag/quick-tip-change-the-windows-user-password-via-command-line/
REM
REM ------------------------------------------------------------