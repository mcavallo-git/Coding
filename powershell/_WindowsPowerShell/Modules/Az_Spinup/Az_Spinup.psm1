#
#	Example Call:
#		Az_Spinup -SubscriptionID "example_subscription_id" -CompanyName "example_company_name"
#
function Az_Spinup {
	Param(

		[Parameter(Mandatory=$true)]
		[String]$SubscriptionID,

		[Parameter(Mandatory=$true)]
		[ValidateLength(2,24)]
		[String]$CompanyName,

		[String]$AzureLocation="eastus",

		[Switch]$CompanyNameAddTimestamp,

		[Switch]$AllowUppercaseResourceNames,

		[Switch]$Quiet,

		[Int]$ExitAfterSeconds = 600
 
	)

	# ---------------------------------------------------------------------------------------------------------- #
	#
	##
	##  Microsoft Documentation, "Tutorial: Host a RESTful API with CORS in Azure App Service"
	##    - Reference: https://docs.microsoft.com/en-us/azure/app-service/app-service-web-tutorial-rest-api
	##
	##  Note that you may perform these actions in Azure's "Cloud Shell" by:
	##    - Logging into [ https://portal.azure.com ]
	##    - Selecting the " >_ " icon (~top middle of screen)
	##    - If presented with [ Choose terminal: "Bash" or "PowerShell" ] (etc.), select "PowerShell"
	##
	#
	# ---------------------------------------------------------------------------------------------------------- #

	# Required PowerShell Command(s)/Install(s)

	$RequiredCommands = @();

	$RequiredCommands += @{
		Name = "az";
		Description = "Azure CLI";
		DownloadUrl = "https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-windows";
		DocumentationUrl = "https://docs.microsoft.com/en-us/cli/azure/reference-index";
		VersionMethod = '--version';
		VersionRegex = '^azure\-cli\s*\(?(\d+)\.(\d+)\.(\d+)\)?\s*\*?$';
		VersionMinLevels = @{1=2; 2=0; 3=62;};
		VersionSeparator = ".";
	};

	$RequiredCommands += @{
		Name = "dotnet";
		Description = "ASP.NET Core";
		DownloadUrl = "https://dotnet.microsoft.com/download/dotnet-core/2.1";
		DocumentationUrl = "https://docs.microsoft.com/en-us/dotnet/core";
	};

	$RequiredCommands += @{
		Name = "git";
		Description = "Git SCM";
		DownloadUrl = "https://git-scm.com/downloads";
	};

	<#
		$RequiredCommands += @{
			Name = "pwsh";
			Description = "PowerShell v6 (Core)";
			DownloadUrl = "https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-core-on-windows";
			DownloadUrlLinux = "https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-core-on-linux";
		};
	#>

	$RequiredCommands | ForEach {
		$VersionMethod = If ($_.VersionMethod -ne $null) { $_.VersionMethod } Else { "" };
		$VersionRegex = If ($_.VersionRegex -ne $null) { $_.VersionRegex } Else { "" };
		$VersionMinLevels = If ($_.VersionMinLevels -ne $null) { $_.VersionMinLevels } Else { "" };
		$VersionSeparator = If ($_.VersionSeparator -ne $null) { $_.VersionSeparator } Else { "" };
		$CommandExists = EnsureCommandExists -Name ($_.Name) -OnErrorShowUrl ($_.DownloadUrl) -VersionMethod ($VersionMethod) -VersionRegex ($VersionRegex) -VersionMinLevels ($VersionMinLevels) -VersionSeparator ($VersionSeparator);
	};

	# ---------------------------------------------------------------------------------------------------------- #

	# Required PowerShell Module(s)

	$RequiredModules = @();
	$RequiredModules += "BombOut";

	ForEach ($EachModule In ($RequiredModules)) {
		Write-Host (("Task - Checking for required module: `"")+($EachModule)+("`"..."));
		If (Get-Module ($EachModule)) {
			Write-Host (("Pass - Required Module exists: `"")+($EachModule)+("`""));

		} Else {
			# Fail-out if any required modules are not found within the current scope
			Write-Host (("Fail - Required Module not found: `"")+($EachModule)+("`""));
			Start-Sleep -Seconds 60;
			Exit 1;

		}
	}

	# ---------------------------------------------------------------------------------------------------------- #
	
	$statics = @{};

	$statics.timestamp = (Get-Date ((Get-Date).ToUniversalTime()) -UFormat "%Y%m%d%H%M%S");
	$statics.timestamp_hex = [Convert]::ToString(($statics.timestamp), 16);

	$statics.max = @{};
	$statics.max.rg_name_length = 24;
	$statics.max.rg_name_timestamp_length = (($statics.max.rg_name_length)-($statics.timestamp_hex).Length);

	$statics.dashes="----------------------------------------------------------------------------------------------------------";

	# ---------------------------------------------------------------------------------------------------------- #
	#
	## Required: SubscriptionID
	#   |
	#   |--|> Must be specified as [ an in-line parameter ] or [ an environment variable ]
	#
	$SubscriptionID = If ($PSBoundParameters.ContainsKey("SubscriptionID")) {$SubscriptionID} ElseIf ($Env:SubscriptionID -ne $null) {$Env:SubscriptionID} Else {$null};

	$SubscriptionID_ExitCode = If ($SubscriptionID -ne $null) {0} Else {1};

	BombOut `
		-ExitCode ($SubscriptionID_ExitCode) `
		-MessageOnError ("Fail - Required variable `"SubscriptionID`" missing (must be specified as [ an in-line parameter ] or [ an environment variable ])") `
		-MessageOnSuccess ("Pass - Using subscription ID `"$SubscriptionID`"");

	# ---------------------------------------------------------------------------------------------------------- #
	#
	## Required: Company Name
	#

	$CompanyName = If ($PSBoundParameters.ContainsKey("CompanyName")) {$CompanyName} ElseIf ($Env:CompanyName -ne $null) {$Env:CompanyName} Else {$null};

	# Force lowercase resource names (by default)
	If ($PSBoundParameters.ContainsKey('AllowUppercaseResourceNames') -eq $false) {
		$CompanyName = $CompanyName.ToLower();
	}

	If (($PSBoundParameters.ContainsKey('CompanyNameAddTimestamp'))) {
		# Optional - Concatenate a timestamp to end of the resource's name

		$CompanyShortName = $null;
		If (($CompanyName.Length) -gt ($statics.max.rg_name_timestamp_length)) {
			# Ensure that final Company Name is equal-to or less-than the max number of characters (for a Company Name)
			$CompanyShortName = ($CompanyName.Substring(0, ($statics.max.rg_name_timestamp_length)));
		} Else {
			$CompanyShortName = $CompanyName;
		}
		$CompanyName = (($CompanyShortName)+(Get-Date ((Get-Date).ToUniversalTime()) -UFormat "%Y%m%d%H%M%S"));

	} Else {
		If ($CompanyName.length -gt ($statics.max.rg_name_length)) {
			# Ensure that final Company Name is equal-to or less-than the max number of characters (for a Company Name)
			$CompanyName = $ResourceNameFull.Substring(0, ($statics.max.rg_name_length));
		}
	}
	
	$last_exit_code = If ($CompanyName -ne $null) {0} Else {1};
	BombOut `
		-ExitCode ($last_exit_code) `
		-MessageOnError ("Fail - Required variable `"CompanyName`" missing (must be specified as [ an in-line parameter ] or [ an environment variable ])") `
		-MessageOnSuccess ("Pass - Using CompanyName `"$CompanyName`"");

	# ---------------------------------------------------------------------------------------------------------- #

	$az = @{};

	$az.epithet = ($CompanyName);

	$az.subscription = ($SubscriptionID);
	
	$az.location = ($AzureLocation);

	## Login to Azure via CLI
	$az.login = @{};

	## Subscription Information
	$az.account = @{};
	$az.account.show = @{};

	## Resource group
	$az.group = @{};
	$az.group.name = (($az.epithet) + ("-rg"));
	$az.group.create = @{};

	## Extensions
	$az.extension = @{}; # View all extensions		-->		JsonDecoder -InputObject (az extension list-available);
	$az.extension.required = @();
	$az.extension.required += "azure-devops"; # az artifacts, az boards, az devops, az pipelines, az repos --> https://docs.microsoft.com/en-us/cli/azure/ext/azure-devops/devops
	$az.extension.required += "azure-firewall"; # az network firewall application-rule --> https://docs.microsoft.com/en-us/cli/azure/ext/azure-firewall/network/firewall/application-rule
	$az.extension.required += "log-analytics";
	$az.extension.required += "front-door";
	$az.extension.required += "log-analytics";
	$az.extension.required += "webapp";
	$az.extension.results = @{};

	## Keyvaults
	$az.keyvault = @{};
	$az.keyvault.git = @{};
	$az.keyvault.sql = @{};

	## Keyvault Secret(s)
	$az.secrets = @{};

	## Storage (Files, Blobs, Tables)
	$az.storage = @{};

	## Storage Account(s)
	$az.storage.account = @{};

	$az.secrets.git = @{};
	$az.secrets.git.vault = "bis-static-keyvault";
	$az.secrets.git.clone_url_https = "git-pull-url-https";
	$az.secrets.git.clone_url_ssh = "git-pull-url-ssh";
	$az.secrets.git.branch = "git-pull-branch";
	$az.secrets.git.username = "git-pull-user";
	$az.secrets.git.usertoken = "git-pull-token";
	$az.secrets.git.project_https_port = "webapp-dotnet-https-port";
	$az.secrets.git.buildpath_backend_dotnet = "webapp-backend-project";
	$az.secrets.git.buildpath_frontend_dotnet = "webapp-frontend-project";
	$az.secrets.git.buildpath_frontend_angular = "webapp-frontend-project-angular";

	$az.secrets.sql = @{};
	$az.secrets.sql.vault = "bis-static-keyvault";
	$az.secrets.sql.admin_user = "sql-adminuser";
	$az.secrets.sql.admin_pass = "sql-adminpass";

	## App Service plans
	$az.appservice = @{};
	$az.appservice.desc = 'App Service Plan';
	$az.appservice.plan = @{};
	$az.appservice.plan.name = (($az.epithet) + ("-appservice-plan"));
	$az.appservice.plan.resource_group = ($az.group.name);
	$az.appservice.plan.sku = "FREE";

	# SQL Server + Database
	$az.sql = @{};
	$az.sql.server = @{};
	$az.sql.database = @{};

	# App Insights
	$az.insights = @{};

	# App Service(s)
	$az.webapp = @{};

	# App Service Deployments (Kudu)
	$az.webapp.deployment = @{};
	$az.webapp.deployment.desc = "Git Deployment Credentials";
	$az.webapp.deployment.user_name = (("bnl-")+(([Convert]::ToBase64String([System.Text.Encoding]::Unicode.GetBytes((Get-Random -SetSeed (Get-Random))))).Substring(0,20)));
	# Wait for a random amount of time so that we increase the millisecond gap between user & password string-generation (expert mode guessing)
	Start-Sleep -Milliseconds (Get-Random -Minimum (Get-Random -Minimum 50 -Maximum 499) -Maximum (Get-Random -Minimum 500 -Maximum 949));
	$az.webapp.deployment.user_pass = ((([Convert]::ToBase64String([System.Text.Encoding]::Unicode.GetBytes(("PASS!")+(Get-Random -SetSeed (Get-Random))))).Substring(0,20))+("aA1!"));

	# ---------------------------------------------------------------------------------------------------------- #
	#
	#		Azure-CLI: Add required extension(s)
	#		
	#			az extension ...
	#				--> https://docs.microsoft.com/en-us/cli/azure/azure-cli-extensions-overview
	#
	ForEach ($EachRequiredExtensionName In ($az.extension.required)) {
		
		$az.extension.results[$EachRequiredExtensionName] = `
			Az_Extension `
				-Add `
				-Name ($EachRequiredExtensionName) `
			;

	}

	# ---------------------------------------------------------------------------------------------------------- #
	#
	#  0.1   Make sure Azure-CLI session exists (az login)
	#

	$CommandDescription = "Requesting current session's Azure Subscription-Info";

	Write-Host (("`nTask - ")+($CommandDescription)+("...`n"));

	# Get current subscription info, etc.
	$az.account.show = `
		az account show `
		| ConvertFrom-Json;
	$last_exit_code = If($?){0}Else{1};

	If ($last_exit_code -ne 0) {

		# If the account details throws an error, then no session exists --> request Azure user-credentials
		$CommandDescription = "Performing User Authentication/Authorization";
		Write-Host (("`nTask - ")+($CommandDescription)+("...`n"));

		$az.login = `
			az login `
			| ConvertFrom-Json;
		$last_exit_code = If($?){0}Else{1};

		# Bomb-out on errors
		BombOut `
			-ExitCode ($last_exit_code) `
			-MessageOnError (('Error thrown while [')+($CommandDescription)+(']')) `
			-MessageOnSuccessJSON ($az.account.show);

		# Re-acquire Subscription info
		$CommandDescription = "Requesting current session's Azure Subscription-Info";
		Write-Host (("`nTask - ")+($CommandDescription)+("...`n"));

		$az.account.show = `
			az account show `
			| ConvertFrom-Json;
		$last_exit_code = If($?){0}Else{1};

	}

	# Bomb-out on errors
	BombOut `
		-ExitCode ($last_exit_code) `
		-MessageOnError (('Error thrown while [')+($CommandDescription)+(']')) `
		-MessageOnSuccess ("Azure credentials validated") `
		-MessageOnSuccessJSON ($az.account.show);

	# ---------------------------------------------------------------------------------------------------------- #
	#
	# 1.1   Create Resource Group
	#

	$CommandDescription = "Creating Resource Group";
	Write-Host (("`nTask - ")+($CommandDescription)+("...`n"));

	$az.group.create = `
		az group create `
			--name ($az.group.name) `
			--location ($az.location) `
			--subscription ($az.subscription) `
		| ConvertFrom-Json;
	$last_exit_code = If($?){0}Else{1};

	# Bomb-out on errors
	BombOut `
		-ExitCode ($last_exit_code) `
		-MessageOnError (('Error thrown while [')+($CommandDescription)+(']')) `
		-MessageOnSuccessJSON ($az.group.create) `
	;

	# ---------------------------------------------------------------------------------------------------------- #
	#
	# 2.1   Create Storage Account
	#

	Write-Host (("`n`n")+($statics.dashes)+("`nCalling Module:   Az_StorageAccount `n"));
	$az.storage.account = `
		Az_StorageAccount `
			-SubscriptionID ($az.subscription) `
			-ResourceGroup ($az.group.name) `
	;

	# ---------------------------------------------------------------------------------------------------------- #
	#
	# 3.1   Create Keyvault
	#
	# 	Az_KeyVault `
	# 		-SubscriptionID ($az.subscription) `
	# 		-ResourceGroup ($az.group.name) `
	# 		-AppServicePlanName ($az.appservice.plan.name) `
	# 		-Name ($az.epithet) `
	# 	;

	# ---------------------------------------------------------------------------------------------------------- #
	#
	# 3.2   Whitelist current CIDR on the SQL Keyvault's Firewall
	#
	#		
	#		az keyvault network-rule
	#			https://docs.microsoft.com/en-us/cli/azure/keyvault/network-rule?view=azure-cli-latest
	#
	$Loopback_CIDR = `
		ResolveIPv4 `
			-GetLoopbackAddress `
			-OutputNotation "CIDR";

	$az.keyvault.sql.network_rule_list = `
		az keyvault network-rule list `
			--name ($az.secrets.sql.vault) `
			| ConvertFrom-Json `
	;
	
	$Loopback_CIDR_AlreadyWhitelisted = $false;

	ForEach ($EachCIDR_WhitelistObj In (($az.keyvault.sql.network_rule_list).ipRules)) {
		If ($Loopback_CIDR -eq $EachCIDR_WhitelistObj.value) {
			$CIDR_AlreadyWhitelisted = $true;
		}
	}

	If ($CIDR_AlreadyWhitelisted -eq $true) {
			
		Write-Host (("Skip - Current CIDR `"")+($Loopback_CIDR)+("`" is already allowed through the firewall on KeyVault `"")+($az.secrets.sql.vault)+("`""));

	} Else {

		$CommandDescription = (("Whitelisting current-loopback CIDR `"")+($Loopback_CIDR)+("`" through the firewall on KeyVault `"")+($az.secrets.sql.vault)+("`""));
		Write-Host (("`nTask - ")+($CommandDescription)+("...`n"));

		$az.keyvault.sql.allow_current_ipv4 = `
		az keyvault network-rule add `
			--name ($az.secrets.sql.vault) `
			--ip-address ($Loopback_CIDR) `
			| ConvertFrom-Json;
		$last_exit_code = If($?){0}Else{1};

		# Bomb-out on errors
		BombOut -NoAzLogout `
			-ExitCode ($last_exit_code) `
			-MessageOnError (('Error thrown while [')+($CommandDescription)+(']')) `
			-MessageOnSuccessJSON ($az.keyvault.allow_current_ipv4);

	}

	# ---------------------------------------------------------------------------------------------------------- #
	#
	# 3.3   Whitelist current session's IPv4 (in CIDR notation) on the Git Keyvault's Firewall
	#
	If ($az.secrets.git.vault -ne $az.secrets.sql.vault) {

		# Only perform the whitelist if the Git & SQL Keyvaults are separate resources

		$Loopback_CIDR = ResolveIPv4 -GetLoopbackAddress;

		$az.keyvault.git.network_rule_list = `
			az keyvault network-rule list `
				--name ($az.secrets.git.vault) `
				| ConvertFrom-Json `
		;

		$Loopback_CIDR_AlreadyWhitelisted = $false;
			
		ForEach ($EachCIDR_WhitelistObj In (($az.keyvault.git.network_rule_list).ipRules)) {
			If ($Loopback_CIDR -eq $EachCIDR_WhitelistObj.value) {
				$CIDR_AlreadyWhitelisted = $true;
			}
		}

		If ($CIDR_AlreadyWhitelisted -eq $true) {
				
			Write-Host (("Skip - Current CIDR `"")+($Loopback_CIDR)+("`" is already allowed through the firewall on KeyVault `"")+($az.secrets.git.vault)+("`""));

		} Else {

			$CommandDescription = (("Whitelisting current-loopback CIDR `"")+($Loopback_CIDR)+("`" through the firewall on KeyVault `"")+($az.secrets.git.vault)+("`""));
			Write-Host (("`nTask - ")+($CommandDescription)+("...`n"));

			$az.keyvault.git.allow_current_ipv4 = `
			az keyvault network-rule add `
				--name ($az.secrets.git.vault) `
				--ip-address ($Loopback_CIDR) `
				| ConvertFrom-Json;
			$last_exit_code = If($?){0}Else{1};

			# Bomb-out on errors
			BombOut -NoAzLogout `
				-ExitCode ($last_exit_code) `
				-MessageOnError (('Error thrown while [')+($CommandDescription)+(']')) `
				-MessageOnSuccessJSON ($az.keyvault.allow_current_ipv4);

		}

	}

	# ---------------------------------------------------------------------------------------------------------- #

	# 3.4   Create Secret:  sql-adminuser
	# $az.sqldb.adminuser = (((az keyvault secret show --subscription ("xxyyzz-sub") --vault-name ("xxyyzz-vault") --name ("xxyyzz-user"))	| ConvertFrom-Json).value);

	# 3.5   Create Secret:  sql-adminpass
	# $az.sqldb.adminpass = (((az keyvault secret show --subscription ("xxyyzz-sub") --vault-name ("xxyyzz-vault") --name ("xxyyzz-pass"))	| ConvertFrom-Json).value);

	# ---------------------------------------------------------------------------------------------------------- #

	# 4   Create SQL Server & Database (Firewall-Included)
	
	Write-Host (("`n`n")+($statics.dashes)+("`nCalling Module:   Az_CreateSqlDb `n"));

	$Az_CreateSqlDb = `
		Az_CreateSqlDb `
			-SubscriptionID ($az.subscription) `
			-ResourceGroup ($az.group.name) `
			-Epithet ($az.epithet) `
		;

	$az.sql.server = $Az_CreateSqlDb.server;
	$az.sql.database = $Az_CreateSqlDb.database;

	# ---------------------------------------------------------------------------------------------------------- #

	# 5.1   App Service Plan (hardware specs for associated App Service(s))

	Write-Host (("`n`n")+($statics.dashes)+("`nCalling Module:   Az_CreateAppServicePlan `n"));

	$az.appservice.plan = `
		Az_CreateAppServicePlan `
			-SubscriptionID ($az.subscription) `
			-ResourceGroup ($az.group.name) `
			-Epithet ($az.epithet) `
		;

	# ---------------------------------------------------------------------------------------------------------- #

	# 5.2   App Service, Backend/Api

	Write-Host (("`n`n")+($statics.dashes)+("`nCalling Module:   Az_AppService_Backend `n"));

	$az.webapp.backend = `
		Az_AppService_Backend `
			-SubscriptionID ($az.subscription) `
			-ResourceGroup ($az.group.name) `
			-AppServicePlanName ($az.appservice.plan.name) `
			-Epithet ($az.epithet) `
			-KeyVault_Git ($az.secrets.git.vault) `
			-Vault_GitPullUrl443 ($az.secrets.git.clone_url_https) `
			-Vault_GitPullUrl22 ($az.secrets.git.clone_url_ssh) `
			-Vault_GitBranch ($az.secrets.git.branch) `
			-Vault_GitPullUser ($az.secrets.git.username) `
			-Vault_GitPullPass ($az.secrets.git.usertoken) `
			-Vault_WebAppPortHttps ($az.secrets.git.project_https_port) `
			-Vault_BackendProject ($az.secrets.git.buildpath_backend_dotnet) `
			-KeyVault_Sql ($az.secrets.sql.vault) `
			-Vault_SqlUser ($az.secrets.sql.admin_user) `
			-Vault_SqlPass ($az.secrets.sql.admin_pass) `
			-ConnectionString_AzureWebJobsDashboard ($az.storage.account.connection_string) `
			-ConnectionString_AzureWebJobsStorage ($az.storage.account.connection_string) `
		;

	# ---------------------------------------------------------------------------------------------------------- #
	# 5.3   App Service, Frontend

	Write-Host (("`n`n")+($statics.dashes)+("`nCalling Module:   Az_AppService_Frontend `n"));

	$az.webapp.frontend = `
		Az_AppService_Frontend `
			-SubscriptionID ($az.subscription) `
			-ResourceGroup ($az.group.name) `
			-AppServicePlanName ($az.appservice.plan.name) `
			-Epithet ($az.epithet) `
			-KeyVault_Git ($az.secrets.git.vault) `
			-Vault_GitPullUrl443 ($az.secrets.git.clone_url_https) `
			-Vault_GitPullUrl22 ($az.secrets.git.clone_url_ssh) `
			-Vault_GitBranch ($az.secrets.git.branch) `
			-Vault_GitPullUser ($az.secrets.git.username) `
			-Vault_GitPullPass ($az.secrets.git.usertoken) `
			-Vault_WebAppPortHttps ($az.secrets.git.project_https_port) `
			-Vault_FrontendProject ($az.secrets.git.buildpath_frontend_dotnet) `
			-Vault_FrontendProject_Angular ($az.secrets.git.buildpath_frontend_angular) `
			-ConnectionString_AzureWebJobsDashboard ($az.storage.account.connection_string) `
			-ConnectionString_AzureWebJobsStorage ($az.storage.account.connection_string) `
		;

	# ---------------------------------------------------------------------------------------------------------- #

	# 6.1   Api Management Service (App Service request throughput/handling)

	# ???

	# ---------------------------------------------------------------------------------------------------------- #

	# 7.1   Application Insights - Backend/Api App Service (logging/monitoring)

	Write-Host (("`n`n")+($statics.dashes)+("`nCalling Module:   Az_AppInsights_Backend `n"));
	
	$az.insights.backend = `
		Az_AppInsights_Backend `
			-SubscriptionID ($az.subscription) `
			-ResourceGroup ($az.group.name) `
			-AppServicePlanName ($az.appservice.plan.name) `
			-Epithet ($az.epithet) `
		;

	# ---------------------------------------------------------------------------------------------------------- #

	# 7.2   Application Insights - Frontend App Service (logging/monitoring)

	Write-Host (("`n`n")+($statics.dashes)+("`nCalling Module:   Az_AppInsights_Frontend `n"));

	$az.insights.frontend = `
		Az_AppInsights_Frontend `
			-SubscriptionID ($az.subscription) `
			-ResourceGroup ($az.group.name) `
			-AppServicePlanName ($az.appservice.plan.name) `
			-Epithet ($az.epithet) `
		;

	# ---------------------------------------------------------------------------------------------------------- #

}

Export-ModuleMember -Function "Az_Spinup";
