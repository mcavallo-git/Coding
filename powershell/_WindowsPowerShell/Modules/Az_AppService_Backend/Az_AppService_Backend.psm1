#
# Example Call:
#
# 	Az_AppService_Backend `
# 		-SubscriptionID ($az.subscription) `
# 		-ResourceGroup ($az.group.name) `
# 		-AppServicePlanName ($az.appservice.plan.name) `
# 		-Epithet ($az.epithet) `
# 		-KeyVault_Git ($az.secrets.git.vault) `
# 		-Vault_GitPullUrl443 ($az.secrets.git.clone_url_https) `
# 		-Vault_GitPullUrl22 ($az.secrets.git.clone_url_ssh) `
# 		-Vault_GitBranch ($az.secrets.git.branch) `
# 		-Vault_GitPullUser ($az.secrets.git.username) `
# 		-Vault_GitPullPass ($az.secrets.git.usertoken) `
# 		-Vault_WebAppPortHttps ($az.secrets.git.project_https_port) `
# 		-Vault_BackendProject ($az.secrets.git.buildpath_backend_dotnet) `
# 		-KeyVault_Sql ($az.secrets.sql.vault) `
# 		-Vault_SqlUser ($az.secrets.sql.admin_user) `
# 		-Vault_SqlPass ($az.secrets.sql.admin_pass) `
# 	;
#
function Az_AppService_Backend {
	Param(
		
		[Parameter(Mandatory=$true)]
		[String]$SubscriptionID	= "",
		
		[Parameter(Mandatory=$true)]
		[String]$ResourceGroup = "",

		[Parameter(Mandatory=$true)]
		[String]$AppServicePlanName = "",

		[String]$StartTimestamp = (Get-Date ((Get-Date).ToUniversalTime()) -UFormat "%Y%m%d-%H%M%S"),

		[String]$Epithet = (("bis-")+($StartTimestamp)),
			[String]$Epithet_SqlServer = $Epithet,
			[String]$Epithet_SqlDb = $Epithet,

		[String]$Sku = "Developer",

		[String]$KeyVault_Sql,
			[String]$Vault_SqlUser,
			[String]$Vault_SqlPass,

		[String]$KeyVault_Git,
			[String]$Vault_GitPullUrl443,
			[String]$Vault_GitPullUrl22,
			[String]$Vault_GitBranch,
			[String]$Vault_GitPullPass,
			[String]$Vault_GitPullUser,
			[String]$Vault_WebAppPortHttps,
			[String]$Vault_BackendProject,

		[String]$ConnectionString_AzureWebJobsDashboard="DefaultEndpointsProtocol=https;AccountName=[myaccount];AccountKey=[mykey];",
		[String]$ConnectionString_AzureWebJobsStorage="DefaultEndpointsProtocol=https;AccountName=[myaccount];AccountKey=[mykey];",
		
		[Switch]$Quiet
	)
	
	# Fail-out if any required modules are not found within the current scope
	$RequireModule="BombOut"; 
	if (!(Get-Module ($RequireModule))) {
		Write-Host (("`n`nRequired Module not found: `"")+($RequireModule)+("`"`n`n"));
		Start-Sleep -Seconds 60;
		Exit 1;
	}

	# ------------------------------------------------------------- #

	$az = @{};
	
	$az.account = @{};
	
	$az.group = @{};

	$az.keyvault = @{};

	$az.secrets = @{};

	$az.sql = @{};

	$az.webapp = @{};

	$az.webapp.config = @{};
	$az.webapp.connection_string = @{};
	$az.webapp.cors = @{};
	$az.webapp.deployment = @{};
	$az.webapp.logging = @{};
	$az.webapp.update = @{};

	$az.webapp.git = @{};
	$az.webapp.https = @{};
	$az.webapp.keyvault = @{};

	# ------------------------------------------------------------- #
	#### Web App (Backend)

	$az.epithet = ($Epithet);

	$az.subscription = ($SubscriptionID);

	$az.group.name = ($ResourceGroup);

	$az.keyvault.name_git = ($KeyVault_Git);
	$az.keyvault.name_sql = ($KeyVault_Sql);
	
	$az.sql.server_name = (($Epithet_SqlServer)+("-sqlserver"));
	$az.sql.database_name = (($Epithet_SqlDb)+("-sqldb"));

	$az.webapp.plan = ($AppServicePlanName);

	$az.webapp.name = (($az.epithet)+("-api"));

	$az.webapp.fqdn_web = (("https://")+($az.epithet)+(".azurewebsites.net"));
	$az.webapp.fqdn_api = (("https://")+($az.epithet)+("-api.azurewebsites.net"));
	
	$az.webapp.fqdn_kudu_web = (($az.webapp.fqdn_web).Replace(".azurewebsites.net", "scm.azurewebsites.net"));
	$az.webapp.fqdn_kudu_api = (($az.webapp.fqdn_api).Replace(".azurewebsites.net", "scm.azurewebsites.net"));

	$az.webapp.connection_string.type = "SQLAzure";
	
	$az.webapp.connection_string.AzureWebJobsDashboard = (("AzureWebJobsDashboard=")+($ConnectionString_AzureWebJobsDashboard));
	$az.webapp.connection_string.AzureWebJobsStorage = (("AzureWebJobsStorage=")+($ConnectionString_AzureWebJobsStorage));

	$az.webapp.git.branch = $null;
	$az.webapp.git.appType = "AspNetCore";
	$az.webapp.git.repoType = "vsts";
	$az.webapp.git.token = "some_token";

	# Kudu Git-Deployment Credentials
	$az.webapp.deployment.user = (("bnl-")+(([Convert]::ToBase64String([System.Text.Encoding]::Unicode.GetBytes((Get-Random -SetSeed (Get-Random))))).Substring(0,20)));
	# Wait for a random amount of time so that we increase the millisecond gap between user & password string-generation (expert mode guessing)
	Start-Sleep -Milliseconds (Get-Random -Minimum (Get-Random -Minimum 50 -Maximum 499) -Maximum (Get-Random -Minimum 500 -Maximum 949));
	$az.webapp.deployment.pass = ((([Convert]::ToBase64String([System.Text.Encoding]::Unicode.GetBytes(("PASS!")+(Get-Random -SetSeed (Get-Random))))).Substring(0,20))+("aA1!"));
	$az.webapp.deployment.setuser = @{};	## Filled-in by:	[ az webapp deployment user set ... ]

	# ------------------------------------------------------------- #

	# Azure Subscription Info/Defaults
	$CommandDescription = "Requesting current session's Azure Subscription-Info";
	Write-Host (("`nTask - ")+($CommandDescription)+("...`n"));

	$az.account.show = `
	az account show `
		| ConvertFrom-Json;
	$last_exit_code = If($?){0}Else{1};

	# Bomb-out on errors
	BombOut `
		-ExitCode ($az.account.exit_code) `
		-MessageOnError (('Fail - Error thrown while [')+($CommandDescription)+(']')) `
		-MessageOnSuccessJSON ($az.account.show);

	# ------------------------------------------------------------- #

	# Get Secret [ Git Username ]
	$SecretName = $Vault_GitPullUser;
	$CommandDescription = ("Acquiring secret `"")+($SecretName)+("`"...");
	$az.secrets[$SecretName] = az keyvault secret show --subscription ($az.subscription) --vault-name ($az.keyvault.name_git) --name ($SecretName) | ConvertFrom-Json;
	$last_exit_code = If($?){0}Else{1};
	BombOut -NoAzLogout -ExitCode ($last_exit_code) -MessageOnError (('Error while [') + ($CommandDescription) + (']')) -MessageOnSuccess (("Acquired secret `"")+($SecretName)+("`"")); 

	$az.secrets[$SecretName] = $az.secrets[$SecretName].value;

	# ------------------------------------------------------------- #

	# Get Secret [ Git Password ]
	$SecretName = $Vault_GitPullPass;
	$CommandDescription = (("Acquiring secret `"")+($SecretName)+("`"..."));
	$az.secrets[$SecretName] = az keyvault secret show --subscription ($az.subscription) --vault-name ($az.keyvault.name_git) --name ($SecretName) | ConvertFrom-Json;
	$last_exit_code = If($?){0}Else{1};
	BombOut -NoAzLogout -ExitCode ($last_exit_code) -MessageOnError (('Error while [') + ($CommandDescription) + (']')) -MessageOnSuccess (("Acquired secret `"")+($SecretName)+("`"")); 

	$az.secrets[$SecretName] = $az.secrets[$SecretName].value;

	# ------------------------------------------------------------- #

	# Get Secret [ Git Url (HTTPS) ]
	$SecretName = $Vault_GitPullUrl443;
	$CommandDescription = (("Acquiring secret `"")+($SecretName)+("`"..."));
	$az.secrets[$SecretName] = az keyvault secret show --subscription ($az.subscription) --vault-name ($az.keyvault.name_git) --name ($SecretName) | ConvertFrom-Json;
	$last_exit_code = If($?){0}Else{1};
	BombOut -NoAzLogout -ExitCode ($last_exit_code) -MessageOnError (('Error while [') + ($CommandDescription) + (']')) -MessageOnSuccess (("Acquired secret `"")+($SecretName)+("`"")); 

	$az.secrets[$SecretName] = $az.secrets[$SecretName].value;

	# ------------------------------------------------------------- #

	# Get Secret [ Git Branch ]
	$SecretName = $Vault_GitBranch;
	$CommandDescription = (("Acquiring secret `"")+($SecretName)+("`"..."));
	$az.secrets[$SecretName] = az keyvault secret show --subscription ($az.subscription) --vault-name ($az.keyvault.name_git) --name ($SecretName) | ConvertFrom-Json;
	$last_exit_code = If($?){0}Else{1};
	BombOut -NoAzLogout -ExitCode ($last_exit_code) -MessageOnError (('Error while [') + ($CommandDescription) + (']')) -MessageOnSuccess (("Acquired secret `"")+($SecretName)+("`"")); 

	$az.secrets[$SecretName] = $az.secrets[$SecretName].value;

	# ------------------------------------------------------------- #

	# Sql Secret [ App Service HTTPS Port ]
	$SecretName = $Vault_WebAppPortHttps;
	$CommandDescription = (("Acquiring secret `"")+($SecretName)+("`"..."));
	$az.secrets[$SecretName] = az keyvault secret show --subscription ($az.subscription) --vault-name ($az.keyvault.name_git) --name ($SecretName) | ConvertFrom-Json;
	$last_exit_code = If($?){0}Else{1};
	BombOut -NoAzLogout -ExitCode ($last_exit_code) -MessageOnError (('Error while [') + ($CommandDescription) + (']')) -MessageOnSuccess (("Acquired secret `"")+($SecretName)+("`"")); 

	$az.secrets[$SecretName] = $az.secrets[$SecretName].value;

	# ------------------------------------------------------------- #

	# Sql Secret [ Backend App Service Build-Path ]
	$SecretName = $Vault_BackendProject;
	$CommandDescription = (("Acquiring secret `"")+($SecretName)+("`"..."));
	$az.secrets[$SecretName] = az keyvault secret show --subscription ($az.subscription) --vault-name ($az.keyvault.name_git) --name ($SecretName) | ConvertFrom-Json;
	$last_exit_code = If($?){0}Else{1};
	BombOut -NoAzLogout -ExitCode ($last_exit_code) -MessageOnError (('Error while [') + ($CommandDescription) + (']')) -MessageOnSuccess (("Acquired secret `"")+($SecretName)+("`"")); 

	$az.secrets[$SecretName] = $az.secrets[$SecretName].value;
	
	# ------------------------------------------------------------- #

	# Sql Secret [ Sql Admin-User ]
	$SecretName = $Vault_SqlUser;
	$CommandDescription = (("Acquiring secret `"")+($SecretName)+("`"..."));
	$az.secrets[$SecretName] = az keyvault secret show --subscription ($az.subscription) --vault-name ($az.keyvault.name_sql) --name ($SecretName) | ConvertFrom-Json;
	$last_exit_code = If($?){0}Else{1};
	BombOut -NoAzLogout -ExitCode ($last_exit_code) -MessageOnError (('Error while [') + ($CommandDescription) + (']')) -MessageOnSuccess (("Acquired secret `"")+($SecretName)+("`"")); 

	$az.secrets[$SecretName] = $az.secrets[$SecretName].value;

	# ------------------------------------------------------------- #

	# Sql Secret [ Sql Admin-Pass ]
	$SecretName = $Vault_SqlPass;
	$CommandDescription = (("Acquiring secret `"")+($SecretName)+("`"..."));
	$az.secrets[$SecretName] = az keyvault secret show --subscription ($az.subscription) --vault-name ($az.keyvault.name_sql) --name ($SecretName) | ConvertFrom-Json;
	$last_exit_code = If($?){0}Else{1};
	BombOut -NoAzLogout -ExitCode ($last_exit_code) -MessageOnError (('Error while [') + ($CommandDescription) + (']')) -MessageOnSuccess (("Acquired secret `"")+($SecretName)+("`"")); 

	$az.secrets[$SecretName] = $az.secrets[$SecretName].value;

	# ------------------------------------------------------------- #
	#
	#		Create App Service
	#

	$UseLocalGitRepo = $false;

	If ($UseLocalGitRepo -eq $true) {
		# Create a App Service with local Git-deployment enabled

		$CommandDescription = (("Creating App Service `"")+($az.webapp.name)+("`""));
		Write-Host (("`nTask - ")+($CommandDescription)+("...`n"));
		$az.webapp.create = `
			az webapp create `
				--resource-group ($az.group.name) `
				--plan ($az.webapp.plan) `
				--name ($az.webapp.name) `
				--deployment-local-git `
			| ConvertFrom-Json;
		$last_exit_code = If($?){0}Else{1};

		# Bomb-out on errors
		BombOut -NoAzLogout `
			-ExitCode ($last_exit_code) `
			-MessageOnError (('Fail - Error thrown while [')+($CommandDescription)+(']')) `
			-MessageOnSuccessJSON ($az.webapp.create);

	} Else {
		# Create a App Service with local Git-deployment disabled (then enable the Kudu build server)

		$CommandDescription = (("Creating App Service `"")+($az.webapp.name)+("`""));
		Write-Host (("`nTask - ")+($CommandDescription)+("...`n"));
		$az.webapp.create = `
			az webapp create `
				--resource-group ($az.group.name) `
				--plan ($az.webapp.plan) `
				--name ($az.webapp.name) `
			| ConvertFrom-Json;
		$last_exit_code = If($?){0}Else{1};

		# Bomb-out on errors
		BombOut -NoAzLogout `
			-ExitCode ($last_exit_code) `
			-MessageOnError (('Fail - Error thrown while [')+($CommandDescription)+(']')) `
			-MessageOnSuccessJSON ($az.webapp.create);

		# Enable Kudu build server
		$CommandDescription = (("Enabling Kudu build-server for `"")+($az.webapp.name)+("`""));
		Write-Host (("`nTask - ")+($CommandDescription)+("...`n"));
		$az.webapp.enable_kudu = `
		az webapp deployment source config-local-git `
			--name ($az.webapp.name) `
			--resource-group ($az.group.name) `
			--subscription ($az.subscription) `
			| ConvertFrom-Json;
			# --verbose `
		$last_exit_code = If($?){0}Else{1};

		# Bomb-out on errors
		BombOut -NoAzLogout `
			-ExitCode ($last_exit_code) `
			-MessageOnError (('Fail - Error thrown while [')+($CommandDescription)+(']')) `
			-MessageOnSuccessJSON ($az.webapp.enable_kudu);
		
	}

	# ------------------------------------------------------------- #
	#		Kudu Build-Server   (Git deployment-credentials)
	#
	#			az webapp deployment user set ...
	#				--> https://docs.microsoft.com/en-us/cli/azure/webapp/deployment/user
	#
	# ------------------------------------------------------------- #
	#
	#	Kudu - Read Kudu's default deployment-credentials
	#
	$CommandDescription = (("Reading default deployment-credentials for App Service `"")+($az.webapp.name)+("`""));
	Write-Host (("`nTask - ")+($CommandDescription)+("...`n"));

	$az.webapp.deployment.getuser = `
		JsonDecoder -InputObject (`
			az webapp deployment list-publishing-credentials `
				--name ($az.webapp.name) `
				--resource-group ($az.group.name) `
				--subscription ($az.subscription) `
		);
	$last_exit_code = If($?){0}Else{1};

	# Bomb-out on errors
	BombOut -NoAzLogout `
		-ExitCode ($last_exit_code) `
		-MessageOnError (('Error thrown while [')+($CommandDescription)+(']')) `
		-MessageOnSuccessJSON ($az.webapp.deployment.getuser);

	#	Kudu - Set Git deployment-credentials
	$CommandDescription = (("Setting default deployment-credentials for subscription `"")+($az.subscription)+("`""));
	Write-Host (("`nTask - ")+($CommandDescription)+("...`n"));

	$az.webapp.deployment.setuser = `
		JsonDecoder -InputObject (`
			az webapp deployment user set `
				--subscription ($az.subscription) `
				--user-name ($az.webapp.deployment.user) `
				--password ($az.webapp.deployment.pass) `
		);
	$last_exit_code = If($?){0}Else{1};

	# Bomb-out on errors
	BombOut -NoAzLogout `
		-ExitCode ($last_exit_code) `
		-MessageOnError (('Error thrown while [')+($CommandDescription)+(']')) `
		-MessageOnSuccessJSON ($az.webapp.deployment.setuser);

	# ------------------------------------------------------------- #
	#		App Service Update 
	#
	#			az webapp update ...
	#			--> https://docs.microsoft.com/en-us/cli/azure/webapp?view=azure-cli-latest#az-webapp-update
	#
	<#
	$CommandDescription = ("Configuring App Service `"")+($az.webapp.name)+("`" - Enabling `"Client-Affinity`", `"HTTPS-Only`"");
	Write-Host (("`nTask - ")+($CommandDescription)+("...`n"));
	
	$az.webapp.update = `
	az webapp update `
		--name ($az.webapp.name) `
		--resource-group ($az.group.name) `
		--subscription ($az.subscription) `
		--client-affinity-enabled true `
		--https-only true `
		| ConvertFrom-Json;
	$last_exit_code = If($?){0}Else{1};

	# Bomb-out on errors
	BombOut `
		-MessageOnError (('Fail - Error thrown while [')+($CommandDescription)+(']')) `
		-ExitCode ($last_exit_code) `
		-NoAzLogout;
	#>

	# ------------------------------------------------------------- #

	# Git Schema
	$git = @{};
	$git.local = @{};
	$git.remote = @{};

		# Git Source-Remote (to push-to)
		$git.remote.source = @{};
		$git.remote.source.url = ($az.secrets[$Vault_GitPullUrl443]);
		$git.remote.source.branch = ($az.secrets[$Vault_GitBranch]);
		$git.remote.source.reponame = [System.IO.Path]::GetFileNameWithoutExtension(([System.Uri]$git.remote.source.url).Segments[-1]);
		$git.remote.source.ref_uid = (("sourcerepo")+($StartTimestamp));

		# Git Destination-Remote (to push-to)
		$git.remote.destination = @{};
		$git.remote.destination.url = (("https://")+($az.webapp.name)+(".scm.azurewebsites.net/")+($az.webapp.name)+(".git"));
		$git.remote.destination.fqdn = ([System.Uri]($git.remote.destination.url)).Host;
		$git.remote.destination.reponame = [System.IO.Path]::GetFileNameWithoutExtension(([System.Uri]$git.remote.destination.url).Segments[-1]);
		$git.remote.destination.ref_uid = (("webapp")+($StartTimestamp));
		$git.remote.destination.branch = "master";
		$git.remote.destination.commit_msg = (("Publishing Code for App Service `"")+($az.epithet)+("`" "));
		
		# Build the username & token into one single url-request to push-to (which deploys into the App Service)
		$git.remote.destination.inline_creds_url = (("https://")+($az.webapp.deployment.user)+(":")+($az.webapp.deployment.pass)+("@")+($az.webapp.name)+(".scm.azurewebsites.net/")+($az.webapp.name)+(".git"));

		# Git Schema - Local
		$git.local.parent_dir = (($Home)+("/git"));
		$git.local.reponame = ($git.remote.source.reponame);
		$git.local.work_tree = (($git.local.parent_dir)+("/")+($git.local.reponame));
	
	# Make sure the parent directory to the git-repo exists
	if ((Test-Path -Path ($git.local.parent_dir)) -eq $false) {
		Write-Host (("`nTask - Creating git parent-directory at `"")+($git.local.parent_dir)+("`""));
		New-Item -ItemType "Directory" -Path ($git.local.parent_dir);
	}

	# ------------------------------------------------------------- #

	$dotnet = @{};
	$dotnet.publish = @{};

	$dotnet.publish.reponame = ($git.local.reponame);
	
	$dotnet.publish.parent_abs = ($git.local.work_tree);

	$dotnet.publish.project_rel = ($az.secrets[$Vault_BackendProject]);
	$dotnet.publish.project_abs = (($dotnet.publish.parent_abs)+("/")+($dotnet.publish.project_rel));

	$dotnet.publish.csproj_rel = (($dotnet.publish.project_rel)+("/")+($dotnet.publish.project_rel)+(".csproj"));
	$dotnet.publish.csproj_abs = (($dotnet.publish.parent_abs)+("/")+($dotnet.publish.csproj_rel));
	
	# $dotnet.publish.configuration = "Debug";
	# $dotnet.publish.configuration = "Development";
	# $dotnet.publish.configuration = "Production";

	$dotnet.publish.output = (($dotnet.publish.parent_abs)+("/published_")+($StartTimestamp));

	# ------------------------------------------------------------- #
	#		Create a firewall rule (SQL Server)
	#
	#		az sql server firewall-rule create ...
	#			--> https://docs.microsoft.com/en-us/cli/azure/sql/server/firewall-rule#az-sql-server-firewall-rule-create
	#

	<#
	
	$CommandDescription = ("Adding App Service's IPv4 to SQL Server Firewall's Whitelist");
	$CommandDescription = ("Configuring SQL Server Firewall for `"")+($az.sql.server_name)+("`" - Allowing access to IPv4 `"")+($git.remote.destination.wan_ipv4)+("`"");
	Write-Host (("`nTask - ")+($CommandDescription)+("...`n"));

	$az.sql.firewall_allow_webapp_ipv4 = `
	JsonDecoder -InputObject (`
		az sql server firewall-rule create `
			--subscription ($az.subscription) `
			--resource-group ($az.group.name) `
			--server ($az.sql.server_name) `
			--name (("Allow_IPv4_")+($git.remote.destination.wan_ipv4)) `
			--start-ip-address ($git.remote.destination.wan_ipv4) `
			--end-ip-address ($git.remote.destination.wan_ipv4) `
	);
	$last_exit_code = If($?){0}Else{1};

	# Bomb-out on errors
	BombOut -NoAzLogout `
		-ExitCode ($last_exit_code) `
		-MessageOnError (('Fail - Error thrown while [')+($CommandDescription)+(']')) `
		-MessageOnSuccessJSON ($az.sql.firewall_allow_webapp_ipv4);

	#>

	# ------------------------------------------------------------- #
	#		App Service Config. -> General
	#
	#			az webapp config appsettings ...
	#			--> https://docs.microsoft.com/en-us/cli/azure/webapp/config?view=azure-cli-latest#az-webapp-config-set
	#

	$CommandDescription = (("Setting general-config. options for App Service `"")+($az.webapp.name)+("`""));
	Write-Host (("`nTask - ")+($CommandDescription)+("...`n"));

	$az.webapp.config.set = `
	az webapp config set `
		--name ($az.webapp.name) `
		--resource-group ($az.group.name) `
		--subscription ($az.subscription) `
		--http20-enabled "false" `
		--min-tls-version "1.2" `
		--ftps-state "FtpsOnly" `
		| ConvertFrom-Json;
	$last_exit_code = If($?){0}Else{1};

	# Bomb-out on errors
	BombOut `
		-NoAzLogout `
		-ExitCode ($last_exit_code) `
		-MessageOnError (('Fail - Error thrown while [')+($CommandDescription)+(']')) `
		-MessageOnSuccessJSON ($az.webapp.config.set);
	
	# ------------------------------------------------------------- #

	###-- App Service Config. -> Application Settings
	#
	#	az webapp config appsettings
	#	 |-->https://docs.microsoft.com/en-us/cli/azure/webapp/config/appsettings?view=azure-cli-latest
	#
	# Configurable settings
	#	 |--> https://github.com/projectkudu/kudu/wiki/Configurable-settings
	#
	# docs.microsoft.com - "To customize your deployment, include a .deployment file in the repository root"
	#	 |-->https://docs.microsoft.com/en-us/azure/app-service/deploy-local-git
	#

	$CommandDescription = (("Configuring Application Settings for App Service `"")+($az.webapp.name)+("`""));
	Write-Host (("`nTask - ")+($CommandDescription)+("...`n"));

	$az.webapp.appSettings = @{};

	$az.webapp.appSettings["MobileAppsManagement_EXTENSION_VERSION"] = "latest";

	$az.webapp.appSettings["MSDEPLOY_RENAME_LOCKED_FILES"] = "1";

	$az.webapp.appSettings["WEBSITE_RUN_FROM_PACKAGE"] = "0";

	$az.webapp.appSettings["WEBSITE_TIME_ZONE"] = "Eastern Standard Time";

	$last_exit_code = 0;
	ForEach ($appSetting In (($az.webapp.appSettings).GetEnumerator())) {
		
		$az.webapp.appSettingsSet = `
		az webapp config appsettings set `
			--name ($az.webapp.name) `
			--resource-group ($az.group.name) `
			--subscription ($az.subscription) `
			--settings (($appSetting.Name)+("=")+($appSetting.Value)) `
			| ConvertFrom-Json;
			
		$last_exit_code += If($?){0}Else{1};

	}

	# Bomb-out on errors
	BombOut -NoAzLogout `
		-ExitCode ($last_exit_code) `
		-MessageOnError (('Fail - Error thrown while [')+($CommandDescription)+(']')) `
		-MessageOnSuccessJSON ($az.webapp.appSettingsSet);

	# ------------------------------------------------------------- #
	#
	#	App Service Config. -> Connection Strings (Databases, Storage, etc.)
	#
	#		az webapp config connection-string set  -->  https://docs.microsoft.com/en-us/cli/azure/webapp/config/connection-string
	#
	# ------------------------------------------------------------- #
	#
	# Connection String:   "AzureWebJobsDashboard"
	#		--> Optional storage account connection string for storing logs and displaying them in the Monitor tab in the portal.
	#		--> https://docs.microsoft.com/en-us/azure/azure-functions/functions-app-settings#azurewebjobsdashboard
	#

	$CommandDescription = (("Configuring Connection String `"AzureWebJobsDashboard`" for App Service `"")+($az.webapp.name)+("`""));

	Write-Host (("`nTask - ")+($CommandDescription)+("...`n"));

	$az.webapp.connection_string.SetConnectionDashboard = `
	JsonDecoder -InputObject ( `
		az webapp config connection-string set `
			--name ($az.webapp.name) `
			--resource-group ($az.group.name) `
			--connection-string-type ($az.webapp.connection_string.type) `
			--settings ($az.webapp.connection_string.AzureWebJobsDashboard) `
	);
	$last_exit_code = If($?){0}Else{1};

	# Bomb-out on errors
	BombOut -NoAzLogout `
		-ExitCode ($last_exit_code) `
		-MessageOnError (('Error thrown while [')+($CommandDescription)+(']')) `
		-MessageOnSuccess ('Pass - ( Credentials hidden )');

	# ------------------------------------------------------------- #
	#
	# Connection String:   "AzureWebJobsStorage"
	#		--> The Azure Functions runtime uses this storage account connection string for all functions except for HTTP triggered functions
	#		--> https://docs.microsoft.com/en-us/azure/azure-functions/functions-app-settings#azurewebjobsstorage
	#

	$CommandDescription = (("Configuring Connection String `"AzureWebJobsStorage`" for App Service `"")+($az.webapp.name)+("`""));

	Write-Host (("`nTask - ")+($CommandDescription)+("...`n"));

	$az.webapp.connection_string.SetConnectionStorage = `
	JsonDecoder -InputObject ( `
		az webapp config connection-string set `
			--name ($az.webapp.name) `
			--resource-group ($az.group.name) `
			--connection-string-type ($az.webapp.connection_string.type) `
			--settings ($az.webapp.connection_string.AzureWebJobsStorage) `
	);
	$last_exit_code = If($?){0}Else{1};

	# Bomb-out on errors
	BombOut -NoAzLogout `
		-ExitCode ($last_exit_code) `
		-MessageOnError (('Error thrown while [')+($CommandDescription)+(']')) `
		-MessageOnSuccess ('Pass - ( Credentials hidden )');
	
	# ------------------------------------------------------------- #
	#
	# Connection String:   "DefaultConnection"
	#		--> Default SQL Database to-be-used by ASP.NET Application
	#		--> https:// ... (Add reference here)
	#

	$CommandDescription = (("Configuring Connection String `"DefaultConnection`" for App Service `"")+($az.webapp.name)+("`""));

	Write-Host (("`nTask - ")+($CommandDescription)+("...`n"));

	$az.webapp.connectionStrings = ( `
		"DefaultConnection='" + `
			("Server=tcp:")+($az.sql.server_name)+(".database.windows.net,1433;") + `
			("Initial Catalog=")+($az.sql.database_name)+(";") + `
			("Persist Security Info=False;") + `
			("User ID=")+($az.secrets[$Vault_SqlUser])+(";") + `
			("Password=")+($az.secrets[$Vault_SqlPass])+(";") + `
			("MultipleActiveResultSets=False;") + `
			("Encrypt=True;") + `
			("TrustServerCertificate=False;") + `
			("Connection Timeout=60;") + `
		"'" `
	);

	$az.webapp.connectionStringsSet = `
	az webapp config connection-string set `
		--name ($az.webapp.name) `
		--resource-group ($az.group.name) `
		--connection-string-type ($az.webapp.connection_string.type) `
		--settings ($az.webapp.connectionStrings) `
		| ConvertFrom-Json;
	$last_exit_code = If($?){0}Else{1};

	# Bomb-out on errors
	BombOut -NoAzLogout `
		-ExitCode ($last_exit_code) `
		-MessageOnError (('Fail - Error thrown while [')+($CommandDescription)+(']')) `
		-MessageOnSuccess ('Pass - ( Credentials hidden )');
		# -MessageOnSuccessJSON ($az.webapp.connectionStringsSet);

	# ------------------------------------------------------------- #
	#
	###-- App Service Config. -> Diagnostics logs
	#
	#		az webapp log config  --> https://docs.microsoft.com/en-us/cli/azure/webapp/log#az-webapp-log-config
	#

	$CommandDescription = (("Configuring Diagnostics logs for App Service `"")+($az.webapp.name)+("`""));
	
	Write-Host (("`nTask - ")+($CommandDescription)+("...`n"));

	$az.webapp.logging.config = `
	JsonDecoder -InputObject ( `
		az webapp log config `
			--name ($az.webapp.name) `
			--resource-group ($az.group.name) `
			--subscription ($az.subscription) `
			--application-logging ($true) `
			--detailed-error-messages ($true) `
			--failed-request-tracing ($true) `
			--level ("warning") `
			--web-server-logging ("filesystem") `
	);
	$last_exit_code = If($?){0}Else{1};

		# --settings ($az.webapp.connectionStringsJSON) `

	# Bomb-out on errors
	BombOut -NoAzLogout `
		-ExitCode ($last_exit_code) `
		-MessageOnError (('Fail - Error thrown while [')+($CommandDescription)+(']')) `
		-MessageOnSuccessJSON ($az.webapp.logging.config);

	# ------------------------------------------------------------- #
	#	App Service CORS Configuration
	#			
	#		az webapp cors add ...
	#			--> https://docs.microsoft.com/en-us/cli/azure/webapp/cors?view=azure-cli-latest#az-webapp-cors-add
	#		
	#		general overview of CORS
	#			--> https://www.html5rocks.com/en/tutorials/cors
	#

	$CommandDescription = (("Setting CORS Configuration for App Service `"")+($az.webapp.name)+("`""));
	Write-Host (("`nTask - ")+($CommandDescription)+("...`n"));

	$az.webapp.cors.add = `
	JsonDecoder -InputObject (`
		az webapp cors add  `
			--name ($az.webapp.name) `
			--resource-group ($az.group.name) `
			--subscription ($az.subscription) `
			--allowed-origins "*" `
	);
		# --allowed-origins ($az.webapp.fqdn_web) ($az.webapp.fqdn_api) `
	$last_exit_code = If($?){0}Else{1};

	# Bomb-out on errors
	BombOut `
		-NoAzLogout `
		-ExitCode ($last_exit_code) `
		-MessageOnError (('Fail - Error thrown while [')+($CommandDescription)+(']')) `
		-MessageOnSuccessJSON ($az.webapp.cors.add);

	# ------------------------------------------------------------- #

	# Git Pull from the Source-Repo
	
	# Build the username & token into one single url-request to pull from the git-repo with
	$git.remote.source.inline_creds_url = (("https://")+($az.secrets[$Vault_GitPullUser])+(":")+($az.secrets[$Vault_GitPullPass])+("@")+(($git.remote.source.url).Replace("https://","")));

	Set-Location -Path ($git.local.parent_dir);

	## Clone the Source-Repo
	$git.remote.destination.clone = `
		GitCloneRepo `
			-Url ($git.remote.source.inline_creds_url) `
			-LocalDirname ($git.local.parent_dir) `
			-SkipResolveUrl `
			-Quiet;
	
	# ------------------------------------------------------------- #

	$CommandDescription = ("Installing Windows Pre-Required DLL Runtimes");
	Write-Host (("`nTask - ")+($CommandDescription)+("...`n"));

	# HOTFIX - Install addtional required packages (required to be installed before dotnet publish runs)
	$dotnet.packages = @{};

	# Microsoft.AspNetCore
	$dotnet.packages["Microsoft.AspNetCore.Identity"] = "2.1.6";
	$dotnet.packages["Microsoft.AspNetCore.Identity.EntityFrameworkCore"] = "2.1.6";
	# $dotnet.packages["Microsoft.AspNetCore.Identity.UI"] = "2.1.6";

	# Microsoft.Extensions
	$dotnet.packages["Microsoft.Extensions.Identity.Core"] = "2.1.6";
	$dotnet.packages["Microsoft.Extensions.Identity.Stores"] = "2.1.6";

	Set-Location -Path ($dotnet.publish.project_abs);
	ForEach ($RequiredPackage In (($dotnet.packages).GetEnumerator())) {
		
		ForEach ($EachMatchedDir In ((Get-ChildItem -Directory -Name -Path ($git.local.work_tree) -Include (($dotnet.publish.reponame)+("*"))).GetEnumerator())) {
			Set-Location -Path (($git.local.work_tree)+("/")+($EachMatchedDir));

			$CommandDescription = (("Installing: `"")+($RequiredPackage.Name)+(".dll`",  Version `"")+($RequiredPackage.Value)+("`" into `"")+($EachMatchedDir)+("`""));
			Write-Host ($CommandDescription);

			dotnet add package ($RequiredPackage.Name) --version ($RequiredPackage.Value) | Out-Null;

		}
	}

	# ------------------------------------------------------------- #
	
	# Push Codebase to App Service (caught by the Kudu build server running in Azure App Services)

	# $PublishBeforePush = $false;
	$PublishBeforePush = $true;

	Set-Location -Path ($git.local.work_tree);
	git config --global user.email ($az.account.show.user.name);
	git config --global user.name ($az.account.show.user.name);
		
	# -------------------------------------------------------------------------------------------------------------------------- #
	If ($PublishBeforePush -eq $true) {

		# Publish the App Service
		Set-Location -Path ($dotnet.publish.parent_abs);

		# dotnet publish  <-- automatically performs dotnet restore & dotnet build, unless specified otherwise
		
		#	Pre-Compiled Codebase
		#		Note: --output (dir) - dir must be an absolute (full) filepath
		dotnet publish ($dotnet.publish.csproj_abs) --output ($dotnet.publish.output) --verbosity detailed;

		# Setup Repo inside of the pre-compiled codebase (push only those files)
		Set-Location -Path ($dotnet.publish.output);

		git init;
		git add .;
		git commit -m ($git.remote.destination.commit_msg);
		git remote add origin ($git.remote.destination.inline_creds_url);

		# Set a default Project build-path for the app-service
		# $az.webapp.appSettingsSet = `
		# az webapp config appsettings set `
		# 	--name ($az.webapp.name) `
		# 	--resource-group ($az.group.name) `
		# 	--subscription ($az.subscription) `
		# 	--settings (("COMMAND='dotnet .\BonEdge.Api.dll'")) `
		# 	| ConvertFrom-Json;
		
		$CommandDescription = (("Pushing pre-compiled codebase to App Service `"")+($az.webapp.name)+("`"'s Kudu Build-Server"));
		Write-Host (("`nTask - ")+($CommandDescription)+("...`n"));

		git push origin master;

	} Else { # -------------------------------------------------------------------------------------------------------------------------- #

		# Redirect current code-repo so we can push to separate remote git-repo

		# Set a default Project build-path for the app-service
		$az.webapp.appSettingsSet = `
		az webapp config appsettings set `
			--name ($az.webapp.name) `
			--resource-group ($az.group.name) `
			--subscription ($az.subscription) `
			--settings (("PROJECT=")+($dotnet.publish.csproj_rel)) `
			| ConvertFrom-Json;

		Set-Location -Path ($git.local.work_tree);
		
		git remote add ($git.remote.destination.ref_uid) ($git.remote.destination.inline_creds_url);
		git add -A;
		git commit -m ($git.remote.destination.commit_msg);

		$CommandDescription = (("Pushing Full Repo to App Service `"")+($az.webapp.name)+("`"'s Kudu Build-Server"));
		Write-Host (("`nTask - ")+($CommandDescription)+("...`n"));
		
		### COMPILE STEP
		git push ($git.remote.destination.ref_uid) ($git.remote.destination.branch);
		
	}

	Return $az.webapp;

}

Export-ModuleMember -Function "Az_AppService_Backend";