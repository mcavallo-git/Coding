
#
# Windows Task Scheduler
#  |--> Trigger any time a local network connection reports the "Connected" (10000) status

# ------------------------------------------------------------
#
#		Scheduled Task -> New Trigger
#
#			     Log:  Microsoft-Windows-NetworkProfile/Operational
#			  Source:  NetworkProfile
#			Event ID:  10000
#
# ------------------------------------------------------------