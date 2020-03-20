
# ------------------------------------------------------------
#
# CCleaner has 2 command-line parameters:
#   /AUTO - Runs the cleaner upon loading and then closes the application.
#   /DEBUG - Runs the program in debug mode, only recommended for advanced users.


# 32-bit version
Start-Process -Filepath ("C:\Program Files\CCleaner\CCleaner.exe") -ArgumentList (@("/AUTO")) -Wait -PassThru -Verb ("RunAs") -ErrorAction ("SilentlyContinue");


# 64-bit version
Start-Process -Filepath ("C:\Program Files\CCleaner\CCleaner64.exe") -ArgumentList (@("/AUTO")) -Wait -PassThru -Verb ("RunAs") -ErrorAction ("SilentlyContinue");


# ------------------------------------------------------------
#
# Citation(s)
#
#   community.ccleaner.com  |  "How to start + run CCleaner from command line ? - CCleaner - CCleaner Community Forums"  |  https://community.ccleaner.com/topic/6234-how-to-start-run-ccleaner-from-command-line/
#
# ------------------------------------------------------------