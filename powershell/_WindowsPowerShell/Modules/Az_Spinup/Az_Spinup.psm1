
function Az_Spinup {
	Param(

		[Parameter(Mandatory=$true)]
		[String]$SubscriptionID,

		[Parameter(Mandatory=$true)]
		[String]$CompanyName,

		[Int]$ExitAfterSeconds = 600,

		[Switch]$RunLocalServer,
		
		[Switch]$Echo

	)

	# ------------------------------------------------------------- #

	##  Microsoft Documentation, "Tutorial: Host a RESTful API with CORS in Azure App Service"
	##     [ https://docs.microsoft.com/en-us/azure/app-service/app-service-web-tutorial-rest-api ]
	## 
	## 
	##  Note that you may perform these actions in Azure's "Cloud Shell" by:
	##    - Logging into [ https://portal.azure.com ]
	##    - Selecting the " >_ " icon (~top middle of screen)
	##    - If presented with [ Choose terminal: "Bash" or "PowerShell" ] (etc.), select "PowerShell"

	
	# ------------------------------------------------------------- #

	# Fail-out if any required modules are not found within the current scope
	$RequireModule="BombOut"; 
	if (!(Get-Module -ListAvailable -Name ($RequireModule))) {
		Write-Host (("`n`nRequired Module not found: `"")+($RequireModule)+("`"`n`n"));
		Exit 1;
	}
	
	## Requirements for server spinup
		
	BombOut `
	-ExitCode (&{If((!($PSBoundParameters.ContainsKey("CompanyName"))) -or (!(Test-Path Env:CompanyName))) {1} Else {0}});
	-MessageOnError ("Fail - Required variable `"SubscriptionID`" missing (not specified at start & no environment variable found to match)") `
	-MessageOnSuccess ("Pass - Valid Company Name Exists;");
	$CompanyName = If($PSBoundParameters.ContainsKey("CompanyName")) { $CompanyName } Else { $Env:CompanyName; }
	

	BombOut `
	-ExitCode (&{If((!($PSBoundParameters.ContainsKey("SubscriptionID"))) -or (!(Test-Path Env:CompanyName))) {1} Else {0}});
	-MessageOnError ("Fail - Required variable `"SubscriptionID`" missing (not specified at start & no environment variable found to match)") `
	-MessageOnSuccess ("Pass - Valid Company Name Exists;");
	$SubscriptionID = If($PSBoundParameters.ContainsKey("SubscriptionID")) { $SubscriptionID } Else { $Env:SubscriptionID; }

	# FORCE FAIL #
	BombOut `
	-ExitCode (1) `
	-MessageOnError ("FORCING FAIL");

	# ------------------------------------------------------------- #

	$url = @{};

	$url.downloads = @{};
	$url.downloads.git = ("https://git-scm.com/downloads");
	$url.downloads.dotnet_core = ("https://dotnet.microsoft.com/download/archives");

	$url.services = @{};
	$url.services.azure = @{};
	$url.services.azure.portal = 'https://portal.azure.com';

	$url.documentation = @{};
	$url.documentation.az_cli = ('https://docs.microsoft.com/en-us/cli/azure/reference-index?view=azure-cli-latest'); # General documentation on the "az" powershell command
	$url.documentation.dotnet_cli = ('https://docs.microsoft.com/en-us/dotnet/core'); # General documentation on the "dotnet" powershell command
	$url.documentation.this_script = ('https://docs.microsoft.com/en-us/azure/app-service/app-service-web-tutorial-rest-api'); # Guide that this script was based off-of
	$url.documentation.local_https = ('https://docs.microsoft.com/en-us/aspnet/core/getting-started/?view=aspnetcore-2.2&tabs=windows'); # Web-Apps w/ HTTPS on Localhost

	# ------------------------------------------------------------- #

	## git (Pre-Req)

	EnsureCommandExists -Name ("git") -OnErrorShowUrl ("https://git-scm.com/downloads");

	# $which = @{};

	# Write-Host ("`n Version-checking local install:  git  ");
	# $which.git = @{};
	# $which.git.version = [System.String]::Join(".", ((Get-Command "git").Version));
	# $which.git.exit_code = If($?){0}Else{1};

	# ## Git - Download/Install URL
	# if ($which.git.exit_code -ne 0) { Start ($url.downloads.git); }
	# $MessageOnError = (('Error - "git" command not found.   Please Download and Install Git from [ ')+($url.downloads.git)+(' ], then Re-Run this script'));
	# $MessageOnSuccess = (("Success!  Local runtime exists:  git v")+($which.git.version)+("`n"));
	# BombOut `
	# -ExitCode ($which.git.exit_code) `
	# -MessageOnError ($MessageOnError) `
	# -MessageOnSuccess ($MessageOnSuccess);


	# ------------------------------------------------------------- #

	## dotnet (Pre-Req)

	Write-Host ("`n Version-checking local install:  dotnet  ");
	$which.dotnet = @{};
	$which.dotnet.version = [System.String]::Join(".", ((Get-Command "dotnet").Version));;
	$which.dotnet.exit_code = If($?){0}Else{1};

	## dotnet (".NET Core SDK") - Download/Install URL
	if ($which.dotnet.exit_code -ne 0) { Start ($url.downloads.dotnet_core); }
	$MessageOnError = (('Error - "dotnet" command not found.   Please Download & Install .NET Core SDK from [ ')+($url.downloads.dotnet_core)+(' ], then Re-Run this script'));
	$MessageOnSuccess = (("Success!  Local runtime exists:  dotnet v")+($which.dotnet.version)+("`n"));
	BombOut `
	-ExitCode ($which.dotnet.exit_code) `
	-MessageOnError ($MessageOnError) `
	-MessageOnSuccess ($MessageOnSuccess);



	# ------------------------------------------------------------- #

	$az = @{};

	$az.epithet = (($CompanyName) + ("-") + (Get-Date -UFormat "%Y%m%d%H%M%S"));

	## Login to Azure via CLI
	$az.login = @{};  ## Filled-in by:  [ az login ]
	$az.login_desc = "User Authentication/Authorization";
	$az.login_error = $false;

	## Subscription Information
	$az.account = @{};
	$az.account.desc = 'Subscription Information';
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

	## Web apps
	$az.webapp = @{};
	$az.webapp.desc = 'Web App';
	$az.webapp.exit_code = 1;
	$az.webapp.create = @{}; ## Filled-in by:  [ az webapp create ... ]
	$az.webapp.resource_group = ($az.group.name);
	$az.webapp.plan = ($az.appservice.plan.name);
	$az.webapp.name = (($az.epithet) + ("-webapp"));
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
	$az.webapp.deployment.user_name = (("bnl-")+(([Convert]::ToBase64String([System.Text.Encoding]::Unicode.GetBytes((Get-Date -Format "FileDateTimeUniversal")))).Substring(0,20)));
	# Wait for a random amount of time so that we increase the millisecond gap between user & password string-generation (expert mode guessing)
	Start-Sleep -Milliseconds (Get-Random -Minimum (Get-Random -Minimum 50 -Maximum 499) -Maximum (Get-Random -Minimum 500 -Maximum 949));
	$az.webapp.deployment.user_pass = ((([Convert]::ToBase64String([System.Text.Encoding]::Unicode.GetBytes(("PASS!")+(Get-Date -Format "FileDateTimeUniversal")))).Substring(0,20))+("aA1!"));

	# ------------------------------------------------------------- #

	###--  Get current subscription info, etc.
	$command_description = (("Requesting ")+($az.account.desc));
	Write-Host (("`n ")+($command_description)+("...`n"));

	$az.account.show = az account show | ConvertFrom-Json;
	$az.account.exit_code = If($?){0}Else{1};

	if ($az.account.exit_code -ne 0) {

		# If the account details throws an error for the first time, then request Azure user-credentials to be entered
		$command_description = (("Performing ")+($az.login_desc));
		Write-Host (("`n ")+($command_description)+("...`n"));

		$az.login = az login | ConvertFrom-Json;
		$az.login_error = $?;

		# Bomb-out on errors
		BombOut `
		-ExitCode ($az.login_error) `
		-MessageOnError (('Error thrown while [')+($command_description)+(']')) `
		-MessageOnSuccessJSON ($az.account.show);

		# Re-acquire Subscription info
		$command_description = (("Requesting ")+($az.account.desc));
		Write-Host (("`n ")+($command_description)+("...`n"));

		$az.account.show = az account show | ConvertFrom-Json;
		$az.account.exit_code = If($?){0}Else{1};

	}

	# Bomb-out on errors
	BombOut `
	-ExitCode ($az.account.exit_code) `
	-MessageOnError (('Error thrown while [')+($command_description)+(']')) `
	-MessageOnSuccessJSON ($az.account.show);



	# ------------------------------------------------------------- #

	###--  Add credentials for local git deployment of Azure Web Apps (similar to GitHub's "Deploy Keys")
	###--     Microsoft Docs, "az webapp deployment user" [ https://docs.microsoft.com/en-us/cli/azure/webapp/deployment/user?view=azure-cli-latest ]
	$command_description = (("Creating ")+($az.webapp.deployment.desc));
	Write-Host (("`n ")+($command_description)+("...`n"));

	$az.webapp.deployment.user = `
	az webapp deployment user set `
	--user-name ($az.webapp.deployment.user_name) `
	--password ($az.webapp.deployment.user_pass) `
	| ConvertFrom-Json;
	$az.webapp.deployment.exit_code = If($?){0}Else{1};

	# Bomb-out on errors
	BombOut `
	-ExitCode ($az.webapp.deployment.exit_code) `
	-MessageOnError (('Error thrown while [')+($command_description)+(']')) `
	-MessageOnSuccessJSON ($az.webapp.deployment.user);



	# ------------------------------------------------------------- #

	###-- Create a new resource group
	$command_description = (("Creating ")+($az.group.desc));
	Write-Host (("`n ")+($command_description)+("...`n"));

	$az.group.create = `
	az group create `
	--name ($az.group.name) `
	--location ($az.group.location) `
	| ConvertFrom-Json;
	$az.group.exit_code = If($?){0}Else{1};

	# Bomb-out on errors
	BombOut `
	-ExitCode ($az.group.exit_code) `
	-MessageOnError (('Error thrown while [')+($command_description)+(']')) `
	-MessageOnSuccessJSON ($az.group.create);



	# ------------------------------------------------------------- #

	###-- Create an App Service plan
	$command_description = (("Creating ")+($az.appservice.desc));
	Write-Host (("`n ")+($command_description)+("...`n"));

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
	-MessageOnError (('Error thrown while [')+($command_description)+(']')) `
	-MessageOnSuccessJSON ($az.appservice.plan.create);



	# ------------------------------------------------------------- #

	###-- Create a web app
	$command_description = (("Creating ")+($az.webapp.desc));
	Write-Host (("`n ")+($command_description)+("...`n"));

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
	-MessageOnError (('Error thrown while [')+($command_description)+(']')) `
	-MessageOnSuccessJSON ($az.webapp.create);



	# ------------------------------------------------------------- #

	###-- Prepare the Schema for the Sample .NET Core Git-Repo
	$git = @{};

	# Git-Schema - Local
	$git.local = @{};
	$git.local._parent_dir = ((${Env:USERPROFILE})+("\Documents\GitHub"));
	$git.local.description = "Sample Web App - .NET Core";
	$git.local.url = "https://github.com/Azure-Samples/dotnet-core-api";
	$git.local.name = [io.path]::GetFileNameWithoutExtension($git.local.url);
	$git.local.work_tree = (($git.local._parent_dir)+("\")+($git.local.name));
	$git.local.dot_git = (($git.local.work_tree)+("\")+(".git"));
	$git.local.services = @{};
	$git.local.services.swagger = "http://localhost:5000/swagger";

	# Git-Schema - Remote
	$git.remote = @{};
	$git.remote.origin = @{};
	$git.remote.origin.url = ($az.webapp.create.deploymentLocalGitUrl);
	$git.remote.origin.name = [io.path]::GetFileNameWithoutExtension($git.remote.origin.url);
	$git.remote.origin.description = (("azure_") + ($git.remote.origin.name) + (Get-Date -UFormat "%Y%m%d%H%M%S"));
	$git.remote.origin.trunk_name = "master";
	# Insert Password into Git Push-URL using the credentials previously created (specfically for Git)
	($git.remote.origin.url_start), ($git.remote.origin.url_end) = ($git.remote.origin.url).split("@");
	$git.remote.origin.git_push_url = (($git.remote.origin.url_start) + (":") + ($az.webapp.deployment.user_pass) + ("@") + ($git.remote.origin.url_end));

	## Setup directory structure for the sample git-repo
	if (!(Test-Path -Path ($git.local.dot_git))) {

		### Parent Git-Directory
		if (!(Test-Path -Path ($git.local._parent_dir))) {
			Write-Host (("`n Sample git-repo's parent directory not found - creating [ ") + ($git.local._parent_dir) + (" ]..."));
			New-Item ($git.local._parent_dir) -ItemType "Directory";
		}

		### Base Git-Directory
		if (!(Test-Path -Path ($git.local.work_tree))) {
			Write-Host (("`n Sample git-repo's base directory not found - creating [ ") + ($git.local.work_tree) + (" ]..."));
			New-Item ($git.local.work_tree) -ItemType "Directory";
		}

		#### Clone the sample repo
		if (!(Test-Path -Path ($git.local.dot_git))) {
			Write-Host (("`n Sample git-repo's configuration directory not found: [ ")+($git.local.dot_git)+(" ] "));
			Write-Host (("Cloning sample git-repo [ ")+($git.local.url)+(" ] ... "));
			cd $git.local._parent_dir;
			git clone ($git.local.url);
		}
	}

	### Install .NET packages required by the git-repo
	cd ($git.local.work_tree);
	Write-Host ("`n Updating application dependencies via [ dotnet restore ]");
	dotnet restore;

	### Determine if we want to run a local server (or continue with Azure cloud-based spin-up)
	If ($PSBoundParameters.ContainsKey('RunLocalServer')) {

		### Navigate to the Swagger service, which should now be running locally
		$ErrorActionPreference = 'SilentlyContinue';
		$PowerShell_SourceExe = (Get-Command -Name powershell.exe).Source;

		### Run a secondary powershell instance temporarily (so we can still use the first)
		Write-Host (("`n`n`n  Spinning-Up server:   ") + ($git.local.services.swagger) + ("`n`n`n"));
		Start "${PowerShell_SourceExe}" "cd '$pwd'; dotnet run;";

		### Wait for Swagger to be reponsive
		while (((Invoke-WebRequest -UseBasicParsing -Method HEAD -Uri ($git.local.services.swagger)).StatusCode) -ne (200)) {
			Start-Sleep -Milliseconds 500;
		}
		Write-Host (("`n`n`n  Server is now responsive:   ") + ($git.local.services.swagger) + ("`n`n`n"));

		### Open Swagger once-responsive
		Start ($git.local.services.swagger);
	}



	# ------------------------------------------------------------- #

	###-- Push the sample code (above) to the newly created git-repo

	cd ($git.local.work_tree);

	### Adding the newly created git-repo as a secondary remote/origin for the sample code (locally)
	# git remote add ($git.remote.origin.description) ($git.remote.origin.url);
	git remote add ($git.remote.origin.description) ($git.remote.origin.git_push_url);

	### Push the sample-code to the new git-repo to instantiate the master branch & deploy the web-app as a service
	$command_description = (("Deploying ")+($az.webapp.desc));
	Write-Host (("`n ")+($command_description)+("...`n"));
	git push ($git.remote.origin.description) ($git.remote.origin.trunk_name);



	# ------------------------------------------------------------- #

	# Closer Message
	BombOut `
	-ExitCode 0 `
	-MessageOnSuccess ("Runtime Complete, connecting to remote app-service(s) via local web-browser");

	# Azure Portal URL(s) - Resource Group(s), etc.
	$azure_group_portal_direct_url = (('https://portal.azure.com/#@programmersboneal.onmicrosoft.com/resource')+($az.group.create.id)+('/overview'));
	Write-Host (("`n Opening [ ") + ($azure_group_portal_direct_url) + (" ] in local web-browser...")); Start ($azure_group_portal_direct_url);
	Write-Host (("`n Opening [ ") + ($url.services.azure.portal) + (" ] in local web-browser...")); Start ($url.services.azure.portal);

	# API Service URL(s) - Swagger, etc.
	# if ($skip_frontend_demo_of_backend_apis -eq $false) {
	# 	Write-Host (("`n Opening [ ") + ($az.webapp.api.swagger) + (" ] in local web-browser...")); Start ($az.webapp.api.swagger);
	# 	Write-Host (("`n Opening [ ") + ($az.webapp.api.todo) + (" ] in local web-browser...")); Start ($az.webapp.api.todo);
	# }
	Write-Host (("`n Opening [ ") + ($az.webapp.service.swagger) + (" ] in local web-browser...")); Start ($az.webapp.service.swagger);

	# Exit Message & Counter
	BombOut `
	-ExitCode 1 `
	-MessageOnError ("Runtime Complete");

	# ------------------------------------------------------------- #

}

Export-ModuleMember -Function "Az_Spinup";
