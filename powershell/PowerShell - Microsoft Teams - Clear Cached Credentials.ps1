# 1.  Fully exit the Microsoft Teams desktop client. To do this, either right click Teams from the Icon Tray and select ‘Quit’, or run Task Manager and fully kill the process.

# 2.  Go to File Explorer, and type in ${Env:APPDATA}\Microsoft\teams

#  3.  Once in the directory, you’ll see a few of the following folders

#  a.  From within ‘Application Cache’, go to Cache and delete any of the files in the Cache location

Get-ChildItem -Path ("${Env:APPDATA}\Microsoft\teams\application cache\cache\") -Recurse -Force -ErrorAction "SilentlyContinue" | ForEach-Object { Write-Host "Deleting $($_.FullName)"; Remove-Item -Path ($_.FullName) -Force; }

#  b.  From within ‘Blob_storage’, delete any files that are located in here if any

Get-ChildItem -Path ("${Env:APPDATA}\Microsoft\teams\blob_storage\") -Recurse -Force -ErrorAction "SilentlyContinue" | ForEach-Object { Write-Host "Deleting $($_.FullName)"; Remove-Item -Path ($_.FullName) -Force; }

#  c.  From within ‘Cache’, delete all files

Get-ChildItem -Path ("${Env:APPDATA}\Microsoft\teams\Cache\") -Recurse -Force -ErrorAction "SilentlyContinue" | ForEach-Object { Write-Host "Deleting $($_.FullName)"; Remove-Item -Path ($_.FullName) -Force; }

#  d.  From within ‘databases’, delete all files

Get-ChildItem -Path ("${Env:APPDATA}\Microsoft\teams\databases\") -Recurse -Force -ErrorAction "SilentlyContinue" | ForEach-Object { Write-Host "Deleting $($_.FullName)"; Remove-Item -Path ($_.FullName) -Force; }

#  e.  From within ‘GPUCache’, delete all files

Get-ChildItem -Path ("${Env:APPDATA}\Microsoft\teams\GPUcache\") -Recurse -Force -ErrorAction "SilentlyContinue" | ForEach-Object { Write-Host "Deleting $($_.FullName)"; Remove-Item -Path ($_.FullName) -Force; }

#  f.  From within ‘IndexedDB’, delete the .db file

Get-ChildItem -Path ("${Env:APPDATA}\Microsoft\teams\IndexedDB\") -Recurse -Force -ErrorAction "SilentlyContinue" | ForEach-Object { Write-Host "Deleting $($_.FullName)"; Remove-Item -Path ($_.FullName) -Force; }

#  g.  From within ‘Local Storage’, delete all files

Get-ChildItem -Path ("${Env:APPDATA}\Microsoft\teams\Local Storage\") -Recurse -Force -ErrorAction "SilentlyContinue" | ForEach-Object { Write-Host "Deleting $($_.FullName)"; Remove-Item -Path ($_.FullName) -Force; }

#  h.  Lastly, from within ‘tmp’, delete any file

Get-ChildItem -Path ("${Env:APPDATA}\Microsoft\teams\tmp\") -Recurse -Force -ErrorAction "SilentlyContinue" | ForEach-Object { Write-Host "Deleting $($_.FullName)"; Remove-Item -Path ($_.FullName) -Force; }


# ------------------------------------------------------------
#
# Citation(s)
#
#   social.technet.microsoft.com  |  "What folders are used by Teams for caching"  |  https://social.technet.microsoft.com/Forums/en-US/f9e1c12b-47a6-4b12-8d5c-a57fda4d9042/what-folders-are-used-by-teams-for-caching?forum=msteams
#
# ------------------------------------------------------------