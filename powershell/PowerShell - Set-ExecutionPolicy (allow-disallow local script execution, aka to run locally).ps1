Exit



### Allow Powershell (.ps1) Scripts to run locally

Set-ExecutionPolicy RemoteSigned -Force



### Disallow Powershell (.ps1) Scripts from running locally

Set-ExecutionPolicy Restricted -Force



### Check the status of whether-or-not PowerShell scripts can run locally (or not)

Get-ExecutionPolicy
