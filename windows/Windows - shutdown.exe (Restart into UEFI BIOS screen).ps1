# ------------------------------------------------------------
#
# COMMAND TO REBOOT COMPUTER INTO BIOS (UEFI) SCREEN
#
#   shutdown.exe
#     /r         Full shutdown and restart the computer.
#     /t xxx     Set the time-out period before shutdown to xxx seconds.
#     /fw        Combine with a shutdown option to cause the next boot to go to the firmware user interface.
#


shutdown /r /fw /t 0


# ------------------------------------------------------------
#
# Citation(s)
#
#   www.reddit.com  |  "Is 'restart to bios from Windows' possible with a cmd or powershell command i can put in a shortcut? : r/windows"  |  https://www.reddit.com/r/windows/comments/hxqgua/comment/fz7p7p3
#
# ------------------------------------------------------------