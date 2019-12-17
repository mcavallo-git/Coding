		
## SET "localtime" & "timezone" to EST (test with date):

	## Ubuntu && Cent-OS
TZ="America/Chicago" && \
ln -snf "/usr/share/zoneinfo/$TZ" "/etc/localtime" && \
echo $TZ > "/etc/timezone" && \
timedatectl set-timezone "${TZ}";

	## Alpine-Linux
# TZ="UTC+4";
# ln -snf "/usr/share/zoneinfo/$TZ" "/etc/localtime";
# echo $TZ > "/etc/TZ";

