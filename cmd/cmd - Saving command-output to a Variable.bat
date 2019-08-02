REM
REM	cmd (Windows)
REM	 |
REM	 |--> Saving command-output to a Variable
REM

FOR /F "tokens=* USEBACKQ" %%F IN (`command`) DO (
SET var=%%F
)
ECHO %var%

REM
REM	Note - USEBACKQ
REM	 |--> "I always use the USEBACKQ so that if you have a string to insert or a long
REM	       file name, you can use your double quotes without screwing up the command."
REM	                       - quoted from solution by (stackoverflow) user "Mechaflash"
REM



REM
REM	Citation(s)
REM
REM		stackoverflow.com  |  "How to set commands output as a variable in a batch file"  |  https://stackoverflow.com/a/6362922
REM
REM