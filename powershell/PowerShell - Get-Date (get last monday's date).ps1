#
# Note:
#
# Phrases such as "this Monday" become muddled & hard to identify when "today" is a Saturday/Sunday (weekend day).
#
# For example's sake, let's say today is Saturday - From the Saturday perspective, saying "this Monday" could equally refer to the next Monday OR the previous Monday, which, respectively, is 2 days in the future vs. 5 days in the past.
#
# The weekend prevents simple arithmetic such as "2 days is less than 5 so 'this Monday' must refer to the next Monday" from being correct, as Saturday appears much closer to the previous week's row-of-days on a paper calendar (lending to "this" referring to "previous" - keeping both Mondays plausibly in the picture).
#
# The outcome: The date of "this Monday" ends up referring to a date in the future while also simultaneously referring to a date in the past - Monday has now become a paradox. Monday must be resolved.
#
# This is where the English phrases "this last Monday" and "this upcoming Monday" neatly iron-out the confusion and restore polite, colloquial conversation to a level far from paradoxical Mondays.
#
# (Should the week begin on Saturday on paper calendars?)
#

$GetDate_LastMonday = (Get-Date 0:0).AddDays(1 + ([Int](Get-Date).DayOfWeek * -1));
$LastMondaysDate = (Get-Date 0:0).AddDays(1 + ([Int](Get-Date).DayOfWeek * -1));

Write-Host (Get-Date $LastMondaysDate -UFormat "%Y-%m-%d");

#
# Citation(s)
#		
#		Thanks to StackOverflow user [ Jan ] on forum [ https://stackoverflow.com/questions/21665362 ]
#
