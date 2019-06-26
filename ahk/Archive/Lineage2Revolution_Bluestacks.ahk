
;
;
; SkipTutorial     ~{1778,78}       TL={1679,33}, BR={1884, 112}
; SkipTutorial_OK  ~{1087,701}      TL={966,666}, BR={???, ???}
;
;
;
;   ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;   ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;

<#Escape::
>#Escape::
	ExitApp
	Return

; ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;

<#r::
>#r::
	CoordMode,Mouse,Screen
	SetDefaultMouseSpeed, 0
	Loop {
		Sleep 100
		DoBulkSale()
		Loop 300 {
			AutoQuest()
			Sleep 100
			ConfirmWholescreenProgress()
			Sleep 100
			GotoMainview()
			Sleep 100
			NotEnoughInventory__OK()
			Sleep 100
			GotoMainview()
		}
	}
	Return
	
;
; ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
; 		// FUNCTION:  Goto Main view (Top-Down, normal view while playing)
;

GotoMainview() {
	CoordMode,Mouse,Screen
	SetDefaultMouseSpeed, 0
	SetControlDelay, -1
	; Title = "NoxPlayer"
	Title = "BlueStacks"
	Sleep 10
	MouseClick,Left, 1370, 206 ; "X" on "Buy ..." popup (GTFO)
	Sleep 10
	MouseClick,Left, 1643, 182 ; "X" on "Super Sale ..." popup (GTFO)
	Sleep 250
	MouseClick,Left, 1906, 35 ; "X" or [DOOR] @ top-right of screen
	Return
}
;
; ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
; 		// FUNCTION:  Auto-Attack (Toggle)
;
AutoAttack() {
	CoordMode,Mouse,Screen
	SetDefaultMouseSpeed, 0
	SetControlDelay, -1
	; Title = "NoxPlayer"
	Title = "BlueStacks"
	Sleep 100
	x_btn = 1403
	y_btn = 920
	ControlClick, x%x_btn% y%y_btn%, %Title%
	MouseClick,Left, %x_btn%, %y_btn%
	Sleep 100
	Return
}
;
; ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
; 		// FUNCTION:  ClickAutoQuest
;
EnableAutoQuest() {
	CoordMode,Mouse,Screen
	SetDefaultMouseSpeed, 0
	SetControlDelay, -1
	; Title = "NoxPlayer"
	Title = "BlueStacks"
	Sleep 100
	AutoAttack()
	Sleep 10
	MouseClick,Left, 191, 383 ; AutoQuest
	Sleep 100
	Return
}
;
; ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
; 		// FUNCTION:  ClickWalkToQuest
;
ClickWalkToQuest() {
	CoordMode,Mouse,Screen
	SetDefaultMouseSpeed, 0
	SetControlDelay, -1
	; Title = "NoxPlayer"
	Title = "BlueStacks"
	Sleep 100
	MouseClick,Left, 757, 748 ; AutoQuest
	Sleep 100
	Return
}
;
; ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
; 		// FUNCTION:  AutoQuest - Left Side
;
AutoQuest() {
	CoordMode,Mouse,Screen
	SetDefaultMouseSpeed, 0
	SetControlDelay, -1
	; Title = "NoxPlayer"
	Title = "BlueStacks"
	Sleep 100
	Loop 3 {
		GotoMainview()
		Sleep 100
		TakeAStep()
		Sleep 100
		EnableAutoQuest()
		Sleep 100
		ClickWalkToQuest()
		Sleep 100
		EnableAutoQuest()
		Sleep 100
		AcceptQuest()
		Sleep 100
		GotoMainview()
		Sleep 100
		SkipQuestDialogue()
		Sleep 100
	}
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
	; Jiggle the Stick
	MouseClick,Left,226,847,1,0,D
	MouseMove,-100,5,0,R
	MouseClick,Left,-1,0,1,0,U,R
	Sleep 100
	Return
}
;
; ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
; 		// FUNCTION:  SkipQuestDialogue
;
SkipQuestDialogue() {
	CoordMode,Mouse,Screen
	SetDefaultMouseSpeed, 0
	Sleep 100
	MouseClick,Left, 1886, 769   ; "Skip" at the bottom-right
	Sleep 100
	; MouseClick,Left, 1778, 78    ; "Skip Tutorial" at the Top-Right
	MouseClick,Left, 1775, 42    ; "Skip Tutorial" at the Top-Right
	Sleep 100
	MouseClick,Left, 1087, 701   ;   ^^^  "OK" after "Skip Tutorial" was hit
	Sleep 100
	Return
}
;
; ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
; 		// FUNCTION:  AcceptQuest (Half-Width Blue-Button, with "Close" as a Gray button to the left of it)
;

AcceptQuest() {
	CoordMode,Mouse,Screen
	SetDefaultMouseSpeed, 0
	SetControlDelay, -1
	MouseClick,Left, 1142, 885 ; "Accept Quest"
	Sleep 100
	GotoMainview()
	Sleep 100
	Return
}

; ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
; 		// FUNCTION:  ClaimReward (Blue Button)
;

ClaimReward() {
	CoordMode,Mouse,Screen
	SetDefaultMouseSpeed, 0
	SetControlDelay, -1
	; Title = "NoxPlayer"
	Title = "BlueStacks"
	Sleep 100
	x_btn = 948
	y_btn = 885
	ControlClick, x%x_btn% y%y_btn%, %Title%
	MouseClick,Left, %x_btn%, %y_btn%
	Sleep 100
	Return
}

; ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
; 		// FUNCTION:  ConfirmWholescreenProgress (Blue Button)
;
ConfirmWholescreenProgress() {
	CoordMode,Mouse,Screen
	SetDefaultMouseSpeed, 0
	SetControlDelay, -1
	; Title = "NoxPlayer"
	Title = "BlueStacks"
	Sleep 100
	; 1467 ???
	;   ~ 1695 936
	;       1764 993
	x_btn = 1695
	y_btn = 936
	ControlClick, x%x_btn% y%y_btn%, %Title%
	MouseClick,Left, %x_btn%, %y_btn%
	Sleep 100
	Return
}
;
; ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
; 		// FUNCTION:  Close the NotEnoughInventorySpace popup
;

NotEnoughInventory__OK() {
	CoordMode,Mouse,Screen
	SetDefaultMouseSpeed, 0
	SetControlDelay, -1
	; Title = "NoxPlayer"
	Title = "BlueStacks"
	Sleep 100
	x_btn = 963
	y_btn = 708
	MouseClick,Left, %x_btn%, %y_btn%
	ControlClick, x%x_btn% y%y_btn%, %Title%
	Sleep 100
	Return
}
;
; ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
; 		// FUNCTION:  DoBulkSale
;
DoBulkSale() {
	CoordMode,Mouse,Screen
	SetDefaultMouseSpeed, 0
	Sleep 100
	GotoMainview()
	Sleep 100
	MouseClick,Left, 1466, 80    ; "Skip" Popup at the top-middle (Main-Helper Lady) ; was HelpSkipper()
	Sleep 100
	GotoMainview()
	Sleep 100
	OpenInventory()
	Sleep 1000
	BulkSaleButton()
	Loop 2 {
		Sleep 100
		Sell_BulkSale()
		Sleep 100
		ConfirmSell_BulkSale() ; Again for OK / Nothing to sell
	}	
	Sleep 100
	Return
}
;
; ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
; 		// FUNCTION:  OpenInventory
;
OpenInventory() {
	CoordMode,Mouse,Screen
	SetDefaultMouseSpeed, 0
	SetControlDelay, -1
	Title = "BlueStacks"
	Sleep 100
	x_btn = 1486
	y_btn = 44
	ControlClick, x%x_btn% y%y_btn%, %Title%
	MouseClick,Left, %x_btn%, %y_btn%
	Sleep 100
	Return
}
;
; ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
; 		// FUNCTION:  BulkSaleButton
;

BulkSaleButton() {
	CoordMode,Mouse,Screen
	SetDefaultMouseSpeed, 0
	SetControlDelay, -1
	Title = "BlueStacks"
	Sleep 100
	x_btn = 1439
	y_btn = 1014
	ControlClick, x%x_btn% y%y_btn%, %Title%
	MouseClick,Left, %x_btn%, %y_btn%
	Sleep 100
	Return
}
;
; ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
; 		// FUNCTION:  BulkSaleButton
;

Sell_BulkSale() {
	CoordMode,Mouse,Screen
	SetDefaultMouseSpeed, 0
	SetControlDelay, -1
	Title = "BlueStacks"
	Sleep 100
	x_btn = 1785
	y_btn = 1018
	ControlClick, x%x_btn% y%y_btn%, %Title%
	MouseClick,Left, %x_btn%, %y_btn%
	Sleep 100
	Return
}
;
; ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
; 		// FUNCTION:  ConfirmSell_BulkSale
;

ConfirmSell_BulkSale() {
	CoordMode,Mouse,Screen
	SetDefaultMouseSpeed, 0
	SetControlDelay, -1
	Title = "BlueStacks"
	Sleep 100
	x_btn = 1142
	y_btn = 750
	ControlClick, x%x_btn% y%y_btn%, %Title%
	MouseClick,Left, %x_btn%, %y_btn%
	Sleep 100
	Return
}
