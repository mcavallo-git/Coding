
REM Deleting a Service
REM EXAMPLE: Delete service named 'ltsvcmon' under Task Manager -> Services

REM  USING CMD:
sc.exe delete ltsvcmon

REM USING REGEDIT (PREFERRED METHOD IS CMD)
REM		HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\ltsvcmon
REM			Select the key, right click & delete