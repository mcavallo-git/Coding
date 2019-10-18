
# If the WSL Feature is currently set to Disabled, Enable it
If ( ((Get-WindowsOptionalFeature -Online -FeatureName "Microsoft-Windows-Subsystem-Linux").State) -Eq "Disabled" ) { 
	Enable-WindowsOptionalFeature -Online -FeatureName "Microsoft-Windows-Subsystem-Linux";
}
