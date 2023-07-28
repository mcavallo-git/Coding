<!-- https://github.com/mcavallo-git/Coding/blob/main/prtg/PRTG%20-%20Manually%20trigger%20a%20configuration%20snapshot%20(force%20a%20backup).md -->
<!-- https://github.com/mcavallo-git/Coding/blob/main/prtg/PRTG%20-%20Manually%20trigger%20a%20configuration%20snapshot%20%28force%20a%20backup%29.md -->
<!-- https://github.com/mcavallo-git/Coding/blob/main/prtg/PRTG%20%2d%20Manually%20trigger%20a%20configuration%20snapshot%20%28force%20a%20backup%29.md -->

## PRTG - Manually trigger a configuration snapshot (force a backup)

***

- ### Create a new snapshot (backup)
  - Via the GUI:
    - `Setup` → `System Administration` → `Administrative Tools` → `Create Configuration Snapshot`
  - Via an API call (replace `<your-prtg-server>` with your PRTG server's hostname/FQDN):
    - ```http://<your-prtg-server>/api/savenow.htm?username=<admin username>&passhash=<admin passhash>```

- ## Snapshot output directory
  - `%ProgramData%\Paessler\PRTG Network Monitor\Configuration Auto-Backups`

***

- ## Note(s) from Paessler

  > By default, PRTG always performs the backup at 3:08am. In case you need more frequent snapshots of the configuration due to a lot of changes made throughout the day. Proceed with the following steps in order to create multiple snapshots per day.

***

- ## Citation(s)
  - [kb.paessler.com | Is there a way to schedule PRTG backups? - Paessler Knowledge Base](https://kb.paessler.com/en/topic/59619-is-there-a-way-to-schedule-prtg-backups)
  - [kb.paessler.com | Restore Map - Paessler Knowledge Base](https://kb.paessler.com/en/topic/44833-restore-map#reply-301803)

***
