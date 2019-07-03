
#
# Windows Task Scheduler
#  |--> Trigger any time a local network connection reports the "Connected" (10000) status



# ------------------------------------------------------------
# TRIGGER LOGIC:
#
#			Begin the task:  On an Event
#
#			           Log:  Microsoft-Windows-NetworkProfile/Operational
#			        Source:  NetworkProfile
#			      Event ID:  10000
#
#			Delay task for:  20 Seconds
#
# ------------------------------------------------------------


