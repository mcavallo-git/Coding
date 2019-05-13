#
#	Example Call:
#
# 	Az_CreateAppServicePlan `
# 		-SubscriptionID ("xyz") `
# 		-ResourceGroup ("xyz") `
# 		-Location ("xyz") `
# 		-Epithet ("xyz");
#
function Az_CreateAppServicePlan {
	Param(

		[Parameter(Mandatory=$true)]
		[String]$SubscriptionID,

		[Parameter(Mandatory=$true)]
		[String]$ResourceGroup,

		[Parameter(Mandatory=$true)]
		[String]$Epithet,

		[String]$Location = "eastus",

		[String]$Sku = "S1",

		[Switch]$Quiet

	)

	# Fail-out if any required modules are not found within the current scope
	$RequireModule="BombOut"; 
	if (!(Get-Module ($RequireModule))) {
		Write-Host (("`n`nRequired Module not found: `"")+($RequireModule)+("`"`n`n"));
		Start-Sleep -Seconds 60;
		Exit 1;
	}
		

	$az = @{};
	$az.epithet = $Epithet;

	# ------------------------------------------------------------- #
	#### APP SERVICE PLAN    
	$az.appServicePlan = @{};
	$az.appServicePlan.name = (($az.epithet) + ("-appserviceplan"));
	$az.appServicePlan.location = $Location;
	$az.appServicePlan.sku = $Sku;
	$CommandDescription = "Creating App Service Plan";

	## Create an App Service Plan
	## Do not use [az appservice plan create --is-linux] because this will bubble up to the resource group
	##   and block the use of any Non-Linux applications
	$az.appServicePlan.create = `
	az appservice plan create `
		--name $az.appServicePlan.name `
		--subscription $SubscriptionID `
		--resource-group $ResourceGroup `
		--location $az.appServicePlan.location `
		--sku $az.appServicePlan.sku `
		| ConvertFrom-Json;
	$az.appServicePlan.exit_code = If($?){0}Else{1};

	BombOut `
		-ExitCode ($az.appServicePlan.exit_code) `
		-MessageOnError (('Error thrown while [')+($CommandDescription)+(']')) `
		-MessageOnSuccessJSON ($az.appServicePlan.create);

	# ------------------------------------------------------------- #

	Return $az.appServicePlan.create;

	# ------------------------------------------------------------- #
}

Export-ModuleMember -Function "Az_CreateAppServicePlan";
