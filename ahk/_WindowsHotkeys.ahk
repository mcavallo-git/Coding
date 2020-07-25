; ------------------------------------------------------------
;
; _WindowsHotkeys.ahk, by Cavalol
;   |
;   |--> Effective Hotkeys for Windows-based Workstaitons
;   |
;   |--> Runs via "Autohotkey" (AHK) - Download @ https://www.autohotkey.com/download/
;   |
;   |--> Download this script:  https://raw.githubusercontent.com/mcavallo-git/Coding/master/ahk/_WindowsHotkeys.ahk
;
; ------------------------------------------------------------
;
; Runtime Globals (Settings)
;

#Persistent  ; https://www.autohotkey.com/docs/commands/_Persistent.htm

#HotkeyInterval 2000  ; https://www.autohotkey.com/docs/commands/_HotkeyInterval.htm

#MaxHotkeysPerInterval 2000  ; https://www.autohotkey.com/docs/commands/_MaxHotkeysPerInterval.htm

#SingleInstance Force  ; https://www.autohotkey.com/docs/commands/_SingleInstance.htm

; #EscapeChar \  ; https://www.autohotkey.com/docs/commands/_EscapeChar.htm

; #InstallKeybdHook  ; https://www.autohotkey.com/docs/commands/_InstallKeybdHook.htm

; #UseHook off  ; https://www.autohotkey.com/docs/commands/_UseHook.htm

; SetBatchLines, -1  ; https://www.autohotkey.com/docs/commands/SetBatchLines.htm

SetWorkingDir, %A_ScriptDir%  ; https://www.autohotkey.com/docs/commands/SetWorkingDir.htm

DetectHiddenWindows, On  ; https://www.autohotkey.com/docs/commands/DetectHiddenWindows.htm

SetCapsLockState, Off  ; https://www.autohotkey.com/docs/commands/SetNumScrollCapsLockState.htm

; FileEncoding, UTF-8  ; https://www.autohotkey.com/docs/commands/FileEncoding.htm

; #ErrorStdOut  ; https://www.autohotkey.com/docs/commands/_ErrorStdOut.htm


; ------------------------------------------------------------
;
; Runtime Globals (Variables)
;

; #NoEnv  ; Prevents environment vars from being used (occurs when a var is called/referenced without being instantiated)

A_SYSTEM32 := WINDIR "\System32"

USER_DESKTOP := USERPROFILE "\Desktop"
 
USER_DOCUMENTS := USERPROFILE "\Documents"

CR := "`r"

LF := "`n"

VerboseOutput := 1

DebugMode := 0

;
; RFC3339 - Timestamps (Internet date-time standardization-values) (https://tools.ietf.org/html/rfc3339)
;  |-->  Example RFC-3339 timestamp w/ timezone:   "2020-07-25 05:46:03-05:00"
;
RFC3339_YearMonthDay_Separator := "-"  ; Character-separator between [ year, month, and day date-field values ]
RFC3339_HourMinuteSecond_Separator := ":"  ; Character-separator between [ hour, minute, and second time-field ] values
RFC3339_DecimalSeconds_Separator := "."  ; Character-separator between [ seconds and fractions-of-a-second (microsecond/millisecond) values ]
RFC3339_DateAndTimeField_Separator := "T"  ; Character-separator between [ date- and time-fields ]
RFC3339_UTC_ZeroHourReplacement := "Z"  ; Replacement-string to use for timezone when the UTC timezone (UTC+00:00) is output


; ------------------------------------------------------------
;
; Setup targeting [ Windows Explorer ]-classed windows
;

GroupAdd, Explorer, ahk_class ExploreWClass ; Unused on Vista and later

GroupAdd, Explorer, ahk_class CabinetWClass


; ------------------------------------------------------------
; ------------------------------------------------------------
; ---                   HOTKEY-LISTENERS                   ---
; ------------------------------------------------------------
; ------------------------------------------------------------


; ------------------------------------------------------------
;   HOTKEY:  Win + Esc
;   ACTION:  Refresh This Script  ::: Closes then re-opens this script (Allows saved changes to THIS script (file) to be tested/applied on the fly)
;
~#Escape::
	BlockInPut, Off  ;  Stop blocking input (e.g. restore full interaction)
	Reload  ; Reload this script
	Sleep 1000 ; If successful, the reload will close this instance during the Sleep, so the line below will never be reached.
	MsgBox, 4,, The script could not be reloaded. Would you like to open it for editing?
	; IfMsgBox, Yes, Edit
	If (A_MsgBoxResult = "Yes") {
		Edit
	}
	Return

; ------------------------------------------------------------
;   HOTKEY:  ???
;   ACTION:  Attempt to re-run the current program with escalated/elevated privileges (e.g. rerun the current program as admin)
;
; ???::
; 	(PSEUDO-CODE)  CHECK IF WINDOW IS ALREADY RUNNING AS ADMIN -> IF YES, DO NOTHING
; ;;;
; 	(PSEUDO-CODE)  GET ACTIVE WINDOW'S EXE-PATH
; ;;;
; 	(PSEUDO-CODE)  GET ACTIVE WINDOW'S ADDITIONAL-ARGS
; ;;;
; 	(PSEUDO-CODE)  OPEN WINDOW AS ADMIN
; ;;;
; 	Return


; ------------------------------------------------------------
;   HOTKEY:  Win + Z
;   ACTION:  Grabs information about current (active) window's exe-filepath, process-id, on-screen location, & more, and displays it in a popup table Gui
;
#Z::
	GetWindowSpecs()
	Return


; ------------------------------------------------------------
;   HOTKEY:  Win + -
;   ACTION:  Type a line of -----'s (override default windows-hotkey for the magnifier tool)
;
#If !WinActive("ahk_class FFXIVGAME")
#-::
#NumpadSub::
	AwaitModifierKeyup()
	SetKeyDelay, 0, -1
	; StringToType := StringRepeat("-",60)
	SendInput, ------------------------------------------------------------
	Return
#If

; ------------------------------------------------------------
;   HOTKEY:  Win + =
;   HOTKEY:  Win + [ Plus-Key ]
;   ACTION:  Create a citations footer (refer to function description for more info)
;
#If !WinActive("ahk_class FFXIVGAME")
#=::
#+::
#NumpadAdd::
	CreateCitationsFooter()
	Return
#If


; ------------------------------------------------------------
;   HOTKEY:  Win + V
;   ACTION:  Open VS Code
;
#V::
	OpenVisualStudioCode()
	Return


; ------------------------------------------------------------
;   HOTKEY:  Ctrl + Shift + V
;   HOTKEY:  Ctrl + Alt + V
;   HOTKEY:  Ctrl + Win + V
;   ACTION:  Paste the Clipboard
;
*^+V::
*^!V::
*^#V::
	; PasteClipboardAsText()
	PasteClipboardAsBinary()
	Return


; ------------------------------------------------------------
;  HOTKEY:  Shift + Win + P
;  HOTKEY:  Ctrl + Win + P
;  ACTION:  Ask user if they wish to paste the clipboard as Text or Binary data (workaround for websites which block pasting into forms)
;
^#P::
+#P::
	AwaitModifierKeyup()  ; Wait until all modifier keys are released
	PasteClipboard_TextOrBinary()
	Return

; ------------------------------------------------------------
;  HOTKEY:  Win + P
;  ACTION:  Open RoboForm's Generate-Password Executable
;
#P::
	OpenPasswordGenerator()
	Return


; ------------------------------------------------------------
;  HOTKEY:  Win + H
;  ACTION:  Type the COMPUTERNAME
;
#H::
	SetKeyDelay, 0, -1
	AwaitModifierKeyup()  ; Wait until all modifier keys are released
	WinProcessName := WinGetProcessName("A")
	SetTitleMatchMode, 2 ; Title must CONTAIN [ WinTitle ] as a substring
	if (WinProcessName == "chrome.exe") {
		If (WinActive("LastPass")) {  ; IfWinActive - https://www.autohotkey.com/docs/commands/WinActive.htm
			If (WinActive("Duo Security")) {
				FormatTime,NowTimestamp,,yyyy-MM-dd_HH-mm-ss
				EchoStr := A_ComputerName " " NowTimestamp " " WinProcessName
				Send {Blind}{Text}%EchoStr%
			} Else {
				Send {Blind}{Text}%A_ComputerName% 
			}
		} Else {
			Send {Blind}{Text}%A_ComputerName% 
		}
	} Else {
		Send {Blind}{Text}%A_ComputerName% 
	}
	Return


; ------------------------------------------------------------
;  HOTKEY:  Win + U
;  ACTION:  Type the DOMAIN-USERNAME
;
#U::
	SetKeyDelay, 0, -1
	AwaitModifierKeyup()  ; Wait until all modifier keys are released
	; RET_VAL = %USERNAME%
	RET_VAL := USERDOMAIN "-" A_UserName
  Send %RET_VAL%
	Return


; ------------------------------------------------------------
;  HOTKEY:  Win + G
;  ACTION:  Types the contents of target file
;
#G::
	SplitPath %A_MyDocuments%, OutFileName, OutDirname, OutExtension, OutNameNoExt, OutDrive
	FilePathToRead := OutDirname "\.ahk\#g"
	FileRead, FilePathContents, %FilePathToRead%
	SendInput, %FilePathContents%
	Return


; ------------------------------------------------------------
;  HOTKEY:  Win + W
;  ACTION:  Types the contents of target file
;
#W::
	SplitPath %A_MyDocuments%, OutFileName, OutDirname, OutExtension, OutNameNoExt, OutDrive
	FilePathToRead := OutDirname "\.ahk\#w"
	FileRead, FilePathContents, %FilePathToRead%
	SendInput, %FilePathContents%
	Return


; ------------------------------------------------------------
;  HOTKEY:  Win + D
;  ACTION:  Types one of a dynamic set of timestamp-strings
;
#D::     ;  20200725T080521              (Base Case + Win + D)
!#D::    ;  20200725T080550-0500         (Alt + Win + D)
^#D::    ;  2020-07-25T08:05:55          (Ctrl + Win + D)
+#D::    ;  20200725T080557.608027       (Shift + Win + D)
!^#D::   ;  2020-07-25T08:06:04-05:00    (Ctrl + Alt + Win + D)
+^#D::   ;  2020-07-25T08:06:10.470061   (Shift + Ctrl + Win + D)
+!#D::   ;  20200725T080613.297487-0500  (Shift + Alt + Win + D)
+!^#D::  ;  2020-07-25T08:34:12.318040-05:00   (Shift + Ctrl + Alt + Win + D)  <-- NOTE:  For some reason, Microsoft made [ Alt + Ctrl + Shift + Win ] open their Win10 Office app --> Disable via https://superuser.com/a/1484507
	Global RFC3339_YearMonthDay_Separator
	Global RFC3339_HourMinuteSecond_Separator
	Global RFC3339_DecimalSeconds_Separator
	Global RFC3339_DateAndTimeField_Separator
	Global RFC3339_UTC_ZeroHourReplacement
	SetKeyDelay, 0, -1
	AwaitModifierKeyup()  ; Wait until all modifier keys are released
	YMD_Separator := RFC3339_YearMonthDay_Separator
	HMS_Separator := RFC3339_HourMinuteSecond_Separator
	Microseconds_Separator := RFC3339_DecimalSeconds_Separator
	DT_Field_Separator := RFC3339_DateAndTimeField_Separator
	Add_Microseconds := 0
	Add_Timezone := 0
	KeysPressed := A_ThisHotkey
	If (InStr(KeysPressed, "+") = 1) {  ; Shift + [...]
		Add_Microseconds := 1
		KeysPressed := StrReplace(KeysPressed,"+","")
	}
	If (InStr(KeysPressed, "!") = 1) {  ; Alt + [...]
		Add_Timezone := 1
		KeysPressed := StrReplace(KeysPressed,"!","")
	}
	If (DebugMode = 1) {
		TrayTip, AHK, A_ThisHotkey=[%A_ThisHotkey%] KeysPressed=[%KeysPressed%] Add_Microseconds=[%Add_Microseconds%] Add_Timezone=[%Add_Timezone%]
	}
	If (KeysPressed = "#D") {  ; Win + D
		; Output a "filename-friendly" timestamp
		;  |--> Generally-speaking, only allow characters which are alphanumeric "[a-zA-Z0-9]", dashes "-", plus-signs "+", and periods "."
		YMD_Separator := ""
		HMS_Separator := ""
		DT_Field_Separator := RFC3339_DateAndTimeField_Separator
	} Else If (KeysPressed = "^#D") {  ; Ctrl + Win + D
		; Default to RFC 3339 format
	} Else { ; Fallthrough
		; Default to RFC 3339 format
	}
	; Get the current timestamp
	Keys := GetTimestamp(YMD_Separator, HMS_Separator, DT_Field_Separator)
	; Add [ fractions-of-a-second ] onto output timestamp
	If (Add_Microseconds = 1) {
		GetMicroseconds(Current_Microseconds)
		Keys := Keys Microseconds_Separator Current_Microseconds
	}
	; Add [ Timezone ] onto output timestamp
	If (Add_Timezone = 1) {
		Current_TZ := ""
		GetTimezoneOffset(Current_TZ, HMS_Separator)
		Keys := Keys Current_TZ
	}
	Send(Keys)
	Return


; ------------------------------------------------------------
;  HOTKEY:  Win + F1
;  ACTION:  Edit this Script (the one you're reading right now)
;
#F1::
	Run Notepad %A_ScriptFullPath%
	Return


; ------------------------------------------------------------
;  HOTKEY:  Win + F2
;  ACTION:  Opens a window (GetKeyCodes.ahk) which displays verbose keypress info, live (allowing user to press combo keys and view how it is interpreted by AHK)
;
#F2::
	GetKeyCodes := A_ScriptDir "\GetKeyCodes.ahk"
	Run %GetKeyCodes%
	Return


; ------------------------------------------------------------
; HOTKEY:  Win + F3  (or "#SC03D")
; ACTION:  Xbox Captures - Download & Delete recordings/captures via XBox's Windows 10 built-in application
;   |-->   !!! MAKE SURE TO HIDE SCREENSHOTS BEFOREHAND !!!
;
#F3::
	SetTitleMatchMode, 2 ; Title must CONTAIN [ WinTitle ] as a substring
	SetKeyDelay, 0, -1
	SetControlDelay, -1
	CoordMode, Mouse, Screen
	SetDefaultMouseSpeed, 0

	WaitForDownload_MaxSeconds := 30000
	; WaitForDownload_MaxSeconds := 90000
	; WinTitle := "Xbox Console Companion"

	; ControlSend, ApplicationFrameTitleBarWindow1, {PGDN}, Xbox Console Companion

	; ControlGetText, OutputVar , Control, WinTitle, WinText, ExcludeTitle, ExcludeText

	; ControlGet, OutputVar, SubCommand , Value, Control, WinTitle, WinText, ExcludeTitle, ExcludeText

	; ControlGet, VarListA, List,, ThunderRT6ListBox2, Xbox Console Companion

	; EmptyVar =
	; Loop 50 {
	; 	ControlGet, VarListA, List,, ApplicationFrameTitleBarWindow1, Xbox Console Companion
	; 	Tooltip, "List at A_Index %A_Index% has contents `"%VarListA%`""
	; 	If (VarListA <> %EmptyVar%) {
	; 		; MsgBox, "List at A_Index %A_Index% has contents `"%VarListA%`""
	; 		Sleep 10000
	; 		Break
	; 	} Else {
	; 		Sleep 100
	; 	}
	; 	If (A_Index > 50000) {
	; 		Break
	; 	}
	; 	Continue
	; }

	; ClassNN := ControlGetClassNN(Control , WinTitle, WinText, ExcludeTitle, ExcludeText)

	; ClassNN := ControlGetClassNN(ControlGetFocus("A"))
	; MsgBox, "ClassNN = [%ClassNN%]"
	; Sleep 5000

	; OutputVar := ControlGetText("ApplicationFrameTitleBarWindow1", "Xbox Console Companion")
	; MsgBox, %OutputVar%
	; Sleep 5000

	; OutputVar := ControlGetText("Windows.UI.Core.CoreWindow1", "Xbox Console Companion")
	; MsgBox, %OutputVar%
	; Sleep 5000

	; OutputVar := ControlGetText("ApplicationFrameTitleBarWindow2", "Xbox Console Companion")
	; MsgBox, %OutputVar%
	; Sleep 5000

	; OutputVar := ControlGetText("ApplicationFrameInputSinkWindow1", "Xbox Console Companion")
	; MsgBox, %OutputVar%
	; Sleep 5000

	Loop 2000 {
		MouseClick, Left, 861, 947
		Sleep %WaitForDownload_MaxSeconds%
		MouseClick, Left, 1420, 905
		Sleep 1000
		MouseClick, Left, 848, 575
		Sleep 7500
	}
	Return

; ------------------------------------------------------------
;  HOTKEY:  Win + Ctrl + Z
;  HOTKEY:  Win + Shift + Z
;  ACTION:  Show all (current) Window Titles
;
^#Z::
+#Z::
	ShowWindowTitles()
	Return


; ------------------------------------------------------------
;  HOTKEY:  Fn Key (X1 Carbon)
;  ACTION:  Set Fn to perform Ctrl action, instead
;
;SC163::   ;"Fn" Key
;Return


; ------------------------------------------------------------
;  HOTKEY:  Windows-Key + [
;  ACTION:  FOLLOW-UP HOTKEY TO: Windows-key P   :::   Click "Duplicate" monitors
;
#[::
#]::
	Global DebugMode
	CoordMode, Mouse, Screen
	SetDefaultMouseSpeed, 0
	SetControlDelay, -1
	SetTitleMatchMode, 1  ; A window's title must start with the specified WinTitle to be a match
	; Save current monitor config (to compare against once it's been updated)
	SysGet, MonitorCountBefore, 80
	SysGet, ViewportWidthBefore, 78
	SysGet, ViewportHeightBefore, 79
	; Save current mouse coordinates
	MouseGetPos, MouseX, MouseY
	; Send an Escape keypress to close any old Projection menus
	Send {Escape}
	Sleep 250
	If (A_OSVersion="WIN_7") {  ; Windows7
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
		Sleep 2000
		MouseClick, Left, %x_loc%, %y_loc%
		Sleep 100
	} Else If (SubStr(A_OSVersion, 1, 4)="10.0") {  ; Windows10
		; Open the "Projection" window
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
					SysGet, MonitorCountAfter, 80
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
					Error: Unable to locate Projection window
				)
				Break
			} Else {
				Sleep 10
			}
		}
	}
	MouseMove, %MouseX%, %MouseY%
	If (DebugMode = 1) {
		SysGet, MonitorCountAfter, 80
		SysGet, ViewportWidthAfter, 78
		SysGet, ViewportHeightAfter, 79
		; Check-for Windows' percentage (%) based display scaling
		Get_CurrentVerticalResolution := "PowerShell.exe -Command '([String]((Get-CimInstance -ClassName CIM_VideoController).CurrentVerticalResolution)).Trim();'"
		CurrentVerticalResolution := GetCommandOutput(Get_CurrentVerticalResolution)
		CurrentVerticalResolution := StrReplace(StrReplace(StrReplace(CurrentVerticalResolution, "`n", ""), "`v", ""), "`r", "")
		; Read the registry to check for display scaling
		KeyName := "HKEY_CURRENT_USER\Control Panel\Desktop"
		PropertyName := "DpiScalingVer"
			RegRead, DpiScalingVer, %KeyName%, %PropertyName%
		PropertyName := "Win8DpiScaling"
			RegRead, Win8DpiScaling, %KeyName%, %PropertyName%
		PropertyName := "DpiScalingVer"
			RegRead, LogPixels, %KeyName%, %PropertyName%
		; ------------------------------------------------------------
		;
		; DpiScalingVer    ; originally 1000
		; Win8DpiScaling   ; originally 0 
		; LogPixels        ; originally absent
		;
		; DPI--->Scale Factor
		;   96 === x60  <-- 100%
		;  120 === x78  <-- 125%
		;  144 === x90  <-- 150%
		;  192 === xC0  <-- 200%
		;  240 === xF0  <-- 250%
		;
		; From:  https://www.tenforums.com/general-support/69742-resolution-mismatch-when-using-change-size-text.html#post869493
		;
		; ------------------------------------------------------------
		; HKEY_CURRENT_CONFIG\System\CurrentControlSet\Control\Video
		;
		; DefaultSetting.XResolution
		; REG_DWORD
		; 0x00000400 (1024)
		;
		; DefaultSetting.YResolution
		; REG_DWORD
		; 0x00000300 (768)
		;
		; From:  https://superuser.com/a/1050763
		;
		; ------------------------------------------------------------
		MsgBox,
		(LTrim
			x_loc = %x_loc%
			y_loc = %y_loc%
			
			ViewportWidthBefore = %ViewportWidthBefore%
			ViewportWidthAfter = %ViewportWidthAfter%
			ViewportHeightBefore = %ViewportHeightBefore%
			ViewportHeightAfter = %ViewportHeightAfter%
			
			DpiScalingVer = %DpiScalingVer%
			Win8DpiScaling = %Win8DpiScaling%
			LogPixels = %LogPixels%
		)
	}
	Return


; ------------------------------------------------------------
;  HOTKEY:  Windows-Key + Right-Click
;  ACTION:  Output cursor location
;
#RButton::
	FollowDuration := 10
	ShowCursorCoordinates(FollowDuration)
	Return


; ------------------------------------------------------------
;  HOTKEY:  WinKey + L
;  ACTION:  Allow native function (via ~) to lock the workstatiton, wait a sec, then show the screensaver

#L::
	LockWorkstation()
	; Monitor_ShowScreenSaver()
	Reload
	Return


; ------------------------------------------------------------
;  HOTKEY:  AppsKey
;  ACTION:  Replace functionality with that of the right Windows-Key by using a "pass-through" (~) hotkey --> https://www.autohotkey.com/docs/HotkeyFeatures.htm#pass-through
;
;
; *AppsKey::
; 	Send {Blind}{RWin down}
; 	Return
; *AppsKey up::
; 	Send {Blind}{RWin up}
; 	Return

AppsKey::RWin


; ------------------------------------------------------------
;  HOTKEY:  Windows-Key + N
;  ACTION:  Opens "View Network Connections" (in the Control Panel)
; 
#N::
	TrayTip, AHK, Opening "View Network Connections"  ; Toast Notification
	ViewNetworkConnections_PATH := WINDIR "\System32\ncpa.cpl"
	Run %ViewNetworkConnections_PATH%
	; ViewNetworkConnections_CLSID=::{7007acc7-3202-11d1-aad2-00805fc1270e}  ; CLSID (Windows Class Identifier) for 'View Network Connections'
	; Run %ViewNetworkConnections_CLSID%
	Return


; ------------------------------------------------------------
; HOTKEY:  Windows-Key + S
; ACTION:  Opens "Sound Control Panel" (Windows-7 Style, not Windows-10 Style)
; 
#S::
	;
	; Run explorer shell:::{F2DDFC82-8F12-4CDD-B7DC-D4FE1425AA4D}
	; Run control.exe /name Microsoft.Sound
	; Run control mmsys.cpl
	;
	; Note: You can choose which tab you want to open by default. 0 opens the first tab, 1 opens the 2nd tab, and so on.
	;
	; Run control mmsys.cpl,,0
	; Run control mmsys.cpl,,1
	; Run "control.exe mmsys.cpl,,2"
	; Run control mmsys.cpl,,3
	;
	TrayTip, AHK, Opening "Sound - Playback"  ; Toast Notification
	RunWaitOne("control.exe mmsys.cpl,,0")  ; Playback
	; RunWaitOne("control.exe mmsys.cpl,,1")  ; Recording
	; RunWaitOne("control.exe mmsys.cpl,,2")  ; Sounds
	WinTitle := "Sound"
	SetTitleMatchMode, 3 ; 3: A window's title must exactly match WinTitle to be a match.
	WinWait, %WinTitle%,, 5  ; Waits until the specified window exists  |  https://www.autohotkey.com/docs/commands/WinWait.htm
	WinActivate, %WinTitle%  ;  Activates the specified window  |  https://www.autohotkey.com/docs/commands/WinActivate.htm
	Return


; ------------------------------------------------------------
;  HOTKEY:  Windows-Key + E
;  ACTION:  Opens "USERPROFILE" directory
; 
#E::
	SplitPath %A_MyDocuments%, OutFileName, OutDirname, OutExtension, OutNameNoExt, OutDrive
	Run "%OutDirname%"
	Return
; 
; ------------------------------------------------------------
;  HOTKEY:  Windows-Key + O (not zero, the letter O)
;  ACTION:  Opens "Programs & Features" in the Control Panel

#O::
	Run "c:\windows\system32\appwiz.cpl"
	Return


; ------------------------------------------------------------
;  HOTKEY:  Windows-Key + ` (Tilde)
;  ACTION:  Keyboard-Command for a Mouse-Left-Click

#`::
	MouseClick, Left
	Return


; ------------------------------------------------------------
;  HOTKEY:  Alt + ` (Tilde)
;  ACTION:  Keyboard-Command for a Mouse-Right-Click

!`::
	MouseClick, Right
	Return


; ------------------------------------------------------------
;  HOTKEY:  Ctrl/Shift/Alt + WinKey + Right/Left (Arrow)
;  ACTION:  Turn screen brightness up (right) or down (left)

+#Left::
!#Left::
^#Left::
	BS := new BrightnessSetter()
	BS.SetBrightness(-1)
	Return

+#Right::
!#Right::
^#Right::
	BS := new BrightnessSetter()
	BS.SetBrightness(+1)
	Return


; ------------------------------------------------------------
;  HOTKEY:  Win + Mouse-Wheel Up/Down
;  ACTION:  Turn computer volume up/down

+#Up::
!#Up::
^#Up::
+#Down::
!#Down::
^#Down::
#MButton::
#WheelUp::
#WheelDown::
^#MButton::
^#WheelUp::
^#WheelDown::

	VolumeLevel_Increment := 2

	If ((A_ThisHotkey=="#MButton") || (A_ThisHotkey=="^#MButton")) {  ; Mute On/Off
		SoundSet, +1, , MUTE

	} Else {

		If ((A_ThisHotkey=="+#Up") || (A_ThisHotkey=="!#Up") || (A_ThisHotkey=="^#Up")) {  ; Volume Up
			vDelta := "+" ( VolumeLevel_Increment )

		} Else If ((A_ThisHotkey=="+#Down") || (A_ThisHotkey=="!#Down") || (A_ThisHotkey=="^#Down")) {  ; Volume Down
			vDelta := "-" ( VolumeLevel_Increment )

		} Else If (A_ThisHotkey=="#WheelUp") {  ; Volume Up
			vDelta := "+" ( VolumeLevel_Increment )

		} Else If (A_ThisHotkey=="^#WheelUp") {  ; Volume Up ( More )
			vDelta := "+" ( VolumeLevel_Increment * 2 )


		} Else If (A_ThisHotkey=="#WheelDown") {  ; Volume Down
			vDelta := "-" ( VolumeLevel_Increment )

		} Else If (A_ThisHotkey=="^#WheelDown") {  ; Volume Down ( More )
			vDelta := "-" ( VolumeLevel_Increment * 2 )

		}

		SoundSet , %vDelta%

	}
	ShowVolumeLevel()
	Return

; ------------------------------------------------------------
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

; ------------------------------------------------------------
;  HOTKEY:  "Rock" the Mouse's Wheel Left or Right   (Mouse-Wheel-Left or Mouse-Wheel-Right)
;  ACTION:  Change Tabs Left or Right
;
WheelLeft::
	Send ^{PgUp}
	Return
WheelRight::
	Send ^{PgDn}
	Return

; 	; ------------------------------------------------------------

; 	; Use RegexReplace to strip leading whitespace from every copied line
; 	ClipboardDuped := Clipboard
; 	ClipboardDuped := RegExReplace(ClipboardDuped, "m)^[ `t]*|[ `t]*$")

; 	Newline=`n
; 	Echo_Tooltip := A_Space
; 	Echo_Tooltip := Echo_Tooltip Newline "  StrLen(ClipboardDuped) = [ " StrLen(ClipboardDuped) " ]"
; 	Echo_Tooltip := Echo_Tooltip Newline A_Space
; 	TrayTip, AHK, %Echo_Tooltip%  ; Toast Notification

; 	; If ( IsUbuntuWSL = 1 ) {
; 	; 	; TrayTip, AHK, Pasting Clipboard into Ubuntu WSL Instance  ; Toast Notification
; 	; 	; ; Send {Blind}{Text}%ClipboardDuped%
; 	; } Else {
; 	; 	; Send {Shift}{Insert}
; 	; 	TrayTip, AHK, WSL Instance Not Found Locally  ; Toast Notification
; 	; }

; 	Return


; ------------------------------------------------------------
;  HOTKEY:  Windows-Key + A
;  ACTION:  Foxit PhantomPDF - Add Text
;
; #A::
; 	Global VerboseOutput
; 	CoordMode, Mouse, Screen
; 	SetDefaultMouseSpeed, 0
; 	SetControlDelay, -1
; 	SetTitleMatchMode, 2 ; Title must CONTAIN [ WinTitle ] as a substring
; 	WinGetTitle, WinTitle, A
; 	; MatchTitle=Foxit PhantomPDF ; PDF Titles can override this (in Foxit)
; 	WinProcessName := WinGetProcessName("A")
; 	MatchProcessName=FoxitPhantomPDF.exe
; 	If (InStr(WinProcessName, MatchProcessName)) {
; 		If (VerboseOutput == 1) {
; 			TrayTip, AHK, Adding Text-Field in `nvia Foxit PhantomPDF, 4, 1  ; Toast Notification
; 		}
; 		x_loc = 223
; 		y_loc = 40
; 		ControlClick, x%x_loc% y%y_loc%, %WinTitle%
; 		Sleep 100
; 		x_loc = 355
; 		y_loc = 63
; 		ControlClick, x%x_loc% y%y_loc%, %WinTitle%
; 	}
; 	; } Else {
; 	; 	If (VerboseOutput == 1) {
; 	; 		TrayTip, AHK, Foxit PhantomPDF`nMUST be active (to add text), 4, 1  ; Toast Notification
; 	; 	}
; 	; }
; 	Return


; ------------------------------------------------------------
;  HOTKEY:  Ctrl + WinKey + K
;  HOTKEY:  Ctrl + Shift  + K
;  HOTKEY:  Right-WinKey  + K
;  ACTION:  Send a Checkmark
;
^+K::
^!K::
^#K::
>#K::
	SetKeyDelay, 0, -1
	; Send ✔
	; Send 🗸  ; Light Check Mark
	Send ✔️  ; Check Mark
	Return


; ------------------------------------------------------------
;  HOTKEY:  Left-WinKey + K
;  ACTION:  Send a Thumbs-Up
;
<#K::
	SetKeyDelay, 0, -1
	; Send 👍
	; Send 👍🏿  ; Thumbs Up: Dark Skin Tone
	; Send 👍🏾  ; Thumbs Up: Medium-Dark Skin Tone
	Send 👍🏽  ; Thumbs Up: Medium Skin Tone
	; Send 👍🏼  ; Thumbs Up: Medium-Light Skin Tone
	; Send 👍🏻  ; Thumbs Up: Light Skin Tone
	Return


; ------------------------------------------------------------
;  HOTKEY:  Win + C
;  ACTION:  Open Google Chrome
;
#C::
	OpenChrome()
	Return


; ------------------------------------------------------------
;  HOTKEY:  Alt + Win + C
;           Ctrl + Win + C
;  ACTION:  Workbench hotkey for quick-testing, one-time wizbangs, etc.
;
!#C::
^#C::
	; WinTitle=Task Scheduler
	; WinTitle=Visual Studio Code
	; SpaceUp_Loop(50, WinTitle)
	; SpaceUp_Loop(50)
	; ClickLoop(1724,749)
	Return


; ------------------------------------------------------------
;  HOTKEY:  Windows-Key + F
;  ACTION:  Do nothing (kills Windows "Feedback Hub", in the very least)
;
#F::
	If (1 == 0) {
		; ------------------------------------------------------------
		; OLD RUNTIME - Open "Effective File Search" (software)
		; ------------------------------------------------------------
		; ExeFilepath := "C:`\Program Files (x86)`\efs`\search.exe"
		efs := "\Effective File Search.efsp"
		; iso=C:\ISO
		ExeFilepath := "C:`\ISO`\Effective File Search.efsp"
		ExeFilepath2 := A_MyDocuments efs
		; MsgBox, % ExeFilepath2
		If (FileExist(ExeFilepath)) {
			Run, %ExeFilepath%
		} Else {
			If (FileExist(ExeFilepath2)) {
				Run, %ExeFilepath2%
			} Else {
				; If EFS does NOT exist, offer user the URL to download it
				exe_download_url := "http://www.sowsoft.com/download/efsearch.zip"
				MsgBox, 4, Download EFS?, Effective File Search not found`n`nDownload EFS Now?
				If (A_MsgBoxResult = "Yes") {
					Run, chrome.exe %exe_download_url%
				}
			}
		}
	}
	Return


; ------------------------------------------------------------
;  HOTKEY:  Left-Shift + Right-Shift  (Shift + Shift --> Both Shift-Keys pressed simultaneously)
;  ACTION:  Toggle between "Maximized" and "Restored" window-sizes for the currently-active window
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


; ------------------------------------------------------------
;  HOTKEY:  WinKey + 8
;  ACTION:  Wait a random duration of time (example)
#8::
	Random, RandomSleep_15s_to_20s, 15000, 20000
	TrayTip, AHK, % ( "Sleeping for [ " RandomSleep_15s_to_20s " ] ms" )  ; Toast Notification
	Sleep %RandomSleep_15s_to_20s%
	TrayTip, AHK, % ( "Sleep for [ " RandomSleep_15s_to_20s " ] ms has finished" )  ; Toast Notification
	Return


; ------------------------------------------------------------
;  HOTKEY:  WinKey + 9
;  ACTION:  Send a {PrintScreen} keypress (for keyboards without the printscreen key)
#9::
	AwaitModifierKeyup()  ; Wait until all modifier keys are released
	Send {PrintScreen}
	Return
!#9::
	AwaitModifierKeyup()  ; Wait until all modifier keys are released
	Send !{PrintScreen}
	Return
^#9::
	AwaitModifierKeyup()  ; Wait until all modifier keys are released
	Send ^{PrintScreen}
	Return
+#9::
	AwaitModifierKeyup()  ; Wait until all modifier keys are released
	Send +{PrintScreen}
	Return


; ------------------------------------------------------------
;  HOTKEY:  WinKey + 0
;  ACTION:  Move the currently-active window's top-left corner to the top-left of the screen
#0::
	AwaitModifierKeyup()  ; Wait until all modifier keys are released
	WinMove, A, , 0, 0
	Return


; ------------------------------------------------------------
;  Win+J - Start Node.JS (Git-Bash) && Postman
;
; #J::
; 	; - -
; 	SG_REPO=%USERPROFILE%/Documents/GitHub/supplier_gateway
; 	; - -
; 	POSTMAN_EXE=%LOCALAPPDATA%/Postman/Update.exe
; 	GIT_BASH_EXE=%PROGRAMFILES%\Git\git-bash.exe
; 	; - -
; 	SG_BUILD_SCRIPT=%SG_REPO%/build/_start_frontend.sh
; 	SG_BUILD_API_LNK=%SG_REPO%/_start_server_api.lnk
; 	SG_BUILD_PM_LNK=%SG_REPO%/_start_server_pm.lnk
; 	SG_BUILD_SG_LNK=%SG_REPO%/_start_server_sg.lnk
; 	; - -
; 	WinTitle_NodeJS=Supplier Gateway (localhost)
; 	WinTitle_Postman=Postman
; 	; - -
; 	if ((!FileExist(SG_REPO)) || (!InStr(FileExist(SG_REPO), "D"))) {
; 		MsgBox, 
; 		(LTrim
; 			Error: Required directory not-found:
; 			%SG_REPO%
; 		)
; 	} Else {
; 		; Microsoft Windows has some unusual values for the window-bounds, when maximized/snapped
; 		Increment_Left := -7
; 		Increment_Top := 0
; 		Increment_Width := 14
; 		Increment_Height := 7
; 		; Prep Monitor Widths/Heights
; 		SysGet, DesktopMonitorCount, 80 , N
; 		BoundsLeft = -1
; 		BoundsRight = -1
; 		BoundsTop = -1
; 		BoundsBottom = -1
; 		BoundsCenterHoriz = 0
; 		BoundsCenterVert = 0
; 		Loop, %DesktopMonitorCount% {
; 			SysGet, MonitorWorkArea, MonitorWorkArea, %A_Index%
; 			; If (%MonitorWorkAreaLeft% > %BoundsLeft%) {
; 			If (BoundsLeft < MonitorWorkAreaLeft)
; 			{
; 				; MsgBox, Floor(BoundsLeft) < Floor(MonitorWorkAreaLeft)
; 				; Widths
; 				BoundsLeft := MonitorWorkAreaLeft
; 				BoundsRight := MonitorWorkAreaRight
; 				; Heights
; 				BoundsTop := MonitorWorkAreaTop
; 				BoundsBottom := MonitorWorkAreaBottom
; 			} Else {
; 				; MsgBox, Floor(BoundsLeft) >= Floor(MonitorWorkAreaLeft)
; 			}
; 		}
; 		; Widths
; 		BoundsWidthFull := (BoundsRight - BoundsLeft)
; 		BoundsWidthHalf := Floor(BoundsWidthFull/2)
; 		BoundsCenterHoriz := (BoundsLeft + BoundsWidthHalf)
; 		; Heights
; 		BoundsHeightFull := (BoundsBottom - BoundsTop)
; 		BoundsHeightHalf := Floor(BoundsHeightFull/2)
; 		BoundsCenterVert := (BoundsTop + BoundsHeightHalf)
; 		SetTitleMatchMode, 1  ; A window's title must start with the specified WinTitle to be a match
; 		; - -
; 		WinTitle_Postman=Postman
; 		WinTitle_NodeJS=Supplier Gateway (localhost)
; 		; - -
; 		; Start Postman
; 		IfWinNotExist,%WinTitle_Postman%
; 		{
; 			; Need to run the program, as no window was found for it (yet)
; 			POSTMAN_ARGS= --processStart Postman.exe
; 			; POSTMAN_ARGS=--processStart Postman.exe
; 			Run, %POSTMAN_EXE% %POSTMAN_ARGS%
; 		}
; 		; - -
; 		Sleep 100
; 		; - -
; 		; Start Node.JS in Git-Bash
; 		IfWinNotExist,%WinTitle_NodeJS%
; 		{
; 			GIT_BASH_ARGS_API=-c "C:/Users/%USERNAME%/Documents/GitHub/supplier_gateway/build/_start_frontend.sh rest-api start-localhost;"
; 			GIT_BASH_ARGS_PM=-c "C:/Users/%USERNAME%/Documents/GitHub/supplier_gateway/build/_start_frontend.sh boneal-app start-localhost;"
; 			GIT_BASH_ARGS_SG=-c "C:/Users/%USERNAME%/Documents/GitHub/supplier_gateway/build/_start_frontend.sh project-manager start-localhost;"
; 			Run, %GIT_BASH_EXE% %GIT_BASH_ARGS_API%, %SG_REPO%
; 			; Run, %GIT_BASH_EXE% %GIT_BASH_ARGS_PM%, %SG_REPO%
; 			; Run, %GIT_BASH_EXE% %GIT_BASH_ARGS_SG%, %SG_REPO%
; 		}
; 		;
; 		; Wait until the script(s)/program(s) start before moving them around
; 		; WinWait,%WinTitle_Postman%,,5
; 		; WinWait,%WinTitle_NodeJS%,,3
; 		; Move the window to occupy the right-half of the Right-Most monitor
; 		; WinMove,%WinTitle_Postman%,,%BoundsCenterHoriz%,%BoundsTop%,%BoundsWidthHalf%,%BoundsHeightFull%
; 		; WinMove,%WinTitle_Postman%,,953,0,974,1047 (1st Monitor, Right, Actual)
; 		; Move the window to occupy the left-half of the Right-Most monitor
; 		; WinMove,%WinTitle_NodeJS%,,%BoundsLeft%,%BoundsTop%,%BoundsWidthHalf%,%BoundsHeightFull%
; 		; WinMove,%WinTitle_NodeJS%,,-7,0,974,1047 ;; (1st Monitor, Left, Actual)
; 		;
; 	}
; 	Return


; ------------------------------------------------------------
;  Win + T - Get Windows Environment Vars
;
#T::
	PrintEnv()
	Return

; ------------------------------------------------------------
;  HOTKEY:  Caps Lock
;  ACTION:  Permanently DISABLE Capslock (unless pressed with shift, which toggles it as-normal)
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


; ----------------------------------------------------
;  HOTKEY:  Num Lock
;  ACTION:  Keep NumLock state enabled (unless pressed with shift, which enables it)
;           Allow for a specific config-file, if exists, to keep Numlock disabled by-default (for specific hardware/VM use-cases)
;
Numlock::
^Numlock::
!Numlock::
#Numlock::
	ConfigFilepath_KeepNumlockDisabled := USERPROFILE "\.ahk\numlock-keep-disabled.config"
	If (FileExist(ConfigFilepath_KeepNumlockDisabled)) {
		; Reverse Action - Keep Numlock disabled by-default
		NumLockEnabled_BeforeKeypress := GetKeyState("Numlock", "T")
		If (NumLockEnabled_BeforeKeypress == 1) {
			SetNumlockState, Off
		} Else {
			TextToolTip := "Enable NumLock via Shift+NumLock"
			ToolTip, %TextToolTip%
			ClearTooltip(3000)
		}
	} Else {
		; Default Action - Keep Numlock enabled by-default
		NumLockEnabled_BeforeKeypress := GetKeyState("Numlock", "T")
		If (NumLockEnabled_BeforeKeypress == 0) {
			SetNumlockState, On
		} Else {
			TextToolTip := "Disable NumLock via Shift+NumLock"
			ToolTip, %TextToolTip%
			ClearTooltip(3000)
		}
	}
	Sleep 500
	Return

+Numlock::
	ConfigFilepath_KeepNumlockDisabled := USERPROFILE "\.ahk\numlock-keep-disabled.config"
	If (FileExist(ConfigFilepath_KeepNumlockDisabled)) {
		; Reverse Action - Allow Shift+Numlock to enable NumLock
		NumLockEnabled_BeforeKeypress := GetKeyState("Numlock", "T")
		If (NumLockEnabled_BeforeKeypress == 0) {
			SetNumlockState, On
		}
	} Else {
		; Default Action - Allow Shift+Numlock to disable NumLock
		NumLockEnabled_BeforeKeypress := GetKeyState("Numlock", "T")
		If (NumLockEnabled_BeforeKeypress == 1) {
			SetNumlockState, Off
		}
	}
	; SetNumlockState, % GetKeyState("Numlock", "T") ? "Off" : "On"
	Sleep 500
	Return


; ------------------------------------------------------------
; ------------------------------------------------------------
; ---                       FUNCTIONS                      ---
; ------------------------------------------------------------
; ------------------------------------------------------------


;
; ActiveWindow_Maximize
;   |--> Maximize active window (if not maximized, already)
;
ActiveWindow_Maximize() {
	WinState := WinGetMinMax("A")
	If (WinState<=0) { ; Window is not maximized - maximize it
		WinMaximize "A"
	}
	Return
}


;
; ActiveWindow_ToggleRestoreMaximize
;   |--> Toggle currently-active window between "Maximized" and "Non-Maximized" (or "Restored") states
;
ActiveWindow_ToggleRestoreMaximize() {
	Global DebugMode
	WinState := WinGetMinMax("A")
	WinStyle := WinGetStyle("A")
	TestVar := 1
	DebugString := "WinState=[ %WinState% ]"
	If ("%WinState%" = "") {  ; ??? Window-state not pulled as-intended
		WinMaximize("A")
		DebugString := "%DebugString%, Do WinMaximize"
	} Else {
		If (WinState = 0) {  ; 0: The window is neither minimized nor maximized
			WinMaximize("A")
			DebugString := "%DebugString%, Do WinMaximize"
		} Else If (WinState = -1) {  ; -1: The window is minimized (WinRestore can unminimize it)
			WinRestore("A")
			DebugString := "%DebugString%, Do WinRestore"
		} Else If (WinState = 1) {  ; 1: The window is maximized (WinRestore can unmaximize it)
			WinRestore("A")
			DebugString := "%DebugString%, Do WinRestore"
		} Else {  ; Fallthrough-catch
			WinMaximize("A")
			DebugString := "%DebugString%, Do WinMaximize"
		}
	}
	If (DebugMode = 1) {
		TrayTip, AHK, %DebugString%
	}
	Return
}


;
; AwaitModifierKeyup
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
; ClearSplashText
;   |--> If called with a positive [ %Period% ], wait [ %Period% ] milliseconds, executes [ %Label% ], then repeats (until explicitly cancelled)
;	  |--> If called with a negative [ %Period% ], wait [ %Period% ] milliseconds, executes [ %Label% ], then returns
;
ClearSplashText(Period) {
	Label := "RemoveSplashText"
	SetTimer, %Label%, -%Period%
	Return
}


;
; ClearTooltip
;   |--> If called with a positive [ %Period% ], wait [ %Period% ] milliseconds, executes [ %Label% ], then repeats (until explicitly cancelled)
;	  |--> If called with a negative [ %Period% ], wait [ %Period% ] milliseconds, executes [ %Label% ], then returns
;
ClearTooltip(Period) {
	Label := "RemoveToolTip"
	SetTimer, %Label%, -%Period%
	Return
}


;
;	ClickLoop
;   |--> Clicks indefinitely until script is cancelled, with a long enough break between clicks to not make it impossible to stop
;
ClickLoop(MouseX,MouseY) {
	Loop {
		Sleep 1000
		MouseClick, Left, %MouseX%, %MouseY%
		Sleep 1000
	}
	Return
}


;
; CreateCitationsFooter
;   |--> Creates a block of text designed for placement at the bottom (footer) of a document,
;        script, etc. which contains Web-Urls to sources which assisted in building said script
;
CreateCitationsFooter() {
	AwaitModifierKeyup()
	Revert_A_KeyDelay := A_KeyDelay
	SetKeyDelay, 0, -1
	LF := "`n"
	Dashes := "------------------------------------------------------------"
	CitationsFooter := LF Dashes LF LF "Citation(s)" LF LF "domain  |  `"title`"  |  url" LF LF Dashes
	Send %LF%
	Send {Space}{Shift Down}{Home}{Shift Up}{Delete}
	Send %CitationsFooter%
	Send {LControl Down}{q}{LControl Up}
	Send {Up}
	Send {Home}{LControl Down}{q}{LControl Up}{Backspace}
	Send {Up}
	Send {LControl Down}{q}{LControl Up}
	Send {Home}{Right}{Space}{Space}
	Send {Up}
	Send {Home}{LControl Down}{q}{LControl Up}{Backspace}
	Send {Up}
	Send {LControl Down}{q}{LControl Up}
	Send {Up}
	Send {Home}{LControl Down}{q}{LControl Up}{Backspace}
	Send {Up}
	Send {LControl Down}{q}{LControl Up}
	Send {Up}
	SetKeyDelay, %Revert_A_KeyDelay%, -1
	Return
}


;
; CommentCurrentLine
;   |--> Uses Ctrl + Q hotkey to comment the current line (WITH a leading space) in a given IDE (Notepad++/VS-Code) 
;
CommentCurrentLine() {
	Send {LControl Down}{q}{LControl Up}
	Sleep 10
	Return
}


;
; CommentCurrentLine_NoSpace
;   |--> Uses Ctrl + Q hotkey to comment the current line (WITHOUT a leading space) in a given IDE (Notepad++/VS-Code)
;
CommentCurrentLine_NoSpace() {
	Send {Home}{LControl Down}{q}{LControl Up}{Backspace}
	Sleep 10
	Return
}


;
; Get_ahk_id_from_title
;   |--> Input: WinTitle to Target, WinTitle to Exclude from Targeting
;   |--> Returns ahk_id (process-handle) for AHK back-end control-based calls
;
Get_ahk_id_from_title(WinTitle,ExcludeTitle) {
	SetTitleMatchMode, 2 ; Title must CONTAIN [ WinTitle ] as a substring
	ControlGet, OutputVar, Hwnd,,, %WinTitle%,, %ExcludeTitle%
	Return ahk_id %OutputVar%
}


;
;	GetCommandOutput
;   |--> Returns the standard output returned from a CMD (ComSpec) command
;
GetCommandOutput(CMD_Command) {
	WScript_Shell_StdOut := RunWaitMany(CMD_Command)
	Return WScript_Shell_StdOut
}


;
;	GetPID
;   |--> Returns PID if process IS found
;   |--> Returns 0 if process is NOT found
;
GetPID(ProcName) {
	ProcessExist,, %ProcName%
	; ProcessExist, OutputVar, %ProcName%
	Return %ErrorLevel%
}


;
; Get_ahk_id_from_pid
;   |--> Input: WinPID to Target
;   |--> Returns ahk_id (process-handle) for AHK back-end control-based calls
;
Get_ahk_id_from_pid(WinPid) {
	SetTitleMatchMode, 2 ; Title must CONTAIN [ WinTitle ] as a substring
	ControlGet, OutputVar, Hwnd,,, ahk_pid %WinPid%
	Return ahk_id %OutputVar%
	; dat_ahk_id=ahk_id %output_var%
	; Return dat_ahk_id
}


;
; GetTimestamp
;   |--> Returns the current datetime formatted as-needed
;   |
;   |--> Example:  GetTimestamp("yyyyMMddTHHmmss")
;   |--> Example:  GetTimestamp("yyyy.MM.dd-HH.mm.ss")
;   |--> Example:  GetTimestamp("yyyy-MM-ddTHH-mm-ss")
;
GetTimestamp(YMD_Separator:="-", HMS_Separator:=":", DT_Field_Separator:="T") {
	; Global RFC3339_YearMonthDay_Separator
	; Global RFC3339_HMS_Separator
	; Global RFC3339_DateAndTimeField_Separator
	Timestamp_Format := "yyyy" YMD_Separator "MM" YMD_Separator "dd" DT_Field_Separator "HH" HMS_Separator "mm" HMS_Separator "ss"
	Return FormatTime("",Timestamp_Format)
}


;
; GetTimezoneOffset
;   |--> Returns the timezone with [ DateTime +/- Zulu-Offset ]
;
GetTimezoneOffset(ByRef Output_TZ, HMS_Separator:=":", UTC_ReplacementStr:="Z", StripCharacter:=".") {
	; Global RFC3339_UTC_ZeroHourReplacement
	Time_CurrentTZ := A_Now
	Time_UTC := A_NowUTC
	TZ_UTC_LocalOffset := DateDiff(Time_CurrentTZ, Time_UTC, "Minutes")
	TZ_UTC_HourOffset := Floor(TZ_UTC_LocalOffset/60)
	TZ_UTC_MinuteOffset := TZ_UTC_LocalOffset - TZ_UTC_HourOffset*60
	; +/- Timezone ahead/behind UTC determination
	TZ_UTC_PositiveNegative_Sign := ""
	If (TZ_UTC_HourOffset<0.0) {
		TZ_UTC_PositiveNegative_Sign := "-"
		TZ_UTC_HourOffset *= -1
	} Else {
		TZ_UTC_PositiveNegative_Sign := "+"
	}
	; Hours - Left-Pad with zeroes as-needed
	TZ_UTC_HourOffset_Padded := Format("{:02}", TZ_UTC_HourOffset)
	; Minutes - Left-Pad with zeroes as-needed
	TZ_UTC_MinuteOffset_Padded := Format("{:02}", TZ_UTC_MinuteOffset)
	Output_TZ := ""
	If ((TZ_UTC_HourOffset = 0.0) && (StrLen(UTC_ReplacementStr) > 0)) {
		; Replacement-string to use for timezone when the UTC timezone (UTC+00:00) is output
		Output_TZ := UTC_ReplacementStr
	} Else {
		Output_TZ := Output_TZ TZ_UTC_PositiveNegative_Sign
		Output_TZ := Output_TZ TZ_UTC_HourOffset_Padded
		Output_TZ := Output_TZ HMS_Separator
		Output_TZ := Output_TZ TZ_UTC_MinuteOffset_Padded
	}
	If (StrLen(StripCharacter) > 0) {
		Output_TZ := StrReplace(Output_TZ, StripCharacter, "")
	}
	Return
}


;
; GetTimezoneOffset_P
;   |--> Returns the timezone with "P" instead of "+", for fields which only allow alphanumeric with hyphens
;
GetTimezoneOffset_P(ByRef Output_TZ_P) {
	Output_TZ_P := ""
	GetTimezoneOffset(Output_TZ_P)
	Output_TZ_P := StrReplace(Output_TZ_P, "+", "P")
	Return
}


;
; GetWindowSpecs
;   |--> Gets Specs for currently-active window
;
GetWindowSpecs() {
	; Set the Gui-identifier (e.g. which gui-popup is affected by gui-based commands, such as [ Gui, ... ] and [ LV_Add(...) ])
	Gui, WindowSpecs:Default
	WinGetPos(Left, Top, Width, Height, "A")
	WinClass := WinGetClass("A")
	WinID := WinGetPID("A")
	WinPID := WinGetPID("A")
	WinProcessName := WinGetProcessName("A")
	WinProcessPath := WinGetProcessPath("A")
	WinText := WinGetText("A")
	WinTitle := WinGetTitle("A")
	WinControls := WinGetControls("A")  ; Get all control names in this window
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
	GUI_BACKGROUND_COLOR := "1E1E1E"
	GUI_TEXT_COLOR := "FFFFFF"
	; Gui Listview has many options under its "G-Label" callback - See more @ https://www.autohotkey.com/docs/commands/ListView.htm#G-Label_Notifications_Secondary
	GUI_OPT := "r" GUI_ROWCOUNT
	GUI_OPT := GUI_OPT " w" GUI_WIDTH
	GUI_OPT := GUI_OPT " gGetWindowSpecs_OnClick_LV_WindowSpecs"
	GUI_OPT := GUI_OPT " Background" GUI_BACKGROUND_COLOR
	GUI_OPT := GUI_OPT " C" GUI_TEXT_COLOR
	GUI_OPT := GUI_OPT " Grid"
	GUI_OPT := GUI_OPT " NoSortHdr"
	; GUI_OPT = %GUI_OPT% AltSubmit
	Gui, Add, ListView, %GUI_OPT%, Key|Value
	LV_Add("", "WinTitle", WinTitle)
	LV_Add("", "WinClass", WinClass)
	LV_Add("", "ProcessName", WinProcessName)
	LV_Add("", "ProcessPath", WinProcessPath)
	LV_Add("", "ControlList", WinControls)
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
		If (A_MsgBoxResult = "Yes") {
			Clipboard := ValSelected
		}
		; Gui, WindowSpecs:Default
		; Gui, Destroy
	}
	; DEBUGGING-ONLY (Set "%LV_Verbosity%" to 1 to enable verbose debug-logging)
	LV_Verbosity := 0
	If ( LV_Verbosity = 1 ) {
		TooltipOutput := "A_GuiEvent=[" A_GuiEvent "], A_EventInfo=[" A_EventInfo "]"
		ToolTip, %TooltipOutput%
		SetTimer, RemoveToolTip, -2500
	}
	Return
}


;
;	IfProcessExist (proxy-function for GetPID(...))
;   |--> Returns True if process IS found
;   |--> Returns False if process is NOT found
;
IfProcessExist(ProcName) {
	Return (GetPID(ProcName)>0) ? True : False
}


;
; LockWorkstation
;   |--> Lock the Workstation and turn-off/activate-lower-power-mode on monitors
;
LockWorkstation() {
	DllCall("LockWorkStation")
	Sleep 10
	Monitor_ActivateLowPowerMode()
	; Monitor_PowerOff()
	Return
}


;
; GetMicroseconds
;   |--> Gets the current timestamp's fractions-of-a-second, down to the 6th digit (microseconds-precision)
;   |--> Example call:
;          GetMicroseconds(CurrentMicroseconds)
;
GetMicroseconds(ByRef OutputVar) {
	vIntervals := 0
	DllCall("kernel32\GetSystemTimeAsFileTime", "Int64*",vIntervals)  ; 1 interval = 0.1 microseconds
	OutputVar := SubStr(Format("{:00}00", Mod(vIntervals, 10000000)), 1, 6)
	Return
}


;
; GetMilliseconds
;   |--> Gets the current timestamp's fractions-of-a-second, down to the 3rd digit (millisecond-precision)
;   |--> Example call:
;          GetMilliseconds(CurrentMilliseconds)
;
GetMilliseconds(ByRef OutputVar) {
	OutputVar := A_MSec
	Return
}

;
; GetNanoseconds
;   |--> Gets the current timestamp's fractions-of-a-second, down to the 9th digit (pseudo-nanosecond-precision - max-precision is actually only 7 digits past decimal, e.g. per-100-nanoseconds)
;   |--> Example call:
;          GetNanoseconds(CurrentNanoseconds)
;
GetNanoseconds(ByRef OutputVar) {
	vIntervals := 0
	DllCall("kernel32\GetSystemTimeAsFileTime", "Int64*",vIntervals)  ; 1 interval = 100 nanoseconds
	; vDate := 1601
	; EnvAdd, vDate, % vIntervals//10000000, S  ; autohotkey.com  |  "EnvAdd"  |  https://www.autohotkey.com/docs/commands/EnvAdd.htm
	OutputVar := Format("{:07}00", Mod(vIntervals, 10000000))
	Return
}


;
; Monitor_ActivateLowPowerMode
;   |--> [ 0x112 ] targets [ WM_SYSCOMMAND ] - https://docs.microsoft.com/en-us/windows/win32/menurc/wm-syscommand
;   |--> [ 0xF170 ] targets [ SCMONITORPOWER ]
;          |--> Sending a value of [ 1 ] sends [ activate low-power mode ] to attached monitor(s)
;
Monitor_ActivateLowPowerMode() {
	DllCall("LockWorkStation")
	Sleep 10
	SendMessage, 0x112, 0xF170, 1,, Program Manager
	Return
}


;
; Monitor_PowerOff
;   |--> [ 0x112 ] targets [ WM_SYSCOMMAND ] - https://docs.microsoft.com/en-us/windows/win32/menurc/wm-syscommand
;   |--> [ 0xF170 ] targets [ SCMONITORPOWER ]
;          |--> Sending a value of [ 2 ] sends [ power off ] to attached monitor(s)
;
Monitor_PowerOff() {
	DllCall("LockWorkStation")
	Sleep 10
	SendMessage, 0x112, 0xF170, 2,, Program Manager
	Return
}


;
; Monitor_PowerOn
;   |--> [ 0x112 ] targets [ WM_SYSCOMMAND ]
;   |--> [ 0xF170 ] targets [ SCMONITORPOWER ]
;          |--> Sending a value of [ -1 ] sends [ power on ] to attached monitor(s)
;
Monitor_PowerOn() {
	DllCall("LockWorkStation")
	Sleep 10
	SendMessage, 0x112, 0xF170, -1,, Program Manager
	Return
}


;
; Monitor_ShowScreenSaver
;   |--> [ 0x112 ] targets [ WM_SYSCOMMAND ] - https://docs.microsoft.com/en-us/windows/win32/menurc/wm-syscommand
;   |--> [ 0xF140 ] targets [ SC_SCREENSAVE ]
;          |--> Sending a value of [ 2 ] sends [ power off ] to attached monitor(s)
;
Monitor_ShowScreenSaver() {
	SendMessage, 0x112, 0xF140, 0,, Program Manager
	; |
	; |--> [ 0x112 ] targets [ WM_SYSCOMMAND ] - https://docs.microsoft.com/en-us/windows/win32/menurc/wm-syscommand
	; |
	; |--> [ 0xF140 ] targets [ SC_SCREENSAVE ]
	;
	Return
}


;
;	Open_Exe
;   |--> Opens target exeutable & sets its window to be active
;
Open_Exe(ExeFullpath) {
	Global VerboseOutput
	Timeout := 10
	SplitPath %ExeFullpath%, ExeBasename, ExeDirname, ExeExtension, ExeBasenameNoExt, ExeDrivename
	If (ProcessExist(ExeBasename) == True) {
		; Executable IS running
		If (VerboseOutput == 1) {
			TextToolTip := "Activating `"" ExeBasename "`""
			ToolTip, %TextToolTip%
			ClearTooltip(2000)
		}
		ExePID := GetPID(ExeBasename)
		WinActivate, ahk_pid %ExePID%
	} Else If (FileExist(ExeFullpath)) {
		; Executable NOT running but IS found locally
		If (VerboseOutput == 1) {
			TextToolTip := "Opening `"" ExeBasename "`""
			ToolTip, %TextToolTip%
			ClearTooltip(2000)
		}
		; Run, %ExeFullpath%
		ExitCode := RunWait(%ExeFullpath%,,, ExePID)
		; WinWait "ahk_pid " ExePID
		; ExePID := GetPID(ExeBasename)
		WinActivate, ahk_pid %ExePID%
	} Else {
		; Executable NOT running & NOT found locally
		If (VerboseOutput == 1) {
			TextToolTip := "File not found: `"" ExeFullpath "`""
			ToolTip, %TextToolTip%
			ClearTooltip(2000)
		}
	}
	Return
}

;
;	OpenChrome
;   |--> Opens the "Google Chrome" Application
;
OpenChrome() {
	ExeFullpath := "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
	Open_Exe(ExeFullpath)
	Return
}


;
;	OpenPasswordGenerator
;   |--> Opens Roboform's Password Generator executable
;
OpenPasswordGenerator() {
	Global VerboseOutput
	AwaitModifierKeyup()  ; Wait until all modifier keys are released
	SetTitleMatchMode, 2  ; A window's title can contain WinTitle anywhere inside it to be a match
	; SetTitleMatchMode, 3  ; A window's title must exactly match WinTitle to be a match
	ProcessPath := "C:\Program Files (x86)\Siber Systems\AI RoboForm\passwordgenerator.exe"
	WinTitle := "Password Generator - RoboForm"
	WinTitle_Login := "RoboForm Log In"
	MaxWaitSeconds := 5
	If (WinExist(WinTitle_Login)) {
		WinActivate, %WinTitle_Login%
	} Else If (WinExist(WinTitle)) {
		If (VerboseOutput == 1) {
			Text_TrayTip := "Activating existing instance of `"" WinTitle "`""
			; TrayTip, AHK, %Text_TrayTip%  ; Toast Notification
		}
		WinActivate, %WinTitle%
	} Else If (FileExist(ProcessPath)) {
		If (VerboseOutput == 1) {
			Text_TrayTip := "Opening new-instance of `"" WinTitle "`""
			; TrayTip, AHK, %Text_TrayTip%  ; Toast Notification
		}
		Run, %ProcessPath%
		WinWait, %WinTitle%,, %MaxWaitSeconds%
		If (WinExist(WinTitle)) {
			WinActivate, %WinTitle%
		} Else If (WinExist(WinTitle_Login)) {
			WinActivate, %WinTitle_Login%
		} Else {
			Text_TrayTip := "Error - Max wait-timeout of " MaxWaitSeconds "s reached while waiting for `"" WinTitle "`""
			TrayTip, AHK, %Text_TrayTip%  ; Toast Notification
		}
	} Else {
		Text_TrayTip := "Error - ProcessPath not found:  `"" ProcessPath "`""
		TrayTip, AHK, %Text_TrayTip%  ; Toast Notification
	}
	Return
}


;
; OpenVisualStudioCode
;   |--> Opens Microsoft's "Visual Studio Code" Application (Free Source Code Editor / IDE)
;
OpenVisualStudioCode() {
	ExeFullpath := "C:\Program Files\Microsoft VS Code\Code.exe"
	ExeArg1 := "--user-data-dir=`"" A_AppData "\Code`""
	ExeArg2 := A_MyDocuments "\GitHub\cloud-infrastructure\.vscode\github.code-workspace"
	ExeArguments := ExeArg1 " " ExeArg2
	SplitPath %ExeFullpath%, ExeBasename, ExeDirname, ExeExtension, ExeBasenameNoExt, ExeDrivename
	Run, %ExeFullpath% %ExeArguments%
	ExePID := GetPID(ExeBasename)
	WinActivate, ahk_pid %ExePID%
	Return
}


;
; OpenVSCode
;   |--> Opens the "Visual Studio Code" Application
;
OpenVSCode() {
	OpenVisualStudioCode()
	Return
}


;
; PasteClipboardAsBinary
;   |--> Pastes the current clipboard data as binary-data (as-if the user somehow entered it without pasting it off the Clipboard)
;
PasteClipboardAsBinary() {
	Global VerboseOutput
	SetKeyDelay, 0, -1
	AwaitModifierKeyup()  ; Wait until all modifier keys are released
	Sleep, 100
	Clipboard := ClipboardAll
	Sleep, 100
	Clipboard := Clipboard  ; Convert any copied files, HTML, or other formatted text to plain text.
	Sleep, 100
	Send {Blind}{Text}%Clipboard%
	Sleep, 100
	ClipboardDuped := ""  ; Avoid caching clipboard-contents in memory
	ClipboardSend := ""  ; Avoid caching clipboard-contents in memory
	Return
}


;
; PasteClipboardAsText
;   |--> Pastes the current clipboard data as text (as-if the user typed it instead of pasted it)
;
PasteClipboardAsText() {
	Global VerboseOutput
	SetKeyDelay, 1, -1  ; A tiny delay between each keypress is often required by anti-paste mechanisms on websites - Set the shortest delay to work around this
	AwaitModifierKeyup()  ; Wait until all modifier keys are released
	ClipboardDuped:=Clipboard
	; If (VerboseOutput == 1) {
	; 	TrayTip, AHK,
	; 	(LTrim
	; 		Pasting the Text version of the Clipboard
	; 	)  ; Toast Notification
	; }
	; Trim each line before pasting it (To avoid auto-indentation on Notepad++, VS-Code, & other IDE's)
	ClipboardSend := ""
	VarSetCapacity(ClipboardSend, StrLen(ClipboardDuped)*2)
	Loop, Parse, ClipboardDuped, "`n", "`r"
	{
		ClipboardSend := (A_Index=1?"":"`r`n") Trim(A_LoopField)
		Send {Blind}{Text}%ClipboardSend%
		ClipboardSend := ""  ; Avoid caching clipboard-contents in memory
		Sleep 100
	}
	Sleep, 100
	ClipboardDuped := ""  ; Avoid caching clipboard-contents in memory
	ClipboardSend := ""  ; Avoid caching clipboard-contents in memory
	Return
}


;
; PasteClipboard_TextOrBinary
;   |--> Displays a menu asking user if they wish to paste the clipboard as Text or Binary data (workaround for websites which block pasting into forms)
;
PasteClipboard_TextOrBinary() {
	SetTimer, CustomMsgboxButtons_ClipboardTextOrBinary, 50 
	MsgBox, 3, Text or Binary, Paste the Clipboard as Text or Binary?
	If (A_MsgBoxResult = "Yes") {
		; Paste the Text version of the Clipboard
		PasteClipboardAsText()
	}
	If (A_MsgBoxResult = "No") {
		; Paste the Binary version of the Clipboard
		PasteClipboardAsBinary()
	}
	Return
}
CustomMsgboxButtons_ClipboardTextOrBinary:
	If (WinExist("Text or Binary")=0) {
		Return  ; Continue waiting for the "Clipboard or ClipboardAll" window to appear
	}
	SetTimer, CustomMsgboxButtons_ClipboardTextOrBinary, Off 
	WinActivate 
	ControlSetText, Button1, &Text
	ControlSetText, Button2, &Binary
	Return


;
; PrintEnv
;   |--> Gets Windows Environment Vars (output to file)
;
PrintEnv() {
	Global COMPUTERNAME
	Global USER_DESKTOP
	Global USERNAME
	FormatTime,TIMESTAMP,,yyyyMMddTHHmmss
	Logfile_EnvVars := USER_DESKTOP "\WindowsEnvVars-" COMPUTERNAME "-" USERNAME ".log"
	Logfile_EnvVars_Timestamp := USER_DESKTOP "\WindowsEnvVars-" COMPUTERNAME "-" USERNAME "-" TIMESTAMP ".log"
	; KnownWinEnvVars :=
	; (LTrim
	; ==========================================================================
	;
	; *** Environment Vars - Current Session ***
	;
	; TIMESTAMP = %TIMESTAMP%
	;
	; --------------------------------------------------------------------------
	;
	; *** Windows Environment Vars (Long-standing) ***
	;
	; COMPUTERNAME         %COMPUTERNAME%
	; USERNAME             %USERNAME%
	; USERDOMAIN           %USERDOMAIN%
	; LOGONSERVER          %LOGONSERVER%
	;
	; ALLUSERSPROFILE      %ALLUSERSPROFILE%
	; APPDATA              %APPDATA%
	; COMMONPROGRAMFILES   %COMMONPROGRAMFILES%
	; HOMEDRIVE            %HOMEDRIVE%
	; HOMEPATH             %HOMEPATH%
	; LOCALAPPDATA         %LOCALAPPDATA%
	; PROGRAMDATA          %PROGRAMDATA%
	; PROGRAMFILES         %PROGRAMFILES%
	; PUBLIC               %PUBLIC%
	; SYSTEMDRIVE          %SYSTEMDRIVE%
	; SYSTEMROOT           %SYSTEMROOT%
	; TEMP                 %TEMP%
	; TMP                  %TMP%
	; USERPROFILE          %USERPROFILE%
	; WINDIR               %WINDIR%
	;
	; --------------------------------------------------------------------------
	;
	; *** Autohotkey Vars ***
	;
	; A_AhkVersion: %A_AhkVersion%
	; A_AhkPath: %A_AhkPath%
	; A_IsUnicode: %A_IsUnicode%
	; A_IsCompiled: %A_IsCompiled%
	;
	; A_WorkingDir: %A_WorkingDir%
	; A_ScriptDir: %A_ScriptDir%
	;
	; A_ScriptName: %A_ScriptName%
	; A_ScriptFullPath: %A_ScriptFullPath%
	;
	; A_LineFile: %A_LineFile%
	; A_LineNumber: %A_LineNumber%
	;
	; A_ThisLabel: %A_ThisLabel%
	; A_ThisFunc: %A_ThisFunc%
	;
	; ==========================================================================
	; )
	; ; - -
	; FileAppend, %KnownWinEnvVars%, %Logfile_EnvVars_Timestamp%
	; Run, Notepad "%Logfile_EnvVars_Timestamp%"
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
; RemoveSplashText
;   |--> Removes any SplashText found
;
RemoveSplashText() {
	; SplashTextOff
	Return
}


;
; RemoveToolTip
;   |--> Removes any Tooltips found
;
RemoveToolTip() {
	ToolTip
	Return
}


;
; RunWaitOne
;   |--> Executes a single command through the current ComSpec (usually "cmd.exe")  |  https://www.autohotkey.com/docs/commands/Run.htm#StdOut
;   |--> Example-call:
;          MsgBox % RunWaitOne("dir " A_ScriptDir)
;
RunWaitOne(CMD_Command) {
	WScript_Shell := ComObjCreate("WScript.Shell")
	Run_Command := ComSpec " /C `"" CMD_Command "`" "
	WScript_Shell_Exec := WScript_Shell.Run(Run_Command, 0, true)
	Return WScript_Shell_Exec
}


;
; RunWaitMany
;   |--> Executes multiple commands through the current ComSpec (usually "cmd.exe")  |  https://www.autohotkey.com/docs/commands/Run.htm#StdOut
;   |--> Example-call:
;          MsgBox % RunWaitMany("
;          (
;          echo Put your commands here,
;          echo each one will be run,
;          echo and you'll get the output.
;          )")
;
RunWaitMany(CMD_Commands) {
	WScript_Shell := ComObjCreate("WScript.Shell")
	; Open cmd.exe with echoing of commands disabled
	WScript_Shell_Exec := WScript_Shell.Exec(ComSpec " /Q /K echo off")
	; Send the commands to execute, separated by newline
	WScript_Shell_Exec.StdIn.WriteLine(CMD_Commands "`nexit")  ; Always exit at the end!
	; Read and return the output of all commands
	Return WScript_Shell_Exec.StdOut.ReadAll()
}


;
;	SendSpace
;   |--> For some reason, Windows 10 doesn't like Send {Space} (as-in it 'ignores' the keypress), but happily accepts Send {SC039} as equivalent to a spacebar-press
;
SendSpace() {
	Send {SC039}
	Return
}


;
;	ShowCursorCoordinates
;   |--> Displays a tooltip with the coordinates right next to the cursor's current location
;
ShowCursorCoordinates(FollowDuration) {
	CoordMode, Mouse, Screen
	PollDuration_ms := 10
	Loop_Iterations := Floor((1000 * FollowDuration) / PollDuration_ms)
	Loop %Loop_Iterations% {
		MouseGetPos, MouseX, MouseY
		Tooltip, x%MouseX% y%MouseY%
		Sleep %PollDuration_ms%
	}
	ClearTooltip(0)
}


;
;	ShowVolumeLevel
;   |--> Show a tooltip with the volume as an integer, as well as filled-bars around it to intuitively show the volume, as well as a mute icon around the integer if muted
;
ShowVolumeLevel() {
	CoordMode, Mouse, Screen
	Icon_MutedSpeaker := 🔇
	Icon_SpeakerLowVolume := 🔈
	Icon_SpeakerMediumVolume := 🔉
	Icon_SpeakerHighVolume := 🔊
	Icon_VolumeFilled := ⬛️
	Icon_VolumeBlanks := ⬜️
	; Get the volume & mute current-settings
	SoundGet, NewVolumeLevel
	SoundGet, MasterMute, , MUTE
	; Final volume level
	NewVolumeLevel := Round( NewVolumeLevel )
	NewVolumeLevelPercentage := NewVolumeLevel "`%"
	; Build the volume-bars (out-of dingbats/utf8+ icons)
	Total_IconCount_MaxVolume := 20
	IconCount_TopBot_Filled := Round( ( NewVolumeLevel / 100 ) * Total_IconCount_MaxVolume)
	IconCount_TopBot_Blanks := Total_IconCount_MaxVolume - IconCount_TopBot_Filled
	DisplayedIcons_TopBot_Filled := StringRepeat( Icon_VolumeFilled, IconCount_TopBot_Filled )
	DisplayedIcons_TopBot_Blanks := StringRepeat( Icon_VolumeBlanks, IconCount_TopBot_Blanks )
	VolumeBars_TopBot := DisplayedIcons_TopBot_Filled DisplayedIcons_TopBot_Blanks
	IconCount_Middle_Filled := Round( ( NewVolumeLevel / 100 ) * Total_IconCount_MaxVolume) - 4
	IconCount_Middle_Blanks := Total_IconCount_MaxVolume - IconCount_Middle_Filled
	DisplayedIcons_Middle_Filled := StringRepeat( Icon_VolumeFilled, IconCount_Middle_Filled )
	DisplayedIcons_Middle_Blanks := StringRepeat( Icon_VolumeBlanks, IconCount_Middle_Blanks )
	VolumeBars_Middle := DisplayedIcons_Middle_Filled DisplayedIcons_Middle_Blanks
	TrimCount_TopBot := Round( StrLen( VolumeBars_TopBot ) / 2 )
	TrimCount_Middle := Round( StrLen( VolumeBars_Middle ) / 2 )
	Echo_TopBot_LeftHalf := RTrim(SubStr(VolumeBars_TopBot, 0, (StrLen(VolumeBars_TopBot)-TrimCount_TopBot) ))
	Echo_TopBot_RightHalf := RTrim(SubStr(VolumeBars_TopBot, TrimCount_TopBot, StrLen(VolumeBars_TopBot)))
	Echo_TopBot_LeftHalf := Icon_SpeakerMediumVolume A_Space A_Space A_Space Echo_TopBot_LeftHalf
	Echo_TopBot_RightHalf := Echo_TopBot_RightHalf A_Space A_Space Icon_SpeakerHighVolume
	Echo_Middle_LeftHalf := Echo_TopBot_LeftHalf
	Echo_Middle_RightHalf := Echo_TopBot_RightHalf
	IconSlice_Middle_EachSide := 3
	Mute_AddSpaces := 3
	Echo_Middle_LeftHalf := SubStr( Echo_TopBot_LeftHalf, 1, ( -1 * IconSlice_Middle_EachSide * StrLen( Icon_VolumeFilled )) )
	Echo_Middle_RightHalf := SubStr( Echo_TopBot_RightHalf, ( IconSlice_Middle_EachSide * StrLen( Icon_VolumeFilled )) )
	; Show mute status next to the integer volume level
	;   |--> Replace mute-icon w/ whitespace if un-muted
	Mute_StatusIcon := ( ( MasterMute == "On" ) ? ( Icon_MutedSpeaker ) : ( StringRepeat( A_Space , 4 ) ) )
	Mute_LSpaces := ( Round( Mute_AddSpaces / 2 ) )
	Mute_RSpaces := ( Mute_AddSpaces - Mute_LSpaces )
	Mute_Padding := StringRepeat( A_Space , Mute_LSpaces ) Mute_StatusIcon StringRepeat( A_Space , Mute_RSpaces )
	If ( NewVolumeLevel == 100 ) {
		; Mute_AddSpaces := Mute_AddSpaces + 0
		Echo_Middle_Center := Mute_Padding NewVolumeLevel Mute_Padding
	} Else If ( NewVolumeLevel >= 10 ) {
		; Mute_AddSpaces := Mute_AddSpaces + 1
		Echo_Middle_Center := Mute_Padding A_Space NewVolumeLevel A_Space Mute_Padding
	} Else {
		; Mute_AddSpaces := Mute_AddSpaces + 2
		Echo_Middle_Center := Mute_Padding A_Space A_Space NewVolumeLevel A_Space A_Space Mute_Padding
	}
	Echo_TopBot_Center := StringRepeat( A_Space , 0 )
	Echo_Tooltip := ""
	Echo_Tooltip := Echo_Tooltip Echo_TopBot_LeftHalf Echo_TopBot_Center Echo_TopBot_RightHalf "`n"
	Echo_Tooltip := Echo_Tooltip Echo_Middle_LeftHalf Echo_Middle_Center Echo_Middle_RightHalf "`n"
	Echo_Tooltip := Echo_Tooltip Echo_TopBot_LeftHalf Echo_TopBot_Center Echo_TopBot_RightHalf
	OutputWidth := 317
	OutputHeight := 50
	StartMenuHeight := 40
	; On-Screen Tooltip Location - X Coordinate (Left to Right)
	x_loc := Round( ( A_ScreenWidth - OutputWidth ) / 2 )
	; On-Screen Tooltip Location - Y Coordinate (Top to Bottom)
	y_loc := ( A_ScreenHeight - ( OutputHeight * 3 ) )
	ToolTip, %Echo_Tooltip%, %x_loc%, %y_loc%
	ClearTooltip(750)
	Return
}


;
;	ShowWindowTitles
;   |--> Lists all window-titles (in current user's environment)
;
ShowWindowTitles() {
	Gui, WinTitles:Default
	Gui, Add, ListView, r50 w1000 gShowWindowTitles_OnDoubleClick_GuiDestroy_WinTitles, WindowTitle
	Window := WinGetList("A")
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
}


;
;	ShowWindowTitles_OnDoubleClick_GuiDestroy_WinTitles
;   |--> Sub-Function of "ShowWindowTitles()"
;
ShowWindowTitles_OnDoubleClick_GuiDestroy_WinTitles() {
	If (A_GuiEvent = "DoubleClick") {
		Gui, WinTitles:Default
		Gui, Destroy
	}
	Return
}


;
;	SpaceUp_Loop
;   |--> Designed for Windows Task Scheduler to quickly show open all tasks on the main page, which can then be sorted (but only for the ones that've been opened)
;
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


;
; StringRepeat
;   |--> Repeat a string a given number of times
;
StringRepeat(StrToRepeat, Multiplier) {
	ReturnedVal := ""
	If (Multiplier > 0) {
		Loop {
			If (A_Index > Multiplier) {
				Break
			}
			ReturnedVal .= StrToRepeat
		}
	}
	Return ReturnedVal
}


;
; StrLenUnicode
;   |--> Get String-Length for unicode string(s)? (Need better description)
;
StrLenUnicode(data) {
	RegExReplace(data, "s).", "", i)
	Return i
}


;
; TabSpace_Loop
;   |--> Designed for Samsung SmartThings' Web-IDE where (sometimes) multiple hundreds of checkboxes need to be selected individually to update from a Git repo
;
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
; TempFile
;   |--> Creates a temporary file with a timestamp (down to the millisecond) based filename
;   |--> Returns a string-value containing the fullpath of the temporary file (which was just created)
;
TempFile() {
	TempFile_Dirname := A_Temp "\AutoHotkey\"
	If (!FileExist("%TempFile_Dirname%")) {
		DirCreate "%TempFile_Dirname%"
	}
	TempFile_Basename := A_Now "." A_MSec
	TempFile_Fullpath := TempFile_Dirname TempFile_Basename
	Return %TempFile_Fullpath%
}


;
; XBox_DownloadDelete_GameClips
;   |--> Win10 Download & Delete Recordings via XBox Win10 App
;
XBox_DownloadDelete_GameClips() {
	;	CoordMode, Mouse, Screen
	SetDefaultMouseSpeed, 0
	SetControlDelay, -1
	SetTitleMatchMode, 1  ; A window's title must start with the specified WinTitle to be a match
	Sleep 2500
	; "Captures" (Left Tab)
	MouseClick, Left, 23, 314
	Sleep 7500
	; "On Xbox Live" (Tab within "Captures")
	MouseClick, Left, 240, 138
	Sleep 7500
	; "Everything v" (Dropdown within "On Xbox Live")
	MouseClick, Left, 255, 178
	Sleep 7500
	; "Game clips" (Option on "Everything v" Dropdown)
	MouseClick, Left, 233, 220
	Sleep 7500
	Loop {
		MouseClick, Left, 861, 947
		Sleep 30000
		; Sleep 15000
		; Sleep 10000
		MouseClick, Left, 1420, 905
		Sleep 1000
		MouseClick, Left, 848, 575
		Sleep 7500
	}
	Return
}


;
; SendDashedLine
;   |--> Output a line ------------------------------------------------------------ of dashes
;
SendDashedLine() {
	AwaitModifierKeyup()
	SetKeyDelay, 0, -1
	; StringToType := StringRepeat("-",60)
	SendInput, ------------------------------------------------------------
	Return
}


; ------------------------------------------------------------
;
; Laptop Brightness Class
; BS := new BrightnessSetter()
; PgUp::BS.SetBrightness(10)
; PgDn::BS.SetBrightness(-10)
;

class BrightnessSetter {
	; qwerty12 - 27/05/17
	; https://github.com/qwerty12/AutoHotkeyScripts/tree/master/LaptopBrightnessSetter
	static _WM_POWERBROADCAST := 0x218, _osdHwnd := 0, hPowrprofMod := DllCall("LoadLibrary", "Str", "powrprof.dll", "Ptr") 
	__New() {
		if (BrightnessSetter.IsOnAc(AC))
			this._AC := AC
		if ((this.pwrAcNotifyHandle := DllCall("RegisterPowerSettingNotification", "Ptr", A_ScriptHwnd, "Ptr", BrightnessSetter._GUID_ACDC_POWER_SOURCE(), "UInt", DEVICE_NOTIFY_WINDOW_HANDLE := 0x00000000, "Ptr"))) ; Sadly the callback passed to *PowerSettingRegister*Notification runs on a new threadl
			OnMessage(this._WM_POWERBROADCAST, ((this.pwrBroadcastFunc := ObjBindMethod(this, "_On_WM_POWERBROADCAST"))))
	}
	__Delete() {
		if (this.pwrAcNotifyHandle) {
			OnMessage(BrightnessSetter._WM_POWERBROADCAST, this.pwrBroadcastFunc, 0)
			,DllCall("UnregisterPowerSettingNotification", "Ptr", this.pwrAcNotifyHandle)
			,this.pwrAcNotifyHandle := 0
			,this.pwrBroadcastFunc := ""
		}
	}
	SetBrightness(increment, jump := False, showOSD := True, autoDcOrAc := -1, ptrAnotherScheme := 0)
	{
		static PowerGetActiveScheme := DllCall("GetProcAddress", "Ptr", BrightnessSetter.hPowrprofMod, "AStr", "PowerGetActiveScheme", "Ptr")
			  ,PowerSetActiveScheme := DllCall("GetProcAddress", "Ptr", BrightnessSetter.hPowrprofMod, "AStr", "PowerSetActiveScheme", "Ptr")
			  ,PowerWriteACValueIndex := DllCall("GetProcAddress", "Ptr", BrightnessSetter.hPowrprofMod, "AStr", "PowerWriteACValueIndex", "Ptr")
			  ,PowerWriteDCValueIndex := DllCall("GetProcAddress", "Ptr", BrightnessSetter.hPowrprofMod, "AStr", "PowerWriteDCValueIndex", "Ptr")
			  ,PowerApplySettingChanges := DllCall("GetProcAddress", "Ptr", BrightnessSetter.hPowrprofMod, "AStr", "PowerApplySettingChanges", "Ptr")
		if (increment == 0 && !jump) {
			if (showOSD)
				BrightnessSetter._ShowBrightnessOSD()
			return
		}
		if (!ptrAnotherScheme ? DllCall(PowerGetActiveScheme, "Ptr", 0, "Ptr*", currSchemeGuid, "UInt") == 0 : DllCall("powrprof\PowerDuplicateScheme", "Ptr", 0, "Ptr", ptrAnotherScheme, "Ptr*", currSchemeGuid, "UInt") == 0) {
			if (autoDcOrAc == -1) {
				if (this != BrightnessSetter) {
					AC := this._AC
				} else {
					if (!BrightnessSetter.IsOnAc(AC)) {
						DllCall("LocalFree", "Ptr", currSchemeGuid, "Ptr")
						return
					}
				}
			} else {
				AC := !!autoDcOrAc
			}
			currBrightness := 0
			if (jump || BrightnessSetter._GetCurrentBrightness(currSchemeGuid, AC, currBrightness)) {
				 maxBrightness := BrightnessSetter.GetMaxBrightness()
				,minBrightness := BrightnessSetter.GetMinBrightness()
				if (jump || !((currBrightness == maxBrightness && increment > 0) || (currBrightness == minBrightness && increment < minBrightness))) {
					if (currBrightness + increment > maxBrightness)
						increment := maxBrightness
					else if (currBrightness + increment < minBrightness)
						increment := minBrightness
					else
						increment += currBrightness
					if (DllCall(AC ? PowerWriteACValueIndex : PowerWriteDCValueIndex, "Ptr", 0, "Ptr", currSchemeGuid, "Ptr", BrightnessSetter._GUID_VIDEO_SUBGROUP(), "Ptr", BrightnessSetter._GUID_DEVICE_POWER_POLICY_VIDEO_BRIGHTNESS(), "UInt", increment, "UInt") == 0) {
						; PowerApplySettingChanges is undocumented and exists only in Windows 8+. Since both the Power control panel and the brightness slider use this, we'll do the same, but fallback to PowerSetActiveScheme if on Windows 7 or something
						if (!PowerApplySettingChanges || DllCall(PowerApplySettingChanges, "Ptr", BrightnessSetter._GUID_VIDEO_SUBGROUP(), "Ptr", BrightnessSetter._GUID_DEVICE_POWER_POLICY_VIDEO_BRIGHTNESS(), "UInt") != 0)
							DllCall(PowerSetActiveScheme, "Ptr", 0, "Ptr", currSchemeGuid, "UInt")
					}
				}
				if (showOSD)
					BrightnessSetter._ShowBrightnessOSD()
			}
			DllCall("LocalFree", "Ptr", currSchemeGuid, "Ptr")
		}
	}
	IsOnAc(ByRef acStatus)
	{
		static SystemPowerStatus
		if (!VarSetCapacity(SystemPowerStatus))
			VarSetCapacity(SystemPowerStatus, 12)
		if (DllCall("GetSystemPowerStatus", "Ptr", &SystemPowerStatus)) {
			acStatus := NumGet(SystemPowerStatus, 0, "UChar") == 1
			return True
		}
		return False
	}
	
	GetDefaultBrightnessIncrement()
	{
		static ret := 10
		DllCall("powrprof\PowerReadValueIncrement", "Ptr", BrightnessSetter._GUID_VIDEO_SUBGROUP(), "Ptr", BrightnessSetter._GUID_DEVICE_POWER_POLICY_VIDEO_BRIGHTNESS(), "UInt*", ret, "UInt")
		return ret
	}
	GetMinBrightness()
	{
		static ret := -1
		if (ret == -1)
			if (DllCall("powrprof\PowerReadValueMin", "Ptr", BrightnessSetter._GUID_VIDEO_SUBGROUP(), "Ptr", BrightnessSetter._GUID_DEVICE_POWER_POLICY_VIDEO_BRIGHTNESS(), "UInt*", ret, "UInt"))
				ret := 0
		return ret
	}
	GetMaxBrightness()
	{
		static ret := -1
		if (ret == -1)
			if (DllCall("powrprof\PowerReadValueMax", "Ptr", BrightnessSetter._GUID_VIDEO_SUBGROUP(), "Ptr", BrightnessSetter._GUID_DEVICE_POWER_POLICY_VIDEO_BRIGHTNESS(), "UInt*", ret, "UInt"))
				ret := 100
		return ret
	}
	_GetCurrentBrightness(schemeGuid, AC, ByRef currBrightness)
	{
		static PowerReadACValueIndex := DllCall("GetProcAddress", "Ptr", BrightnessSetter.hPowrprofMod, "AStr", "PowerReadACValueIndex", "Ptr")
			  ,PowerReadDCValueIndex := DllCall("GetProcAddress", "Ptr", BrightnessSetter.hPowrprofMod, "AStr", "PowerReadDCValueIndex", "Ptr")
		return DllCall(AC ? PowerReadACValueIndex : PowerReadDCValueIndex, "Ptr", 0, "Ptr", schemeGuid, "Ptr", BrightnessSetter._GUID_VIDEO_SUBGROUP(), "Ptr", BrightnessSetter._GUID_DEVICE_POWER_POLICY_VIDEO_BRIGHTNESS(), "UInt*", currBrightness, "UInt") == 0
	}
	
	_ShowBrightnessOSD()
	{
		static PostMessagePtr := DllCall("GetProcAddress", "Ptr", DllCall("GetModuleHandle", "Str", "user32.dll", "Ptr"), "AStr", A_IsUnicode ? "PostMessageW" : "PostMessageA", "Ptr")
			  ,WM_SHELLHOOK := DllCall("RegisterWindowMessage", "Str", "SHELLHOOK", "UInt")
		if ((A_OSVersion=="WIN_VISTA")||(A_OSVersion=="WIN_7"))
			return
		BrightnessSetter._RealiseOSDWindowIfNeeded()
		; Thanks to YashMaster @ https://github.com/YashMaster/Tweaky/blob/master/Tweaky/BrightnessHandler.h for realising this could be done:
		if (BrightnessSetter._osdHwnd)
			DllCall(PostMessagePtr, "Ptr", BrightnessSetter._osdHwnd, "UInt", WM_SHELLHOOK, "Ptr", 0x37, "Ptr", 0)
	}
	_RealiseOSDWindowIfNeeded()
	{
		static IsWindow := DllCall("GetProcAddress", "Ptr", DllCall("GetModuleHandle", "Str", "user32.dll", "Ptr"), "AStr", "IsWindow", "Ptr")
		if (!DllCall(IsWindow, "Ptr", BrightnessSetter._osdHwnd) && !BrightnessSetter._FindAndSetOSDWindow()) {
			BrightnessSetter._osdHwnd := 0
			try if ((shellProvider := ComObjCreate("{C2F03A33-21F5-47FA-B4BB-156362A2F239}", "{00000000-0000-0000-C000-000000000046}"))) {
				try if ((flyoutDisp := ComObjQuery(shellProvider, "{41f9d2fb-7834-4ab6-8b1b-73e74064b465}", "{41f9d2fb-7834-4ab6-8b1b-73e74064b465}"))) {
					 DllCall(NumGet(NumGet(flyoutDisp+0)+3*A_PtrSize), "Ptr", flyoutDisp, "Int", 0, "UInt", 0)
					,ObjRelease(flyoutDisp)
				}
				ObjRelease(shellProvider)
				if (BrightnessSetter._FindAndSetOSDWindow())
					return
			}
			; who knows if the SID & IID above will work for future versions of Windows 10 (or Windows 8). Fall back to this if needs must
			Loop 2 {
				SendEvent {Volume_Mute 2}
				if (BrightnessSetter._FindAndSetOSDWindow())
					return
				Sleep 100
			}
		}
	}
	_FindAndSetOSDWindow()
	{
		static FindWindow := DllCall("GetProcAddress", "Ptr", DllCall("GetModuleHandle", "Str", "user32.dll", "Ptr"), "AStr", A_IsUnicode ? "FindWindowW" : "FindWindowA", "Ptr")
		return !!((BrightnessSetter._osdHwnd := DllCall(FindWindow, "Str", "NativeHWNDHost", "Str", "", "Ptr")))
	}
	_On_WM_POWERBROADCAST(wParam, lParam)
	{
		;OutputDebug % &this
		if (wParam == 0x8013 && lParam && NumGet(lParam+0, 0, "UInt") == NumGet(BrightnessSetter._GUID_ACDC_POWER_SOURCE()+0, 0, "UInt")) { ; PBT_POWERSETTINGCHANGE and a lazy comparison
			this._AC := NumGet(lParam+0, 20, "UChar") == 0
			return True
		}
	}
	_GUID_VIDEO_SUBGROUP()
	{
		static GUID_VIDEO_SUBGROUP__
		if (!VarSetCapacity(GUID_VIDEO_SUBGROUP__)) {
			 VarSetCapacity(GUID_VIDEO_SUBGROUP__, 16)
			,NumPut(0x7516B95F, GUID_VIDEO_SUBGROUP__, 0, "UInt"), NumPut(0x4464F776, GUID_VIDEO_SUBGROUP__, 4, "UInt")
			,NumPut(0x1606538C, GUID_VIDEO_SUBGROUP__, 8, "UInt"), NumPut(0x99CC407F, GUID_VIDEO_SUBGROUP__, 12, "UInt")
		}
		return &GUID_VIDEO_SUBGROUP__
	}
	_GUID_DEVICE_POWER_POLICY_VIDEO_BRIGHTNESS()
	{
		static GUID_DEVICE_POWER_POLICY_VIDEO_BRIGHTNESS__
		if (!VarSetCapacity(GUID_DEVICE_POWER_POLICY_VIDEO_BRIGHTNESS__)) {
			 VarSetCapacity(GUID_DEVICE_POWER_POLICY_VIDEO_BRIGHTNESS__, 16)
			,NumPut(0xADED5E82, GUID_DEVICE_POWER_POLICY_VIDEO_BRIGHTNESS__, 0, "UInt"), NumPut(0x4619B909, GUID_DEVICE_POWER_POLICY_VIDEO_BRIGHTNESS__, 4, "UInt")
			,NumPut(0xD7F54999, GUID_DEVICE_POWER_POLICY_VIDEO_BRIGHTNESS__, 8, "UInt"), NumPut(0xCB0BAC1D, GUID_DEVICE_POWER_POLICY_VIDEO_BRIGHTNESS__, 12, "UInt")
		}
		return &GUID_DEVICE_POWER_POLICY_VIDEO_BRIGHTNESS__
	}
	_GUID_ACDC_POWER_SOURCE()
	{
		static GUID_ACDC_POWER_SOURCE_
		if (!VarSetCapacity(GUID_ACDC_POWER_SOURCE_)) {
			 VarSetCapacity(GUID_ACDC_POWER_SOURCE_, 16)
			,NumPut(0x5D3E9A59, GUID_ACDC_POWER_SOURCE_, 0, "UInt"), NumPut(0x4B00E9D5, GUID_ACDC_POWER_SOURCE_, 4, "UInt")
			,NumPut(0x34FFBDA6, GUID_ACDC_POWER_SOURCE_, 8, "UInt"), NumPut(0x486551FF, GUID_ACDC_POWER_SOURCE_, 12, "UInt")
		}
		return &GUID_ACDC_POWER_SOURCE_
	}
}
BrightnessSetter_new() {
	return new BrightnessSetter()
}



; ------------------------------------------------------------
;
; Under Construction:   Duplicate currently-active Window
;   |
;   |--> Planned Workflow & Features (Pseudocode):
;          |
;          |--> Get Active Window's EXE-Filepath
;          |
;          |--> Get Active Window's Runtime-Parameters
;          |     |--> Ask user if they want to run with [ same runtime parameters as active window ] or [ input their own runtime parameters (string input from user because of open-ended-ness) ]
;          |     |--> Ask user if they want to [ run WITH elevated privileges ] or [ run WITHOUT elevated privileges ]
;          |
;          |--> Run [ EXE-Filepath ] with [ Runtime-Parameters ] determined by user (above)
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


; ------------------------------------------------------------
;   Documentation
; ------------------------------------------------------------
;
; SetTitleMatchMode, 1  ; A window's title must start with the specified WinTitle to be a match
; SetTitleMatchMode, 2  ; A window's title can contain WinTitle anywhere inside it to be a match
; SetTitleMatchMode, 3  ; A window's title must exactly match WinTitle to be a match
;
;
; ------------------------------------------------------------
;
; *** To obtain the unique code(s) thrown by the keyboard per-keypress:
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
;   //  NOTE:  If the above method fails, refer to: https://www.autohotkey.com/docs/commands/GetKey.htm
; 
; ------------------------------------------------------------
; 
; *** TO DETERMINE THE COMMAND BEING SENT:
;			SC029::
;			SplashTextOn, 250, 40, Debugging, Command Sent
;			Sleep 500
;			SplashTextOff
; 		-- Remainder of your script
; 
; ------------------------------------------------------------
; 
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
; 
; ------------------------------------------------------------
;
; MouseClickDrag, WhichButton, X1, Y1, X2, Y2 [, Speed, R]
;
; ------------------------------------------------------------
;
; MouseMove, X, Y [, Speed, R]
;
; ------------------------------------------------------------
;
If (False) {

	EXAMPLE_ControlClick() {
		;;;
		;;; ControlClick [, Control-or-Pos, WinTitle, WinText, WhichButton, ClickCount, Options, ExcludeTitle, ExcludeText]
		;;;
		CoordMode, Mouse, Screen
		SetDefaultMouseSpeed, 0
		SetControlDelay, -1
		; WinGetTitle, WinTitle, A
		WinTitle := "NoxPlayer"
		x_loc := (A_ScreenWidth - 20)
		y_loc := 315
		ControlClick, x%x_loc% y%y_loc%, %WinTitle%
	}

}


;
; MsgBox has tons of options for confirmations on popups ( Manual @ https://www.autohotkey.com/docs/commands/MsgBox.htm )
; ...::
	; WinGetActiveStats, WinTitle, Width, Height, X, Y
	; WinGetText, WinText, A
	; MsgBox, 4, , WinTitle `n%WinTitle%   `n`nWindow Size: `n   Width (%Width%)     Height (%Height%)   `n`nWindow Coordinates: `n   X (%X%)     Y (%Y%)   `n`nSkip WinText?, 10  ; 10-second timeout.
	; If (A_MsgBoxResult = "Yes")
		; Return
	; If (A_MsgBoxResult = "No")
		; MsgBox, WinText `n%WinText%
		; Return
	; If (A_MsgBoxResult = "Timeout")
		; Return
	; Return
;
; ------------------------------------------------------------
;
; 
; Menu, tray, add  ; Creates a separator line.
; Menu, tray, add, "Lineage-2", MenuHandler  ; Creates a new menu item.
; return
; 
; MenuHandler:
; MsgBox You selected %A_ThisMenuItem% from menu %A_ThisMenu%.
; MsgBox A_TitleMatchMode[%A_TitleMatchMode%], A_TitleMatchModeSpeed=[%A_TitleMatchModeSpeed%]
; return
; 
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
; 
; Exit:
; ExitApp
; 
; Example: Using in-line if conditional(s)
; 
; y := ( ( y = 8 ) ? ( 2008 ) : ( ( y = 9 ) ? ( 2009 ) : ( ( y = 0 ) ? ( 2010 ) : ( 2011 ) ) ) )
;
; ------------------------------------------------------------
;
; Example: Compare two Strings' Displayed Character-Widths (Strlen doesn't have a whole lot to do with actual/displayed character-widths)
;
; CompareCharacterWidths() {
; 	Newline=`n
; 	Echo1= String = [ chr(0x0061) ]   Strlen = [ StrLen( chr(0x0061) ) ]
; 	Echo2= String = [ chr(0x030a) ]   Strlen = [ StrLen( chr(0x030a) ) ]
; 	Echo_Tooltip=
; 	Echo_Tooltip := Echo_Tooltip Newline "  String=|" chr(0x0061) "|   StrLen=|" StrLen( chr(0x0061) ) "|"
; 	Echo_Tooltip := Echo_Tooltip Newline A_Space
; 	Echo_Tooltip := Echo_Tooltip Newline "  String=|" chr(0x030a) "|   StrLen=|" StrLen( chr(0x030a) ) "|"
; 	Echo_Tooltip := Echo_Tooltip Newline A_Space
; 	MsgBox, %Echo_Tooltip%
; 	Return
; }
; ------------------------------------------------------------

; Example:  Custom Popups
If (False) {

	CustomPopupButtons_Demo() {
		
		SetTimer, CustomMsgboxButtons_UNIQUE_NAME_HERE, 50
		; |--> Ensure that this callback script kills this SetTimer, otherwise it will keep running indefinitely

		MsgBox, 3, Popup_MsgBox_WindowTitle, Popup MsgBox Question? or Statement!

		If (A_MsgBoxResult = "Yes") {
			; TrayTip, AHK, Leftmost Button Selected  ; Toast Notification
		}
		If (A_MsgBoxResult = "No") {
			; TrayTip, AHK, Center Button Selected  ; Toast Notification
		}
		If (A_MsgBoxResult = "Cancel") {
			; TrayTip, AHK, Rightmost Button Selected  ; Toast Notification
		}

		Return

	}

	CustomMsgboxButtons_UNIQUE_NAME_HERE() {
		If (WinExist(Popup_MsgBox_WindowTitle)) {
			Return  ; Continue waiting for the "Clipboard or ClipboardAll" window to appear
		}
		SetTimer, CustomMsgboxButtons_UNIQUE_NAME_HERE, Off 
		WinActivate 
		ControlSetText, Button1, &LEFT_BUTTON
		ControlSetText, Button2, &CENTER_BUTTON
		ControlSetText, Button3, &RIGHT_BUTTON
		Return
	}

}


; ------------------------------------------------------------
;
; Alphabetical Command and Function Index:  https://www.autohotkey.com/docs/commands/
;   |--> Clipboard:       https://www.autohotkey.com/docs/misc/Clipboard.htm
;   |--> ControlGetText:  https://www.autohotkey.com/docs/commands/ControlGetText.htm
;   |--> GetKeyState:     https://www.autohotkey.com/docs/commands/GetKeyState.htm
;   |--> Hotkey:          https://www.autohotkey.com/docs/commands/Hotkey.htm#IfWin
;   |--> KeyWait:         https://www.autohotkey.com/docs/commands/KeyWait.htm
;   |--> Menu:            https://www.autohotkey.com/docs/commands/Menu.htm
;   |--> Run/RunWait:     https://www.autohotkey.com/docs/commands/Run.htm
;   |--> SetTimer:        https://www.autohotkey.com/docs/commands/SetTimer.htm
;   |--> SysGet:          https://www.autohotkey.com/docs/commands/SysGet.htm
;   |--> SplitPath:       https://www.autohotkey.com/docs/commands/SplitPath.htm
;
; ------------------------------------------------------------
;
; Variables and Expressions:  https://www.autohotkey.com/docs/Variables.htm#BuiltIn
;   |
;   |--> Operators in Expressions - If (...) statements, including mathematical operators:  https://www.autohotkey.com/docs/Variables.htm#Operators
;   |
;   |--> Arrays/Objects - Simple Arrays, e.g. "Indexed Arrays":  https://www.autohotkey.com/docs/Objects.htm#Usage_Simple_Arrays
;   |
;   |--> Arrays/Objects - Associative Arrays, e.g. "Associative Arrays":  https://www.autohotkey.com/docs/Objects.htm#Usage_Associative_Arrays
;   |
;   |--> Arrays/Objects - Pseudo-Arrays, e.g. "Variable Variables" (AVOID these to maintain syntax legibility & understandability):  https://www.autohotkey.com/docs/misc/Arrays.htm#pseudo
;
; ------------------------------------------------------------ 
;
; List of Keys:  https://www.autohotkey.com/docs/KeyList.htm
;   |
;   |--> Modifiers Keys:  https://www.autohotkey.com/docs/KeyList.htm#modifier
;
; ------------------------------------------------------------
;
; Remapping Keys (Keyboard, Mouse and Joystick):  https://www.autohotkey.com/docs/misc/Remap.htm
;
; ------------------------------------------------------------
;
; Hotkeys (Mouse, Joystick and Keyboard Shortcuts):  https://www.autohotkey.com/docs/Hotkeys.htm#Symbols
;   |
;   |--> Hotkey Modifier Symbols:  https://www.autohotkey.com/docs/Hotkeys.htm#Symbols
;
;     #    Win
;
;     !    Alt
;
;     +    Shift
;
;     ^    Ctrl
;
;     <    Use the LEFT modifier key, e.g. <# (LWin), <! (LAlt), <+ (LShift), <^ (LCtrl)
;
;     >    Use the RIGHT modifier key, e.g. ># (RWin), >! (RAlt), >+ (RShift), >^ (RCtrl)
;
;          AppsKey  (Application or Menu key, keycap symbol looks like a document w/ 3 lines)
;
; ------------------------------------------------------------
;	
; Citation(s)
;
;   answers.microsoft.com  |  "Shortcut to sound control panel?"  |  https://answers.microsoft.com/en-us/windows/forum/windows_10-start/shortcut-to-sound-control-panel/32d5a6e7-fa92-4ca7-9033-cd38ba525542
;
;   docs.microsoft.com  |  "wscript | Microsoft Docs"  |  https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/wscript
;
;   docs.microsoft.com  |  "WM_SYSCOMMAND message"  |  https://docs.microsoft.com/en-us/windows/win32/menurc/wm-syscommand
;
;   github.com  |  "AutoHotkeyScripts/LaptopBrightnessSetter at master · qwerty12/AutoHotkeyScripts · GitHub"  |  https://github.com/qwerty12/AutoHotkeyScripts/tree/master/LaptopBrightnessSetter
;
;   stackoverflow.com  |  "How can I set AutoHotKey's code to run only in chrome?"  |  https://stackoverflow.com/a/50180863
;
;   www.autohotkey.com  |  "Advanced Hotkey Features | AutoHotkey"  |  https://www.autohotkey.com/docs/HotkeyFeatures.htm#pass-through
;
;   www.autohotkey.com  |  "CLSID List (Windows Class Identifiers)"  |  https://www.autohotkey.com/docs/misc/CLSID-List.htm  <-- Example)  ::{7007acc7-3202-11d1-aad2-00805fc1270e}
;
;   www.autohotkey.com  |  "ControlGet List - Ask for Help - AutoHotkey Community"  |  https://autohotkey.com/board/topic/7649-controlget-list/
;
;   www.autohotkey.com  |  "determine if scaling is not 100% for monitor of a window, change PerMonitorSettings in registry, reflect change, verify - AutoHotkey Community"  |  https://www.autohotkey.com/boards/viewtopic.php?p=160615#p160615
; 
;   www.autohotkey.com  |  "escape double quote - AutoHotkey Community"  |  https://www.autohotkey.com/boards/viewtopic.php?t=14082
; 
;   www.autohotkey.com  |  "Get Current Micro/Nano seconds"  |  https://www.autohotkey.com/boards/viewtopic.php?p=126168#p126168
;
;   www.autohotkey.com  |  "How to paste multiline text - Ask for Help - AutoHotkey Community"  |  https://www.autohotkey.com/board/topic/65421-how-to-paste-multiline-text/
;
;   www.autohotkey.com  |  "How can I send a Windows toast notification? (TrayTip)"  |  https://www.autohotkey.com/boards/viewtopic.php?p=63507&sid=14b947240a145197c869c413824d8c50#p63507
;
;   www.autohotkey.com  |  "If Expression check to see if value is in Array"  |  https://www.autohotkey.com/boards/viewtopic.php?p=52627&sid=4e5a541af8d29ab16154c5a6dd379620#p52627
;
;   www.autohotkey.com  |  "ListView - G-Label Notifications (Primary)"  |  https://www.autohotkey.com/docs/commands/ListView.htm#notify
; 
;   www.autohotkey.com  |  "Optimize StrLen, Unicode Version"  |  https://www.autohotkey.com/boards/viewtopic.php?p=106284#p106284
;
;   www.autohotkey.com  |  "Options and Styles for "Gui, Add, ListView, Options"  |  https://www.autohotkey.com/docs/commands/ListView.htm#Options
;
;   www.autohotkey.com  |  "PostMessage/SendMessage - #1: Press Win+O to turn off the monitor"  |  https://www.autohotkey.com/docs/commands/PostMessage.htm#ExMonitorPower
;
;   www.autohotkey.com  |  "PostMessage/SendMessage - #2: Start the user's chosen screen saver"  |  https://www.autohotkey.com/docs/commands/PostMessage.htm#ExScreenSave
;
;   www.autohotkey.com  |  "Run[Wait] Example #2: The following can be used to run a command and retrieve its output:"  |  https://www.autohotkey.com/docs/commands/Run.htm#StdOut
; 
;   www.autohotkey.com  |  "Single line if statements"  |  https://www.autohotkey.com/board/topic/74001-single-line-if-statements/?p=470078
;
;   www.autohotkey.com  |  "Trim multiple lines"  |  https://www.autohotkey.com/boards/viewtopic.php?p=175097#p175097
;
;   www.autohotkey.com  |  "[HELP!] How to WinActivate without specifying window title? - Ask for Help - AutoHotkey Community"  |  https://www.autohotkey.com/board/topic/102763-help-how-to-winactivate-without-specifying-window-title/
;
;   www.reddit.com  |  "Brightness script? : AutoHotkey"  |  https://www.reddit.com/r/AutoHotkey/comments/5u2lvi/brightness_script/
;
;   www.tenforums.com  |  "Resolution mismatch when using "Change the size of text..." - Windows 10 Forums"  |  https://www.tenforums.com/general-support/69742-resolution-mismatch-when-using-change-size-text.html#post869493
;
; ------------------------------------------------------------