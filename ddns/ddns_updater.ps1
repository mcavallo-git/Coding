
If (Test-Path ((${Home})+('\.ddns\secret'))) { [System.Net.WebRequest]::Create([System.Text.Encoding]::Unicode.GetString([System.Convert]::FromBase64String((Get-Content((${Home})+('\.ddns\secret')))))).GetResponse(); };


If ($False) {

	<# If running as a scheduled-task #>

	powershell.exe -Command "If (Test-Path ((${Home})+('\.ddns\secret'))) { [System.Net.WebRequest]::Create([System.Text.Encoding]::Unicode.GetString([System.Convert]::FromBase64String((Get-Content((${Home})+('\.ddns\secret')))))).GetResponse(); }; Exit 0;";

}
