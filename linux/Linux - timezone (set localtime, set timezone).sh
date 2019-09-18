		
## SET "localtime" & "timezone" to EST (test with date):

	## Ubuntu && Cent-OS
TZ="America/New_York" && \
ln -snf "/usr/share/zoneinfo/$TZ" "/etc/localtime" && \
echo $TZ > "/etc/timezone";

	## Alpine-Linux
# TZ="UTC+4";
# ln -snf "/usr/share/zoneinfo/$TZ" "/etc/localtime";
# echo $TZ > "/etc/TZ";

