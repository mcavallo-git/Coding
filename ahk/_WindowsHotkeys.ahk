;==----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
;            >>>   _WindowsHotkeys.ahk, by Cavalol   <<<
;         AutoHotkey DL: https://autohotkey.com/download/
;
;  Official List of Autohotkey Buttons (Mouse, Keyboard, etc)
;           https://autohotkey.com/docs/KeyList.htm
;
;  Modifiers:
;    #  Windows-Key
;    !  Alt-Key
;    +  Shift-Key
;    ^  Control-Key
;
;  Specific Modifiers:
;    < Only the Left Modifier on the Keyboard   (<#, <!, <+, <^)
;    > Only the Right Modifier on the Keyboard  (>#, >!, >+, >^)
;
;
;  Variables and Expressions  :::  https://autohotkey.com/docs/Variables.htm#BuiltIn
;
;  Run/RunWait  :::  https://autohotkey.com/docs/commands/Run.htm
;  SysGet  :::  https://autohotkey.com/docs/commands/SysGet.htm
;
;==----------------------------------------------------------------------------------------------------------------------------------------------------------------

SetBatchLines, -1

SetWorkingDir, %A_ScriptDir%

DetectHiddenWindows, On

#Persistent

#SingleInstance Force

; #EscapeChar \  ; Change it to be backslash instead of the default of accent (`).

;==----------------------------------------------------------------------------------------------------------------------------------------------------------------

; #NoEnv  ; "Specifying the line #NoEnv anywhere in a script prevents empty variables from being looked up as potential environment variables" - AutoHotkey Docs

USERPROFILE=%USERPROFILE%

USER_DESKTOP=%USERPROFILE%\Desktop
 
USER_DOCUMENTS=%USERPROFILE%\Documents

;==----------------------------------------------------------------------------------------------------------------------------------------------------------------

SetCapsLockState, Off

;==----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
; Setup a group for targeting [Windows Explorer] windows

GroupAdd, Explorer, ahk_class ExploreWClass ; Unused on Vista and later

GroupAdd, Explorer, ahk_class CabinetWClass

;==----------------------------------------------------------------------------------------------------------------------------------------------------------------
;	Tooltip clearing tool(s)

RemoveToolTip() {
	ToolTip
	Return
}

ClearTooltip(TimerPeriod) {
	; If SetTimer's Period...
	;			 |--> is positive, it repeats its command until explicitly cancelled
	;			 |--> is negative, it only runs its command once
	SetTimer, RemoveToolTip, -%TimerPeriod%
	Return
}

;==----------------------------------------------------------------------------------------------------------------------------------------------------------------
;	SplashText clearing tool(s)

RemoveSplashText() {
	SplashTextOff
	Return
}

ClearSplashText(TimerPeriod) {
	; If SetTimer's Period...
	;			 |--> is positive, it repeats its command until explicitly cancelled
	;			 |--> is negative, it only runs its command once
	SetTimer, RemoveSplashText, -%TimerPeriod%
	Return
}
;
;==----------------------------------------------------------------------------------------------------------------------------------------------------------------
;   HOTKEY:  Win + Esc
;   ACTION:  Refresh This Script  ::: Closes then re-opens this script (Allows saved changes to THIS script (file) be tested/applied on the fly)
;
#Escape::
	Reload
	Sleep 1000 ; If successful, the reload will close this instance during the Sleep, so the line below will never be reached.
	MsgBox, 4,, The script could not be reloaded. Would you like to open it for editing?
	IfMsgBox, Yes, Edit
	Return
;

;==----------------------------------------------------------------------------------------------------------------------------------------------------------------
;   HOTKEY:  Win + Z
;		ACTION:  Grabs information about current (active) window's exe-filepath, process-id, on-screen location, & more, and displays it in a popup table Gui
;
#Z::

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

	Gui, Add, ListView, r%GUI_ROWCOUNT% w%GUI_WIDTH% gOnDoubleClick_GuiDestroy_WindowSpecs, Key|Val

	LV_Add("", "Title", WinTitle)
	LV_Add("", "Class", WinClass)
	LV_Add("", "ProcessName", WinProcessName)
	LV_Add("", "ProcessPath", WinProcessPath)
	LV_Add("", "ControlName(s)", ControlNames)
	LV_Add("", "ID", WinID)
	LV_Add("", "PID", WinPID)
	LV_Add("", "Left", Left)
	LV_Add("", "Top", Top)
	LV_Add("", "Width", Width)
	LV_Add("", "Height", Height)
	LV_Add("", "Mimic in AHK", "WinMove,,,%Left%,%Top%,%Width%,%Height%")

	LV_ModifyCol()  ; Auto-size each column to fit its contents.

	; Display the window and return. The script will be notified whenever the user double clicks a row.
	Gui, Show
	Return

OnDoubleClick_GuiDestroy_WindowSpecs() {
	if (A_GuiEvent = "DoubleClick") {
		Gui, WindowSpecs:Default
		Gui, Destroy
	}
	Return
}

;==----------------------------------------------------------------------------------------------------------------------------------------------------------------
;   HOTKEY:  Win + -
;		ACTION:  Type a line of -----'s
;
#V::
	OpenVSCode()
	Return
;
;==----------------------------------------------------------------------------------------------------------------------------------------------------------------
;   HOTKEY:  Win + V
;		ACTION:  Open Program (see below)
;
#-::
#NumpadSub::
	; StringToType := StringRepeat("-",60)
	SendInput, ------------------------------------------------------------
	Return
;
;==----------------------------------------------------------------------------------------------------------------------------------------------------------------
;   HOTKEY:  Win + Alt + V
;		ACTION:  Open Program (see below)
;
#!V::
	OpenVisualStudio()
	Return
;
;==----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
GetTimezoneOffset() {
	RET_VAL := ""
	T1 := A_Now
	T2 := A_NowUTC
	EnvSub, T1, %T2%, M
	MINUTES_DIFF := T1

	; SetFormat, float, 2.0
	TZ_SIGN := ""
	TZ_QUOTIENT := Floor(MINUTES_DIFF/60)
	TZ_REMAINDER := MINUTES_DIFF - TZ_QUOTIENT*60
	; +/- Timezone ahead/behind UTC determination
	if (TZ_QUOTIENT<0.0) {
		TZ_SIGN := "-"
		TZ_QUOTIENT *= -1
	} else {
		TZ_SIGN := "+"
	}
	; Hours - Left-Pad with Zeroes
	if (Abs(TZ_QUOTIENT) < 10) {
		TZ_QUOTIENT = 0%TZ_QUOTIENT%
	}
	; Minutes - Left-Pad with Zeroes
	if (Abs(TZ_REMAINDER) < 10) {
		TZ_REMAINDER = 0%TZ_REMAINDER%
	}

	RET_VAL = %TZ_SIGN%%TZ_QUOTIENT%%TZ_REMAINDER%
	RET_VAL := StrReplace(RET_VAL, ".", "")

	; TZ_REMAINDER := "GMT +" Floor(T1/60)
	Return %RET_VAL%
}

; Returns the timezone with "P" instead of "+", for fields which only allow alphanumeric with hyphens
GetTimezoneOffset_P() {
	RET_VAL := ""
	TZ_OFFSET := GetTimezoneOffset()
	RET_VAL := StrReplace(TZ_OFFSET, "+", "P")
	Return %RET_VAL%
}
;
;==----------------------------------------------------------------------------------------------------------------------------------------------------------------
; 
; Repeat a string a given number of times
StringRepeat(StrToRepeat, Multiplier) {
	ReturnedVal := ""
	If (Multiplier > 0) {
		Loop, %Multiplier% {
			ReturnedVal .= StrToRepeat
		}
	}
	Return ReturnedVal
}
;
;==----------------------------------------------------------------------------------------------------------------------------------------------------------------
;  HOTKEY:  Win + D
;  ACTION:  Types a variety of timestamp strings
;
; Timestamp		:::		Win + Shift + D
; Timestamp		:::		Win + Ctrl + D
; Timestamp		:::		Win + Alt + D
;
#D::
^#D::
!#D::
+#D::
+^#D::
+!#D::

	SetKeyDelay, 0, -1
		
	TimezoneOffset := GetTimezoneOffset_P()

	Needle_Win := "#D"
	Needle_AltWin := "!#D"
	Needle_CtrlWin := "^#D"

	; StringGetPos, pos, file, \, R%A_Index%
        ; if ErrorLevel
	
	If InStr(A_ThisHotkey, Needle_Win) { ; Win
		dat_format=yyyy-MM-dd_HH-mm-ss

	} Else If InStr(A_ThisHotkey, Needle_AltWin) { ; Alt + Win
		dat_format=yyyy.MM.dd-HH.mm.ss

	} Else If InStr(A_ThisHotkey, Needle_CtrlWin) { ; Ctrl + Win
		dat_format=yyyyMMdd-HHmmss

	} Else {
		dat_format=yyyy-MM-dd_HH-mm-ss
	}

	If WinActive("ahk_group Explorer") {
		dat_format := StrReplace(dat_format, ":", "-")
	}

	FormatTime, DatTimestamp, , %dat_format%

	Keys = %DatTimestamp%
	If InStr(A_ThisHotkey, "+") { ; Shift - concat the timezone onto the output timestamp
		Keys = %DatTimestamp%%TZ_OFFSET_P%
	}

  Send %Keys%

	Return
;
;==----------------------------------------------------------------------------------------------------------------------------------------------------------------
;  HOTKEY:  ?????
;  ACTION:  On-the-fly Timezone w/ format: [  -0500  ]
;
; ?????::
; 	TZ_OFFSET := GetTimezoneOffset()
;   Send %TZ_OFFSET%
; 	Return
;
;==----------------------------------------------------------------------------------------------------------------------------------------------------------------
;  HOTKEY:  Win + P
;  ACTION:  type the clipboard (workaround for paste blocking web-scripts)
;
+#P::
	SetKeyDelay, 0, -1
	MsgBox, 4,, Type the Clipboard? (Yes/No)
	IfMsgBox Yes
		Send %Clipboard%
	else {
		; MsgBox Skipped
	}
	Return
;
;==----------------------------------------------------------------------------------------------------------------------------------------------------------------
;  HOTKEY:  Win + H
;  ACTION:  type the COMPUTERNAME
;
#H::
	SetKeyDelay, 0, -1
	RET_VAL = %COMPUTERNAME%
  Send %RET_VAL%
	Return
;
;==----------------------------------------------------------------------------------------------------------------------------------------------------------------
;  HOTKEY:  Win + U
;  ACTION:  type the DOMAIN-USERNAME
;
#U::
	SetKeyDelay, 0, -1
	; RET_VAL = %USERNAME%
	RET_VAL = %USERDOMAIN%-%USERNAME%
  Send %RET_VAL%
	Return
;
;==----------------------------------------------------------------------------------------------------------------------------------------------------------------
;  HOTKEY:  Win + G
;  ACTION:  Types the contents of target file
;
#G::
	FilePathToRead=%USERPROFILE%\.gnupg\passphrase.personal
	FileRead, FilePathContents, %FilePathToRead%
	SendInput, %FilePathContents%
	Return
;
;==----------------------------------------------------------------------------------------------------------------------------------------------------------------
;  HOTKEY:  Win + W
;  ACTION:  Types the contents of target file
;
#W::
	FilePathToRead=%USERPROFILE%\.gnupg\passphrase.work
	FileRead, FilePathContents, %FilePathToRead%
	SendInput, %FilePathContents%
	Return
;
;==----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
;  ACTION:  On-the-fly Timezone w/ format: [  -0500  ]
;  HOTKEY:  Win + G
#F1::   ; #F1 / Win+F1 -- Edit this Script (the one you're reading right now)
	Run Notepad %A_ScriptFullPath%
	Return
;
;==----------------------------------------------------------------------------------------------------------------------------------------------------------------
;  HOTKEY:  Shift + Win + F2
;  ACTION:  Win10 Download & Delete Recordings via XBox Win10 App  !!! MAKE SURE TO HIDE SCREENSHOTS BEFOREHAND !!!
;
+#F2::
	Loop {
		MouseClick, Left, 861, 947
		Sleep 10000
		MouseClick, Left, 1420, 905
		Sleep 1000
		MouseClick, Left, 848, 575
		Sleep 7500
	}
	Return
;
;==----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
; #SC03D::   ; Win + F3
#F3::   ; Win + F3
	; Win10 Download & Delete Recordings via XBox Win10 App
	;  (MAKE SURE TO HIDE SCREENSHOTS BEFOREHAND)
	Loop {
		MouseClick, Left, 861, 947
		Sleep 90000
		MouseClick, Left, 1420, 905
		Sleep 1000
		MouseClick, Left, 848, 575
		Sleep 7500
	}
;
;==----------------------------------------------------------------------------------------------------------------------------------------------------------------
;  HOTKEY:  Win + F2
;  ACTION:  Show all (current) Window Titles
;
#F2::
	Gui, WinTitles:Default
	Gui, Add, ListView, r50 w1000 gOnDoubleClick_GuiDestroy_WinTitles, WindowTitle
	WinGet, Window, List
	Loop %Window% {
		Id:=Window%A_Index%
		WinGetTitle, TVar , % "ahk_id " Id
		If (Tvar != "") {
			LV_Add("", TVar)
			Window%A_Index%:=TVar ;use this if you want an array
			tList.=TVar "`n" ;use this if you just want the list
		}
	}
	; Gui, Add, Text,, %tList%
	Gui, Show
	; MsgBox %tList%
	Return


OnDoubleClick_GuiDestroy_WinTitles() {
	if (A_GuiEvent = "DoubleClick") {
		Gui, WinTitles:Default
		Gui, Destroy
	}
	Return
}

;==----------------------------------------------------------------------------------------------------------------------------------------------------------------
;  HOTKEY:  Fn Key (X1 Carbon)
;  ACTION:  Set Fn to perform CTRL action, instead
;
;SC163::   ;"Fn" Key
;Return
;
;==----------------------------------------------------------------------------------------------------------------------------------------------------------------
;  HOTKEY:  Windows-Key + [
;  ACTION:  FOLLOW-UP HOTKEY TO: Windows-key P   :::   Click "Duplicate" monitors
;
#[::
#]::
	CoordMode,Mouse,Screen
	SetDefaultMouseSpeed, 0
	SetControlDelay, -1
	SetTitleMatchMode, 1
	; Save current monitor config (to compare against once it's been updated)
	SysGet, MonitorCountBefore, MonitorCount
	SysGet, ViewportWidthBefore, 78
	SysGet, ViewportHeightBefore, 79
	; Save current mouse coordinates
	MouseGetPos, MouseX, MouseY
	; Send an Escape keypress to close any old Projection menus
	Send {Escape}
	Sleep 250
	If (A_OSVersion="WIN_7") {
		; Windows7
		If (A_ThisHotkey=="^#[") {
			; Duplicate Monitors
			x_loc := 874
			y_loc := 520
		} Else If (A_ThisHotkey=="^#]") {
			; Extend Monitors
			x_loc := 1044
			y_loc := 520
		}
		Send {LWin up}{RWin up}{LWin down}{p}{LWin up}
		Sleep 1000
		MouseClick, Left, %x_loc%, %y_loc%
		Sleep 1
		
	} Else If (substr(A_OSVersion, 1, 4)="10.0") {

		; Windows10
		Send {LWin up}{RWin up}{LWin down}{p}{LWin up}
		Sleep 250
		StartMilliseconds := A_TickCount
		Loop {
			LoopingForMilliseconds := (A_TickCount-StartMilliseconds)
			WinGetTitle, WinTitle, A
			WinGetClass, WinClass, A
			If ((WinTitle = "Project") && (WinClass = "Windows.UI.Core.CoreWindow")) {
				; Projection menu detected --> select related option (duplicate/extend)
				Sleep 250
				If (A_ThisHotkey=="#[") {
					; Duplicate Monitors
					x_loc := (A_ScreenWidth - 20)
					y_loc := 210
				} Else If (A_ThisHotkey=="#]") {
					; Extend Monitors
					x_loc := (A_ScreenWidth - 20)
					y_loc := 315
				}
				; Select Projection menu option
				MouseClick, Left, %x_loc%, %y_loc%
				; Wait until the new monitor layout is loaded
				Loop 30 {
					Sleep 100
					SysGet, MonitorCountAfter, MonitorCount
					If (MonitorCountAfter != MonitorCountBefore) {
						Break
					}
				}
				; Click outside of the Projection menu to close it
				MouseClick, Left, %MouseX%, %MouseY%
				Sleep 100
				; Send an Escape keypress to ensure the Projection menu closes
				Send {Escape}
				Sleep 100
				Break
			} Else If (LoopingForMilliseconds > 2000) {
				MsgBox, 
				(LTrim
					Error - Unable to locate Projection window
				)
				Break
			} Else {
				Sleep 10
			}
		}
	}

	MouseMove, %MouseX%, %MouseY%

	SysGet, MonitorCountAfter, MonitorCount
	SysGet, ViewportWidthAfter, 78
	SysGet, ViewportHeightAfter, 79

	Return

;
;==----------------------------------------------------------------------------------------------------------------------------------------------------------------
;  HOTKEY:  Windows-Key + Right-Click
;  ACTION:  Output cursor location
;
#RButton::
	CoordMode,Mouse,Screen
	MouseGetPos, MouseX, MouseY
	MsgBox,
	(LTrim
	Pointer Location
	➣X_loc:   %MouseX%
	➣Y_loc:   %MouseY%
	)
	Return
;
;==----------------------------------------------------------------------------------------------------------------------------------------------------------------
;  HOTKEY:  Windows-Key + L
;  ACTION:  Lock the Computer & put monitor(s) into 
;
#End::
#L::
	DllCall("LockWorkStation")  ; Lock the Computer
	Sleep 1000
	SendMessage,0x112,0xF170,2,,Program Manager 
	; 0x112  = WM_SYSCOMMAND
	; 0xF170 = SC_MONITORPOWER
	;            |-->  -1 = turn the monitor(s) on
	;            |-->   1 = activate low-power-mode on the monitor(s)
	;            |-->   2 = turn the monitor(s) off
	Return
; 
; Citation: https://autohotkey.com/docs/commands/PostMessage.htm
;
;==----------------------------------------------------------------------------------------------------------------------------------------------------------------
;  HOTKEY:  Windows-Key + N
;  ACTION:  Opens "View Network Connections" (in the Control Panel)
; 
#N::
	Run ::{7007acc7-3202-11d1-aad2-00805fc1270e}
	Return
; 
;==----------------------------------------------------------------------------------------------------------------------------------------------------------------
;  HOTKEY:  Windows-Key + E
;  ACTION:  Opens "USERPROFILE" directory
; 
#E::
	SplitPath, A_MyDocuments, , UserProfileDirname
	Run %UserProfileDirname%
	Return
; 
;==----------------------------------------------------------------------------------------------------------------------------------------------------------------
;  HOTKEY:  Windows-Key + O
;  ACTION:  Opens "Programs & Features" in the Control Panel
;
#O::
	Run "c:\windows\system32\appwiz.cpl"
	Return
;
;==----------------------------------------------------------------------------------------------------------------------------------------------------------------
;  HOTKEY:  Windows-Key + ` (Tilde)
;  ACTION:  Keyboard-Command for a Mouse-Left-Click
;
#`::
	MouseClick, Left
	Return
;
;==----------------------------------------------------------------------------------------------------------------------------------------------------------------
;  HOTKEY:  Alt + ` (Tilde)
;  ACTION:  Keyboard-Command for a Mouse-Right-Click
;
!`::
	MouseClick, Right
	Return
;
;==----------------------------------------------------------------------------------------------------------------------------------------------------------------
;  HOTKEY:  Win + Mouse-Wheel Up/Down
;  ACTION:  Turn computer volume up/down
;
#MButton::
^#MButton::
#WheelUp::
^#WheelUp::
#WheelDown::
^#WheelDown::

	Icon_LowVolume=🔈
	Icon_MuteVolume=🔇
	Icon_HighVolume=🔊

	VolumeLevel_Increment := 10

	Volume_ForceUpperLimit := 25

	SoundGet, VolumeLevel_BeforeEdits

	VolumeLevel_BeforeEdits := Round(VolumeLevel_BeforeEdits)

	If (A_ThisHotkey=="#MButton") {
		; Mute
		SoundSet, +1, , MUTE
	} Else If (A_ThisHotkey=="^#MButton") {
		; Mute (repeat w/ new hotkey)
		SoundSet, +1, , MUTE
	} Else If (A_ThisHotkey=="#WheelUp") {
		; Up
		SoundSet,+%VolumeLevel_Increment%
	} Else If (A_ThisHotkey=="^#WheelUp") {
		; Up (faster/slow)
		NewVolumeLevel_Increment := ( VolumeLevel_Increment / 2 )
		SoundSet,+%NewVolumeLevel_Increment%
	} Else If (A_ThisHotkey=="#WheelDown") {
		; Down
		SoundSet,-%VolumeLevel_Increment%
	} Else If (A_ThisHotkey=="^#WheelDown") {
		; Down (faster/slow)
		NewVolumeLevel_Increment := ( VolumeLevel_Increment / 2 )
		SoundSet,-%NewVolumeLevel_Increment%
	}
	; Get the volume & mute current-settings
	SoundGet, NewVolumeLevel
	SoundGet, MasterMute, , MUTE
	; Final volume level
	NewVolumeLevel := Round(NewVolumeLevel)
	NewVolumeLevelPercentage=%NewVolumeLevel%`%
	; Build the volume-bars (out-of dingbats utf8+ icons)
	DingbatCount_MaxVolume := Round( ( 100 / VolumeLevel_Increment ) * 2 )
	VolumeBarsCount   := Round( ( NewVolumeLevel / 100 ) * DingbatCount_MaxVolume)
	VolumeSpacesCount := DingbatCount_MaxVolume - VolumeBarsCount
	VolumeBars   := StringRepeat("⬛️",VolumeBarsCount)
	VolumeSpaces := StringRepeat("⬜️",VolumeSpacesCount)
	FinalVolumeBars := VolumeBars VolumeSpaces
	Length_FinalBars := StrLen(FinalVolumeBars)
	TrimCount := Round(Length_FinalBars/2)
	StringTrimRight, FinalVolume_LeftHalf, FinalVolumeBars, TrimCount
	StringTrimLeft, FinalVolume_RightHalf, FinalVolumeBars, TrimCount
	; Prep the padding around the Volume Pentage
	Padding_CenterTopBot=------
	Padding_CenterLeft := A_Space A_Space A_Space A_Space A_Space A_Space
	Padding_CenterRight := Padding_CenterLeft
	If ( MasterMute == "On") {
		Padding_CenterLeft := A_Space Icon_MuteVolume A_Space
		Padding_CenterRight := A_Space Icon_MuteVolume A_Space
	}
	Padding_CenterTopBot=%Padding_CenterTopBot%--
	If (NewVolumeLevel < 100) {
		Padding_CenterLeft := Padding_CenterLeft A_Space
		Padding_CenterRight := A_Space Padding_CenterRight
		If (NewVolumeLevel < 10) {
			Padding_CenterLeft := Padding_CenterLeft A_Space
			Padding_CenterRight := A_Space Padding_CenterRight
		}
	}
	VolumeReplacement := StringRepeat(" ",30)
	Output_TopLine=%Icon_LowVolume%   %FinalVolume_LeftHalf% %VolumeReplacement% %FinalVolume_RightHalf%  %Icon_HighVolume%
	Output_MidLine=%Icon_LowVolume%   %FinalVolume_LeftHalf%≡≡%Padding_CenterLeft%%NewVolumeLevelPercentage%%Padding_CenterRight%≡≡%FinalVolume_RightHalf%  %Icon_HighVolume%
	Output_BotLine=%Icon_LowVolume%   %FinalVolume_LeftHalf% %VolumeReplacement% %FinalVolume_RightHalf%  %Icon_HighVolume%

	OutputTextLen := ( StrLen(Output_MidLine) - 2 )
	OutputBlanks := StringRepeat(" ",95)
	OutputBlankLine := Icon_LowVolume OutputBlanks Icon_HighVolume

	Output_Combined=%Output_TopLine%`n%Output_MidLine%`n%Output_BotLine%
	
	OutputWidth := 317
	OutputHeight := 20
	StartMenuHeight := 40
	; Show the output as a tooltip
	x_loc := Round( ( A_ScreenWidth - OutputWidth ) / 2 )
	y_loc := Round( ( A_ScreenHeight - StartMenuHeight - OutputHeight ) / 2 )
	; y_loc := 50
	; y_loc := ( A_ScreenHeight - ( OutputHeight * 3 ) )
	ToolTip, %Output_Combined%, %x_loc%, %y_loc%
	ClearTooltip(750)
	Return
;
;==----------------------------------------------------------------------------------------------------------------------------------------------------------------
;  HOTKEY:  Alt + Mouse-Wheel Up/Down
;  ACTION:  "SuperScroll" - scrolls 15 wheel-clicks at a time
;
!WheelUp::
	MouseClick,WheelUp,,,15,0,D,R
	Return
;
!WheelDown::
	MouseClick,WheelDown,,,15,0,D,R
	Return
;
;==----------------------------------------------------------------------------------------------------------------------------------------------------------------
;  HOTKEY:  "Rock" the Mouse's Wheel Left or Right   (Mouse-Wheel-Left or Mouse-Wheel-Right)
;  ACTION:  Change Tabs Left or Right
;
WheelLeft::
	Send ^{PgUp}
	Return
WheelRight::
	Send ^{PgDn}
	Return
;
;==----------------------------------------------------------------------------------------------------------------------------------------------------------------
;  HOTKEY:  Windows-Key + C
;  ACTION:  Chrome - Open a New Instance of Google Chrome
;
#C::
	; ------------------------------------------------------------
	OpenChrome()
	; TabSpace_Loop(50)
	Return
;
;==----------------------------------------------------------------------------------------------------------------------------------------------------------------
;  HOTKEY:  Ctrl + Win + C
;  ACTION:  Workbench hotkey for quick-testing, one-time wizbangs, etc.
;
^#C::
	; WinTitle=Task Scheduler
	; WinTitle=Visual Studio Code
	; SpaceUp_Loop(50, WinTitle)
	SpaceUp_Loop(50)
	Return
;
;==----------------------------------------------------------------------------------------------------------------------------------------------------------------
;  HOTKEY:  Windows-Key + F
;  ACTION:  Effective File Search - Open a new Instance of EFS
;
#F::
	; Verify that Effective File Search exists
	; exe_filepath := "C:`\Program Files (x86)`\efs`\search.exe"
	efs=\Effective File Search.efsp
	; iso=C:\ISO
	exe_filepath := "C:`\ISO`\Effective File Search.efsp"
	exe_filepath2=%A_MyDocuments%%efs%
	; MsgBox, % exe_filepath2
	if (FileExist(exe_filepath)) {
		Run, %exe_filepath%
	} Else {
		if (FileExist(exe_filepath2)) {
			Run, %exe_filepath2%
		} else {
			; If EFS does NOT exist, offer user the URL to download it
			exe_download_url := "http://www.sowsoft.com/download/efsearch.zip"
			MsgBox, 4, Download EFS?, Effective File Search not found`n`nDownload EFS Now?
			IfMsgBox Yes
				Run, chrome.exe %exe_download_url%
		}
	}
	Return
;
;==----------------------------------------------------------------------------------------------------------------------------------------------------------------
;  HOTKEY:  Left-Shift + Right-Shift
;  ACTION:  Maximize Current Window
;
; VKA0 & VKA1::     ;VKA1 = RShift
; VKA1 & VKA0::     ;VKA0 = LShift
; SC02A & SC136::   ;SC136 = RShift
; SC136 & SC02A::   ;SC02A = LShift
; >+LShift::        ;>+ = RShift (Modifier)
; <+RShift::        ;<+ = LShift (Modifier)
RShift & LShift::
LShift & RShift::
	ActiveWindow_ToggleRestoreMaximize()
	Return
;
;==----------------------------------------------------------------------------------------------------------------------------------------------------------------
;==----------------------------------------------------------------------------------------------------------------------------------------------------------------
;  Win+J - [DevOps] - Startup Node.JS (Git-Bash) && Postman
;
#J::
	; - -
	SG_REPO=%USERPROFILE%/Documents/GitHub/supplier_gateway
	; - -
	POSTMAN_EXE=%LOCALAPPDATA%/Postman/Update.exe
	GIT_BASH_EXE=%PROGRAMFILES%\Git\git-bash.exe
	; - -
	SG_BUILD_SCRIPT=%SG_REPO%/build/_start_frontend.sh
	SG_BUILD_API_LNK=%SG_REPO%/_start_server_api.lnk
	SG_BUILD_PM_LNK=%SG_REPO%/_start_server_pm.lnk
	SG_BUILD_SG_LNK=%SG_REPO%/_start_server_sg.lnk
	; - -
	WinTitle_NodeJS=Supplier Gateway (localhost)
	WinTitle_Postman=Postman
	; - -
	if ((!FileExist(SG_REPO)) || (!InStr(FileExist(SG_REPO), "D"))) {
		MsgBox, 
		(LTrim
			Error - Required directory not-found:
			%SG_REPO%
		)
	} else {
		; Microsoft Windows has some unusual values for the window-bounds, when maximized/snapped
		Increment_Left := -7
		Increment_Top := 0
		Increment_Width := 14
		Increment_Height := 7
		; Prep Monitor Widths/Heights
		SysGet, MonitorCount, MonitorCount , N
		BoundsLeft = -1
		BoundsRight = -1
		BoundsTop = -1
		BoundsBottom = -1
		BoundsCenterHoriz = 0
		BoundsCenterVert = 0
		Loop, %MonitorCount% {
			SysGet, MonitorWorkArea, MonitorWorkArea, %A_Index%
			; If (%MonitorWorkAreaLeft% > %BoundsLeft%) {
			If (BoundsLeft < MonitorWorkAreaLeft)
			{
				; MsgBox, Floor(BoundsLeft) < Floor(MonitorWorkAreaLeft)
				; Widths
				BoundsLeft := MonitorWorkAreaLeft
				BoundsRight := MonitorWorkAreaRight
				; Heights
				BoundsTop := MonitorWorkAreaTop
				BoundsBottom := MonitorWorkAreaBottom
			} Else {
				; MsgBox, Floor(BoundsLeft) >= Floor(MonitorWorkAreaLeft)
			}
		}
		; Widths
		BoundsWidthFull := (BoundsRight - BoundsLeft)
		BoundsWidthHalf := Floor(BoundsWidthFull/2)
		BoundsCenterHoriz := (BoundsLeft + BoundsWidthHalf)
		; Heights
		BoundsHeightFull := (BoundsBottom - BoundsTop)
		BoundsHeightHalf := Floor(BoundsHeightFull/2)
		BoundsCenterVert := (BoundsTop + BoundsHeightHalf)
		SetTitleMatchMode, 1
		; - -
		WinTitle_Postman=Postman
		WinTitle_NodeJS=Supplier Gateway (localhost)
		; - -
		; Start Postman
		IfWinNotExist,%WinTitle_Postman%
		{
			; Need to run the program, as no window was found for it (yet)
			POSTMAN_ARGS= --processStart Postman.exe
			; POSTMAN_ARGS=--processStart Postman.exe
			Run, %POSTMAN_EXE% %POSTMAN_ARGS%
		}
		; - -
		Sleep 100
		; - -
		; Start Node.JS in Git-Bash
		IfWinNotExist,%WinTitle_NodeJS%
		{
			GIT_BASH_ARGS_API=-c "C:/Users/%USERNAME%/Documents/GitHub/supplier_gateway/build/_start_frontend.sh rest-api start-localhost;"
			GIT_BASH_ARGS_PM=-c "C:/Users/%USERNAME%/Documents/GitHub/supplier_gateway/build/_start_frontend.sh boneal-app start-localhost;"
			GIT_BASH_ARGS_SG=-c "C:/Users/%USERNAME%/Documents/GitHub/supplier_gateway/build/_start_frontend.sh project-manager start-localhost;"
			Run, %GIT_BASH_EXE% %GIT_BASH_ARGS_API%, %SG_REPO%
			; Run, %GIT_BASH_EXE% %GIT_BASH_ARGS_PM%, %SG_REPO%
			; Run, %GIT_BASH_EXE% %GIT_BASH_ARGS_SG%, %SG_REPO%
		}
		;
		; Wait for the script(s)/program(s) to start before moving them around
		; WinWait,%WinTitle_Postman%,,5
		; WinWait,%WinTitle_NodeJS%,,3
		; Move the window to occupy the right-half of the Right-Most monitor
		; WinMove,%WinTitle_Postman%,,%BoundsCenterHoriz%,%BoundsTop%,%BoundsWidthHalf%,%BoundsHeightFull%
		; WinMove,%WinTitle_Postman%,,953,0,974,1047 (1st Monitor, Right, Actual)
		; Move the window to occupy the left-half of the Right-Most monitor
		; WinMove,%WinTitle_NodeJS%,,%BoundsLeft%,%BoundsTop%,%BoundsWidthHalf%,%BoundsHeightFull%
		; WinMove,%WinTitle_NodeJS%,,-7,0,974,1047 ;; (1st Monitor, Left, Actual)
		;
	}
	Return
;
;	----------------------------------------------------------------------------------------------------------------------------------------------------------------
;  Win+T - [DevOps] - Get Windows Environment Variables (output to desktop)
;
#T::
	; - -
	FormatTime,TIMESTAMP,,yyyyMMdd-HHmmss
	Logfile_EnvVars=%USER_DESKTOP%\WindowsEnvVars-%COMPUTERNAME%-%USERNAME%.log.txt
	Logfile_EnvVars_Timestamp=%USER_DESKTOP%\WindowsEnvVars-%COMPUTERNAME%-%USERNAME%-%TIMESTAMP%.log.txt
	; - -
	KnownWinEnvVars=
	(LTrim
	==========================================================================

	*** Variables for Current Session ***

	TIMESTAMP = %TIMESTAMP%

	--------------------------------------------------------------------------

	*** Windows Environment Variables (Long-standing) ***

	COMPUTERNAME         %COMPUTERNAME%
	USERNAME             %USERNAME%
	USERDOMAIN           %USERDOMAIN%
	LOGONSERVER          %LOGONSERVER%
	
	ALLUSERSPROFILE      %ALLUSERSPROFILE%
	APPDATA              %APPDATA%
	COMMONPROGRAMFILES   %COMMONPROGRAMFILES%
	HOMEDRIVE            %HOMEDRIVE%
	HOMEPATH             %HOMEPATH%
	LOCALAPPDATA         %LOCALAPPDATA%
	PROGRAMDATA          %PROGRAMDATA%
	PROGRAMFILES         %PROGRAMFILES%
	PUBLIC               %PUBLIC%
	SYSTEMDRIVE          %SYSTEMDRIVE%
	SYSTEMROOT           %SYSTEMROOT%
	TEMP                 %TEMP%
	TMP                  %TMP%
	USERPROFILE          %USERPROFILE%
	WINDIR               %WINDIR%

	--------------------------------------------------------------------------

	*** Autohotkey Variables ***

	A_AhkVersion: %A_AhkVersion%
	A_AhkPath: %A_AhkPath%
	A_IsUnicode: %A_IsUnicode%
	A_IsCompiled: %A_IsCompiled%
	
	A_WorkingDir: %A_WorkingDir%
	A_ScriptDir: %A_ScriptDir%

	A_ScriptName: %A_ScriptName%
	A_ScriptFullPath: %A_ScriptFullPath%

	A_LineFile: %A_LineFile%
	A_LineNumber: %A_LineNumber%

	A_ThisLabel: %A_ThisLabel%
	A_ThisFunc: %A_ThisFunc%

	==========================================================================
	)
	; - -
	FileAppend, %KnownWinEnvVars%, %Logfile_EnvVars_Timestamp%
	Run, Edit "%Logfile_EnvVars_Timestamp%"
	Return
;
;	----------------------------------------------------------------------------------------------------------------------------------------------------------------
;  Win+K - [DevOps] - Bring-to-Foreground:  Node.JS (Git-Bash) && Postman
#K::
	;
	WinTitle_NodeJS=Supplier Gateway (localhost)
	WinTitle_Postman=Postman
	; MsgBox, A_OSVersion = %A_OSVersion%
	;
	; Windows sets some weird values for its bounds when a window is maximized
	if (A_OSVersion = "WIN_7") {
		; Windows 7 OS
		Increment_Left := 0
		Increment_Top := 0
		Increment_Width := 0
		Increment_Height := 0
	} else {
		; Non Windows-7 OS
		Increment_Left := -7
		Increment_Top := 0
		Increment_Width := 14
		Increment_Height := 7
	}
	; Prep Monitor Widths/Heights
	SysGet, MonitorCount, MonitorCount , N
	BoundsLeft = -1
	BoundsRight = -1
	BoundsTop = -1
	BoundsBottom = -1
	BoundsCenterHoriz = 0
	BoundsCenterVert = 0
	Loop, %MonitorCount% {
		SysGet, MonitorWorkArea, MonitorWorkArea, %A_Index%
		If (BoundsLeft < MonitorWorkAreaLeft)
		{
			; MsgBox, Floor(BoundsLeft) < Floor(MonitorWorkAreaLeft)
			; Widths
			BoundsLeft := MonitorWorkAreaLeft
			BoundsRight := MonitorWorkAreaRight
			; Heights
			BoundsTop := MonitorWorkAreaTop
			BoundsBottom := MonitorWorkAreaBottom
		}
	}
	; Widths
	BoundsWidthFull := (BoundsRight - BoundsLeft)
	BoundsWidthHalf := Floor(BoundsWidthFull/2)
	BoundsCenterHoriz := (BoundsLeft + BoundsWidthHalf)
	; Heights
	BoundsHeightFull := (BoundsBottom - BoundsTop)
	BoundsHeightHalf := Floor(BoundsHeightFull/2)
	BoundsCenterVert := (BoundsTop + BoundsHeightHalf)
	SetTitleMatchMode, 1
	IfWinExist,%WinTitle_NodeJS%
	{
		IfWinExist,%WinTitle_Postman%
		{
			;
			; SIMULATE: Snap Left / Snap Right
			;
			if (MonitorCount = 2) {
				;
				; 2-Monitors
				;
				if (A_OSVersion = "WIN_7") {
					; Msgbox, AAA
					WinMove,%WinTitle_NodeJS%,,1920,0,960,1080
					WinMove,%WinTitle_Postman%,,2880,0,960,1080
					;
					;		Win7
					;			Left-Mon (Mon-1)
					; 			Left-Snap   -->  WinMove,%WinTitle%,,0,0,960,1040       ; w/ taskbar
					; 			Right-Snap  -->  WinMove,%WinTitle%,,960,0,960,1040     ; w/ taskbar
					; 			Maximized   -->  WinMove,%WinTitle%,,-8,-8,1936,1056    ; w/ left-taskbar
					; 		Right-Mon (Mon-2)
					; 			Left-Snap   -->  WinMove,%WinTitle%,,1920,0,960,1080       ; w/ no taskbar
					; 			Right-Snap  -->  WinMove,%WinTitle%,,2880,0,960,1080     ; w/ no taskbar
					; 			Maximized   -->  WinMove,%WinTitle%,,-8,-8,1936,1056    ; w/ no taskbar
					;
				} Else {
					; Msgbox, BBB
					WinMove,%WinTitle_NodeJS%,,1913,0,974,1047
					WinMove,%WinTitle_Postman%,,2873,0,974,1047
					;
					;		Win10
					; 		Left-half,  Left-Mon   -->  WinMove,%WinTitle%,,-7,0,974,1047      ; w/ taskbar
					; 		Right-half, Left-Mon   -->  WinMove,%WinTitle%,,953,0,974,1047    ; w/ taskbar
					; 		Left-half,  Right-Mon  -->  WinMove,%WinTitle%,,1913,0,974,1047    ; w/ taskbar
					; 		Right-half, Right-Mon  -->  WinMove,%WinTitle%,,2873,0,974,1047   ; w/ taskbar
					;
					; WinMove,%WinTitle_NodeJS%,,%BoundsLeft%,%BoundsTop%,%BoundsWidthHalf%,%BoundsHeightFull%
				}
			} Else {
				; Not-2-Monitors (Assumes 1)
				if (A_OSVersion = "WIN_7") {
					; Win-7, 1-Monitor
					; Msgbox, CCC
					WinMove,%WinTitle_NodeJS%,,0,0,960,1040
					WinMove,%WinTitle_Postman%,,960,0,960,1040
				} Else {
					; Win-10, 1-Monitor
					; Msgbox, DDD
					WinMove,%WinTitle_NodeJS%,,1913,0,974,1047
					WinMove,%WinTitle_Postman%,,2873,0,974,1047
				}
			}
			WinActivate,%WinTitle_NodeJS%
			WinActivate,%WinTitle_Postman%
		} Else {
			; Msgbox, EEE
		}
	} Else {
		; Msgbox, FFF
	}
	Return
;
;==----------------------------------------------------------------------------------------------------------------------------------------------------------------
;	@  OpenChrome - Opens the application "Visual Studio Code"
OpenChrome() {
	OPEN_TO_URL = www.google.com
	Run % "chrome.exe" ( winExist("ahk_class Chrome_WidgetWin_1") ? " --new-window " : " " ) OPEN_TO_URL
	Return
}
;
;==----------------------------------------------------------------------------------------------------------------------------------------------------------------
;	@  OpenVisualStudio - Opens the application "Visual Studio Code"
OpenVisualStudio() {
	TargetExe := "C:\Program Files (x86)\Microsoft Visual Studio\2017\Professional\Common7\IDE\devenv.exe"
	Run % TargetExe
	Return
}
;
;==----------------------------------------------------------------------------------------------------------------------------------------------------------------
;	@ TabSpace_Loop
;			Designed for Samsung SmartThings' Web-IDE where (sometimes) multiple hundreds of
;			checkboxes need to be selected individually to update from a Git repo
TabSpace_Loop(LoopIterations) {
	Loop %LoopIterations% {
		Send {Tab}
		Sleep 10
		Send {Space}
		Sleep 10
	}
	Return
}
;
;==----------------------------------------------------------------------------------------------------------------------------------------------------------------
;	@ SendSpace
;			For some reason, windows 10 doesn't like Send {Space} (as-in it 'ignores' the
;			keypress), but happily accepts Send {SC039} as equivalent to a spacebar-press
SendSpace() {
	Send {SC039}
	Return
}
;==----------------------------------------------------------------------------------------------------------------------------------------------------------------
;	@ Space..._Loop
;			Designed for Windows Task Scheduler to quickly show open all tasks on the main
;			page, which can then be sorted (but only for the ones that've been opened)
SpaceUp_Loop(LoopIterations) {
	Loop %LoopIterations% {
		Sleep 500
		Send {SC039}
		SendSpace()
		Sleep 500
		Send {Up}
	}
	Return
}
; SpaceUp_Loop(LoopIterations, WinTitle) {
; 	SetKeyDelay, 0, -1
; 	SetControlDelay, -1
; 	SetTitleMatchMode, 2
; 	; WinActivate,%WinTitle%
; 	Loop %LoopIterations% {
; 		DatStr=Sending {Space} to %WinTitle%
; 		ToolTip, %DatStr%, 250, %A_Index%, `
; 		ControlSend,, {Space}, %WinTitle%
; 		; Send {Space}
; 		Sleep 100
; 		DatStr=Sending {Up} to %WinTitle%
; 		ToolTip, %DatStr%, 500, %A_Index%, 2
; 		ControlSend,, {Up}, %WinTitle%
; 		; Send {Up}
; 		Sleep 100
; 	}
; 	Return
; }
;
;==----------------------------------------------------------------------------------------------------------------------------------------------------------------
;  @  OpenVSCode - Opens the application "Visual Studio Code"
OpenVSCode() {
	; Set Path to VSCode Executable
	VSCode_Dir=C:\Program Files\Microsoft VS Code
	VSCode_Exe=%VSCode_Dir%\Code.exe
	; Set Path to VSCode Workspace
	Repos_Dirname=GitHub
	GitHub_Dir=%A_MyDocuments%\%Repos_Dirname%
	; Runtime Variables
	WinTitle=%Repos_Dirname% - Visual Studio Code
	SetTitleMatchMode, 2
	if !WinExist(WinTitle) {
		; MsgBox,0,AHK-Log,VSCode-Window NOT found
		Run, %VSCode_Exe% %GitHub_Dir%,,Hide,WinPID
		WinWait,%WinTitle%,,15
	}
	; SysGet, MonitorCount, MonitorCount, N
	; WinPID := WinExist(WinTitle)
	if (WinExist(WinTitle)) {
		if (A_OSVersion = "WIN_7") {
			WinMove,%WinTitle%,,-8,-8,1936,1056
		} Else {
			WinMove,%WinTitle%,,0,0,1920,1040
		}
		WinActivate,%WinTitle%
		WinMaximize,%WinTitle%
	}
	; WinGet, WinPID, PID, %WinTitle%
	; WinGet, ProcessName, ProcessName, %WinTitle%
	; WinGet, ProcessPath, ProcessPath, %WinTitle%
	; MsgBox, 0, Active Window Specs,
	; 	(LTrim
	; 		➣ A_Temp:   %A_Temp%
	; 		➣ A_OSVersion:   %A_OSVersion%
	; 		➣ WinTitle:   %WinTitle%
	; 		➣ ProcessName:   %ProcessName%
	; 		➣ ProcessPath:   %ProcessPath%
	; 		➣ WinPID:   %WinPID%
	; 	)
	Return
}
;
;==----------------------------------------------------------------------------------------------------------------------------------------------------------------
;   @ ActiveWindow_ToggleRestoreMaximize - Toggle Active Window:  "Maximized" / "Non-Maximized"
ActiveWindow_ToggleRestoreMaximize() {
	WinGet, WinState, MinMax, A
	WinGet, WinStyle, Style, A
	; WinGet, OutputVar, MinMax 
	if (WinState>0) { ; Window is maximized - restore it
		WinRestore A
	} else if (WinState=0) { ; Window is neither maximized nor minimized - maximize it
		WinMaximize A
	} else if (WinState<0) { ; Window is minimized - restore it, I guess?
		WinRestore A
	}
	Return
}
;==----------------------------------------------------------------------------------------------------------------------------------------------------------------
;   @ ActiveWindow_Maximize - Only maximize active window if it isn't maximized already
ActiveWindow_Maximize() {
	WinGet, WinState, MinMax, A
	if (WinState<=0) { ; Window is not maximized - maximize it
		WinMaximize A
	}
	Return
}
;
;==----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
get_ahk_id_from_title(WinTitle,ExcludeTitle) {
	SetTitleMatchMode, 2
	ControlGet, output_var, Hwnd,,, %WinTitle%,, %ExcludeTitle%
	dat_ahk_id=ahk_id %output_var%
	Return dat_ahk_id
}
get_ahk_id_from_pid(WinPid) {
	SetTitleMatchMode, 2
	ControlGet, output_var, Hwnd,,, ahk_pid %WinPid%
	dat_ahk_id=ahk_id %output_var%
	Return dat_ahk_id
}
;
;==----------------------------------------------------------------------------------------------------------------------------------------------------------------
;  HOTKEY:  Caps Lock
;  ACTION:  Permanently disable CapsLock (unless Shift+CapsLock is pressed, then toggle CapsLock like normal)
;
CapsLock::
^CapsLock::
!CapsLock::
#CapsLock::
	SetCapsLockState, Off
	Return
+CapsLock::
	SetCapsLockState, % GetKeyState("CapsLock", "T") ? "Off" : "On"
	Return
;
;==----------------------------------------------------------------------------------------------------------------------------------------------------------------
;

; Gosub, NumCapsScrollLock_CreateOSD
; Return

; NumCapsScrollLock_CreateOSD:
; {
; 	Gui, NumCapsScrollLock:Default
; 	Gui, -caption +toolwindow +alwaysontop +lastfound
; 	Gui, color, 8b0fc6
; 	Gui, font, s10 w600, Arial Bold
; 	Gui, margin, 0, 0
; 	WinSet, transcolor, 8b0fc6
	
; 	n_color := GetKeyState("NumLock", "t") ? "98cb4a" : "5481E6"
; 	c_color := GetKeyState("CapsLock", "t") ? "98cb4a" : "5481E6"
; 	s_color := GetKeyState("ScrollLock", "t") ? "98cb4a" : "5481E6"

; 	Gui, add, listview, x0 y0 w60 h16 -hdr -e0x200 -multi background%n_color% v_numlock gNumCapsScrollLock_lv altsubmit
; 	Gui, add, text, x0 y0 w60 h16 0x201 cffffff backgroundtrans vtxt_numlock, N

; 	Gui, add, listview, x63 y0 w60 h16 -hdr -e0x200 -multi background%c_color% v_capslock gNumCapsScrollLock_lv altsubmit
; 	Gui, add, text, x63 y0 w60 h16 0x201 cffffff backgroundtrans vtxt_capslock, C

; 	Gui, add, listview, x126 y0 w60 h16 -hdr -e0x200 -multi background%s_color% v_scrolllock gNumCapsScrollLock_lv altsubmit
; 	Gui, add, text, x126 y0 w60 h16 0x201 cffffff backgroundtrans vtxt_scrolllock, S
; }
; Return

; NumLock::
; CapsLock::
; ScrollLock::
; {
; 	; Gui, NumCapsScrollLock:Default
; 	if (!locked_%a_thishotkey%)
; 	{
; 		NumCapsScrollLock_ToggleKey(a_thishotkey)
; 		; soundplay, beep.wav
; 		color := GetKeyState(a_thishotkey, "t") ? "98cb4a" : "5481E6"
; 		GuiControl, +background%color%, _%a_thishotkey%
; 		GuiControl, Hide, txt_%a_thishotkey%
; 		GuiControl, Show, txt_%a_thishotkey%
; 	}
; 	sysget, var_, monitorworkarea
; 	x := (var_right-190)
; 	y := (var_bottom-26)
; 	Gui, Show, x%x% y%y% na, OSD
; 	settimer, NumCapsScrollLock_Cancel, -3000
; 	keywait, % a_thishotkey
; }
; Return

; NumCapsScrollLock_lv:
; {
; 	; Gui, NumCapsScrollLock:Default
; 	if (A_GuiEvent = "normal") or (A_GuiEvent = "doubleclick")
; 	{
; 		control := ltrim(a_guicontrol, "_")
; 		if (!locked_%control%)
; 			{
; 				NumCapsScrollLock_ToggleKey(control)
; 				; soundplay, beep.wav
; 				color := GetKeyState(control, "t") ? "98cb4a" : "5481E6"
; 				GuiControl, +background%color%, %a_guicontrol%
; 				GuiControl, Hide, txt%a_guicontrol%
; 				GuiControl, Show, txt%a_guicontrol%
; 			}
; 		settimer, NumCapsScrollLock_Cancel, -3000
; 	}
; 	else if (A_GuiEvent = "rightclick")
; 	{
; 		NumCapsScrollLock_LockUnlock(ltrim(a_guicontrol, "_"))
; 		; soundplay, click.wav
; 		settimer, NumCapsScrollLock_Cancel, -3000
; 	}
; }
; Return

; NumCapsScrollLock_ToggleKey(key)
; {
; 	if (key = "CapsLock")
; 	{
; 		; SetCapsLockState, % GetKeyState(key, "t") ? "off" : "on"
; 		SetCapsLockState, Off
; 	}
; 	else if (key = "ScrollLock")
; 	{
; 		SetScrollLockState, % GetKeyState(key, "t") ? "off" : "on"
; 	}
; 	else if (key = "NumLock")
; 	{
; 		SetNumLockState, % GetKeyState(key, "t") ? "off" : "on"
; 	}
; 	Return
; }

; NumCapsScrollLock_LockUnlock(key)
; {
; 	Global locked_numlock, locked_capslock, locked_scrolllock
; 	if (key = "NumLock")
; 	{
; 		if (locked_numlock)
; 			{
; 				SetNumLockState
; 				locked_numlock := 0
; 			}
; 		else
; 			{
; 				SetNumLockState, % GetKeyState(key, "t") ? "AlwaysOn" : "AlwaysOff"
; 				locked_numlock := 1
; 			}
; 	}
; 	else if (key = "CapsLock")
; 	{
; 		if (locked_capslock)
; 			{
; 				SetCapsLockState
; 				locked_capslock := 0
; 			}
; 		else
; 			{
; 				SetCapsLockState, % GetKeyState(key, "t") ? "AlwaysOn" : "AlwaysOff"
; 				locked_capslock := 1
; 			}
; 	}
; 	else if (key = "ScrollLock")
; 	{
; 		if (locked_scrolllock)
; 			{
; 				SetScrollLockState
; 				locked_scrolllock := 0
; 			}
; 		else
; 			{
; 				SetScrollLockState, % GetKeyState(key, "t") ? "alwayson" : "AlwaysOff"
; 				locked_scrolllock := 1
; 			}
; 	}
; 	Return
; }

; NumCapsScrollLock_Cancel:
; {
; 	; Gui, NumCapsScrollLock:Default
; 	Gui, Cancel
; }
; Return

; ;	Citation(s)
; ;
; ; NumCapsScrollLock  :::  Thanks to user [ dmg ] on AutoHotkey forum [ https://autohotkey.com/boards/viewtopic.php?p=22579#p22579 ]
; ;

;
;==----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
	
	
  ;                                  ;
 ;;;                                ;;;
;;;;;     ADD NEW SCRIPTS HERE     ;;;;;
 ;;;                                ;;;
  ;                                  ;



  ;                                  ;
 ;;;                                ;;;
;;;;;     ADD NEW SCRIPTS HERE     ;;;;;
 ;;;                                ;;;
  ;                                  ;



  ;                                  ;
 ;;;                                ;;;
;;;;;     ADD NEW SCRIPTS HERE     ;;;;;
 ;;;                                ;;;
  ;                                  ;
	

; FUTURE HOTKEYS TO DESIGN:

;	-----------------------------------------
; NEED: hotkey to open another instance of currently-selected program
; 		-> get the file path selected program (same as winkey+q's old implementation), then run another instance of that program
; -----------------------------------------


  ;                                  ;
 ;;;                                ;;;
;;;;;          END SCRIPTS         ;;;;;
 ;;;                                ;;;
  ;                                  ;




;==----------------------------------------------------------------------------------------------------------------------------------------------------------------
;   ----------------------------------------------------------------   Community-Created Scripts   -----------------------------------------------------------------
;==----------------------------------------------------------------------------------------------------------------------------------------------------------------






;==----------------------------------------------------------------------------------------------------------------------------------------------------------------
;   --------------------------------------------------------   Notes-to-Self  (Documentation / Training)   ---------------------------------------------------------
;==----------------------------------------------------------------------------------------------------------------------------------------------------------------

; *** TO GET KEY-CODES:
;
;   //    Create a separate AutoHotkey (.ahk) Script and paste these 3 lines into
;   //    it. Make sure to save it with a .ahk file extension:
;
;  ----- BEGIN KEY-CODE LO -----
;      #InstallKeybdHook
;      #Persistent
;      KeyHistory
;  ----- END OF FILE -----
;
;   //  NOTE:  After you've saved it, run it, and a command prompt (w/ white background) will
;   //         display the codes for any key pressed while it is running.
;
;		//	 SC:		Refer to the "SC" column to acquire the "scan code" of any keys pressed (string, length 3)
;		//	 VK:		Refer to the "VK" column to acquire the "virtual key code" of any keys pressed (string, length 2)
;   //  Key:    Refer to the "Key" column to acquire the "Hotstring" of any keys pressed (string, length varies)
;
;   //  NOTE:  If the above method fails, refer to: https://autohotkey.com/docs/commands/GetKey.htm


; *** TO DETERMINE THE COMMAND BEING SENT:
;			SC029::
;			SplashTextOn, 250, 40, Debugging, Command Sent
;			Sleep 500
;			SplashTextOff
; 		-- Remainder of your script


;			MouseClick,[Button],[X_Coord],[Y_Coord],[ClickCount],[Speed],[U|D],[Relative]
;
;          PARAMS:
;	         		    [Button]  =  { Left, Right, Middle, X1, X2, WheelUp (or WU), WheelDown (or WD), WheelLeft (or WL), WheelRight (or WR) --- DEFAULTS TO LEFT IF OMITTED }
;	         		   [X_Coord]  =  { Screen Horizontal-Position to fire the click --- DEFAULTS TO CURRENT CURSOR X-COORDINATE }
;	         		   [Y_Coord]  =  { Screen Vertical-Position to fire the click --- DEFAULTS TO CURRENT CURSOR Y-COORDINATE }
;	         		[ClickCount]  =  { Click this many times --- DEFAULTS TO 1 CLICK, IF OMITTED }
;	         		     [Speed]  =  { Movement speed of mouse across the screen - 0 is Instant --- DEFAULTS TO DEFAULT MOUSE MOVE SPEED SET BY [SetDefaultMouseSpeed, Speed], OTHERWISE DEFAULTS TO 2 }
;	         		       [U|D]  =  { Only do a Click-Down (D) or Click-Up (U) click-event --- DEFAULTS A *DOWN* FOLLOWED BY AN *UP* EVENT, IF OMITTED}
;	         		  [Relative]  =  { If set to (R), the X & Y Coordinates will be treated as an offset to mouse's current position --- DEFAULTS TO NON-RELATIVE MOVEMENT, IF OMITTED }
	
; MouseClickDrag, WhichButton, X1, Y1, X2, Y2 [, Speed, R]
; MouseMove, X, Y [, Speed, R]
; ControlClick [, Control-or-Pos, WinTitle, WinText, WhichButton, ClickCount, Options, ExcludeTitle, ExcludeText]
	
; BASIC ARRAY INSTANTIATION:
;				Jack := { profession: "teacher"
;								 , height: "tall"
;								 , country: "USA"
;								 , city: "New York"}
;
;					...
;
;			Person := { Jack: Jack
;								 , Paul: Paul
;								 , Bill: Bill
;								 , Max: Max
;								 , Bill: Bill}
;
; BASIC ARRAY USE:
;				MsgBox, % Person.Jack.city



; MsgBox has tons of options for confirmations on popups ( Manual @ https://autohotkey.com/docs/commands/MsgBox.htm )
; ...::
	; WinGetActiveStats, Title, Width, Height, X, Y
	; WinGetText, WinText, A
	; MsgBox, 4, , WinTitle `n%Title%   `n`nWindow Size: `n   Width (%Width%)     Height (%Height%)   `n`nWindow Coordinates: `n   X (%X%)     Y (%Y%)   `n`nSkip WinText?, 10  ; 10-second timeout.
	; IfMsgBox, Yes
		; Return
	; IfMsgBox, No
		; MsgBox, WinText `n%WinText%
		; Return
	; IfMsgBox, Timeout
		; Return
	; Return
	

;
; MENU ITEMS:    https://autohotkey.com/docs/commands/Menu.htm
; GENERAL USE:   Menu, MenuName, Cmd, P3, P4, P5
;

; Menu, tray, add  ; Creates a separator line.
; Menu, tray, add, "Lineage-2", MenuHandler  ; Creates a new menu item.
; return

; MenuHandler:
; MsgBox You selected %A_ThisMenuItem% from menu %A_ThisMenu%.
; MsgBox A_TitleMatchMode[%A_TitleMatchMode%], A_TitleMatchModeSpeed=[%A_TitleMatchModeSpeed%]
; return

; Menu, FileMenu, Add, Script Icon, MenuHandler_FileMenu
; Menu, FileMenu, Add, Suspend Icon, MenuHandler_FileMenu
; Menu, FileMenu, Add, Pause Icon, MenuHandler_FileMenu
; Menu, FileMenu, Icon, Script Icon, %A_AhkPath%, 2 ;Use the 2nd icon group from the file
; Menu, FileMenu, Icon, Suspend Icon, %A_AhkPath%, -206 ;Use icon with resource identifier 206
; Menu, FileMenu, Icon, Pause Icon, %A_AhkPath%, -207 ;Use icon with resource identifier 207
; Menu, MyMenuBar, Add, &File, :FileMenu
; Gui, Menu, MyMenuBar
; Gui, Add, Button, gExit, Exit This Example
; Gui, Show
; MenuHandler_FileMenu:
; Return

; Exit:
; ExitApp

; SetTitleMatchMode - Sets the matching behavior of the WinTitle parameter in commands such as WinWait.
; 1: A window's title must start with the specified WinTitle to be a match.
; 2: A window's title can contain WinTitle anywhere inside it to be a match. 
; 3: A window's title must exactly match WinTitle to be a match.
