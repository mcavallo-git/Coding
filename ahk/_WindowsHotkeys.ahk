; ------------------------------------------------------------
;
; _WindowsHotkeys.ahk, by Cavalol
;   |
;   |--> Effective Hotkeys for Windows-based Workstaitons
;   |
;   |--> Runs via "Autohotkey" (AHK) - Download @ https://autohotkey.com/download/
;
; ------------------------------------------------------------
;
; Runtime-Global Settings

SetBatchLines, -1  ; https://www.autohotkey.com/docs/commands/SetBatchLines.htm

SetWorkingDir, %A_ScriptDir%  ; https://www.autohotkey.com/docs/commands/SetWorkingDir.htm

DetectHiddenWindows, On  ; https://www.autohotkey.com/docs/commands/DetectHiddenWindows.htm

SetCapsLockState, Off  ; https://www.autohotkey.com/docs/commands/SetNumScrollCapsLockState.htm

; FileEncoding, UTF-8  ; https://www.autohotkey.com/docs/commands/FileEncoding.htm

; #ErrorStdOut  ; https://www.autohotkey.com/docs/commands/_ErrorStdOut.htm

#Persistent  ; https://www.autohotkey.com/docs/commands/_Persistent.htm

#SingleInstance Force  ; https://www.autohotkey.com/docs/commands/_SingleInstance.htm

; #EscapeChar \  ; https://www.autohotkey.com/docs/commands/_EscapeChar.htm

; #InstallKeybdHook  ; https://www.autohotkey.com/docs/commands/_InstallKeybdHook.htm

; #UseHook off  ; https://www.autohotkey.com/docs/commands/_UseHook.htm


; ------------------------------------------------------------
;
; Runtime Global Vars

; #NoEnv  ; Prevents environment vars from being used (occurs when a var is called/referenced without being instantiated)

A_SYSTEM32 := WINDIR "\System32"

USER_DESKTOP := USERPROFILE "\Desktop"
 
USER_DOCUMENTS := USERPROFILE "\Documents"

CR=`r

LF=`n

VerboseOutput := True

; ------------------------------------------------------------
;
; Setup a group for targeting [Windows Explorer] windows

GroupAdd, Explorer, ahk_class ExploreWClass ; Unused on Vista and later

GroupAdd, Explorer, ahk_class CabinetWClass


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
#-::
#NumpadSub::
	AwaitModifierKeyup()
	SetKeyDelay, 0, -1
	; StringToType := StringRepeat("-",60)
	SendInput, ------------------------------------------------------------
	Return


; ------------------------------------------------------------
;   HOTKEY:  Win + =
;   HOTKEY:  Win + [ Plus-Key ]
;   ACTION:  Create a citations footer (refer to function description for more info)
;
#=::
#+::
#NumpadAdd::
	CreateCitationsFooter()
	Return


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
;  HOTKEY:  Shift + Ctrl + P
;  ACTION:  Ask user if they wish to paste the clipboard as Text or Binary data (workaround for websites which block pasting into forms)
;
+^P::
	AwaitModifierKeyup()  ; Wait until all modifier keys are released
	PasteClipboard_TextOrBinary()
	Return

; ------------------------------------------------------------
;  HOTKEY:  Win + P
;  ACTION:  Open RoboForm's Generate-Password Exe
;
#P::
	AwaitModifierKeyup()  ; Wait until all modifier keys are released
	PasswordGenerator := "C:\Program Files (x86)\Siber Systems\AI RoboForm\passwordgenerator.exe"
	If (FileExist(PasswordGenerator)) {
		Run, %PasswordGenerator%
	} Else {
		Text_TrayTip := "Error - File not found:  " PasswordGenerator
		TrayTip, AHK, %Text_TrayTip%  ; Toast Notification
	}
	Return


; ------------------------------------------------------------
;  HOTKEY:  Win + H
;  ACTION:  Type the COMPUTERNAME
;
#H::
	SetKeyDelay, 0, -1
	AwaitModifierKeyup()  ; Wait until all modifier keys are released
	WinGet, WinProcessName, ProcessName, A
	SetTitleMatchMode, 2 ; Title must CONTAIN [ WinTitle ] as a substring
	if (WinProcessName == "chrome.exe") {
		IfWinActive, LastPass  ; IfWinActive - https://www.autohotkey.com/docs/commands/WinActive.htm
		{
			IfWinActive, Duo Security
			{
				FormatTime,DatTimestamp,,yyyy-MM-dd_HH-mm-ss
				EchoStr := A_ComputerName " " DatTimestamp " " WinProcessName
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
	RET_VAL = %USERDOMAIN%-%A_UserName%
  Send %RET_VAL%
	Return


; ------------------------------------------------------------
;  HOTKEY:  Win + G
;  ACTION:  Types the contents of target file
;
#G::
	FilePathToRead=%USERPROFILE%\.gpg_git\personal.passphrase
	FileRead, FilePathContents, %FilePathToRead%
	SendInput, %FilePathContents%
	Return


; ------------------------------------------------------------
;  HOTKEY:  Win + W
;  ACTION:  Types the contents of target file
;
#W::
	FilePathToRead=%USERPROFILE%\.gpg_git\work.passphrase
	FileRead, FilePathContents, %FilePathToRead%
	SendInput, %FilePathContents%
	Return


; ------------------------------------------------------------
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
	AwaitModifierKeyup()  ; Wait until all modifier keys are released
	TimezoneOffset := GetTimezoneOffset_P()
	Needle_Win := "#D"
	Needle_AltWin := "!#D"
	Needle_CtrlWin := "^#D"
	If InStr(A_ThisHotkey, Needle_Win) {  ; Win
		dat_format=yyyyMMdd-HHmmss
	} Else If InStr(A_ThisHotkey, Needle_AltWin) {  ; Alt + Win
		dat_format=yyyy.MM.dd-HH.mm.ss
	} Else If InStr(A_ThisHotkey, Needle_CtrlWin) {  ; Ctrl + Win
		dat_format=yyyy-MM-dd_HH-mm-ss
	} Else {
		dat_format=yyyyMMdd-HHmmss
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


; ------------------------------------------------------------
;  HOTKEY:  ?????
;  ACTION:  On-the-fly Timezone w/ format: [  -0500  ]
;
; ?????::
; 	TZ_OFFSET := GetTimezoneOffset()
;   Send %TZ_OFFSET%
; 	Return


; ------------------------------------------------------------
;
;  HOTKEY:  Win + F1
;  ACTION:  Edit this Script (the one you're reading right now)
#F1::
	Run Notepad %A_ScriptFullPath%
	Return


; ------------------------------------------------------------
;  HOTKEY:  Win + F2
;  ACTION:  Win10 Download & Delete Recordings via XBox Win10 App  !!! MAKE SURE TO HIDE SCREENSHOTS BEFOREHAND !!!
;
#F2::
	GetKeyCodes := A_ScriptDir "\GetKeyCodes.ahk"
	Run %GetKeyCodes%
	Return


; ------------------------------------------------------------
;
; #SC03D::   ; Win + F3
#F3::
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
; ------------------------------------------------------------
;  HOTKEY:  Win + Ctrl + Z
;  HOTKEY:  Win + Shift + Z
;  ACTION:  Show all (current) Window Titles
;
^#Z::
+#Z::
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
	If (A_GuiEvent = "DoubleClick") {
		Gui, WinTitles:Default
		Gui, Destroy
	}
	Return
}

; ------------------------------------------------------------
;  HOTKEY:  Fn Key (X1 Carbon)
;  ACTION:  Set Fn to perform CTRL action, instead
;
;SC163::   ;"Fn" Key
;Return
;
; ------------------------------------------------------------
;  HOTKEY:  Windows-Key + [
;  ACTION:  FOLLOW-UP HOTKEY TO: Windows-key P   :::   Click "Duplicate" monitors
;
#[::
#]::
	CoordMode, Mouse, Screen
	SetDefaultMouseSpeed, 0
	SetControlDelay, -1
	SetTitleMatchMode, 1  ; A window's title must start with the specified WinTitle to be a match
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
		
	} Else If (SubStr(A_OSVersion, 1, 4)="10.0") {

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
					Error: Unable to locate Projection window
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


; ------------------------------------------------------------
;  HOTKEY:  Windows-Key + Right-Click
;  ACTION:  Output cursor location
;
#RButton::
	CoordMode, Mouse, Screen
	MouseGetPos, MouseX, MouseY
	MsgBox,
	(LTrim
	Pointer Location
	➣X_loc:   %MouseX%
	➣Y_loc:   %MouseY%
	)
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

AppsKey::
	Send {Blind}{RWin down}
	Return

AppsKey up::
	Send {Blind}{RWin up}
	Return

; AppsKey::RWin


; ------------------------------------------------------------
;  HOTKEY:  Windows-Key + N
;  ACTION:  Opens "View Network Connections" (in the Control Panel)
; 
#N::
	ViewNetworkConnections_CLSID=::{7007acc7-3202-11d1-aad2-00805fc1270e}  ; CLSID (Windows Class Identifier)
	Run %ViewNetworkConnections_CLSID%
	; ViewNetworkConnections_PATH := windir "\System32\ncpa.cpl"
	; Run %ViewNetworkConnections_PATH%
	TrayTip, AHK, Opening "View Network Connections"  ; Toast Notification
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
	SplitPath, A_MyDocuments, , UserProfileDirname
	Run %UserProfileDirname%
	Return
; 
; ------------------------------------------------------------
;  HOTKEY:  Windows-Key + O
;  ACTION:  Opens "Programs & Features" in the Control Panel
;
#O::
	Run "c:\windows\system32\appwiz.cpl"
	Return
;
; ------------------------------------------------------------
;  HOTKEY:  Windows-Key + ` (Tilde)
;  ACTION:  Keyboard-Command for a Mouse-Left-Click
;
#`::
	MouseClick, Left
	Return
;
; ------------------------------------------------------------
;  HOTKEY:  Alt + ` (Tilde)
;  ACTION:  Keyboard-Command for a Mouse-Right-Click
;
!`::
	MouseClick, Right
	Return
;
; ------------------------------------------------------------
;  HOTKEY:  Win + Mouse-Wheel Up/Down
;  ACTION:  Turn computer volume up/down
;
#MButton::
#WheelUp::
#WheelDown::
^#MButton::
^#WheelUp::
^#WheelDown::

	Icon_MutedSpeaker=🔇
	Icon_SpeakerLowVolume=🔈
	Icon_SpeakerMediumVolume=🔉
	Icon_SpeakerHighVolume=🔊

	Icon_VolumeFilled=⬛️
	Icon_VolumeBlanks=⬜️

	VolumeLevel_Increment := 2
	; VolumeLevel_Increment := 10

	; Volume_ForceUpperLimit := 100

	SoundGet, VolumeLevel_BeforeEdits

	VolumeLevel_BeforeEdits := Round(VolumeLevel_BeforeEdits)

	; Note that [ SoundSet ... ] is used instead of [ Send {Volume_Up} ], etc. because of combo key-presses
	; not handshaking well with the [ Send ... ] function in AHK - e.g. winkey-mousescroll was
	; triggering the start-menu inbetween multiple scrolls + more issues (generally glitchy)
	If ((A_ThisHotkey=="#MButton") || (A_ThisHotkey=="^#MButton")) {
		; Toggle Mute
		SoundSet, +1, , MUTE
	} Else If (A_ThisHotkey=="#WheelUp") {
		; Volume Up
		NewVolumeLevel_Increment := ( VolumeLevel_Increment )
		SoundSet , +%NewVolumeLevel_Increment%
	} Else If (A_ThisHotkey=="^#WheelUp") {
		; Volume Up ( Slower )
		NewVolumeLevel_Increment := ( VolumeLevel_Increment * 2 )
		SoundSet , +%NewVolumeLevel_Increment%
	} Else If (A_ThisHotkey=="#WheelDown") {
		; Volume Down
		NewVolumeLevel_Increment := ( VolumeLevel_Increment )
		SoundSet , -%NewVolumeLevel_Increment%
	} Else If (A_ThisHotkey=="^#WheelDown") {
		; Volume Down ( Slower )
		NewVolumeLevel_Increment := ( VolumeLevel_Increment * 2 )
		SoundSet , -%NewVolumeLevel_Increment%
	}

	; Get the volume & mute current-settings
	SoundGet, NewVolumeLevel
	SoundGet, MasterMute, , MUTE

	; Final volume level
	NewVolumeLevel := Round( NewVolumeLevel )
	NewVolumeLevelPercentage=%NewVolumeLevel%`%

	; Build the volume-bars (out-of dingbats utf8+ icons)
	; Total_IconCount_MaxVolume := Round( ( 100 / VolumeLevel_Increment ) * 2 )
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

	StringTrimRight, Echo_TopBot_LeftHalf, VolumeBars_TopBot, TrimCount_TopBot
	StringTrimLeft, Echo_TopBot_RightHalf, VolumeBars_TopBot, TrimCount_TopBot

	Echo_TopBot_LeftHalf := Icon_SpeakerMediumVolume A_Space A_Space A_Space Echo_TopBot_LeftHalf
	Echo_TopBot_RightHalf := Echo_TopBot_RightHalf A_Space A_Space Icon_SpeakerHighVolume

	Echo_Middle_LeftHalf := Echo_TopBot_LeftHalf
	Echo_Middle_RightHalf := Echo_TopBot_RightHalf
	
	IconSlice_Middle_EachSide := 3
	Mute_AddSpaces := 3

	Echo_Middle_LeftHalf := SubStr( Echo_TopBot_LeftHalf, 1, ( -1 * IconSlice_Middle_EachSide * StrLen( Icon_VolumeFilled )) )
	Echo_Middle_RightHalf := SubStr( Echo_TopBot_RightHalf, ( IconSlice_Middle_EachSide * StrLen( Icon_VolumeFilled )) )

	; Show status of whether volume muted or un-muted next to the volume level 
	;   |--> Replace mute-icon w/ whitespace if un-muted (used manual/visual comparison to determine # of spaces)
	;
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
	; Echo_TopBot_Center := StringRepeat( A_Space , 14 )

	Echo_Tooltip=
	Echo_Tooltip := Echo_Tooltip Echo_TopBot_LeftHalf Echo_TopBot_Center Echo_TopBot_RightHalf LF
	Echo_Tooltip := Echo_Tooltip Echo_Middle_LeftHalf Echo_Middle_Center Echo_Middle_RightHalf LF
	Echo_Tooltip := Echo_Tooltip Echo_TopBot_LeftHalf Echo_TopBot_Center Echo_TopBot_RightHalf
	
	OutputWidth := 317
	OutputHeight := 50
	StartMenuHeight := 40

	; On-Screen Tooltip Location - X Coordinate (Left to Right)
	x_loc := Round( ( A_ScreenWidth - OutputWidth ) / 2 )
	; x_loc := 50

	; On-Screen Tooltip Location - Y Coordinate (Top to Bottom)
	; y_loc := Round( ( A_ScreenHeight - StartMenuHeight - OutputHeight ) / 2 )
	y_loc := ( A_ScreenHeight - ( OutputHeight * 3 ) )

	ToolTip, %Echo_Tooltip%, %x_loc%, %y_loc%
	ClearTooltip(750)
	Return
;
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
;
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
;
; ------------------------------------------------------------
;  HOTKEY:  Shift + Insert
;  ACTION:  If running Ubuntu via WSL (Windows Subsystem for Linux), Paste the clipboard
;

; RShift & Insert::
; LShift & Insert::
; 	SetKeyDelay, 0, -1

; 	; ------------------------------------------------------------
; 	; Determine if currently-active window is WSL
; 	IsUbuntuWSL := 0
; 	If (StrLen(A_OSVersion) >= 2) {
; 		StringLeft, OS_FirstTwoChars, A_OSVersion, 2
; 		If ( OS_FirstTwoChars = "10" ) {
; 			WinGet, ActiveProcessName, ProcessName, A
; 			If ( ActiveProcessName = "ubuntu.exe" ) {
; 				IsUbuntuWSL := 1
; 			}
; 		}
; 	}

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

;
; ------------------------------------------------------------
;  HOTKEY:  Windows-Key + A
;  ACTION:  Foxit PhantomPDF - Add Text
;
; #A::
; 	CoordMode, Mouse, Screen
; 	SetDefaultMouseSpeed, 0
; 	SetControlDelay, -1
; 	SetTitleMatchMode, 2 ; Title must CONTAIN [ WinTitle ] as a substring
; 	WinGetTitle, WinTitle, A
; 	; MatchTitle=Foxit PhantomPDF ; PDF Titles can override this (in Foxit)
; 	WinGet, WinProcessName, ProcessName, A
; 	MatchProcessName=FoxitPhantomPDF.exe
; 	If (InStr(WinProcessName, MatchProcessName)) {
; 		If (%VerboseOutput% == True) {
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
; 	; 	If (%VerboseOutput% == True) {
; 	; 		TrayTip, AHK, Foxit PhantomPDF`nMUST be active (to add text), 4, 1  ; Toast Notification
; 	; 	}
; 	; }
; 	Return


; ------------------------------------------------------------
;  HOTKEY:  Right Windows-Key + K
;  ACTION:  Send a Checkmark
;
>#K::
	SetKeyDelay, 0, -1
	; Send ✔
	; Send 🗸  ; Light Check Mark
	Send ✔️  ; Check Mark
	Return


; ------------------------------------------------------------
;  HOTKEY:  Left Windows-Key + K
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
;  HOTKEY:  Ctrl + Win + C
;  ACTION:  Workbench hotkey for quick-testing, one-time wizbangs, etc.
;
^#C::
	; WinTitle=Task Scheduler
	; WinTitle=Visual Studio Code
	; SpaceUp_Loop(50, WinTitle)
	; SpaceUp_Loop(50)
	Return

; ------------------------------------------------------------
;  HOTKEY:  Win + C
;  ACTION:  Open Google Chrome
;
#C::
	OpenChrome()
	Return


; ------------------------------------------------------------
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
	If (FileExist(exe_filepath)) {
		Run, %exe_filepath%
	} Else {
		If (FileExist(exe_filepath2)) {
			Run, %exe_filepath2%
		} Else {
			; If EFS does NOT exist, offer user the URL to download it
			exe_download_url := "http://www.sowsoft.com/download/efsearch.zip"
			MsgBox, 4, Download EFS?, Effective File Search not found`n`nDownload EFS Now?
			IfMsgBox Yes
				Run, chrome.exe %exe_download_url%
		}
	}
	Return


; ------------------------------------------------------------
;  HOTKEY:  Left-Shift + Right-Shift  (Both Shifts/Shift-Keys)
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
; ------------------------------------------------------------
; ------------------------------------------------------------
;  Win+J - [DevOps] - Startup Node.JS (Git-Bash) && Postman
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
; 		SysGet, MonitorCount, MonitorCount , N
; 		BoundsLeft = -1
; 		BoundsRight = -1
; 		BoundsTop = -1
; 		BoundsBottom = -1
; 		BoundsCenterHoriz = 0
; 		BoundsCenterVert = 0
; 		Loop, %MonitorCount% {
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
;
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
;  ACTION:  Permanently DISABLE Numlock (unless pressed with shift, which toggles it as-normal)
;
Numlock::
^Numlock::
!Numlock::
#Numlock::
	SetNumlockState, On
	Return
+Numlock::
	SetNumlockState, % GetKeyState("Numlock", "T") ? "Off" : "On"
	Return


; ------------------------------------------------------------
;
; >>  FUNCTIONS  <<
;
; ------------------------------------------------------------


;
;	GetPID
;   |--> Returns PID if process IS found
;   |--> Returns 0 if process is NOT found
;
;	ProcessExist
;	IfProcessExist
;   |--> Returns True if process IS found
;   |--> Returns False if process is NOT found
;
GetPID(ProcName) {
	Process, Exist, %ProcName%
	Return %ErrorLevel%
}
ProcessExist(ProcName) {
  Return (GetPID(ProcName)>0) ? True : False
}
IfProcessExist(ProcName) {
	Return (GetPID(ProcName)>0) ? True : False
}


;
; Get_ahk_id_from_title
;   |--> Input: WinTitle to Target, WinTitle to Exclude from Targeting
;   |--> Returns ahk_id (process-handle) for AHK back-end control-based calls
;
Get_ahk_id_from_title(WinTitle,ExcludeTitle) {
	SetTitleMatchMode, 2 ; Title must CONTAIN [ WinTitle ] as a substring
	ControlGet, output_var, Hwnd,,, %WinTitle%,, %ExcludeTitle%
	dat_ahk_id=ahk_id %output_var%
	Return dat_ahk_id
}


;
; Get_ahk_id_from_title
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
;	OpenChrome - Opens the "Google Chrome" Application
;
OpenChrome() {
	SetTitleMatchMode, 2 ; Title must CONTAIN [ WinTitle ] as a substring
	EXE_NICKNAME := "Google Chrome"
	EXE_FULLPATH := "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"

	SplitPath, EXE_FULLPATH, EXE_BASENAME, EXE_DIRNAME, EXE_FILETYPE, EXE_BASENAME_NO_EXT, EXE_DRIVENAME ; SplitPath - https://www.autohotkey.com/docs/commands/SplitPath.htm

	If (ProcessExist(EXE_BASENAME) == True) {
		; Executable IS running - Activate the associated Window based on PID
		If (%VerboseOutput% == True) {
			TRAY_TIP_MSG=Activating "%EXE_NICKNAME%"
			TrayTip, AHK, %TRAY_TIP_MSG%  ; Toast Notification
		}
		; Set Chrome as the Active Window
		EXE_PID := GetPID(EXE_BASENAME)
		WinActivate, ahk_pid %EXE_PID%

	} Else If (FileExist(EXE_FULLPATH)) {
		; Executable is NOT running but IS found locally
		If (%VerboseOutput% == True) {
			TRAY_TIP_MSG=Opening "%EXE_NICKNAME%"
			TrayTip, AHK, %TRAY_TIP_MSG%  ; Toast Notification
		}
		; Open Chrome
		; RunAs, %A_UserName%
		Run, %EXE_FULLPATH%
		WinWait,Chrome,,10
		; Set Chrome as the Active Window
		EXE_PID := GetPID(EXE_BASENAME)
		WinActivate, ahk_pid %EXE_PID%

	} Else {
		; Executable is NOT running and NOT found locally
		If (%VerboseOutput% == True) {
			TRAY_TIP_MSG=Application not Found "%EXE_FULLPATH%"
			TrayTip, AHK, %TRAY_TIP_MSG%  ; Toast Notification
		}

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
	CitationsFooter := LF Dashes LF LF "Citation(s)" LF LF "domain  |  ""title""  |  url" LF LF Dashes
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
;   |--> Uses CTRL + Q hotkey to comment the current line (WITH a leading space) in a given IDE (Notepad++/VS-Code) 
;
CommentCurrentLine() {
	Send {LControl Down}{q}{LControl Up}
	Sleep 10
	Return
}


;
; CommentCurrentLine_NoSpace
;   |--> Uses CTRL + Q hotkey to comment the current line (WITHOUT a leading space) in a given IDE (Notepad++/VS-Code)
;
CommentCurrentLine_NoSpace() {
	Send {Home}{LControl Down}{q}{LControl Up}{Backspace}
	Sleep 10
	Return
}


;
; OpenVisualStudioCode
;   |--> Opens Microsoft's "Visual Studio Code" Application (Free Source Code Editor / IDE)
;
OpenVisualStudioCode() {
	VSCode_Executable := "C:\Program Files\Microsoft VS Code\Code.exe"
	VSCode_UserDataDir := "--user-data-dir=""" A_AppData "\Code"""
	VSCode_Workspace := A_MyDocuments "\GitHub\cloud-infrastructure\.vscode\github.code-workspace"
	Run, %VSCode_Executable% %VSCode_UserDataDir% %VSCode_Workspace%
	Return
}


;
; OpenVSCode
;   |--> Opens the "Visual Studio Code" Application
;
OpenVSCode() {
	OpenVisualStudioCode()
	Return
	; Set Path to VSCode Executable
	; VSCode_Dir=C:\Program Files\Microsoft VS Code
	; VSCode_Exe=%VSCode_Dir%\Code.exe
	; ; Set Path to VSCode Workspace
	; Repos_Dirname=GitHub
	; GitHub_Dir=%A_MyDocuments%\%Repos_Dirname%
	; ; Runtime Vars
	; WinTitle=%Repos_Dirname% - Visual Studio Code
	; SetTitleMatchMode, 2 ; Title must CONTAIN [ WinTitle ] as a substring
	; if !WinExist(WinTitle) {
	; 	; MsgBox,0,AHK-Log,VSCode-Window NOT found
	; 	Run, %VSCode_Exe% %GitHub_Dir%,,Hide,WinPID
	; 	WinWait,%WinTitle%,,15
	; }
	; ; SysGet, MonitorCount, MonitorCount, N
	; ; WinPID := WinExist(WinTitle)
	; if (WinExist(WinTitle)) {
	; 	if (A_OSVersion = "WIN_7") {
	; 		WinMove,%WinTitle%,,-8,-8,1936,1056
	; 	} Else {
	; 		WinMove,%WinTitle%,,0,0,1920,1040
	; 	}
	; 	WinActivate,%WinTitle%
	; 	WinMaximize,%WinTitle%
	; }
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
	; Return
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
;	SendSpace
;   |--> For some reason, Windows 10 doesn't like Send {Space} (as-in it 'ignores' the keypress), but happily accepts Send {SC039} as equivalent to a spacebar-press
;
SendSpace() {
	Send {SC039}
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
; ActiveWindow_ToggleRestoreMaximize
;   |--> Toggle currently-active window between "Maximized" and "Non-Maximized" (or "Restored") states
;
ActiveWindow_ToggleRestoreMaximize() {
	WinGet, WinState, MinMax, A
	WinGet, WinStyle, Style, A
	; WinGet, OutputVar, MinMax 
	If (WinState>0) { ; Window is maximized - restore it
		WinRestore A
	} Else If (WinState=0) { ; Window is neither maximized nor minimized - maximize it
		WinMaximize A
	} Else If (WinState<0) { ; Window is minimized - restore it, I guess?
		WinRestore A
	}
	Return
}


;
; ActiveWindow_Maximize
;   |--> Maximize active window (if not maximized, already)
;
ActiveWindow_Maximize() {
	WinGet, WinState, MinMax, A
	If (WinState<=0) { ; Window is not maximized - maximize it
		WinMaximize A
	}
	Return
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
; Timestamp
;   |--> Gets the current Timestamp in a format which is compatible/ready-to-be-used-within filenames
;   |--> Example call:
;          Timestamp := Timestamp()
;
Timestamp() {
	FormatTime,Timestamp,,yyyyMMdd-HHmmss
	Return %Timestamp%
}


;
; Milliseconds
;   |--> Gets the current timestamp's fractions-of-a-second, down to the 3rd digit (millisecond-precision)
;   |--> Example call:
;          TrayTip, AHK, % ( "Milliseconds = [ " Milliseconds() " ]" )  ; Toast Notification
;
Milliseconds() {
	Return %A_MSec%
}


;
; Microseconds
;   |--> Gets the current timestamp's fractions-of-a-second, down to the 6th digit (microseconds-precision)
;   |--> Example call:
;          TrayTip, AHK, % ( "Microseconds = [ " Microseconds() " ]" )  ; Toast Notification
;
Microseconds() {
	vIntervals := 0
	DllCall("kernel32\GetSystemTimeAsFileTime", "Int64*",vIntervals)  ; 1 interval = 0.1 microseconds
	A_USec := SubStr(Format("{:00}00", Mod(vIntervals, 10000000)), 1, 6)
	Return %A_USec%
}


;
; Nanoseconds
;   |--> Gets the current timestamp's fractions-of-a-second, down to the 9th digit (pseudo-nanosecond-precision - max-precision is actually only 7 digits past decimal, e.g. per-100-nanoseconds)
;   |--> Example call:
;          TrayTip, AHK, % ( "Nanoseconds = [ " Nanoseconds() " ]" )  ; Toast Notification
;
Nanoseconds() {
	vIntervals := 0
	DllCall("kernel32\GetSystemTimeAsFileTime", "Int64*",vIntervals)  ; 1 interval = 100 nanoseconds
	; vDate := 1601
	; EnvAdd, vDate, % vIntervals//10000000, S  ; autohotkey.com  |  "EnvAdd"  |  https://www.autohotkey.com/docs/commands/EnvAdd.htm
	A_NSec := Format("{:07}00", Mod(vIntervals, 10000000))
	Return %A_NSec%
}


;
; TempFile
;   |--> Creates a temporary file with a timestamp (down to the millisecond) based filename
;   |--> Returns a string-value containing the fullpath of the temporary file (which was just created)
;
TempFile() {
	TempFile_Dirname := A_Temp "\AutoHotkey\"
	IfNotExist, %TempFile_Dirname%
	{
		FileCreateDir, %TempFile_Dirname%
	}
	TempFile_Basename := A_Now "." A_MSec
	TempFile_Fullpath := TempFile_Dirname TempFile_Basename
	Return %TempFile_Fullpath%
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
	Sleep 100
}


;
; PasteClipboardAsBinary
;   |--> Pastes the current clipboard data as binary-data (as-if the user somehow entered it without pasting it off the Clipboard)
;
PasteClipboardAsBinary() {
	Global VerboseOutput
	SetKeyDelay, 0, -1
	AwaitModifierKeyup()  ; Wait until all modifier keys are released
	; NewTempFile := TempFile()
	; ClipboardDuped := Clipboard
	; FileAppend, %ClipboardAll%, %NewTempFile% ; The file extension does not matter
	; Sleep, 100
	; FileRead, Clipboard, *c %NewTempFile% ; Note the use of *c, which must precede the filename
	; Sleep, 100
	; If (VerboseOutput == True) {
	; 	TrayTip, AHK,
	; 	(LTrim
	; 		Pasting the Binary version of the Clipboard
	; 		NewTempFile = %NewTempFile%
	; 	)  ; Toast Notification
	; }
	
	; If (False) {
	; 	StringUpper, Clipboard, Clipboard  ; Force uppercase-only strings
	; 	StringLower, Clipboard, Clipboard  ; Force lowercase-only strings
	; }

	Sleep, 100
	Clipboard := ClipboardAll
	Sleep, 100
	Clipboard := Clipboard  ; Convert any copied files, HTML, or other formatted text to plain text.
	Sleep, 100
	Send {Blind}{Text}%Clipboard%

	; Sleep, 100
	; FileDelete, %NewTempFile% ; Delete the clipboard file
	; Sleep, 100
	; Clipboard := ClipboardDuped

	Sleep, 100
	ClipboardDuped = ; Avoid caching clipboard-contents in memory
	ClipboardSend = ; Avoid caching clipboard-contents in memory

	Return
}


;
; PasteClipboardAsText
;   |--> Pastes the current clipboard data as text (as-if the user typed it instead of pasted it)
;
PasteClipboardAsText() {
	Global VerboseOutput
	SetKeyDelay, 0, -1
	AwaitModifierKeyup()  ; Wait until all modifier keys are released
	ClipboardDuped:=Clipboard
	If (VerboseOutput == True) {
		TrayTip, AHK,
		(LTrim
			Pasting the Text version of the Clipboard
		)  ; Toast Notification
	}
	; Trim each line before pasting it (To avoid auto-indentation on Notepad++, VS-Code, & other IDE's)

	; OPTION 1 - Using Built-in AHK Trim Method
	ClipboardSend := ""
	VarSetCapacity(ClipboardSend, StrLen(ClipboardDuped)*2)
	Loop, Parse, ClipboardDuped, `n, `r
	{
		ClipboardSend := (A_Index=1?"":"`r`n") Trim(A_LoopField)
		Send {Blind}{Text}%ClipboardSend%
		ClipboardSend = ; Avoid caching clipboard-contents in memory
		Sleep 100
	}

	; OPTION 2 - Using Regex Replacement Method
	; ClipboardSend := RegExReplace(ClipboardDuped, "m)^[ `t]*|[ `t]*$")
	; Send {Blind}{Text}%ClipboardSend%

	Sleep, 100
	ClipboardDuped = ; Avoid caching clipboard-contents in memory
	ClipboardSend = ; Avoid caching clipboard-contents in memory

	Return
}


;
; PasteClipboard_TextOrBinary
;   |--> Displays a menu asking user if they wish to paste the clipboard as Text or Binary data (workaround for websites which block pasting into forms)
;
PasteClipboard_TextOrBinary() {
	SetTimer, CustomMsgboxButtons_ClipboardTextOrBinary, 50 
	MsgBox, 3, Text or Binary, Paste the Clipboard as Text or Binary?
	IfMsgBox Yes
	{  ; Paste the Text version of the Clipboard
		PasteClipboardAsText()
	}
	IfMsgBox No
	{  ; Paste the Binary version of the Clipboard
		PasteClipboardAsBinary()
	}
	Return
}
CustomMsgboxButtons_ClipboardTextOrBinary: 
	IfWinNotExist, Text or Binary
			return  ; Continue waiting for the "Clipboard or ClipboardAll" window to appear
	SetTimer, CustomMsgboxButtons_ClipboardTextOrBinary, Off 
	WinActivate 
	ControlSetText, Button1, &Text
	ControlSetText, Button2, &Binary
	Return



;
; RunWaitOne
;   |--> Executes a single command through the current ComSpec (usually "cmd.exe")  |  https://www.autohotkey.com/docs/commands/Run.htm#StdOut
;   |--> Example-call:
;          MsgBox % RunWaitOne("dir " A_ScriptDir)
;
RunWaitOne(CMD_Command) {
	WScript_Shell := ComObjCreate("WScript.Shell")
	Run_Command := ComSpec " /C """ CMD_Command """ "
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
	Return exec.StdOut.ReadAll()
}


;
; GetTimezoneOffset
;   |--> Returns the timezone with [ DateTime +/- Zulu-Offset ]
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
	If (TZ_QUOTIENT<0.0) {
		TZ_SIGN := "-"
		TZ_QUOTIENT *= -1
	} Else {
		TZ_SIGN := "+"
	}
	; Hours - Left-Pad with Zeroes
	If (Abs(TZ_QUOTIENT) < 10) {
		TZ_QUOTIENT = 0%TZ_QUOTIENT%
	}
	; Minutes - Left-Pad with Zeroes
	If (Abs(TZ_REMAINDER) < 10) {
		TZ_REMAINDER = 0%TZ_REMAINDER%
	}

	RET_VAL = %TZ_SIGN%%TZ_QUOTIENT%%TZ_REMAINDER%
	RET_VAL := StrReplace(RET_VAL, ".", "")

	; TZ_REMAINDER := "GMT +" Floor(T1/60)
	Return %RET_VAL%
}


;
; GetTimezoneOffset_P
;   |--> Returns the timezone with "P" instead of "+", for fields which only allow alphanumeric with hyphens
;
GetTimezoneOffset_P() {
	RET_VAL := ""
	TZ_OFFSET := GetTimezoneOffset()
	RET_VAL := StrReplace(TZ_OFFSET, "+", "P")
	Return %RET_VAL%
}


;
; StringRepeat
;   |--> Repeat a string a given number of times
;
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
; RemoveToolTip
;   |--> Removes any Tooltips found
;
RemoveToolTip() {
	ToolTip
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
; RemoveSplashText
;   |--> Removes any SplashText found
;
RemoveSplashText() {
	SplashTextOff
	Return
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
; PrintEnv
;   |--> Gets Windows Environment Vars (output to file)
;
PrintEnv() {
	FormatTime,TIMESTAMP,,yyyyMMdd-HHmmss
	Logfile_EnvVars := USER_DESKTOP "\WindowsEnvVars-" COMPUTERNAME "-" USERNAME ".log"
	Logfile_EnvVars_Timestamp := USER_DESKTOP "\WindowsEnvVars-" COMPUTERNAME "-" USERNAME "-" TIMESTAMP ".log"
	; - -
	KnownWinEnvVars=
	(LTrim
	==========================================================================

	*** Environment Vars - Current Session ***

	TIMESTAMP = %TIMESTAMP%

	--------------------------------------------------------------------------

	*** Windows Environment Vars (Long-standing) ***

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

	*** Autohotkey Vars ***

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
	Run, Notepad "%Logfile_EnvVars_Timestamp%"
	Return
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
;   //  NOTE:  If the above method fails, refer to: https://autohotkey.com/docs/commands/GetKey.htm
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
		WinTitle=NoxPlayer
		x_loc := (A_ScreenWidth - 20)
		y_loc := 315
		ControlClick, x%x_loc% y%y_loc%, %WinTitle%
	}

}


;
; MsgBox has tons of options for confirmations on popups ( Manual @ https://autohotkey.com/docs/commands/MsgBox.htm )
; ...::
	; WinGetActiveStats, WinTitle, Width, Height, X, Y
	; WinGetText, WinText, A
	; MsgBox, 4, , WinTitle `n%WinTitle%   `n`nWindow Size: `n   Width (%Width%)     Height (%Height%)   `n`nWindow Coordinates: `n   X (%X%)     Y (%Y%)   `n`nSkip WinText?, 10  ; 10-second timeout.
	; IfMsgBox, Yes
		; Return
	; IfMsgBox, No
		; MsgBox, WinText `n%WinText%
		; Return
	; IfMsgBox, Timeout
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
		IfMsgBox Yes
		{
			TrayTip, AHK, Leftmost Button Selected  ; Toast Notification
		}
		IfMsgBox No
		{
			TrayTip, AHK, Center Button Selected  ; Toast Notification
		}
		IfMsgBox Cancel
		{
			TrayTip, AHK, Rightmost Button Selected  ; Toast Notification
		}

		Return

	}

	CustomMsgboxButtons_UNIQUE_NAME_HERE() {
		IfWinNotExist, Popup_MsgBox_WindowTitle
		{
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
; Alphabetical Command and Function Index:  https://autohotkey.com/docs/commands/
;   |--> Clipboard:  https://www.autohotkey.com/docs/misc/Clipboard.htm
;   |--> GetKeyState:  https://www.autohotkey.com/docs/commands/GetKeyState.htm
;   |--> Hotkey:  https://www.autohotkey.com/docs/commands/Hotkey.htm#IfWin
;   |--> KeyWait:  https://www.autohotkey.com/docs/commands/KeyWait.htm
;   |--> Menu:  https://autohotkey.com/docs/commands/Menu.htm
;   |--> Run/RunWait:  https://autohotkey.com/docs/commands/Run.htm
;   |--> SetTimer:  https://www.autohotkey.com/docs/commands/SetTimer.htm
;   |--> SysGet:  https://autohotkey.com/docs/commands/SysGet.htm
;
; ------------------------------------------------------------
;
; Variables and Expressions:  https://autohotkey.com/docs/Variables.htm#BuiltIn
;   |
;   |--> Arrays/Objects - Simple Arrays, e.g. "Indexed Arrays":  https://www.autohotkey.com/docs/Objects.htm#Usage_Simple_Arrays
;   |
;   |--> Arrays/Objects - Associative Arrays, e.g. "Associative Arrays":  https://www.autohotkey.com/docs/Objects.htm#Usage_Associative_Arrays
;   |
;   |--> Arrays/Objects - Pseudo-Arrays, e.g. "Variable Variables" (AVOID these to maintain syntax legibility & understandability):  https://www.autohotkey.com/docs/misc/Arrays.htm#pseudo
;   |
;   |--> Operators in Expressions - If (...) statements, including mathematical operators:  https://www.autohotkey.com/docs/Variables.htm#Operators
;
; ------------------------------------------------------------ 
;
; List of Keys:  https://autohotkey.com/docs/KeyList.htm
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
;   docs.microsoft.com  |  "WM_SYSCOMMAND message"  |  https://docs.microsoft.com/en-us/windows/win32/menurc/wm-syscommand
;
;   stackoverflow.com  |  "How can I set AutoHotKey's code to run only in chrome?"  |  https://stackoverflow.com/a/50180863
;
;   www.autohotkey.com  |  "Advanced Hotkey Features | AutoHotkey"  |  https://www.autohotkey.com/docs/HotkeyFeatures.htm#pass-through
;
;   www.autohotkey.com  |  "CLSID List (Windows Class Identifiers)"  |  https://www.autohotkey.com/docs/misc/CLSID-List.htm  <-- Example)  ::{7007acc7-3202-11d1-aad2-00805fc1270e}
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
;   www.autohotkey.com  |  "Single line if statements"  |  https://autohotkey.com/board/topic/74001-single-line-if-statements/?p=470078
;
;   www.autohotkey.com  |  "Trim multiple lines"  |  https://www.autohotkey.com/boards/viewtopic.php?p=175097#p175097
;
; ------------------------------------------------------------