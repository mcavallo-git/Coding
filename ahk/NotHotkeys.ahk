; ------------------------------------------------------------
;
; _WindowsHotkeys.ahk, by Cavalol
;   |
;   |--> Effective Hotkeys for Windows-based Workstaitons
;   |
;   |--> Runs via "Autohotkey" (AHK) - Download @ https://www.autohotkey.com/download/
;   |
;   |--> Download this script:  https://raw.githubusercontent.com/mcavallo-git/Coding/master/ahk/NotHotkeys.ahk
;
; ------------------------------------------------------------

#Persistent  ; https://www.autohotkey.com/docs/commands/_Persistent.htm

#HotkeyInterval 2000  ; https://www.autohotkey.com/docs/commands/_HotkeyInterval.htm

#MaxHotkeysPerInterval 2000  ; https://www.autohotkey.com/docs/commands/_MaxHotkeysPerInterval.htm

#SingleInstance Force  ; https://www.autohotkey.com/docs/commands/_SingleInstance.htm

; ------------------------------------------------------------
;  HOTKEY:  WinKey + =
;  ACTION:  Show synthesize location
\::
	SetKeyDelay, 0, -1
	CoordMode, Mouse, Screen
	SetDefaultMouseSpeed, 0
	SetControlDelay, -1
	; SetTitleMatchMode, 1  ; A window's title must start with the specified WinTitle to be a match
	SetTitleMatchMode, 2  ; A window's title can contain WinTitle anywhere inside it to be a match
	; SetTitleMatchMode, 3  ; A window's title must exactly match WinTitle to be a match
	WinTitle := "FINAL FANTASY XIV"
	ControlSend,,[, %WinTitle%
	Sleep 1000
	WinTitle := "cmd.exe"
	ControlSend,,ipconfig{Enter}, %WinTitle%
	Sleep 1000
	Echo_Tooltip := "Test ControlCommand"
	ToolTip, %Echo_Tooltip%
	ClearTooltip(3000)
	Return


; ------------------------------------------------------------
;  HOTKEY:  WinKey + =
;  ACTION:  Show synthesize location
#=::
	SetKeyDelay, 0, -1
	CoordMode, Mouse, Screen
	SetDefaultMouseSpeed, 0
	SetControlDelay, -1
	; SetTitleMatchMode, 1  ; A window's title must start with the specified WinTitle to be a match
	SetTitleMatchMode, 2  ; A window's title can contain WinTitle anywhere inside it to be a match
	; SetTitleMatchMode, 3  ; A window's title must exactly match WinTitle to be a match
	MouseMove, 999, 759
	Echo_Tooltip := "Move 'Synthesize' button to here"
	ToolTip, %Echo_Tooltip%
	ClearTooltip(15000)
	Return


; ------------------------------------------------------------
;  HOTKEY:  WinKey + -
;  ACTION:  Craft it up
#-::
	SetKeyDelay, 0, -1
	CoordMode, Mouse, Screen
	SetDefaultMouseSpeed, 0
	SetControlDelay, -1
	; SetTitleMatchMode, 1  ; A window's title must start with the specified WinTitle to be a match
	SetTitleMatchMode, 2  ; A window's title can contain WinTitle anywhere inside it to be a match
	; SetTitleMatchMode, 3  ; A window's title must exactly match WinTitle to be a match	AwaitModifierKeyup()
	Echo_Tooltip := "Running Crafting Hotkeys"
	ToolTip, %Echo_Tooltip%
	ClearTooltip(5000)
	WinTitle := "FINAL FANTASY XIV"
	Loop 25 {
		; ------------------------------------------------------------
		; General padding at the start of the loop and after each repeat
		Sleep 3000
		; ------------------------------------------------------------
		; Part 1-of-3 - Synthesize
		; MouseClick, Left, 999, 759
		ControlClick, x999 y759, %WinTitle%  ; Clicks at a set of coordinates. Note the lack of a comma between X and Y.
		Sleep 2000  ; Wait for synthesize to finish
		Random, RandomSleep, 1000, 2000  ; Random wait
		Sleep %RandomSleep%
		; ------------------------------------------------------------
		; Part 2-of-3 Level 83 Start Craft
		;   |--> Hotkey:  [
		;
		ControlSend,,[, %WinTitle%  ; Send keypress directly to target window
		Sleep 36000
		Sleep 2000  ; General padding to let craft complete
		Random, RandomSleep, 1000, 5000  ; Random wait
		Sleep %RandomSleep%
		; ------------------------------------------------------------
		; Part 3-of-3 Level 83 Start Craft
		;   |--> Hotkey:  ]
		;
		ControlSend,,], %WinTitle%  ; Send keypress directly to target window
		Sleep 14000
		Sleep 2000  ; General padding to let craft complete
		Random, RandomSleep, 1000, 5000  ; Random wait
		Sleep %RandomSleep%
	}
	Return


; ------------------------------------------------------------
;   HOTKEY:  Win + Esc
;   ACTION:  Refresh This Script  ::: Closes then re-opens this script (Allows saved changes to THIS script (file) be tested/applied on the fly)
;
#1::
#Escape::
	Reload
	Sleep 1000 ; If successful, the reload will close this instance during the Sleep, so the line below will never be reached.
	MsgBox, 4,, The script could not be reloaded. Would you like to open it for editing?
	IfMsgBox, Yes, Edit
	Return


; ------------------------------------------------------------



;
; AwaitModifierKeyup  (function)
;   |-->  Wait until all modifier keys are released
;
AwaitModifierKeyup() {
	KeyWait LAlt    ; Wait for [ Left-Alt ] to be released
	KeyWait LCtrl   ; Wait for [ Left-Control ] to be released
	KeyWait LShift  ; Wait for [ Left-Shift ] to be released
	KeyWait LWin    ; Wait for [ Left-Win ] to be released
	KeyWait RAlt    ; Wait for [ Right-Alt ] to be released
	KeyWait RCtrl   ; Wait for [ Right-Control ] to be released
	KeyWait RShift  ; Wait for [ Right-Shift ] to be released
	KeyWait RWin    ; Wait for [ Right-Win ] to be released
	Sleep 10
}


;
; ClearTooltip  (function)
;   |--> If called with a positive [ %Period% ], wait [ %Period% ] milliseconds, executes [ %Label% ], then repeats (until explicitly cancelled)
;	  |--> If called with a negative [ %Period% ], wait [ %Period% ] milliseconds, executes [ %Label% ], then returns
;
ClearTooltip(Period) {
	Label := "RemoveToolTip"
	SetTimer, %Label%, -%Period%
	Return
}


;
; RemoveToolTip  (function)
;   |--> Removes any Tooltips found
;
RemoveToolTip() {
	ToolTip
	Return
}


; ------------------------------------------------------------