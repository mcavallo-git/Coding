;   ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
;            >>>   _WindowsHotkeys.ahk, by Cavalol   <<<
;         AutoHotkey DL: https://autohotkey.com/download/
;
;  Official List of Autohotkey Buttons (Mouse, Keyboard, etc)
;           https://autohotkey.com/docs/KeyList.htm
;
;    # Windows-Key        ! Alt        + Shift        ^ Control
;    < Left Mod Key                             > Right Mod Key
;
;
;  Variables and Expressions  :::  https://autohotkey.com/docs/Variables.htm#BuiltIn
;
;  Run/RunWait  :::  https://autohotkey.com/docs/commands/Run.htm
;  SysGet  :::  https://autohotkey.com/docs/commands/SysGet.htm
;
;   ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
#SingleInstance force
;
#Persistent
;
; #EscapeChar \  ; Change it to be backslash instead of the default of accent (`).
;
;   ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
;    ACTION:    Refresh This Script
;                 --> Closes then re-opens this script (Allows saved changes to THIS script (file) be tested/applied on the fly)
;
;    HOTKEY:    Win + Esc
;
#Escape::
	Reload
	Sleep 1000 ; If successful, the reload will close this instance during the Sleep, so the line below will never be reached.
	MsgBox, 4,, The script could not be reloaded. Would you like to open it for editing?
	IfMsgBox, Yes, Edit
	Return
;
;   ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
; Debugging Hotkey (Call a function with this)
; +`::
	; CoordMode,Mouse,Screen
	; SetDefaultMouseSpeed, 0
	; Loop 200 {
		; x_loc = 830
		; y_loc = 637
		; MouseClick, Left, %x_loc%, %y_loc%
		; Sleep 10
	; }
	; Return
;
;   ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
;
;		ACTION:  Show active window's location & dimension specs in a popup message-box
;
#Z::
	WinGetActiveStats, Title, Width, Height, Left, Top
	WinGetText, WinText, A
	WinGet, WinPID, PID, A
	WinGet, WinPID, PID, A
	WinGet, ProcessName, ProcessName, A
	WinGet, ProcessPath, ProcessPath, A
	MsgBox, 0, Active Window Specs,
		(LTrim

			➣ WinTitle:   %WinTitle%
			➣ WinPID:   %WinPID%
			➣ ProcessName:   %ProcessName%
			➣ ProcessPath:   %ProcessPath%

			➣ Left:   %Left%
			➣ Top:    %Top%
			
			➣ Width:  %Width%
			➣ Height: %Height%

			➣ WinMove,,,%Left%,%Top%,%Width%,%Height%
		)
	; MsgBox, 0, Active Window Specs, Title:`n   [%Title%]   `n`nDimensions: `n   Width (%Width%)     Height (%Height%)   `n`nPosition: `n   X (%X%)     Y (%Y%)
	; MsgBox, 0, Active Window Specs, Title:`n`n`n ==> WinMove,,,%X%,%Y%,%Width%,%Height%
	Return
;
;   ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
#V::
	SetTitleMatchMode, 2

	ExePath_GitHub=%A_MyDocuments%\GitHub
	RepoName=boneal_github
	; RunAs, A_UserName
	VSC_WinTitle=Visual Studio Code
	VSC_ProcessName=Code.exe 
	VSC_WorkspaceToOpen=%ExePath_GitHub%\%RepoName%

	; VSC_FullCommand=%VSC_ProcessName% %VSC_WorkspaceToOpen%
	VSC_FullCommand=C:\ISO\VSCode\Code.lnk
	; Get a timestamp for 'now'
	formattime,formatted_timestamp,,yyyyMMdd-HHmmss
	; A_Temp
	; C:\ISO\VSCode\Code.lnk
	; "%PROGRAMFILES%\Microsoft VS Code\Code.exe" "%USERPROFILE%\Documents\GitHub\boneal_github"

	WinTitle=%RepoName% - %VSC_WinTitle%
	IfWinNotExist,"%WinTitle%"
	{
		If ProcessExists(VSC_ProcessName) {
			;; Start VS-Code (as it wasn't found, already) - get PID
			RunWait,%VSC_FullCommand%,,Hide
		} Else {
			;; VS-Code already running
		}
	}
	; WinActivate, "%WinTitle%"
	SysGet, MonitorCount, MonitorCount , N
	if (A_OSVersion = "WIN_7") {
		; Msgbox, AAA
		WinMove,%WinTitle%,,-8,-8,1936,1056
		; 		Win10, Maximized, Left-Mon   -->  WinMove,%WinTitle%,,-8,-8,1936,1056     ; w/ taskbar
		; 		Win10, Maximized, Right-Mon  -->  WinMove,%WinTitle%,,1912,-8,1936,1096     ; w/ taskbar
	} Else {
		; Msgbox, BBB
		WinMove,%WinTitle%,,0,0,1920,1040
		;		Win7, Maximized, Left-Mon   -->  WinMove,%WinTitle%,,0,0,1920,1040     ; w/ taskbar

		;		Win10
		; 		Left-half,  Left-Mon   -->  WinMove,%WinTitle_NodeJS%,,-7,0,974,1047      ; w/ taskbar
		; 		Right-half, Left-Mon   -->  WinMove,%WinTitle_Postman%,,953,0,974,1047    ; w/ taskbar
		; 		Left-half,  Right-Mon  -->  WinMove,%WinTitle_NodeJS%,,1913,0,974,1047    ; w/ taskbar
		; 		Right-half, Right-Mon  -->  WinMove,%WinTitle_Postman%,,2873,0,974,1047   ; w/ taskbar
	}
	WinActivate,%WinTitle%
	; WinGet, WinPID, PID, %WinTitle_VSCode%
	; WinGet, ProcessName, ProcessName, %WinTitle_VSCode%
	; WinGet, ProcessPath, ProcessPath, %WinTitle_VSCode%
	; MsgBox, 0, %A_OSVersion%
	; MsgBox, 0, Active Window Specs,
	; 	(LTrim

	; 		➣ A_Temp:   %A_Temp%

	; 		➣ WinTitle:   %WinTitle%

	; 		➣ ProcessName:   %ProcessName%

	; 		➣ ProcessPath:   %ProcessPath%

	; 		➣ WinPID:   %WinPID%

	; 	)
		
	Return

;
;   ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
;    ACTION:    Type a timestamp (on-the-fly) w/ format: [  20181026-013709  ]
;    HOTKEY:    Shift + Win + D
;
+#D::
	SetKeyDelay, 0, -1
  formattime,formatted_timestamp,,yyyyMMdd-HHmmss
  send %formatted_timestamp%
	Return
;
;    ACTION:    Type a timestamp (on-the-fly) w/ format: [  2018-10-26_01-37-09  ]
;    HOTKEY:    Win + D
;
#D::
	SetKeyDelay, 0, -1
  formattime,formatted_timestamp,,yyyy-MM-dd_HH-mm-ss
  send %formatted_timestamp%
	Return
;
;   ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
#SC03B::   ; Win+F1 -- Edit this Script (the one you're reading right now)
	Run, edit "%A_ScriptFullPath%"
	; if (FileExist("C:\Program Files\Microsoft VS Code\Code.exe")) {
	; 	Run "C:\Program Files\Microsoft VS Code\Code.exe" ".\_WindowsHotkeys.ahk"
	; 	Run, edit "%A_ScriptFullPath%"
	; }
	Return
;
;   ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
#SC03C::   ; Win+F2 -- Show all (current) Window Titles
	WinGet, Window, List
	Loop %Window% {
		Id:=Window%A_Index%
		WinGetTitle, TVar , % "ahk_id " Id
		Window%A_Index%:=TVar ;use this if you want an array
		tList.=TVar "`n" ;use this if you just want the list
	}
	MsgBox %tList%
	Return
;
;   ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
!SC03D::   ; Alt+F3
	; Win10 Download & Delete Recordings via XBox Win10 App
	;  (MAKE SURE TO HIDE SCREENSHOTS BEFOREHAND)
	Loop {
		MouseClick, Left, 861, 947
		Sleep 30000
		MouseClick, Left, 1420, 905
		Sleep 1000
		MouseClick, Left, 848, 575
		Sleep 7500
	}
	Return
!SC03C::   ; Alt+F3
	; Win10 Download & Delete Recordings via XBox Win10 App
	;  (MAKE SURE TO HIDE SCREENSHOTS BEFOREHAND)
	Loop {
		MouseClick, Left, 861, 947
		Sleep 30000
		MouseClick, Left, 1420, 905
		Sleep 1000
		MouseClick, Left, 848, 575
		Sleep 7500
	}
	Return
;
;   ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
;    ACTION:    Set Fn to perform CTRL action, instead
;    HOTKEY:    Fn Key (X1 Carbon)
;SC163::   ;"Fn" Key
	
	;Return
;   ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
;    ACTION:    FOLLOW-UP HOTKEY TO: Windows-key P   :::   Click "Duplicate" monitors
;    HOTKEY:    Windows-Key + [
;
<#[::
>#[::
	CoordMode,Mouse,Screen
	SetDefaultMouseSpeed, 0
	SetControlDelay, -1
	; MsgBox, % substr(a_osversion, 1, 100)
	Sleep 250
	Send {LWin up}{RWin up}{LWin down}{p}{LWin up}
	Sleep 1000
	if (A_OSVersion="WIN_7") {
		; Windows7 - Duplicate Monitors
		x_loc = 874
		y_loc = 520
		MouseClick, Left, %x_loc%, %y_loc%
	} else if (substr(A_OSVersion, 1, 4)="10.0") {
		; Windows10 - Duplicate Monitors
		x_loc = 1740
		; x_loc = 180
		y_loc = 213
		MouseClick, Left, %x_loc%, %y_loc%
		; Title=Project
		; ControlClick, x%x_loc% y%y_loc%, %Title%
	}
	Sleep 250
	Send {Escape}
	Return
;   ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
;    ACTION:    FOLLOW-UP HOTKEY TO: Windows-key P   :::   Click "Extend" monitors
;    HOTKEY:    Windows-Key + ]
;
<#]::
>#]::
	CoordMode,Mouse,Screen
	SetDefaultMouseSpeed, 0
	SetControlDelay, -1
	; MsgBox, % substr(a_osversion, 1, 100)
	Sleep 250
	Send {LWin up}{RWin up}{LWin down}{p}{LWin up}
	Sleep 1000
	if (A_OSVersion="WIN_7") {
		; Windows7 - Extend Monitors
		x_loc = 1044
		y_loc = 520
		MouseClick, Left, %x_loc%, %y_loc%
	} else if (substr(A_OSVersion, 1, 4)="10.0") {
		; Windows10 - Extend Monitors
		x_loc = 1740
		y_loc = 315
		MouseClick, Left, %x_loc%, %y_loc%
		; Title=Project
		; ControlClick, x%x_loc% y%y_loc%, %Title%
	}
	Sleep 250
	Send {Escape}
	Return
;
;   ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
;    ACTION:    Output cursor location
;    HOTKEY:    Windows-Key + Right-Click
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
;   ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
;    ACTION:    Opens "View Network Connections" (in the Control Panel)
;    HOTKEY:    Windows-Key + N
;
#n::
	Run "c:\windows\system32\ncpa.cpl"
	Return
;
;   ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
;    ACTION:    Opens "Programs & Features" in the Control Panel
;    HOTKEY:    Windows-Key + O
;
#o::
	Run "c:\windows\system32\appwiz.cpl"
	Return
;
;   ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
;    ACTION:    Keyboard-Command for a Mouse-Left-Click
;    HOTKEY:    Windows-Key + ` (Tilde)
;
#`::
	MouseClick, Left
	Return
;
;   ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
;    ACTION:    Keyboard-Command for a Mouse-Right-Click
;    HOTKEY:    Alt + ` (Tilde)
;
!`::
	MouseClick, Right
	Return
;
;   ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
;    ACTION:    Disable the "Caps Lock" Key from normal-use
;    HOTKEY:    Caps Lock
;
CapsLock::
	SetCapsLockState, Off
	Return
;
;   ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
;    ACTION:    Scroll up 10 wheel clicks
;    HOTKEY:    Caps Lock + w
;
CapsLock & w::
	MouseClick,WheelUp,,,10,0,D,R
	Return
;
;   ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
;    ACTION:    Scroll down 10 wheel clicks
;    HOTKEY:    Caps Lock + s
;
CapsLock & s::
	MouseClick,WheelDown,,,10,0,D,R
	Return
;
;   ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
;    ACTION:    Scroll down 15 wheel clicks
;    HOTKEY:    Alt + Mouse-Wheel-Down
;
!WheelDown::
	MouseClick,WheelDown,,,15,0,D,R
	Return
;
;   ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
;    ACTION:    Scroll up 15 wheel clicks
;    HOTKEY:    Alt + Mouse-Wheel-Up
;
!WheelUp::
	MouseClick,WheelUp,,,15,0,D,R
	Return
;
;   ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
;    ACTION:    Scroll to Bottom (Ctrl+End)
;    HOTKEY:    Mouse-Wheel-Click-Hold + Mouse-Wheel-Down
;
; MButton & WheelDown::
	; MouseClick,WheelDown,,,50,0,D,R ; Previously "Super Scroll Down"
	; Send ^{End}
	; Return
;
;   ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
;    ACTION:    Scroll to Top (Ctrl+Home)
;    HOTKEY:    Mouse-Wheel-Click-Hold + Mouse-Wheel-Down
;
; MButton & WheelUp::
	; MouseClick,WheelUp,,,50,0,D,R
	; Send ^{Home}
	; Return
;
;   ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
;    ACTION:    Restores Mouse-Middle-Click to normal operation
;               AutoHotkey otherwise tries to lump the click with related actions,
;                  then drops the click (forgets it) it if none are found.
;    HOTKEY:    Mouse-Middle-Click
;
; MButton::
	; MouseClick,Middle
	; Return
;
;   ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
;    ACTION:    Change Tabs Left or Right
;    HOTKEY:    "Rock" the Mouse's Wheel Left or Right   (Mouse-Wheel-Left or Mouse-Wheel-Right)
;
WheelLeft::
	Send ^{PgUp}
	Return
WheelRight::
	Send ^{PgDn}
	Return
;
;   ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
;    ACTION:    Chrome - Open a New Instance of Google Chrome
;    HOTKEY:    Windows-Key + C
;
#c::
	url_to_open = www.google.com
	Run % "chrome.exe" ( winExist("ahk_class Chrome_WidgetWin_1") ? " --new-window " : " " ) url_to_open
	Return
;
;   ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
;    ACTION:    Effective File Search - Open a new Instance of EFS
;    HOTKEY:    Windows-Key + F
;
#f::
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
;   ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
;    ACTION:    Maximize Current Window
;    HOTKEY:    Left-Shift + Right-Shift
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
	
;// FUNCTION:    Toggle Active Window:  "Maximized" / "Non-Maximized"
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
;
;// FUNCTION:    Only maximize active window if it isn't maximized already
ActiveWindow_Maximize() {
	WinGet, WinState, MinMax, A
	if (WinState<=0) { ; Window is not maximized - maximize it
		WinMaximize A
	}
	Return
}
;
;   ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;   ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;   ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
; --- ***    DevOps    *** ---
;
#J::   ; Win+J -- Startup Node.JS (Git-Bash) && Postman
	BonealGitHub=C:/Users/%A_UserName%/Documents/GitHub/boneal_github
	WinTitle_NodeJS=Supplier Gateway (localhost)
	WinTitle_Postman=Postman
	if ((!FileExist(BonealGitHub)) || (!InStr(FileExist(BonealGitHub), "D"))) {
		MsgBox, 
		(LTrim
			Error - Required directory not-found:
			%BonealGitHub%
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

		WinTitle_Postman=Postman
		WinTitle_NodeJS=Supplier Gateway (localhost)

		; Start Postman
		IfWinNotExist,%WinTitle_Postman%
		{
			; Need to run the program, as no window was found for it (yet)
			Target="C:/Users/%A_UserName%/AppData/Local/Postman/Update.exe"
			InlineArgs= --processStart Postman.exe
			Run, %Target% %InlineArgs%
		}

		Sleep 100

		; Start Node.JS in Git-Bash
		IfWinNotExist,%WinTitle_NodeJS%
		{
			; Need to run the program, as no window was found for it (yet)
			WorkingDir=%BonealGitHub%/web_files_nodejs
			Target="C:\Program Files\Git\git-bash.exe"
			InlineArgs=-c "%WorkingDir%/_start_server.sh start-dev '%WinTitle_NodeJS%'; sleep 60;"
			Run, %Target% %InlineArgs%, %WorkingDir%
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
;
#K::   ; Win+K -- Bring-to-Foreground:  Node.JS (Git-Bash) && Postman
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
;   ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
; ProcessExists (method)
;   |--> Compact method of checking whether a process exists or not
;   |--> Thanks to user "Menixator" from the Autohotkey Forums (https://autohotkey.com/board/topic/98317-if-process-exist-command)
;
ProcessExists(Name){
	return ProcessExist(Name)
}
ProcessExist(Name){
	Process,Exist,%Name%
	return Errorlevel
}
;
; If ProcessExists("explorer.exe")
; 	MsgBox Explorer.exe exists.
;
; If !ProcessExists("this_will_not_exist.exe")
; 	MsgBox Ofcourse it doesn't exist.
;
;
;   ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;   ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;   ----------------------------------------------------------------------------------------------------------------------------------------------------------------
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




;   ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;   ----------------------------------------------------------------   Community-Created Scripts   -----------------------------------------------------------------
;   ----------------------------------------------------------------------------------------------------------------------------------------------------------------






;   ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;   --------------------------------------------------------   Notes-to-Self  (Documentation / Training)   ---------------------------------------------------------
;   ----------------------------------------------------------------------------------------------------------------------------------------------------------------

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
