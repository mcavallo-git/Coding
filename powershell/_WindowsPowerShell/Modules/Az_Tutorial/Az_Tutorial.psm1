
function Az_Tutorial {
	Param(

		[Parameter(Mandatory=$true)]
		[String]$CompanyName,

		[Switch]$CompanyNameAddTimestamp,

		[Int]$ExitAfterSeconds = 600,

		[Switch]$Quiet,

		[Switch]$RunLocalServer,
		
		[Parameter(Mandatory=$true)]
		[String]$SubscriptionID

	)

	# ------------------------------------------------------------- #
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
	# ------------------------------------------------------------- #
	
	$statics = @{};
	
	$statics.required = @{};

	$statics.required.commands = @{};
	$statics.required.commands.az = "https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-windows?view=azure-cli-latest";
	$statics.required.commands.dotnet = "https://dotnet.microsoft.com/download/dotnet-core/2.1";
	$statics.required.commands.git = "https://git-scm.com/downloads";

	$statics.required.modules = @();
	$statics.required.modules += "BombOut";

	$statics.timestamp = (Get-Date ((Get-Date).ToUniversalTime()) -UFormat "%Y%m%d%H%M%S");

	$statics.url = @{};
	$statics.url.services = @{};
	$statics.url.services.azure = @{};
	$statics.url.services.azure.portal = 'https://portal.azure.com';
	$statics.url.documentation = @{};
	$statics.url.documentation.az_cli = ('https://docs.microsoft.com/en-us/cli/azure/reference-index?view=azure-cli-latest'); # General documentation on the "az" powershell command
	$statics.url.documentation.dotnet_cli = ('https://docs.microsoft.com/en-us/dotnet/core'); # General documentation on the "dotnet" powershell command
	$statics.url.documentation.this_script = ('https://docs.microsoft.com/en-us/azure/app-service/app-service-web-tutorial-rest-api'); # Guide that this script was based off-of
	$statics.url.documentation.local_https = ('https://docs.microsoft.com/en-us/aspnet/core/getting-started/?view=aspnetcore-2.2&tabs=windows'); # Web-Apps w/ HTTPS on Localhost

	# ------------------------------------------------------------- #

	# Required Module(s)

	ForEach ($RequireModule In ($statics.required.modules)) {
		Write-Host (("Task - Checking for required module: `"")+($RequireModule)+("`"..."));
		If (Get-Module ($RequireModule)) {
			Write-Host (("Pass - Required Module exists: `"")+($RequireModule)+("`""));

		} Else {
			# Fail-out if any required modules are not found within the current scope
			Write-Host (("Fail - Required Module not found: `"")+($RequireModule)+("`""));
			Start-Sleep -Seconds 60;
			Exit 1;

		}
	}

	# ------------------------------------------------------------- #

	# Required Command(s)

	ForEach ($RequiredCommand In (($statics.required.commands).GetEnumerator())) {
		$CommandExists = EnsureCommandExists -Name ($RequiredCommand.Name) -OnErrorShowUrl ($RequiredCommand.Value);
	}
	
	# ------------------------------------------------------------- #
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
		-MessageOnSuccess ("Pass - Valid Company Name Exists;");

	# ------------------------------------------------------------- #
	#
	## Required: Company Name
	#
	$CompanyName = "";
	If ($PSBoundParameters.ContainsKey("CompanyName")) {$CompanyName} ElseIf ($Env:CompanyName -ne $null) {$Env:CompanyName} Else {$null};
	$CompanyName_ExitCode = If ($CompanyName -ne $null) {0} Else {1};
	BombOut `
		-ExitCode ($CompanyName_ExitCode) `
		-MessageOnError ("Fail - Required variable `"CompanyName`" missing (must be specified as [ an in-line parameter ] or [ an environment variable ])") `
		-MessageOnSuccess ("Pass - Valid Company Name Exists;");

	# Optional - Concatenate a timestamp to end of the resource's name
	If (($PSBoundParameters.ContainsKey('CompanyNameAddTimestamp'))) {
		$CompanyNameShort = If ($CompanyName.length -gt 9) { $CompanyName.Substring(0, 9) } Else { $CompanyName };
		$CompanyName = (($CompanyNameShort)+("-")+(Get-Date ((Get-Date).ToUniversalTime()) -UFormat "%Y%m%d%H%M%S"));
	} Else {
		If ($CompanyName.length -gt 24) {
			$CompanyName = $ResourceNameFull.Substring(0, 24);
		}
	}

	# ------------------------------------------------------------- #

	$az = @{};

	$az.epithet = (($CompanyName) + ("-") + (Get-Date ((Get-Date).ToUniversalTime()) -UFormat "%Y%m%d%H%M%S"));

	## Login to Azure via CLI
	$az.login = @{};  ## Filled-in by:  [ az login ]
	$az.login_desc = "User Authentication/Authorization";
	$az.login_error = $false;

	## Subscription Information
	$az.account = @{};
	$az.account.exit_code = 1;
	$az.account.list = @{};  ## Filled-in by:  [ az account list ]
	$az.account.show = @{};  ## Filled-in by:  [ az account show ]

	## Resource groups and template deployments
	$az.group = @{};
	$az.group.desc = 'Resource Groups & Template Deployments';
	$az.group.exit_code = 1;
	$az.group.name = (($az.epithet) + ("-resource-group"));
	$az.group.location = "East US";
	$az.group.create = @{};   ## Filled-in by:  [ az group create ... ]

	## App Service plans
	$az.appservice = @{};
	$az.appservice.desc = 'App Service Plan';
	$az.appservice.exit_code = 1;
	$az.appservice.plan = @{};
	$az.appservice.plan.name = (($az.epithet) + ("-appservice-plan"));
	$az.appservice.plan.resource_group = ($az.group.name);
	$az.appservice.plan.sku = "FREE";
	$az.appservice.plan.create = @{}; ## Filled-in by:  [ az appservice plan create ... ]

	## SQL Server
	$az.sqlserver = @{};
	
	## SQL Database
	$az.sqldb = @{};
	# $az.sqldb.adminuser = (((az keyvault secret show --subscription ("xxyyzz-sub") --vault-name ("xxyyzz-vault") --name ("xxyyzz-user"))	| ConvertFrom-Json).value);
	# $az.sqldb.adminpass = (((az keyvault secret show --subscription ("xxyyzz-sub") --vault-name ("xxyyzz-vault") --name ("xxyyzz-pass"))	| ConvertFrom-Json).value);

	## Web apps
	$az.webapp = @{};
	$az.webapp.desc = 'Web App';
	$az.webapp.exit_code = 1;
	$az.webapp.create = @{}; ## Filled-in by:  [ az webapp create ... ]
	$az.webapp.resource_group = ($az.group.name);
	$az.webapp.plan = ($az.appservice.plan.name);
	$az.webapp.name = ($az.epithet);
	$az.webapp.url = (("https://") + ($az.webapp.name) + (".azurewebsites.net"));
	$az.webapp.service = @{};
	$az.webapp.service.swagger = (($az.webapp.url) + ("/swagger"));
	$az.webapp.api = @{};
	$az.webapp.api.swagger = (($az.webapp.url) + ("/swagger/v1/swagger.json"));
	$az.webapp.api.todo = (($az.webapp.url) + ("/api/todo"));

	## Web app deployments (backend user credentials/token)
	$az.webapp.deployment = @{};
	$az.webapp.deployment.desc = "Git Deployment Credentials";
	$az.webapp.deployment.exit_code = 1;
	$az.webapp.deployment.user = @{};  ## Filled-in by:  [ az webapp deployment user ... ]
	$az.webapp.deployment.user_name = (("bnl-")+(([Convert]::ToBase64String([System.Text.Encoding]::Unicode.GetBytes((Get-Random -SetSeed (Get-Random))))).Substring(0,20)));
	# Wait for a random amount of time so that we increase the millisecond gap between user & password string-generation (expert mode guessing)
	Start-Sleep -Milliseconds (Get-Random -Minimum (Get-Random -Minimum 50 -Maximum 499) -Maximum (Get-Random -Minimum 500 -Maximum 949));
	$az.webapp.deployment.user_pass = ((([Convert]::ToBase64String([System.Text.Encoding]::Unicode.GetBytes(("PASS!")+(Get-Random -SetSeed (Get-Random))))).Substring(0,20))+("aA1!"));

	# ------------------------------------------------------------- #

	#  Get current subscription info, etc.
	$CommandDescription = "Requesting current session's Azure Subscription-Info";
	Write-Host (("`n ")+($CommandDescription)+("...`n"));

	$az.account.show = `
		az account show `
		| ConvertFrom-Json;
	
	$az.account.exit_code = If($?){0}Else{1};

	If ($az.account.exit_code -ne 0) {

		# If the account details throws an error for the first time, then request Azure user-credentials to be entered
		$CommandDescription = (("Performing ")+($az.login_desc));
		Write-Host (("`n ")+($CommandDescription)+("...`n"));

		$az.login = `
			az login `
			| ConvertFrom-Json;
		$az.login_error = $?;

		# Bomb-out on errors
		BombOut `
			-ExitCode ($az.login_error) `
			-MessageOnError (('Error thrown while [')+($CommandDescription)+(']')) `
			-MessageOnSuccessJSON ($az.account.show);

		# Re-acquire Subscription info
		$CommandDescription = "Requesting current session's Azure Subscription-Info";
		Write-Host (("`n ")+($CommandDescription)+("...`n"));
		$az.account.show = `
			az account show `
			| ConvertFrom-Json;
		$az.account.exit_code = If($?){0}Else{1};

	}

	# Bomb-out on errors
	BombOut `
		-ExitCode ($az.account.exit_code) `
		-MessageOnError (('Error thrown while [')+($CommandDescription)+(']')) `
		-MessageOnSuccessJSON ($az.account.show);

	# ------------------------------------------------------------- #

	$az.account.list = `
		az account list `
		| ConvertFrom-Json;

	# ------------------------------------------------------------- #

	#  Add credentials for local git deployment of Azure Web Apps (similar to GitHub's "Deploy Keys")
	#     Microsoft Docs, "az webapp deployment user" [ https://docs.microsoft.com/en-us/cli/azure/webapp/deployment/user?view=azure-cli-latest ]
	$CommandDescription = (("Creating ")+($az.webapp.deployment.desc));
	Write-Host (("`n ")+($CommandDescription)+("...`n"));

	$az.webapp.deployment.user = `
	az webapp deployment user set `
		--user-name ($az.webapp.deployment.user_name) `
		--password ($az.webapp.deployment.user_pass) `
		| ConvertFrom-Json;
	$az.webapp.deployment.exit_code = If($?){0}Else{1};

	# Bomb-out on errors
	BombOut `
		-ExitCode ($az.webapp.deployment.exit_code) `
		-MessageOnError (('Error thrown while [')+($CommandDescription)+(']')) `
		-MessageOnSuccessJSON ($az.webapp.deployment.user);

	# ------------------------------------------------------------- #

	# Create a new resource group
	$CommandDescription = (("Creating ")+($az.group.desc));
	Write-Host (("`n ")+($CommandDescription)+("...`n"));

	$az.group.create = `
	az group create `
		--name ($az.group.name) `
		--location ($az.group.location) `
	| ConvertFrom-Json;
	$az.group.exit_code = If($?){0}Else{1};

	$json_returned = Az_CreateSqlDb -ServerName "XYZ" -ResourceGroup "bis-sandbox-rg";

	$servername = "xxyyzz";
	$resourcegroup = "bis-sandbox-rg";

	$testsql = `
	az sql db `
		--server $servername `
		--resource-group $resourcegroup `
		| ConvertFrom-Json;
	$exitcode = If($?){0}Else{1};

	# Bomb-out on errors
	BombOut `
		-ExitCode ($az.group.exit_code) `
		-MessageOnError (('Error thrown while [')+($CommandDescription)+(']')) `
		-MessageOnSuccessJSON ($az.group.create);



	# ------------------------------------------------------------- #

	# Create an App Service plan
	$CommandDescription = (("Creating ")+($az.appservice.desc));
	Write-Host (("`n ")+($CommandDescription)+("...`n"));

	$az.appservice.plan.create = `
	az appservice plan create `
		--resource-group ($az.appservice.plan.resource_group) `
		--name ($az.appservice.plan.name) `
		--sku ($az.appservice.plan.sku) `
		| ConvertFrom-Json;
	$az.appservice.exit_code = If($?){0}Else{1};

	# Bomb-out on errors
	BombOut `
		-ExitCode ($az.appservice.exit_code) `
		-MessageOnError (('Error thrown while [')+($CommandDescription)+(']')) `
		-MessageOnSuccessJSON ($az.appservice.plan.create);



	# ------------------------------------------------------------- #

	# Create a web app
	$CommandDescription = (("Creating ")+($az.webapp.desc));
	Write-Host (("`n ")+($CommandDescription)+("...`n"));

	$az.webapp.create = `
	az webapp create `
		--resource-group ($az.webapp.resource_group) `
		--plan ($az.webapp.plan) `
		--name ($az.webapp.name) `
		--deployment-local-git `
		| ConvertFrom-Json;
	$az.webapp.exit_code = If($?){0}Else{1};

	# Bomb-out on errors
	BombOut `
		-ExitCode ($az.webapp.exit_code) `
		-MessageOnError (('Error thrown while [')+($CommandDescription)+(']')) `
		-MessageOnSuccessJSON ($az.webapp.create);



	# ------------------------------------------------------------- #

	# Prepare the Schema for the Sample .NET Core Git-Repo
	$git = @{};

	# Git-Schema - Local
	$git.local = @{};
	$git.local._parent_dir = (($Home)+("/git"));
	$git.local.description = "Sample Web App - .NET Core";
	$git.local.url = "https://github.com/Azure-Samples/dotnet-core-api";
	$git.local.name = [System.IO.Path]::GetFileNameWithoutExtension($git.local.url);
	$git.local.work_tree = (($git.local._parent_dir)+("/")+($git.local.name));
	$git.local.dot_git = (($git.local.work_tree)+("/")+(".git"));
	$git.local.services = @{};
	$git.local.services.swagger = "http://localhost:5000/swagger";

	# Git-Schema - Remote
	$git.remote = @{};
	$git.remote.origin = @{};
	$git.remote.origin.url = ($az.webapp.create.deploymentLocalGitUrl);
	$git.remote.origin.name = [System.IO.Path]::GetFileNameWithoutExtension($git.remote.origin.url);
	$git.remote.origin.description = (("azure_") + ($git.remote.origin.name) + (Get-Date ((Get-Date).ToUniversalTime()) -UFormat "%Y%m%d%H%M%S"));
	$git.remote.origin.trunk_name = "master";
	
	# Insert Password into Git Push-URL using the credentials previously created (specfically for Git)
	($git.remote.origin.url_start), ($git.remote.origin.url_end) = ($git.remote.origin.url).split("@");
	$git.remote.origin.git_push_url = (($git.remote.origin.url_start) + (":") + ($az.webapp.deployment.user_pass) + ("@") + ($git.remote.origin.url_end));

	# Make sure the parent directory to the sample git-repo exists
	if (!(Test-Path -Path ($git.local._parent_dir))) {
		Write-Host (("`n Task - Creating parent directory to the sample git-repo: ")+($git.local._parent_dir));
		New-Item -ItemType "Directory" -Path (($git.local._parent_dir)+("/")) | Out-Null;
	}

	# Clone the sample git-repo
	Set-Location -Path ($git.local._parent_dir);

	GitCloneRepo -Url "https://github.com/Azure-Samples/dotnet-core-api";
	
	# Install .NET packages required by the git-repo

	Set-Location -Path ($git.local.work_tree);

	Write-Host ("`n Updating application dependencies via [ dotnet restore ]");

	dotnet restore;

	# Determine if we want to run a local server (or continue with Azure cloud-based spin-up)
	If ($PSBoundParameters.ContainsKey('RunLocalServer')) {

		# Navigate to the Swagger service, which should now be running locally
		$Revertable_ErrorActionPreference = $ErrorActionPreference;
		$ErrorActionPreference = 'SilentlyContinue';

		$PowerShell_SourceExe = (Get-Command -Name powershell.exe).Source;

		# Run a secondary powershell instance temporarily (so we can still use the first)
		Write-Host (("`n`n`n  Spinning-Up server:   ") + ($git.local.services.swagger) + ("`n`n`n"));

		Start "${PowerShell_SourceExe}" "Set-Location -Path '$pwd'; dotnet run;";

		$ErrorActionPreference = $Revertable_ErrorActionPreference;

		# Wait for Swagger to be reponsive
		While (((Invoke-WebRequest -UseBasicParsing -Method HEAD -Uri ($git.local.services.swagger)).StatusCode) -ne (200)) {
			Start-Sleep -Milliseconds 500;
		}

		Write-Host (("`n`n`n  Server is now responsive:   ") + ($git.local.services.swagger) + ("`n`n`n"));

		# Open Swagger once-responsive
		Start ($git.local.services.swagger);
		
	}



	# ------------------------------------------------------------- #

	# Push the sample code (above) to the newly created git-repo

	Set-Location -Path ($git.local.work_tree);

	# Adding the newly created git-repo as a secondary remote/origin for the sample code (locally)
	
	git remote add ($git.remote.origin.description) ($git.remote.origin.git_push_url);

	# Push the sample-code to the new git-repo to instantiate the master branch & deploy the web-app as a service

	$CommandDescription = (("Deploying ")+($az.webapp.desc));

	Write-Host (("`n ")+($CommandDescription)+("...`n"));

	git push ($git.remote.origin.description) ($git.remote.origin.trunk_name);

	# Delete [ locally saved git repository ]
	# Delete .....

	# ------------------------------------------------------------- #

	# Closer Message
	BombOut `
		-ExitCode 0 `
		-MessageOnSuccess ("Runtime Complete, connecting to remote app-service(s) via local web-browser");

	# Azure Portal URL(s) - Resource Group(s), etc.
	$azure_group_portal_direct_url = (('https://portal.azure.com/#@programmersboneal.onmicrosoft.com/resource')+($az.group.create.id)+('/overview'));
	Write-Host (("`n Opening [ ") + ($azure_group_portal_direct_url) + (" ] in local web-browser...")); Start ($azure_group_portal_direct_url);
	Write-Host (("`n Opening [ ") + ($statics.url.services.azure.portal) + (" ] in local web-browser...")); Start ($statics.url.services.azure.portal);

	# API Service URL(s) - Swagger, etc.
	# if ($skip_frontend_demo_of_backend_apis -eq $false) {
	# 	Write-Host (("`n Opening [ ") + ($az.webapp.api.swagger) + (" ] in local web-browser...")); Start ($az.webapp.api.swagger);
	# 	Write-Host (("`n Opening [ ") + ($az.webapp.api.todo) + (" ] in local web-browser...")); Start ($az.webapp.api.todo);
	# }
	Write-Host (("`n Opening [ ") + ($az.webapp.service.swagger) + (" ] in local web-browser...")); Start ($az.webapp.service.swagger);

	# Exit Message
	BombOut `
		-ExitCode 1 `
		-MessageOnError ("Runtime Complete");

	# ------------------------------------------------------------- #

}

Export-ModuleMember -Function "Az_Tutorial";
