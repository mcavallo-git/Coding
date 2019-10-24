#
#	EnsureFeatureIsEnabled
#		|--> Checks the status of a given windows feature, then makes sure it is enabled (if disabled)
#
function EnsureFeatureIsEnabled {
	#
	# Module to Fetch & Pull all Repositories in a given directory [ %USERPROFILE%\Documents\GitHub ] Directory 
	#
	Param(

		[String]$FeatureID = "",

		[String]$FeatureName = ""

	)

	$AllFeatures = (Get-WindowsOptionalFeature -Online);

	If ( $False ) {

Get-WindowsOptionalFeature -Online
(Get-WindowsOptionalFeature -Online -FeatureName "NetFx3").RestartRequired
# Possible

	}
	#
	# ------------------------------------------------------------
	#
	Return;
}
Export-ModuleMember -Function "GitSyncAll";

#
#	Citation(s)
#		
#		Icon file "GitSyncAll.ico" thanks-to:  https://www.iconarchive.com/download/i103479/paomedia/small-n-flat/sign-sync.ico
#
