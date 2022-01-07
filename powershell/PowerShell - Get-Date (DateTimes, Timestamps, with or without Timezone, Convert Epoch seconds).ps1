# ------------------------------------------------------------
# 
# PowerShell - Get-Date (Timestamps, with or without Timezone)
# 
# ------------------------------------------------------------
#
# Note --> Example-date used in emails:
#   Wed, 23 Sep 2020 14:06:25 -0700 (PDT)
#
# ------------------------------------------------------------


# Timestamp_Filename               20210505T171718
$(Get-Date -Format 'yyyyMMddTHHmmss')

# Timestamp_Filename_TZ            20210505T171718-04
$(Get-Date -Format 'yyyyMMddTHHmmsszz')

# Timestamp_Filename_ms            20210505T171718.066
$(Get-Date -Format 'yyyyMMddTHHmmss.fff')

# Timestamp_Filename_μs            20210505T171718.066992
$(Get-Date -Format 'yyyyMMddTHHmmss.ffffff')

# Timestamp_Filename_ms_TZ         20210505T171718.066-04
$(Get-Date -Format 'yyyyMMddTHHmmss.fffzz')

# Timestamp_Filename_μs_TZ         20210505T171718.066992-04            <# BEST FOR FILENAMES #>
$(Get-Date -Format 'yyyyMMddTHHmmss.ffffffzz')

# Timestamp_Short                  20210505171718
$(Get-Date -Format 'yyyyMMddHHmmss')

# Timestamp_Short_TZ               20210505171718-04
$(Get-Date -Format 'yyyyMMddHHmmsszz')

# Timestamp_RFC3339                2021-05-05T05:17:18-04:00
$(Get-Date -Format 'yyyy-MM-ddTHH:mm:sszzz')

# Timestamp_RFC3339_ms             2021-05-05T05:17:18.066-04:00      <# BEST FOR LOG OUTPUTS #>
$(Get-Date -Format 'yyyy-MM-ddTHH:mm:ss.fffzzz')

# Timestamp_RFC3339_μs             2021-05-05T05:17:18.066992-04:00
$(Get-Date -Format 'yyyy-MM-ddTHH:mm:ss.ffffffzzz')

# Timestamp_RFC3339_MaxPrecision   2021-05-05T05:17:18.0674926-04:00
$(Get-Date -Format 'yyyy-MM-ddTHH:mm:ss.fffffffzzz')


# ------------------------------------------------------------

$TzOffset_WithColon = ((Get-Date -UFormat ('%Z'))+(([String](Get-TimeZone).BaseUtcOffset) -replace "^([-+]?)(\d+):(\d+):(\d+)$",':$3'));
$TzOffset_NoColon = ((Get-Date -UFormat ('%Z'))+(([String](Get-TimeZone).BaseUtcOffset) -replace "^([-+]?)(\d+):(\d+):(\d+)$",'$3'));

# Timestamp, Filename-compatible w/ decimal-seconds
If ($True) {

	$EpochDate = ([Decimal](Get-Date -UFormat ("%s")));

	$EpochToDateTime = (New-Object -Type DateTime -ArgumentList 1970,1,1,0,0,0,0).AddSeconds([Math]::Floor($EpochDate));

	$TimestampLong = (Get-Date -Date ("${EpochToDateTime}") -UFormat ("%Y-%m-%d_%H-%M-%S"));
	$TimestampShort = (Get-Date -Date ("${EpochToDateTime}") -UFormat ("%Y%m%d-%H%M%S"));

	$DecimalTimestampLong = ( (Get-Date -Date ("${EpochToDateTime}") -UFormat ("%Y-%m-%d_%H-%M-%S")) + (([String]((${EpochDate}%1))).Substring(1).PadRight(6,"0")) );
	$DecimalTimestampShort = ( (Get-Date -Date ("${EpochToDateTime}") -UFormat ("%Y%m%d-%H%M%S")) + (([String]((${EpochDate}%1))).Substring(1).PadRight(6,"0")) );

	Write-Host "`n`n";
	Write-Host "`$EpochDate = [ ${EpochDate} ]";
	Write-Host "";
	Write-Host "`$EpochToDateTime = [ ${EpochToDateTime} ]";
	Write-Host "";
	Write-Host "`$TimestampLong = [ ${TimestampLong} ]";
	Write-Host "`$DecimalTimestampLong = [ ${DecimalTimestampLong} ]";
	Write-Host "";
	Write-Host "`$TimestampShort = [ ${TimestampShort} ]";
	Write-Host "`$DecimalTimestampShort = [ ${DecimalTimestampShort} ]";
	Write-Host "`n`n";

}


# Example filename usage
$NewDesktopDir = "${Home}\Desktop\New Folder_$(Get-Date -UFormat '%Y%m%d-%H%M%S')"; New-Item -ItemType "Directory" -Path ("${NewDesktopDir}") | Out-Null;


# ------------------------------------------------------------

#
# Method 1 of obtaining (milli-/micro-) seconds past the decimal
#
$DecimalSec_Split = [Decimal]"0.$($(Get-Date -UFormat ('%s')).Split('.')[1].Trim())";


#
# Method 2 of obtaining (milli-/micro-) seconds past the decimal
#
$DecimalSec_Mod = (([Decimal](Get-Date -UFormat ('%s')))%1);
$DecimalSec_Mod_Padded = "$(([Decimal](Get-Date -UFormat ('%s')))%1)".Substring(2).PadRight(5,'0');


# ------------------------------------------------------------
#
# Timezone Conversion
#

If ($True) {

# Example: Convert a timestamp from UTC to device's current timezone
$TZ_Source = [System.TimeZoneInfo]::GetSystemTimeZones() | Where-Object { $_.Id -Eq "UTC" };
$TZ_Destination = [System.TimeZoneInfo]::GetSystemTimeZones() |  Where-Object { $_.Id -Eq "$((Get-TimeZone).Id)" };

# $Timestamp_Source = '2018-12-25T00:00:00';
$Timestamp_Source = 'Aug 1, 2020, 4:06:27 AM';
$Timestamp_Source = [System.TimeZoneInfo]::ConvertTime($Timestamp_Source, $TZ_Source, $TZ_Source);
$Timestamp_Destination = [System.TimeZoneInfo]::ConvertTime($Timestamp_Source, $TZ_Source, $TZ_Destination);

Write-Host "";
Write-Host "`$TZ_Source = `"${TZ_Source}`"";
Write-Host "`$TZ_Destination = `"${TZ_Destination}`"";
Write-Host "";
Write-Host "`$Timestamp_Source = `"${Timestamp_Source}`"";
Write-Host "`$Timestamp_Destination = `"${Timestamp_Destination}`"";
Write-Host "";

}


# ------------------------------------------------------------
# Relative DateTime Queries (Common English Statements)
#   |
#   |--> Phrases such as "this Monday" become muddled & hard to identify when "today" is a Saturday/Sunday (weekend day).             For example's sake, let's say today is Saturday - From the Saturday perspective, saying "this Monday" could equally refer to the next Monday OR the previous Monday, which, respectively, is 2 days in the future vs. 5 days in the past.             The weekend prevents simple arithmetic such as "2 days is less than 5 so 'this Monday' must refer to the next Monday" from being correct, as Saturday appears much closer to the previous week's row-of-days on a paper calendar (lending to "this" referring to "previous" - keeping both Mondays plausibly in the picture).             The outcome: The date of "this Monday" ends up referring to a date in the future while also simultaneously referring to a date in the past - Monday has now become a paradox. Monday must be resolved.             This is where the English phrases "this last Monday" and "this upcoming Monday" neatly iron-out the confusion and restore polite, colloquial conversation to a level far from paradoxical Mondays.             (Should the week begin on Saturday on paper calendars?)
# 

$GetDate_LastMonday = (Get-Date 0:0).AddDays(1 + ([Int](Get-Date).DayOfWeek * -1));
$LastMondaysDate = (Get-Date 0:0).AddDays(1 + ([Int](Get-Date).DayOfWeek * -1));

Write-Host (Get-Date $LastMondaysDate -UFormat "%Y-%m-%d");


# ------------------------------------------------------------
# 
# Set file "Date Created" and "Last Modified" datetime/timestamp(s)
#
If ($True) {
	$Filepath_UpdateTimestamps = "${Home}\Desktop\file-created-01-Jan-1990.txt";
	Set-Content -Path ("${Filepath_UpdateTimestamps}") -Value ("");
	$Updated_CreationTime = (New-Object -Type DateTime -ArgumentList 1990, 1, 1, 0, 1, 1, 1);
	(Get-Item "${Filepath_UpdateTimestamps}").CreationTime = ($Updated_CreationTime);
	(Get-Item "${Filepath_UpdateTimestamps}").LastWriteTime = ($Updated_CreationTime);
	explorer.exe "$([IO.Path]::GetDirectoryName("${Filepath_UpdateTimestamps}"))";
}


# ------------------------------------------------------------
#
#	CMD/Batch-File:
#
#		@ECHO OFF
#		
#		SET HoursElapsed=8.5
#		
#		REM Note: Uses Powershell's Get-Date (See citations, below for docs)
#		
#		REM Get the Day-of-Week (Monday, Tuesday, etc.)
#		FOR /f "delims=" %%G IN ('powershell "(Get-Date %time% -UFormat %%A);"') DO SET DayOfWeek_Current=%%G
#		
#		REM Get the Current Time
#		FOR /f "delims=" %%G IN ('powershell "(Get-Date %time% -UFormat %%I:%%M:%%S);"') DO SET DateTime_Current=%%G
#		FOR /f "delims=" %%G IN ('powershell "(Get-Date %time% -UFormat %%p);"') DO SET AM_PM_Current=%%G
#		
#		REM Get the Day-of-Week after (%HoursElapsed%) Hours have elapsed
#		FOR /f "delims=" %%G IN ('powershell "((Get-Date %time%).AddHours(%HoursElapsed%) | Get-Date -UFormat %%A);"') DO SET DayOfWeek_Elapsed=%%G
#		REM Get the Time after (%HoursElapsed%) Hours have elapsed
#		FOR /f "delims=" %%G IN ('powershell "((Get-Date %time%).AddHours(%HoursElapsed%) | Get-Date -UFormat %%I:%%M:%%S);"') DO SET DateTime_Elapsed=%%G
#		FOR /f "delims=" %%G IN ('powershell "((Get-Date %time%).AddHours(%HoursElapsed%) | Get-Date -UFormat %%p);"') DO SET AM_PM_Elapsed=%%G
#		
#		ECHO.
#		ECHO   Datetime currently is:   %DayOfWeek_Current% @ %DateTime_Current% %AM_PM_Current%
#		ECHO   Datetime after [ %HoursElapsed% ] hours have elapsed:   %DayOfWeek_Elapsed% @ %DateTime_Elapsed% %AM_PM_Elapsed%
#		ECHO.
#		
#		REM Debugging Timeout (to view output while testing)
#		TIMEOUT -T 30
#		
#		EXIT
# 
# 
# ------------------------------------------------------------
#
# Citation(s)
#
#		devblogs.microsoft.com  |  "PowerTip: Remove First Two Letters of String | Scripting Blog"  |  https://devblogs.microsoft.com/scripting/powertip-remove-first-two-letters-of-string/
#
#		docs.microsoft.com  |  "Custom date and time format strings | Microsoft Docs"  |  https://docs.microsoft.com/en-us/dotnet/standard/base-types/custom-date-and-time-format-strings?view=netframework-4.8
#
#		docs.microsoft.com  |  "Get-Date - Gets the current date and time"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/get-date
#
#		docs.microsoft.com  |  "Math.Floor Method (System) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/dotnet/api/system.math.floor
#
#		docs.microsoft.com  |  "String.PadRight Method (System) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/dotnet/api/system.string.padright
#
#		stackoverflow.com  |  "Midnight last Monday in Powershell"  |  https://stackoverflow.com/a/42578179
#
#		stackoverflow.com  |  "Powershell - Round down to nearest whole number - Stack Overflow"  |  https://stackoverflow.com/a/5864061
#
#		www.craigforrester.com  |  "Convert Times Between Time Zones with PowerShell"  |  https://www.craigforrester.com/posts/convert-times-between-time-zones-with-powershell/
#
# ------------------------------------------------------------