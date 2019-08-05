
; -------------------------- ;
;     TightVNC - Connect     ;
; -------------------------- ;
<#`::
	IfWinExist, username.local
	{
		WinActivate
		WinMove, 764, 152
	}
	else
	{
		Run "C:\Program Files\TightVNC\TightVNC_cavallo.local.vnc"
		WinWait username.local
		WinActivate
		WinMove, 764, 152
	}
Return


; ------------------------- ;
;     TightVNC - Unlock     ;
; ------------------------- ;
<#1::
	CoordMode,Mouse,Screen
	MouseClickDrag, Left, 800,802, 1123,796
	Sleep, 1000
	SetMouseDelay, 25
	SetDefaultMouseSpeed, 0
	Click 857,460
	Click 960,726
	Click 1060,834
	Click 1060,834
	Click 857,634		
	Click 1063,542
	Click 1060,834
	Click 963,544
	Click 857,460
	Click 1060,834
	Click 857,634
	Click 1060,834
	Click 1064,639
	Click 960,726
	Click 960,726
	Click 1060,834
	Click 1067,454
	Click 1060,834
	Click 857,460
	Click 1060,834
	Click 857,634
	Click 963,544
	MouseMove 960,871
Return


; -------------------------- ;
;     TightVNC - Open CC     ;
; -------------------------- ;
<#2::
	CoordMode,Mouse,Screen
	MouseClickDrag, Left, 960,877, 960,720
Return
