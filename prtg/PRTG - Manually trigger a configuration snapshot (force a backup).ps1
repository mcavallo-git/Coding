# ------------------------------------------------------------
# PRTG - Manually trigger a configuration snapshot (force a backup)
# ------------------------------------------------------------
#
# Browser GUI - Create new snapshot
#  |
#  |--> Replace "<your-prtg-server>" with your PRTG server's hostname/FQDN
#

"You can manually trigger a backup of your configuration under Setup >> System Administration >> Administrative Tools >> Create Configuration Snapshot or via the following API call"


# ------------------------------------------------------------
#
# API Call - Create new snapshot
#  |
#  |--> Replace "<your-prtg-server>" with your PRTG server's hostname/FQDN
#

http://<your-prtg-server>/api/savenow.htm?username=<admin username>&passhash=<admin passhash>


# ------------------------------
#
# Output - Snapshots are saved to:
#

%ProgramData%\Paessler\PRTG Network Monitor\Configuration Auto-Backups


# ------------------------------
#
# Note (from Paessler):
#  "By default, PRTG always performs the backup at 3:08am. In case you need more frequent snapshots of the configuration due to a lot of changes made throughout the day. Proceed with the following steps in order to create multiple snapshots per day."
#
# ------------------------------------------------------------
#
# Citation(s)
#
#   kb.paessler.com  |  "Is there a way to schedule PRTG backups? | Paessler Knowledge Base"  |  https://kb.paessler.com/en/topic/59619-is-there-a-way-to-schedule-prtg-backups
#
#   kb.paessler.com  |  "Restore Map | Paessler Knowledge Base"  |  https://kb.paessler.com/en/topic/44833-restore-map#reply-301803
#
# ------------------------------------------------------------