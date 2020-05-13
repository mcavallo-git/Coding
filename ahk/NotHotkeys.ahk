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
;  HOTKEY:  WinKey + -
;  ACTION:  Craft it up
#-::
	SetKeyDelay, 0, -1
	CoordMode, Mouse, Screen
	SetDefaultMouseSpeed, 0
	SetControlDelay, -1
	SetTitleMatchMode, 1  ; A window's title must start with the specified WinTitle to be a match
	Sleep 2000

	Loop 2 {
		; ------------------------------------------------------------
		; Part 1-of-3 - Synthesize
		MouseClick, Left, 999, 759
		Sleep 2000  ; Wait for synthesize to finish

		; ------------------------------------------------------------
		; Part 2-of-3 Level 83 Start Craft
		Send {LAlt up}{RAlt up}{LAlt down}{5}{LAlt up}
		Sleep 36000
		Sleep 2000  ; General padding to let craft complete
		Random, RandomSleep, 1000, 5000  ; Random wait
		Sleep %RandomSleep%

		; ------------------------------------------------------------
		; Part 3-of-3 Level 83 Start Craft
		Send {LAlt up}{RAlt up}{LAlt down}{-}{LAlt up}
		Sleep 14000
		Sleep 2000  ; General padding to let craft complete
		Random, RandomSleep, 1000, 5000  ; Random wait
		Sleep %RandomSleep%

		Sleep 2000

	}

	Return


; ------------------------------------------------------------
;   HOTKEY:  Win + Esc
;   ACTION:  Refresh This Script  ::: Closes then re-opens this script (Allows saved changes to THIS script (file) be tested/applied on the fly)
;
#Escape::
	Reload
	Sleep 1000 ; If successful, the reload will close this instance during the Sleep, so the line below will never be reached.
	MsgBox, 4,, The script could not be reloaded. Would you like to open it for editing?
	IfMsgBox, Yes, Edit
	Return


; ------------------------------------------------------------