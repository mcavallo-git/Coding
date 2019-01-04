EXIT

REM Deleting a Service

REM  USING CMD:
sc.exe delete SERVICE_NAME

REM EXAMPLE: Delete service named 'ltsvcmon' under Task Manager -> Services
REM sc.exe delete ltsvcmon

REM USING REGEDIT (PREFERRED METHOD IS CMD)
REM		HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\ltsvcmon
REM			Select the key, right click & delete