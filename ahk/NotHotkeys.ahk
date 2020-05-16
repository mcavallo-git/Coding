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

VERBOSE_OUTPUT := True

CurrentlyCrafting := False

Target_ahk_id=

; ------------------------------------------------------------

ExeBasename := "ffxiv_dx11.exe"

ExeWinTitle := "FINAL FANTASY XIV"

; ------------------------------------------------------------
;  HOTKEY:  WinKey + =
;  ACTION:  Show synthesize location
; #=::
; 	SetKeyDelay, 0, -1
; 	CoordMode, Mouse, Screen
; 	SetDefaultMouseSpeed, 0
; 	SetControlDelay, -1
; 	; SetTitleMatchMode, 1  ; A window's title must start with the specified WinTitle to be a match
; 	; SetTitleMatchMode, 2  ; A window's title can contain WinTitle anywhere inside it to be a match
; 	; SetTitleMatchMode, 3  ; A window's title must exactly match WinTitle to be a match
; 	MouseMove, 999, 759
; 	Echo_Tooltip := "Move 'Synthesize' button to here"
; 	ToolTip, %Echo_Tooltip%
; 	ClearTooltip(15000)
; 	Return


; ------------------------------------------------------------
;
; Listen for a given window to appear
;

Gui +LastFound  ; this is needed
DllCall("RegisterShellHookWindow", UInt,WinExist())
MsgNum := DllCall("RegisterWindowMessage", Str,"SHELLHOOK")
OnMessage(MsgNum,"ShellMessage")

ShellMessage(wParam, lParam, msg, hwnd) {
	Global CurrentlyCrafting
	Global ExeBasename
	Global ExeWinTitle
	Global LastActiveWindowID
	Global Target_ahk_id
	Global VERBOSE_OUTPUT
	SetTitleMatchMode, 2  ; A window's title can contain WinTitle anywhere inside it to be a match
	If (VERBOSE_OUTPUT = True) {
		Echo_Tooltip=
		Echo_Tooltip := Echo_Tooltip "wParam = "  wParam "`n"
		Echo_Tooltip := Echo_Tooltip "lParam = "  lParam "`n"
		Echo_Tooltip := Echo_Tooltip "msg = "  msg "`n"
		Echo_Tooltip := Echo_Tooltip "hwnd = "  hwnd "`n"
		Echo_Tooltip := Echo_Tooltip "Target_ahk_id = "  Target_ahk_id "`n"
		ToolTip, %Echo_Tooltip%
		; ClearTooltip(5000)
	}
	If (CurrentlyCrafting = True) {
		If (ProcessExist(ExeBasename) == True) {
			ExePID := GetPID(ExeBasename)
			Target_ahk_id := Get_ahk_id_from_pid(ExePID)
			WinSet, AlwaysOnTop, Off, ahk_pid %ExePID%
			If ( wParam = 4 And WinExist( "ahk_id " lParam ) ) {  ; HSHELL_WINDOWACTIVATED = 4
				IfWinExist, %ExeWinTitle% ahk_id %lParam%
				{
					BlockInput, MouseMove  ; Kill mouse interaction
					Loop {
						Sleep, 1
						IfWinNotActive, %ExeWinTitle%  ; Use last found window
						{
							BlockInPut, MouseMoveOff  ; Restore mouse interaction
							Break
						}
					}
				}
			}
		}
	}
}




; ------------------------------------------------------------
;  HOTKEY:  WinKey + -
;  ACTION:  Craft it up
#-::
	SetKeyDelay, 0, -1
	; SetTitleMatchMode, 2  ; A window's title can contain WinTitle anywhere inside it to be a match
	CoordMode, Mouse, Screen
	SetDefaultMouseSpeed, 0
	SetControlDelay, -1
	Global CurrentlyCrafting
	Global ExeBasename
	Global ExeWinTitle
	Global Target_ahk_id
	Global VERBOSE_OUTPUT
	If (ProcessExist(ExeBasename) == True) {
		ExePID := GetPID(ExeBasename)
		Target_ahk_id := Get_ahk_id_from_pid(ExePID)
		Echo_Tooltip := "Running Crafting Hotkeys"
		ToolTip, %Echo_Tooltip%
		ClearTooltip(5000)
		MaxLoops := 25
		MsgBox, 3, FFXIV AutoCraft, Is the 'Crafting Log' open with desired item selected?
		IfMsgBox Yes
		{
			CurrentlyCrafting := True
			Sleep 1000
			; WinSet, Disable,, ahk_pid %ExePID%
			OverlayOn(ExeBasename)
			Sleep 2000
			Loop 4 {
				ControlSend,, =, ahk_pid %ExePID%
				Random, RandomSleep, 500, 1000  ; Random wait
				Sleep %RandomSleep%
			}
			Loop %MaxLoops% {
				; ------------------------------------------------------------
				; General padding at the start of the loop and after each repeat
				Sleep 3000
				Echo_Tooltip := "Crating 83* Gear (loop " A_Index "/"  MaxLoops ")"
				ToolTip, %Echo_Tooltip%
				ClearTooltip(15000)
				Sleep 100
				; ------------------------------------------------------------
				; Part 1-of-3 Level 83 Start Craft
				;   |--> Hotkey:  [
				;
				ControlSend,,[, ahk_pid %ExePID%
				Sleep 36000
				Sleep 2000  ; General padding to let craft complete
				Random, RandomSleep, 1000, 5000  ; Random wait
				Sleep %RandomSleep%
				; ------------------------------------------------------------
				; Part 2-of-3 Level 83 Start Craft
				;   |--> Hotkey:  ]
				;
				ControlSend,,], ahk_pid %ExePID%
				Sleep 14000
				Sleep 2000  ; General padding to let craft complete
				Random, RandomSleep, 1000, 5000  ; Random wait
				Sleep %RandomSleep%
				; ------------------------------------------------------------
				; Part 3-of-3 - Select Synthesize
				Sleep 2000
				Loop 3 {
					ControlSend,, =, ahk_pid %ExePID%
					Random, RandomSleep, 500, 1000  ; Random wait
					Sleep %RandomSleep%
				}
				Random, RandomSleep, 1000, 2000  ; Random wait
				Sleep 2000  ; Wait for synthesize to finish
			}
			CurrentlyCrafting := False
			; WinSet, Enable,, ahk_pid %ExePID%
			OverlayOff(ExeBasename)
		}
	}
	Return


; ------------------------------------------------------------
;   HOTKEY:  Win + Esc
;   ACTION:  Refresh This Script  ::: Closes then re-opens this script (Allows saved changes to THIS script (file) be tested/applied on the fly)
;
#Escape::
	Global CurrentlyCrafting
	Global ExeBasename
	Global ExeWinTitle
	Global VERBOSE_OUTPUT
	CurrentlyCrafting := False
	OverlayOff(ExeBasename)
	Reload
	Sleep 1000 ; If successful, the reload will close this instance during the Sleep, so the line below will never be reached.
	MsgBox, 4,, The script could not be reloaded. Would you like to open it for editing?
	IfMsgBox, Yes, Edit
	Return


; ------------------------------------------------------------
; ------------------------------------------------------------
; ---                       FUNCTIONS                      ---
; ------------------------------------------------------------
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
; Get_ahk_id_from_pid
;   |--> Input: WinPID to Target
;   |--> Returns ahk_id (process-handle) for AHK back-end control-based calls
;
Get_ahk_id_from_pid(WinPid) {
	SetTitleMatchMode, 2 ; Title must CONTAIN [ WinTitle ] as a substring
	ControlGet, output_var, Hwnd,,, ahk_pid %WinPid%
	dat_ahk_id=ahk_id %output_var%
	Return dat_ahk_id
}


;
;	GetPID
;   |--> Returns PID if process IS found
;   |--> Returns 0 if process is NOT found
;
GetPID(ProcName) {
	Process, Exist, %ProcName%
	Return %ErrorLevel%
}


;
; OverlayOff  (function)
;	  |--> Removes overlay from in-front of target window, restoring access to the user
;
OverlayOff(ExeBasename) {
	If (ProcessExist(ExeBasename) == True) {
		ExePID := GetPID(ExeBasename)
		; WinSet, AlwaysOnTop, Off, ahk_pid %ExePID%
		; WinSet, ExStyle, -0x20, ahk_pid %ExePID%
		; WinSet, Transparent, OFF, ahk_pid %ExePID%
	}
	Return
}


;
; OverlayOn  (function)
;	  |--> Creates an overlay which blocks a target window, denying access from the user until it is removed or otherwise closed
;
OverlayOn(ExeBasename) {
	If (ProcessExist(ExeBasename) == True) {
		ExePID := GetPID(ExeBasename)
		; WinSet, AlwaysOnTop, On, ahk_pid %ExePID%
		; WinSet, Transparent, 80, ahk_pid %ExePID%
		; WinSet, ExStyle, +0x20, ahk_pid %ExePID%
	}
	Return
}


;
;	ProcessExist (proxy-function for GetPID(...))
;   |--> Returns True if process IS found
;   |--> Returns False if process is NOT found
;
ProcessExist(ProcName) {
  Return (GetPID(ProcName)>0) ? True : False
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
;
; Citation(s)
;
;   autohotkey.com  |  "WinSet, Disable... not working as expected - Ask for Help - AutoHotkey Community"  |  https://autohotkey.com/board/topic/103478-winset-disable-not-working-as-expected/
;
;   www.autohotkey.com  |  "WinSet - Syntax & Usage | AutoHotkey"  |  https://www.autohotkey.com/docs/commands/WinSet.htm#Style
;
; ------------------------------------------------------------