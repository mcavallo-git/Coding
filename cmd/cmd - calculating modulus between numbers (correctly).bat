@ECHO OFF
EXIT

SET dividend=-5
SET divisor=7
SET /A modulo=(dividend%divisor+divisor)%divisor
SET /A invalid_mod=dividend%divisor
ECHO modulo = ( %dividend% % %divisor% + %divisor%) % %divisor% = %modulo%
ECHO invalid_mod = ( %dividend% % %divisor% ) = %invalid_mod%


REM ------------------------------------------------------------
REM Citation(s)
REM 
REM   stackoverflow.com  |  "CMD set /a, modulus, and negative numbers"  |  https://stackoverflow.com/a/27894447
REM 
REM ------------------------------------------------------------