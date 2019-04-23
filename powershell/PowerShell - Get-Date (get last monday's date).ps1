
$LastMondaysDate = (Get-Date (Get-Date 0:00).AddDays(-([int](Get-date).DayOfWeek)+1) -UFormat "%Y-%m-%d");
Write-Host $LastMondaysDate;

#
# Citation(s)
#		
#		Thanks to StackOverflow user [ Jan ] on forum [ https://stackoverflow.com/questions/21665362 ]
#
