
; TightVNC -> Keyboard 'W' sends GBA4iOS 'Up'
w::
	CoordMode,Mouse,Screen
	SetDefaultMouseSpeed, 0
	while GetKeyState("w","p")
	{	Click 846,694 
	}
	Return

	
; TightVNC -> Keyboard 'A' sends GBA4iOS 'Left'
a::
	CoordMode,Mouse,Screen
	SetDefaultMouseSpeed, 0
	while GetKeyState("a","p")
	{	Click 808,737
	}
Return


; TightVNC -> Keyboard 'S' sends GBA4iOS 'Down'
s::
	CoordMode,Mouse,Screen
	SetDefaultMouseSpeed, 0
	while GetKeyState("s","p")
	{	Click 848,779
	}
Return


; TightVNC -> Keyboard 'D' sends GBA4iOS 'Right'
d::
	CoordMode,Mouse,Screen
	SetDefaultMouseSpeed, 0
	while GetKeyState("d","p")
	{	Click 890,740
	}
Return


; TightVNC -> Keyboard 'Up' sends GBA4iOS 'A'
Up::
	CoordMode,Mouse,Screen
	SetDefaultMouseSpeed, 0
	Click 1109,719
Return


; TightVNC -> Keyboard 'Left' sends GBA4iOS 'B'
Left::
	CoordMode,Mouse,Screen
	SetDefaultMouseSpeed, 0
	Click 1023,759
Return


; TightVNC -> Keyboard 'Right' spams GBA4iOS 'B'
Right::
	CoordMode,Mouse,Screen
	SetDefaultMouseSpeed, 0
	while GetKeyState("Right","p")
	{	Click 023,759
	}
Return


; TightVNC -> Keyboard 'Shift' sends GBA4iOS 'Start'
Shift::
	CoordMode,Mouse,Screen
	SetDefaultMouseSpeed, 0
	Click 994,855
Return


; AutoHotkey - Cancel any running scripts and kill program (must restart)
<#Escape::
	ExitApp
Return
