<!--
------------------------------------------------------------

Microsoft Outlook - Set the limit for (or hide, disable) the 'Recent Items' when adding an attachment

------------------------------------------------------------
-->

1. Open regedit.exe (Registry Editor)

2. Set the current value:

```
  Key:  HKEY_CURRENT_USER\SOFTWARE\Microsoft\Office\16.0\Outlook\Options\Mail
  Property: MaxAttachmentMenuItems
  Type: DWORD
  Value: 00000000
```

### Note:
- If you have to run regedit.exe as an admin user WHICH IS A DIFFERENT USER than the user you want to apply the change to, open [ HKEY_USERS\USER_SID\SOFTWARE\Microsoft\Office\16.0\Outlook\Options\Mail ], where [ USER_SID ] is the SID for the user you want to apply the change to - Acquire user SID by running the following command in a powershell AS THE USER YOU WANT TO APPLY THE CHANGE TO:   (whoami /user /fo table /nh).Split(" ")[1]


<!--
------------------------------------------------------------

 Citation(s)

   social.technet.microsoft.com  |  "Outlook 2016 Unable to turn off recent items"  |  https://social.technet.microsoft.com/Forums/ie/en-US/f9759ed9-3e9b-4161-86e4-47bde3501573/outlook-2016-unable-to-turn-off-recent-items?forum=outlook

------------------------------------------------------------
-->