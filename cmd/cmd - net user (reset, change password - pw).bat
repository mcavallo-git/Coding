@ECHO OFF

EXIT

REM Check via cmd - shows users who you can reach & change passwords-of
net user

REM Syntax for resetting a user's password
net user [TargetUsername] [NewPassword]

REM EXAMPLE: Reset user w/ name "Example Username" to password "ExampleNewPassword1!"
net user "Example Username" ExampleNewPassword1!

EXIT

REM	Citation(s)
REM
REM		www.makeuseof.com, "How to Change the Windows User Password via Command Line"
REM		https://www.makeuseof.com/tag/quick-tip-change-the-windows-user-password-via-command-line/
REM