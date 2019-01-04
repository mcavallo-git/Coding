
REM -----------------------------------------

REM Show "Max Processor State" to Power Options
powercfg -attributes SUB_PROCESSOR bc5038f7-23e0-4960-96da-33abaf5935ec -ATTRIB_HIDE
REM Hide "Max Processor State" to Power Options (DEFAULT)
REM powercfg -attributes SUB_PROCESSOR bc5038f7-23e0-4960-96da-33abaf5935ec +ATTRIB_HIDE

REM Side-Option: regdit.exe
REM Key Path: HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\bc5038f7-23e0-4960-96da-33abaf5935ec
REM Key Type: Attributes DWORD
REM Key Value: 1 (Hide "Max Processor State" to Power Options (DEFAULT))
REM Key Value: 2 (Show "Max Processor State" to Power Options)

REM -----------------------------------------

REM (Win10 Only) Show the "Ultimate Performance" power plan, hidden by default in most versions of Windows 10
REM powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61

REM -----------------------------------------