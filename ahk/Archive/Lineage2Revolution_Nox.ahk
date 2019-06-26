;
;
;        # Windows-Key        ! Alt        + Shift        ^ Control
;        < Left Mod Key                             > Right Mod Key
;
#SingleInstance force
CoordMode,Mouse,Screen
SetDefaultMouseSpeed, 0
SetKeyDelay, 0, -1
SetControlDelay, -1
;
; ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
#Escape::
	ExitApp
	Return
;
; ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
#w::
	RestartNoxPlayers()
	Return
;
; ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
+d::
+f::
	KeepAlive_InfiniteLoop()
	Return
;
; ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
; @function get_ahk_id_from_title
;
;    --> Finds a window with an exact-title-match to input string & return the window's uid (ahk_id)
;
; get_ahk_id_from_title(WinTitle,ExcludeTitle) {
; 	SetTitleMatchMode, 2
; 	ControlGet, output_var, Hwnd,,, %WinTitle%,, %ExcludeTitle%
; 	return_ahk_id=ahk_id %output_var%
; 	return return_ahk_id
; }
	
;
; ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
Manual_Show_Title() {
	SetKeyDelay, 0, -1
	SetControlDelay, -1
	ControlGet, ControlHwndMan, Hwnd,,, A
	MsgBox MANUAL: %ControlHwndMan%
	Return
}
;
; ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
RestartNoxPlayers() {
	SetKeyDelay, 0, -1
	SetControlDelay, -1
	
	WinTitle=NoxPlayer__1
	WinTitle__sidemenu1=nox
	WinTitle__sidemenu2=Nox_2
	WinTitle__syncpopup1=Dialog
	WinTitle__syncpopup2=Dialog
	WinTitle__multiboxer=Nox multi-instance manager
	WinTitle__popup_multiboxer=MultiPlayerManager
	
	key_HOME=SC147
	key_L=SC026
	key_TICK=SC029
	key_SPACE=SC039
	
	Runwait, taskkill /im Nox.exe /f
	Sleep 1000
	Runwait, taskkill /im MultiPlayerManager.exe /f
	Sleep 1000
	Run "C:\Program Files (x86)\Nox\bin\MultiPlayerManager.exe"
	WinWait, %WinTitle__multiboxer%
	Sleep 1000
	CenterWindow()
	Sleep 1000
	x_btn = 1362 ; Okay - Close game
	y_btn = 330
	ControlClick, x%x_btn% y%y_btn%, %WinTitle__multiboxer%
	Sleep 1000
	x_btn = 23 ; Select All - Multi Manager
	y_btn = 67
	ControlClick, x%x_btn% y%y_btn%, %WinTitle__multiboxer%
	Sleep 1000
	x_btn = 201 ; Batch Dropdown - Multi Manager
	y_btn = 63
	ControlClick, x%x_btn% y%y_btn%, %WinTitle__multiboxer%
	Sleep 500
	x_btn = 201 ; Close All
	y_btn = 125
	ControlClick, x%x_btn% y%y_btn%, %WinTitle__multiboxer%
	Sleep 2000
	x_btn = 142 ; "Yes" Confirmation
	y_btn = 154
	ControlClick, x%x_btn% y%y_btn%, %WinTitle__popup_multiboxer%
	Sleep 10000
	x_btn = 526 ; Start NoxPlayer
	y_btn = 119
	ControlClick, x%x_btn% y%y_btn%, %WinTitle__multiboxer%
	Sleep 5000
	x_btn = 526 ; Start NoxPlayer__1
	y_btn = 177
	ControlClick, x%x_btn% y%y_btn%, %WinTitle__multiboxer%
	; Sleep 60000
	Sleep 30000
	; Immediately grab the unique-ids for each window upon opening them
	ahk_id_nox_1 := get_ahk_id_from_title("NoxPlayer__1","")
	ahk_id_nox_2 := get_ahk_id_from_title("NoxPlayer__1","")
	ahk_id_nox_3 := get_ahk_id_from_title("NoxPlayer__3","")
	Sleep 1000
	x_btn = 16 ; Open "Synchronize Operations in all Instances"
	y_btn = 106
	ControlClick, x%x_btn% y%y_btn%, %WinTitle__sidemenu1%
	Sleep 2000
	x_btn = 273 ; Click Synchronize (play) Button
	y_btn = 22
	ControlClick, x%x_btn% y%y_btn%, %WinTitle__syncpopup1%
	Sleep 1500
	x_btn = 401 ; Close "Synchronize" Window
	y_btn = 5
	ControlClick, x%x_btn% y%y_btn%, %WinTitle__syncpopup1%
	Sleep 2000
	x_btn = 16 ; Open "Synchronize Operations in all Instances"
	y_btn = 106
	ControlClick, x%x_btn% y%y_btn%, %WinTitle__sidemenu2%
	Sleep 2000
	x_btn = 273 ; Click Synchronize (play) Button
	y_btn = 22
	ControlClick, x%x_btn% y%y_btn%, %WinTitle__syncpopup2%
	Sleep 1500
	x_btn = 401 ; Close "Synchronize" Window
	y_btn = 5
	ControlClick, x%x_btn% y%y_btn%, %WinTitle__syncpopup2%
	Sleep 1500
	Loop 2 {
		; Scroll to the main page (w/ Lin-2 on it)
		ControlSend,, {Home}, %WinTitle%
		Sleep 3000
	}
	Loop 2 {
		; Open App "Lineage 2"
		ControlClick, x165 y182, %WinTitle%
		Sleep 2000
	}
	Sleep 45000
	Loop 3 {
		Sleep 7500
		; 1x for:  Login-Screen - "Tap to Start"
		; 2x for:  Popup-Ads before Character-Select Screen
		ControlClick, x905 y35, %WinTitle%
	}
	Sleep 10000
	; Hit "Play" on Character-Select Screen
	ControlClick, x853 y493, %WinTitle%
	Return
}
;
; ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
; 		// FUNCTION:  KeepAlive_InfiniteLoop
;
KeepAlive_InfiniteLoop() {
	WinTitle="NoxPlayer__1"
	Sleep 100
	Loop {
		; CenterWindow()
		Sleep 100
		BasicAttack()
		Sleep 100
		DoBulkSale()
		Sleep 60000
	}
	Return
}
;
; ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
; 		// FUNCTION:  CenterWindow
;
CenterWindow() {
	CoordMode,Mouse,Screen
	SetDefaultMouseSpeed, 0
	SetControlDelay, -1
	WinTitle=Nox multi-instance manager
	WinGetPos,,, WidthVar, HeightVar, %WinTitle%
	WinMove, %WinTitle%,, (A_ScreenWidth/2)-(WidthVar/2), (A_ScreenHeight/2)-(HeightVar/2)
	; WinActivate %WinTitle%
	Return
}
;
; ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
; 		// FUNCTION:  Random5001000
;
Random5001000() {
	Random, return_val, 1, 10
	Return return_val
}
;
; ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
; 		// FUNCTION:  BasicAttack
;
BasicAttack() {
	WinTitle=NoxPlayer__1
	; MouseClick,Left,226,847,1,0,D
	; MouseMove,-100,5,0,R
	; MouseClick,Left,-1,0,1,0,U,R
	
	; ControlSend,,{Space down},%WinTitle%
	; Sleep Random5001000()
	; ControlSend,,{Space up},%WinTitle%
	Return
}
; ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
; 		// FUNCTION:  HitEscape
;
HitEscape() {
	SetKeyDelay, 0, -1
	SetControlDelay, -1
	WinTitle = NoxPlayer__1
	Sleep 1000
	ControlSend,,{Escape down},%WinTitle%
	Sleep 250
	ControlSend,,{Escape up},%WinTitle%
	Sleep 100
	Return
}
;
; ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
; 		// FUNCTION:  DoBulkSale
;
DoBulkSale() {
	WinTitle=NoxPlayer__1
	Delay := 5000
	Sleep 10000
	ControlClick, x704 y37, %WinTitle% ; Open Inventory
	Sleep %Delay%
	ControlClick, x687 y515, %WinTitle% ; Bulk Sale
	Sleep %Delay%
	ControlClick, x857 y516, %WinTitle% ; Sell
	Sleep %Delay%
	ControlClick, x559 y383, %WinTitle% ; Confirm Sell
	Sleep %Delay%
	ControlClick, x559 y383, %WinTitle% ; Okay to Receipt
	Sleep %Delay%
	ControlClick, x889 y52, %WinTitle% ; Close Inventory (Top-Right)
	Sleep %Delay%
	; ControlClick, x30 y52, %WinTitle% ; Back Button (Top-Left)
	; Sleep %Delay%
	Return
}
;
; ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
; 		// FUNCTION:  TakeAStep
;
TakeAStep() {
	CoordMode,Mouse,Screen
	SetDefaultMouseSpeed, 0
	SetControlDelay, -1
	; Jiggle the Stick
	MouseClick,Left,226,847,1,0,D
	MouseMove,-100,5,0,R
	MouseClick,Left,-1,0,1,0,U,R
	Sleep 100
	Return
}
;
JiggleTheStick() {
	CoordMode,Mouse,Screen
	SetDefaultMouseSpeed, 0
	SetControlDelay, -1
	Sleep 100
	CenterWindow()
	; Jiggle the Stick
	MouseClick,Left,476,747,1,0,D
	MouseMove,-100,5,0,R
	MouseClick,Left,-1,0,1,0,U,R
	Sleep 100
	Return
}
;
; ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;