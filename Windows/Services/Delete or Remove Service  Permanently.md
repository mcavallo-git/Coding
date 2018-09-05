Deleting a Service

EXAMPLE: Delete service named 'ltsvcmon' under Task Manager -> Services

   USING CMD:
	sc.exe delete ltsvcmon

   USING REGEDIT (JUST USE CMD THOUGH):
	HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\ltsvcmon
		Select the key, right click & delete