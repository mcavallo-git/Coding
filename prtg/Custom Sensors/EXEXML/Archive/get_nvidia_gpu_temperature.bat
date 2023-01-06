@echo off
echo ^<?xml version="1.0" encoding="Windows-1252" ?^>
echo ^<prtg^>

echo ^<result^>
echo        ^<channel^>GPU0 Temperature^</channel^>
echo ^<value^>
"C:\Program Files\NVIDIA Corporation\NVSMI\nvidia-smi.exe" --query-gpu=temperature.gpu --format="csv,nounits,noheader" --id=0
echo ^</value^>
echo ^</result^>

echo ^<result^>
echo        ^<channel^>GPU1 Temperature^</channel^>
echo ^<value^>
"C:\Program Files\NVIDIA Corporation\NVSMI\nvidia-smi.exe" --query-gpu=temperature.gpu --format="csv,nounits,noheader" --id=1
echo ^</value^>
echo ^</result^>

echo ^</prtg^>



REM ------------------------------------------------------------
REM
REM Citation(s)
REM
REM   www.reddit.com  |  "Graphing GPU Temps with PRTG : gpumining"  |  https://www.reddit.com/r/gpumining/comments/7v14xz/graphing_gpu_temps_with_prtg/dtoofn3/
REM
REM ------------------------------------------------------------