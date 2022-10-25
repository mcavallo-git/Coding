# ------------------------------------------------------------
# PRTG - Manually trigger a snapshot (force a backup)
# ------------------------------------------------------------
#
# Create new snapshot
#  |--> Manually trigger a PRTG configuration snapshot (backup) by browsing to URL:
#

http://<your-prtg-server>/api/savenow.htm

# Note: Replace "<your-prtg-server>" with your PRTG server's hostname/FQDN


# ------------------------------
#
# Get snapshots/backups
#  |--> Configuration snapshots/backups are saved to the following directory
#

%ProgramData%\Paessler\PRTG Network Monitor\Configuration Auto-Backups


# ------------------------------------------------------------
#
# Citation(s)
#
#   kb.paessler.com  |  "Is there a way to schedule PRTG backups? | Paessler Knowledge Base"  |  https://kb.paessler.com/en/topic/59619-is-there-a-way-to-schedule-prtg-backups
#
# ------------------------------------------------------------