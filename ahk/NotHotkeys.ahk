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

CurrentlyCrafting := 0

VerboseOutput := 0

ExeBasename := "ffxiv_dx11.exe"

ExeWinTitle := "FINAL FANTASY XIV"

ExeWinClass := "FFXIVGAME"

; ------------------------------------------------------------

SetTimer, WatchCursor, 10
Return

WatchCursor:
	Global CurrentlyCrafting
	Global VerboseOutput
	CoordMode, Mouse, Screen
	MouseGetPos, , , WinID, control
	WinGetClass, WinClass, ahk_id %WinID%
	KillMouseInteraction := 0
	If (WinClass == "FFXIVGAME") {
		If (CurrentlyCrafting == 1) {
			Echo_Tooltip := "Block mouse interaction`n |--> In-game & crafting"
			KillMouseInteraction := 1
		} Else {
			Echo_Tooltip := "Allow mouse interaction`n |--> Not currently crafting"
		}
	} Else {
		Echo_Tooltip := "Allow mouse interaction`n |--> Not in Game"
	}
	If (KillMouseInteraction == 1) {
		BlockInput, MouseMove      ;  Kill mouse interaction
		ToolTip, %Echo_Tooltip%
		ClearTooltip(10000)
	} Else {
		BlockInPut, MouseMoveOff   ;  Restore mouse interaction
		If (VerboseOutput > 0) {
			ToolTip, %Echo_Tooltip%
			ClearTooltip(10000)
		}
		; BlockInPut, Off            ;  Restore full interaction
	}
	Return

; ------------------------------------------------------------

#If WinActive("ahk_class FFXIVGAME") and (CurrentlyCrafting == 1)
	LButton::
	RButton::
		Return
#If


; ------------------------------------------------------------
;
;  HOTKEY:  WinKey + -
;  ACTION:  Craft it up
;
#-::
	SetKeyDelay, 0, -1
	; SetTitleMatchMode, 2  ; A window's title can contain WinTitle anywhere inside it to be a match
	CoordMode, Mouse, Screen
	SetDefaultMouseSpeed, 0
	SetControlDelay, -1
	Global Active_HWND
	Global CurrentlyCrafting
	Global ExeBasename
	Global ExeWinClass
	Global ExeWinTitle
	Global Target_HWND
	Global VerboseOutput
	ExePID := GetPID(ExeBasename)
	Target_HWND := WinActive(ahk_pid %ExePID%)
	Echo_Tooltip := "Running Crafting Hotkeys"
	ToolTip, %Echo_Tooltip%
	ClearTooltip(5000)
	MaxLoops := 25
	MsgBox, 3, FFXIV AutoCraft, Is the 'Crafting Log' open with desired item selected?
	IfMsgBox Yes
	{
		CurrentlyCrafting := 1
		Sleep 1000
		; WinSet, Disable,, ahk_pid %ExePID%
		; OverlayOn(ExeBasename)
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
		CurrentlyCrafting := 0
		; WinSet, Enable,, ahk_pid %ExePID%
		; OverlayOff(ExeBasename)
	}
	Return


; ------------------------------------------------------------
;   HOTKEY:  Win + Z
;   ACTION:  Grabs information about current (active) window's exe-filepath, process-id, on-screen location, & more, and displays it in a popup table Gui
;
#Z::
	GetWindowSpecs()
	Return


; ------------------------------------------------------------
;
;   HOTKEY:  Win + Esc
;   HOTKEY:  WinKey + =
;   ACTION:  Refresh This Script  ::: Closes then re-opens this script (Allows saved changes to THIS script (file) be tested/applied on the fly)
;
#Escape::
#=::
	Global CurrentlyCrafting
	Global ExeBasename
	Global ExeWinClass
	Global ExeWinTitle
	Global VerboseOutput
	CurrentlyCrafting := 0
	AwaitModifierKeyup()
	BlockInPut, Off  ;  Restore full interaction
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
; GetWindowSpecs
;   |--> Gets Specs for currently-active window
;
GetWindowSpecs() {

	; Set the Gui-identifier (e.g. which gui-popup is affected by gui-based commands, such as [ Gui, ... ] and [ LV_Add(...) ])
	Gui, WindowSpecs:Default

	WinGetActiveStats, Title, Width, Height, Left, Top
	WinGetTitle, WinTitle, A
	WinGetText, WinText, A
	WinGet, WinID, ID, A
	WinGet, WinPID, PID, A
	WinGetClass, WinClass, A
	WinGet, WinProcessName, ProcessName, A
	WinGet, WinProcessPath, ProcessPath, A
	WinGet, ControlNames, ControlList, A	; Get all control names in this window
	
	; Create the ListView with two columns

	; Note that [ Gui, {configs...} ] declarations must come DIRECTLY (as-in the PREVIOUS LINE) BEFORE [ Gui, Add, ... ]
	Gui, Font, s10, Tahoma
	Gui, Font, s10, Consolas
	Gui, Font, s10, Courier New
	Gui, Font, s10, Open Sans
	Gui, Font, s10, Fira Code
	Gui, Color, 1E1E1E
	
	GUI_ROWCOUNT := 12
	GUI_WIDTH := 1000
	GUI_BACKGROUND_COLOR = 1E1E1E
	GUI_TEXT_COLOR = FFFFFF
	
	; Gui Listview has many options under its "G-Label" callback - See more @ https://www.autohotkey.com/docs/commands/ListView.htm#G-Label_Notifications_Secondary
	GUI_OPT = r%GUI_ROWCOUNT%
	GUI_OPT = %GUI_OPT% w%GUI_WIDTH%
	GUI_OPT = %GUI_OPT% gGetWindowSpecs_OnClick_LV_WindowSpecs
	GUI_OPT = %GUI_OPT% Background%GUI_BACKGROUND_COLOR%
	GUI_OPT = %GUI_OPT% C%GUI_TEXT_COLOR%
	GUI_OPT = %GUI_OPT% Grid
	GUI_OPT = %GUI_OPT% NoSortHdr
	; GUI_OPT = %GUI_OPT% AltSubmit

	Gui, Add, ListView, %GUI_OPT%, Key|Value

	LV_Add("", "WinTitle", WinTitle)
	LV_Add("", "WinClass", WinClass)
	LV_Add("", "ProcessName", WinProcessName)
	LV_Add("", "ProcessPath", WinProcessPath)
	LV_Add("", "ControlList", ControlNames)
	LV_Add("", "ID", WinID)
	LV_Add("", "PID", WinPID)
	LV_Add("", "Left", Left)
	LV_Add("", "Top", Top)
	LV_Add("", "Width", Width)
	LV_Add("", "Height", Height)
	LV_Add("", "Mimic in AHK", "WinMove,,,%Left%,%Top%,%Width%,%Height%")
	LV_Add("", "A_SendLevel", A_SendLevel)

	LV_ModifyCol(1, "AutoHdr Text Left")

	LV_ModifyCol(2, "AutoHdr Text Left")

	; LV_ModifyCol()  ; Auto-size each column to fit its contents.

	; Display the window and return. The script will be notified whenever the user double clicks a row.
	Gui, Show

	Return
}
;
; GetWindowSpecs_OnClick_LV_WindowSpecs  ^^^ NEEDED BY GET_WINDOW_SPECS()  ^^^
;   |--> Sub-Function of "GetWindowSpecs()"
;
GetWindowSpecs_OnClick_LV_WindowSpecs() {
	; Obj_EventTriggers := {"Normal": 1, "DoubleClick": 1, "RightClick": 1, "R": 1}
	Obj_EventTriggers := {"DoubleClick": 1, "RightClick": 1, "R": 1}
	If (Obj_EventTriggers[A_GuiEvent]) {
		LV_GetText(KeySelected, A_EventInfo, 1)  ; Grab the key (col. 1) associated with the double-click event
		LV_GetText(ValSelected, A_EventInfo, 2)  ; Grab the val (col. 2) associated with the double-click event
		MsgBox, 4, %A_ScriptName%,
		(LTrim
			You selected:
			%ValSelected%

			Copy this to the clipboard?
		)
		IfMsgBox Yes
		{
			Clipboard := ValSelected
		}
		; Gui, WindowSpecs:Default
		; Gui, Destroy
	}
	; DEBUGGING-ONLY (Set "%LV_Verbosity%" to 1 to enable verbose debug-logging)
	LV_Verbosity := 0
	If ( LV_Verbosity = 1 ) {
		TooltipOutput = A_GuiEvent=[%A_GuiEvent%], A_EventInfo=[%A_EventInfo%]
		ToolTip, %TooltipOutput%
		SetTimer, RemoveToolTip, -2500
	}
	Return
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
		; WinSet, 	, 80, ahk_pid %ExePID%
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
;   autohotkey.com  |  "How to block mouse input for a named window? - Ask for Help - AutoHotkey Community"  |  https://autohotkey.com/board/topic/29027-how-to-block-mouse-input-for-a-named-window/
;
;   autohotkey.com  |  "WinSet, Disable... not working as expected - Ask for Help - AutoHotkey Community"  |  https://autohotkey.com/board/topic/103478-winset-disable-not-working-as-expected/
;
;   www.autohotkey.com  |  "OnMessage() - Syntax & Usage | AutoHotkey"  |  https://www.autohotkey.com/docs/commands/OnMessage.htm#The_Functions_Parameters
;
;   www.autohotkey.com  |  "WinSet - Syntax & Usage | AutoHotkey"  |  https://www.autohotkey.com/docs/commands/WinSet.htm#Style
;
; ------------------------------------------------------------