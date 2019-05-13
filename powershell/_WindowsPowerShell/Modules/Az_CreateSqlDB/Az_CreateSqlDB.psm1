#
#	Example Call:
#
#		Az_CreateSqlDb `
#			-SubscriptionID ("xyz") `
#			-ResourceGroup ("xyz") `
#			-Epithet ("xyz");
#
function Az_CreateSqlDB {
	Param(

		[Parameter(Mandatory=$true)]
		[String]$SubscriptionID	= "",

		[Parameter(Mandatory=$true)]
		[String]$ResourceGroup = "",

		[ValidateSet(10,20,50,100,200,400,800,1600,3000)]
		[Int]$Capacity = 10,

		[ValidateSet('Basic','Standard','Premium','GeneralPurpose','BusinessCritical')]
		[String]$Edition = "Standard",

		[String]$Location	= "eastus",
		
		[String]$MaxSize = "250G",

		[String]$Epithet = (("bis-") + (Get-Date ((Get-Date).ToUniversalTime()) -UFormat "%Y%m%d%H%M%S")),	
		
		[String]$KeyVault_Sql = "bis-static-keyvault",
		[String]$SecretName_SqlUser = "sql-adminuser",
		[String]$SecretName_SqlPass = "sql-adminpass",

		[String]$KeyVault_Git = "bis-static-keyvault",
		[String]$SecretName_GitUser = "git-pull-user",
		[String]$SecretName_GitPass = "git-pull-token",
		[String]$SecretName_GitUrlHttps = "git-pull-url-https",
		[String]$SecretName_GitUrlSsh = "git-pull-url-ssh",
		[String]$SecretName_GitBranchName = "git-pull-branch"

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

	$az.server = @{};
	$az.server.firewall = @{};
	$az.server.fqdn = (($az.epithet) + (".database.windows.net"));
	$az.server.location = $Location;
	$az.server.name = (($az.epithet) + ("-sqlserver"));
	$az.server.type = "Microsoft.Sql/servers";

	# ------------------------------------------------------------- #
	#	Create SQL Server
	#
	$CommandDescription = (("Creating SQL Server `"")+($az.server.name)+("`""));
	Write-Host (("`n")+($CommandDescription)+(".....`n"));

	# Create an SQL Server
	#		https://docs.microsoft.com/en-us/cli/azure/sql/server?view=azure-cli-latest#az-sql-server-create
	#
	$az.server.create = `
	az sql server create `
	--admin-user (((az keyvault secret show --subscription ($SubscriptionID) --vault-name ($KeyVault_Sql) --name ($SecretName_SqlUser)) | ConvertFrom-Json).value) `
	--admin-password (((az keyvault secret show --subscription ($SubscriptionID) --vault-name ($KeyVault_Sql) --name ($SecretName_SqlPass)) | ConvertFrom-Json).value) `
	--location $az.server.location `
	--name $az.server.name `
	--resource-group $ResourceGroup `
	--subscription $SubscriptionID `
	| ConvertFrom-Json;
	$az.server.exit_code = If($?){0}Else{1};

	BombOut `
	-ExitCode ($az.server.exit_code) `
	-MessageOnError (('Error thrown while [')+($CommandDescription)+(']')) `
	-MessageOnSuccessJSON ($az.server.create); 

	# ------------------------------------------------------------- #
	#		Create a firewall rule (SQL Server)
	#
	#		az sql server firewall-rule create ...
	#			--> https://docs.microsoft.com/en-us/cli/azure/sql/server/firewall-rule#az-sql-server-firewall-rule-create
	#
	
	# Allow access to Azure services

	$CommandDescription = ("Configuring SQL Server Firewall for `"")+($az.server.name)+("`" - Allowing access to Azure services");
	Write-Host (("`nTask - ")+($CommandDescription)+("...`n"));
	
	$az.server.firewall.allow_azure_services = `
	JsonDecoder -InputObject (`
		az sql server firewall-rule create `
			--subscription ($SubscriptionID) `
			--resource-group ($ResourceGroup) `
			--server ($az.server.name) `
			--name ("Allow_AzureServices") `
			--start-ip-address 0.0.0.0 `
			--end-ip-address 0.0.0.0 `
	);
	$last_exit_code = If($?){0}Else{1};

	# Bomb-out on errors
	BombOut -NoAzLogout `
		-ExitCode ($last_exit_code) `
		-MessageOnError (('Fail - Error thrown while [')+($CommandDescription)+(']')) `
		-MessageOnSuccessJSON ($az.server.firewall.allow_azure_services);

	# ------------------------------------------------------------- #
	#
	# Create SQL Database

	if ((($MaxSize | Select-String "T").Matches.Value) -eq "T") {

			$maxSize_splitString = $MaxSize.split("T");
			$maxSize_inBytes = ([int]($maxSize_splitString[0]) * ([Math]::Pow(2,40)));			 # Max Size in TB

	} elseif ((($MaxSize | Select-String "M").Matches.Value) -eq "M") {

			$maxSize_splitString = $MaxSize.split("M");
			$maxSize_inBytes = ([int]($maxSize_splitString[0]) * ([Math]::Pow(2,20)));			 # Max Size in MB

	} else {
			# Default MaxSize ------> in GB				[$maxSize_inGB = (($MaxSize | Select-String "G").Matches.Value -eq "G")]
			$maxSize_splitString = $MaxSize.split("G");
			$maxSize_inBytes = ([int]($maxSize_splitString[0]) * ([Math]::Pow(2,30)));			 # Max Size in GB

	}
	
	$az.db = @{};
		$az.db.name = (($az.epithet) + ("-sqldb"));
		$az.db.server = $az.server.name;
		$az.db.capacity = $Capacity;
		$az.db.maxSize = $maxSize_inBytes;
		$az.db.location = $Location;
		$az.db.edition = $Edition;
		$CommandDescription = (("Creating SQL Database `"")+($az.db.name)+("`""));
		Write-Host (("`nTask - ")+($CommandDescription)+("...`n"));

	# Create a SQL Database
	#		https://docs.microsoft.com/en-us/cli/azure/sql/db?view=azure-cli-latest#az-sql-db-create
	#
	$az.db.create = `
	az sql db create `
		--name $az.db.name `
		--resource-group $ResourceGroup `
		--subscription $SubscriptionID `
		--server $az.db.server `
		--capacity $az.db.capacity `
		--max-size $az.db.maxSize `
		--edition $az.db.edition `
		| ConvertFrom-Json;
	$az.db.exit_code = If($?){0}Else{1};
	
	BombOut `
		-ExitCode ($az.db.exit_code) `
		-MessageOnError (('Error thrown while [')+($CommandDescription)+(']')) `
		-MessageOnSuccessJSON ($az.db.create);
	
	$rt = @{};
	$rt.server = $az.server.create;
	$rt.database = $az.db.create;

	Return $rt;

	# ------------------------------------------------------------- #
}

Export-ModuleMember -Function "Az_CreateSqlDB";
