
ForEach ($EachDir In ((Get-ChildItem -Directory -Name -Path ($Home) -Include ("Do*")).GetEnumerator())) {
	Write-Host $EachDir;
}
