function Az_AppInsights_Backend {
  Param(

    [Parameter(Mandatory=$true)]
    [String]$SubscriptionID = "",
        
    [Parameter(Mandatory=$true)]
    [String]$ResourceGroup = "",

    [Parameter(Mandatory=$true)]
    [String]$AppServicePlanName = "",

    [String]$StartTimestamp = (Get-Date ((Get-Date).ToUniversalTime()) -UFormat "%Y%m%d-%H%M%S"),

		[String]$Epithet = (("bis-")+($StartTimestamp)),

    [String]$Location = "eastus",
          
    [Int]$ExitAfterSeconds = 600,

    [Switch]$RunLocalServer,
        
    [Switch]$Quiet

  )

  # Fail-out if any required modules are not found within the current scope
  $RequireModule = "BombOut"; 
  if (!(Get-Module ($RequireModule))) {
    # if (!(Get-Module -ListAvailable -Name ($RequireModule))) {
    Write-Host (("`n`nRequired Module not found: `"") + ($RequireModule) + ("`"`n`n"));
    Start-Sleep -Seconds 60;
    Exit 1;
  }
    
  $az = @{};

  $az.epithet = ($Epithet);

	$az.subscription = ($SubscriptionID);

  $az.resource_group = ($ResourceGroup);
  
  $az.webapp = @{};
  $az.webapp.name = (($az.epithet)+("-api"));
  $az.webapp.resourceType = "Microsoft.Insights/components";
  $az.webapp.plan = ($AppServicePlanName);
  $az.webapp.properties = ConvertTo-Json -InputObject ('{"serverFarmId": "/subscriptions/' + $az.subscription + '/resourceGroups/' + $az.resource_group + '/providers/Microsoft.Web/serverfarms/' + $az.webapp.plan + '"}') -Depth 100;
  $az.webapp.location = $Location;
  
  $CommandDescription = (("Creating Application Insights for  `"") + ($az.webapp.name) + ("`""));
  Write-Host (("`n ") + ($CommandDescription) + (".....`n"));

  # Create Application Insights for Backen App
  $az.webapp.appInsights = `
    az resource create `
    --name $az.webapp.name `
    --properties $az.webapp.properties `
    --resource-group $az.resource_group `
    --subscription $az.subscription `
    --resource-type $az.webapp.resourceType `
    | ConvertFrom-Json;
  $az.webapp.exit_code = If ($?) {0}Else {1};

  BombOut `
    -ExitCode ($az.webapp.exit_code) `
    -MessageOnError (('Error thrown while [') + ($CommandDescription) + (']')) `
    -MessageOnSuccessJSON ($az.webapp.appInsights); 

  # ------------------------------------------------------------- #
    
  $CommandDescription = (("Configuring [ Application Settings ] for Web-App `"")+($az.webapp.name)+("`""));
	Write-Host (("`nTask - ")+($CommandDescription)+("...`n"));

	$az.webapp.appSettings = @{};

	$az.webapp.appSettings["APPINSIGHTS_INSTRUMENTATIONKEY"] = ($az.webapp.appInsights.properties.InstrumentationKey);

  $az.webapp.appSettings["ApplicationInsightsAgent_EXTENSION_VERSION"] = "~2";

  $az.webapp.appSettings["ASPNETCORE_ENVIRONMENT"] = "Development";
	
  $az.webapp.appSettings["XDT_MicrosoftApplicationInsights_Mode"] = "default";
	

	$last_exit_code = 0;
	ForEach ($appSetting In (($az.webapp.appSettings).GetEnumerator())) {
		
		$az.webapp.appSettingsSet = `
		az webapp config appsettings set `
			--name ($az.webapp.name) `
			--resource-group ($az.resource_group) `
			--subscription ($az.subscription) `
			--settings (($appSetting.Name)+("=")+($appSetting.Value)) `
			| ConvertFrom-Json;
			
		$last_exit_code += If($?){0}Else{1};

	}

	# Bomb-out on errors
	BombOut -NoAzLogout `
		-ExitCode ($last_exit_code) `
		-MessageOnError (('Error thrown while [')+($CommandDescription)+(']')) `
		-MessageOnSuccessJSON ($az.webapp.appSettingsSet);

  # ------------------------------------------------------------- #

  
  $rt = @{};
  $rt.appInsightsCreate = $az.webapp.appInsights;
  $rt.appInsightsSet = $az.webapp.appSettings;

  Return $rt;

}

Export-ModuleMember -Function "Az_AppInsights_Backend";