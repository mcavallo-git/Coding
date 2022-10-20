function Az_ApiManagementService {
  Param(

    #[Parameter(Mandatory=$true)]
    [String]$SubscriptionID = "sandbox",
        
    #[Parameter(Mandatory=$true)]
    [String]$ResourceGroup = "sandbox-rg-redux",

    #[Parameter(Mandatory=$true)]
    [String]$AppServicePlan = "sandbox-appserviceplan",

    #[Parameter(Mandatory=$true)]
    [String]$Epithet = (("webapp-") + (Get-Date ((Get-Date).ToUniversalTime()) -UFormat "%Y%m%d%H%M%S")),

    [String]$Sku = "Developer",

    [String]$Location = "eastus",

    #[Parameter(Mandatory=$true)]
    [String]$WebAppName = "webapp-name",

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
  $az.epithet = $Epithet;
  $az.webapp = @{};
  $az.webapp.name = $WebAppName;
  $az.webapp.fqdn = (($WebAppName) + (".azurewebsites.net"));
  $az.webapp.resourceType = "Microsoft.Insights/components";

 
  $az.webapp.skuproperties = ConvertTo-Json -InputObject ( `
    ('{"sku": {"name": "Developer"},') + `
    ('"properties": {"publisherEmail": "firstname_lastname@example.com","publisherName": "abc","gatewayUrl": "https://webapp-name.azurewebsites.net","managementApiUrl": "https://webapp-name.azurewebsites.net"},') + `
    ('"location": "East US","hostnameConfigurations": ') + `
    ('[{"type": "Microsoft.Web/certificates","hostNames": "https://localhost:44383/"}]}')) -Depth 100;
  $az.webapp.location = $Location;

  # ------------------------------------------------------------- #
  $CommandDescription = (("Creating an API Management Service for  `"") + ($az.webapp.name) + ("`""));
  Write-Host (("`n ") + ($CommandDescription) + (".....`n"));
  # Create API Management service
  $az.webapp.apiManagementService = `
    az resource create `
    --name $az.webapp.name `
    --is-full-object `
    --properties $az.webapp.skuproperties `
    --resource-group $ResourceGroup `
    --subscription $SubscriptionID `
    --resource-type 'Microsoft.ApiManagement/service' `
    | ConvertFrom-Json;
  $az.webapp.exit_code = If ($?) {0}Else {1};
    
  BombOut `
    -ExitCode ($az.webapp.exit_code) `
    -MessageOnError (('Error thrown while [') + ($CommandDescription) + (']')) `
    -MessageOnSuccessJSON ($az.webapp.apiManagementService); 
  # ------------------------------------------------------------- #
           
  Return $az.webapp.create;

}

<# Only export the module if the caller is attempting to import it #>
If (($MyInvocation.GetType()) -Eq ("System.Management.Automation.InvocationInfo")) {
	Export-ModuleMember -Function "Az_ApiManagementService";
}

