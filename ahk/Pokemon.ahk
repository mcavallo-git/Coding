; ------------------------------------------------------------
; HOTKEYS:
;	Windows-Key + Esc								Refresh This Script
;	Windows-Key + -									Craft Non-Expert Recipes
;	Windows-Key + =									Turn In Collectible Items
;	Windows-Key + Right-Click						Craft expert recipes
;	Windows-Key + Ctrl + Right-Click				Follows the mouse-cursor and displays its the X,Y coordinates

; _WindowsHotkeys.ahk, by Cavalol
;   |--> Effective Hotkeys for Windows-based Workstaitons
;   |--> Runs via "Autohotkey" (AHK) - Download @ https://www.autohotkey.com/download/
;
; ------------------------------------------------------------

#Persistent											; https://www.autohotkey.com/docs/commands/_Persistent.htm
#HotkeyInterval 2000								; https://www.autohotkey.com/docs/commands/_HotkeyInterval.htm
#MaxHotkeysPerInterval 2000							; https://www.autohotkey.com/docs/commands/_MaxHotkeysPerInterval.htm
#SingleInstance Force								; https://www.autohotkey.com/docs/commands/_SingleInstance.htm

Block_FFXIV_MouseClicks 		:= 0
DebugMode 						:= 1

; ------------------------------------------------------------
; Set the app button to act as the right Windows-Key when pressed
AppsKey::RWin
;
; ------------------------------------------------------------
;  HOTKEY:  Left-MouseClick
;  HOTKEY:  Right-MouseClick
;  ACTION:  Block mouseclick events if the FFXIV window is active && crafting is occurring
#If WinActive("ahk_class FFXIVGAME") and (Block_FFXIV_MouseClicks == 1)
	LButton::
	RButton::
		Return
#If

;======================================================================================================================================
;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
;														H  O  T  K  E  Y  S																
;\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
;======================================================================================================================================

; ------------------------------------------------------------
; HOTKEY: Windows-Key + Esc
; ACTION: Refresh This Script  ::: Closes then re-opens this script (Allows saved changes to THIS script (file) be tested/applied on the fly)
#Escape::
	Sleep 250
	BlockInPut, Off ; Stop blocking input (e.g. restore full interaction)
	Reload ; Reload this script
	Sleep 1000 ; If successful, the reload will close this instance during the Sleep, so the line below will never be reached.
	MsgBox, 4,, The script could not be reloaded. Would you like to open it for editing?
	IfMsgBox, Yes, Edit
	Return

; ------------------------------------------------------------
; HOTKEY:  Windows-Key + -
; ACTION:  Craft Non-Expert Recipes
#-::
	SetKeyDelay, 25, -1
	CoordMode, Mouse, Screen
	SetDefaultMouseSpeed, 0
	SetControlDelay, -1
	ExeBasename := "ffxiv_dx11.exe"
	If (ProcessExist(ExeBasename) == True) {
		ExePID := GetPID(ExeBasename)
		PollDuration_ms := 10
		FollowDuration_ms := 6000
		TooltipOutput := "Running Crafting Hotkeys"
		ToolTip, %TooltipOutput%
		ClearTooltip(5000)
		NumberOfCrafts		:= 1 ; Set the number of items to craft
		FirstMacroRunTime	:= 36000 ; Sets the length of the first macro in milliseconds (1000 milliseconds = 1 second)
		SecondMacroRunTime	:= 0 ; Sets the length of the first macro in milliseconds (1000 milliseconds = 1 second)
		ThirdMacroRunTime	:= 0 ; Sets the length of the first macro in milliseconds (1000 milliseconds = 1 second)
		NumberOfMacros		:= 1 ; Sets the number of macros each craft takes to complete
		CollectableStatus	:= 0 ; If CollectableStatus = 1, then run the collectable macro; if CollectableStatus = 0, run the non-collectable macro

		; Ask the user how many crafts they want to create
		NumberOfCrafts := LoopUntil_UserInputs_PositiveInteger()

		; Confirm whether the user wants to craft a collectible item before proceeding
		MsgBox, 4, FFXIV AutoCraft, Are you crafting a collectable item?
		IfMsgBox Yes
		{
			CollectableStatus	:= 1
			MsgBox, 4, FFXIV AutoCraft, Do you have "Collectable Synthesis" turned on?
			IfMsgBox No
			{
				ControlSend,, 0, ahk_pid %ExePID% ; Press the button that is saved as the hotkey for "Collectable Synthesis" ("0")
				Random, RandomSleep, 1000, 1200
				Sleep %RandomSleep%
			}
		} else {
			CollectableStatus	:= 0
		}

		; Confirm whether the user has the Crafting Log open with the desired item selected before proceeding
		MsgBox, 4, FFXIV AutoCraft, Is the 'Crafting Log' open with the desired item selected?
		IfMsgBox Yes
		{
			Loop %NumberOfCrafts% {

				; Indicate the number of times that "Confirm" needs to be pressed in order to select "Synthesize"
				Sleep 1500
				If A_Index > 1
				{
					NumberOfConfirmPresses	:= 3
				} else {
					NumberOfConfirmPresses	:= 4
				}

				; Press the "Confirm" button the specified number of times in order to initiate Synthesize
				Loop %NumberOfConfirmPresses%
				{
					ControlSend,, =, ahk_pid %ExePID% ; Press the button that is saved as the hotkey for "Confirm" ("=")
					Random, RandomSleep, 1000, 1500
					Sleep %RandomSleep%
				}

				; General padding at the start of the loop and after each repeat							;
				Sleep 1500
				Random, RandomSleep, 1000, 1500
				Sleep %RandomSleep%

				; Initiate Crafting Macro #1
				ControlSend,,[, ahk_pid %ExePID% ; Press the button that is saved as the hotkey to initiate the 1st crafting macro ("[")
				TooltipOutput := "Crafting (" A_Index "/"  NumberOfCrafts ") - Macro 1 of " NumberOfMacros
				ToolTip, %TooltipOutput%
				ClearTooltip(5000)
				Sleep %FirstMacroRunTime%
				Sleep 2000
				Random, RandomSleep, 200, 800
				Sleep %RandomSleep%

				; Initiate Crafting Macro #2 (if applicable - run the following only if the user has indicated that each craft requires at least a 2-step macro)
				If NumberOfMacros > 1
				{
					ControlSend,,], ahk_pid %ExePID% ; Press the button that is saved as the hotkey to initiate the 3rd crafting macro ("]")
					TooltipOutput := "Crafting (" A_Index "/"  NumberOfCrafts ") - Macro 2 of " NumberOfMacros
					ToolTip, %TooltipOutput%
					ClearTooltip(5000)
					Sleep %SecondMacroRunTime%
					Sleep 2000
					Random, RandomSleep, 200, 800
					Sleep %RandomSleep%
				}																							;
																											;
				; Initiate Crafting Macro #3 (if applicable - run the following only if the user has indicated that each craft requires at least a 3-step macro)
				If NumberOfMacros > 2
				{
					ControlSend,,', ahk_pid %ExePID% ; Press the button that is saved as the hotkey to initiate the 3rd crafting macro ("'")
					TooltipOutput := "Crafting (" A_Index "/"  NumberOfCrafts ") - Macro 3 of " NumberOfMacros
					ToolTip, %TooltipOutput%
					ClearTooltip(5000)
					Sleep %ThirdMacroRunTime%
					Sleep 2000
					Random, RandomSleep, 200, 800
					Sleep %RandomSleep%
				}

				; Confirm Collectability (if applicable)
				If CollectableStatus > 0
				{
					Loop 2 {
						ControlSend,, =, ahk_pid %ExePID%
						Random, RandomSleep, 1000, 1200
						Sleep %RandomSleep%
						}
					Sleep 2000
					Random, RandomSleep, 200, 800
					Sleep %RandomSleep%
				}
			}
			Loop 2000
			{
				TooltipOutput := "All crafts complete!"
				Tooltip, %TooltipOutput%
				Sleep 10
			}
			ClearTooltip(0)
		}
	}
	Return

; ------------------------------------------------------------
; HOTKEY: Windows-Key + =
; ACTION: Turn In Collectible Items
#=::
	SetKeyDelay, 25, -1
	CoordMode, Mouse, Screen
	SetDefaultMouseSpeed, 0
	SetControlDelay, -1
	ExeBasename := "ffxiv_dx11.exe"
	
	; Set the random wait time
	RandomSleepLowerLimit			:= 450
	RandomSleepUpperLimit			:= 500
	
	If (ProcessExist(ExeBasename) == True) {
		ExePID := GetPID(ExeBasename)
		NumberOfTurnIns				:= 5

		MsgBox, 4, FFXIV AutoCraft, Are you ready to have your collectable items appraised?
		IfMsgBox Yes
		{
			Random, RandomSleep, 1000, 1200
			Sleep %RandomSleep%
			ControlSend,, =, ahk_pid %ExePID%
			Random, RandomSleep, RandomSleepLowerLimit, RandomSleepUpperLimit
			Sleep %RandomSleep%

			Loop %NumberOfTurnIns%
			{
				TooltipOutput := "Turning in " A_Index " of " NumberOfTurnIns " collectable items"
				ToolTip, %TooltipOutput%
				ClearTooltip(5000)

				ControlSend,, =, ahk_pid %ExePID% ; Press the button that is saved as the hotkey for "Confirm" ("=")
				Random, RandomSleep, RandomSleepLowerLimit, RandomSleepUpperLimit
				Sleep %RandomSleep%

				ControlSend,, /, ahk_pid %ExePID% ; Press the button that is saved as the hotkey for "Display Subcommands" ("/")
				Random, RandomSleep, RandomSleepLowerLimit, RandomSleepUpperLimit
				Sleep %RandomSleep%

				ControlSend,, =, ahk_pid %ExePID% ; Press the button that is saved as the hotkey for "Confirm" ("=")
				Random, RandomSleep, RandomSleepLowerLimit, RandomSleepUpperLimit
				Sleep %RandomSleep%

				ControlSend,, =, ahk_pid %ExePID% ; Press the button that is saved as the hotkey for "Confirm" ("=")
				Random, RandomSleep, RandomSleepLowerLimit, RandomSleepUpperLimit
				Sleep %RandomSleep%
			}
			ControlSend,, {Esc}, ahk_pid %ExePID% ; Press escape
		}
	}
	Return

; ------------------------------------------------------------
; HOTKEY: Windows-Key + z
; ACTION: Turn In Expert Recipes
#z::
	SetKeyDelay, 25, -1
	CoordMode, Mouse, Screen
	SetDefaultMouseSpeed, 0
	SetControlDelay, -1
	ExeBasename := "ffxiv_dx11.exe"
	
	; Set the random wait time
	RandomSleepLowerLimit			:= 450
	RandomSleepUpperLimit			:= 500
	
	If (ProcessExist(ExeBasename) == True) {
		ExePID := GetPID(ExeBasename)

		MsgBox, 4, FFXIV AutoCraft, Are you ready to have your collectable items appraised?
		IfMsgBox Yes
		{
			Random, RandomSleep, 1000, 1200
			Sleep %RandomSleep%
			ControlSend,, =, ahk_pid %ExePID%
			Random, RandomSleep, RandomSleepLowerLimit, RandomSleepUpperLimit
			Sleep %RandomSleep%

			ContinueLoop := 1
			While (ContinueLoop > 0)
			{
				TooltipOutput := "Turning in " A_Index " of " NumberOfTurnIns " collectable items"
				ToolTip, %TooltipOutput%
				ClearTooltip(5000)

				ControlSend,, =, ahk_pid %ExePID% ; Press the button that is saved as the hotkey for "Confirm" ("=")
				Random, RandomSleep, RandomSleepLowerLimit, RandomSleepUpperLimit
				Sleep %RandomSleep%

				ControlSend,, /, ahk_pid %ExePID% ; Press the button that is saved as the hotkey for "Display Subcommands" ("/")
				Random, RandomSleep, RandomSleepLowerLimit, RandomSleepUpperLimit
				Sleep %RandomSleep%

				ControlSend,, =, ahk_pid %ExePID% ; Press the button that is saved as the hotkey for "Confirm" ("=")
				Random, RandomSleep, RandomSleepLowerLimit, RandomSleepUpperLimit
				Sleep %RandomSleep%

				ControlSend,, =, ahk_pid %ExePID% ; Press the button that is saved as the hotkey for "Confirm" ("=")
				Random, RandomSleep, RandomSleepLowerLimit, RandomSleepUpperLimit
				Sleep %RandomSleep%
			
				If (GetKeyState("LButton", "P")) ; If this statement is true, the user has physically pressed the left mouse key
				{
					ContinueLoop := 0
					Break
				}
			}
		}
	}
	Return

; ------------------------------------------------------------
; HOTKEY: Ctrl + Windows-Key + Right-Click
; ACTION: Follows the mouse-cursor and displays its the X,Y coordinates  (as a tooltip next to the cursor)
^#RButton::
	FollowDuration_Seconds := 10
	ShowCursorCoordinates(FollowDuration_Seconds)
	Return

; ------------------------------------------------------------
; HOTKEY: Windows-Key + Right-Click
; ACTION: Craft expert recipes
CurrentDurability				:= StartingDurability
CurrentCP						:= StartingCP
CPMultiplier					:= 1
DurabilityMultiplier			:= 1
FinisherThreshhold_Progress		:= 0 ; 0 = not ready, 1 = ready
IQStatus						:= 0 ; 0 = Inner Quiet is not on, 1 = Inner Quiet is on
FAStatus						:= 0 ; 0 = Final Appraisal is not on, 1 = Final Appraisal is on
CurrentManipulationStacks		:= 0
StartingDurability				:= 60
StartingCP						:= 610

#RButton::
	SetKeyDelay, 25, -1
	CoordMode, Mouse, Screen
	SetDefaultMouseSpeed, 0
	SetControlDelay, -1
	ExeBasename					:= "ffxiv_dx11.exe"

	; Declare the globals
	Global CurrentDurability
	Global CurrentCP
	Global CPMultiplier
	Global DurabilityMultiplier
	Global FinisherThreshhold_Progress
	Global IQStatus
	Global FAStatus
	Global CurrentManipulationStacks
	Global StartingDurability
	Global StartingCP

	; Set the value of all of the constants
	NumberOfExpertRecipes 				:= 1		; The default number of recipes is 1
	StartingDurability					:= 60
	StartingCP							:= 610		; 544 without food, 597 with NQ BB, 610 with HQ BB
	FinisherDurability					:= 25		; More intensive one is 25, less intensive one is 15
	FinisherCP							:= 131		; More intensive one is 131, less intensive one is 74
	CraftsSinceLastMeal					:= 0
	ShowTooltips						:= 1		; 0 = do not show tooltips, 1 - show tooltips

	NumberOfExpertRecipes := LoopUntil_UserInputs_PositiveInteger()

	If (ProcessExist(ExeBasename) == True)
	{
		ExePID := GetPID(ExeBasename)
		PollDuration_ms := 10
		FollowDuration_Seconds := 600
		Loop_Iterations := Floor((1000 * FollowDuration_Seconds) / PollDuration_ms)
		TooltipOutput := "Crafting " NumberOfExpertRecipes "Expert Recipes"
		ToolTip, %TooltipOutput%
		ClearTooltip(3000)

		; Ascertain the location of the "Condition" bubble
		ConditionConfirmed := 0
		TooltipOutput := "Left-click the center of the Condition color-bubble"
		While (ConditionConfirmed < 1)
		{
			Tooltip, %TooltipOutput%
			Sleep 10

			If  (GetKeyState("LButton", "P")) ; If this statement is true, the user has physically pressed the left mouse key
			{
				ClearTooltip(0)
				MouseGetPos, ColorCenter_X, ColorCenter_Y
				Sleep 10
				Condition		:= CheckConditionOfExpertRecipe(ColorCenter_X, ColorCenter_Y, 1)
				If (Condition == "???")
				{
					TooltipOutput := "Unable to determine Condition - please left-click the center of the Condition color-bubble again"
					ConditionConfirmed := 0
				} Else
				{
					ConditionConfirmed := 1
				}
			}
		}
		ClearTooltip(0)
		Sleep 10
		TextToLog		:= "Condition bubble confirmed: " Condition
		;DoLogging(TextToLog)

		; Ascertain the location of finisher progress
		TooltipOutput := "Condition confirmed. Next, please left-click around the 95% complete mark within the Progress bar"
		Loop 120
		{
			Tooltip, %TooltipOutput%
			Sleep 10
		}
		BarLocator := 0
		While (BarLocator < 1)
		{
			MouseGetPos, ProgressBarClick_X, ProgressBarClick_Y
			PixelGetColor, Color, ProgressBarClick_X, ProgressBarClick_Y
			ColorComponent_Blue := (Color & 0xFF)
			ColorComponent_Green := ((Color & 0xFF00) >> 8)
			ColorComponent_Red := ((Color & 0xFF0000) >> 16)

			BarConfirmed		:= 0
			If ((ColorComponent_Blue <= 51) && (ColorComponent_Green <= 51) && (ColorComponent_Red <= 51) && (ColorComponent_Blue >= 46) && (ColorComponent_Green >= 46) && (ColorComponent_Red >= 46))
			{
				BarConfirmed		:= 1
				TooltipOutput := "Progress bar detected - please left-click around the 95% complete mark"
			} Else
			{
				BarConfirmed		:= 0
				TooltipOutput := "Progress bar not detected"
			}

			Tooltip, %TooltipOutput%
			Sleep 10

			If (GetKeyState("LButton", "P")) && (BarConfirmed == 1) ; If this statement is true, the user has physically pressed the left mouse key within the Progress bar
			{
				MouseGetPos, ProgressBarClick_X, ProgressBarClick_Y
				BarLocator := 1
				Break
			}
		}
		ClearTooltip(0)

		; Ascertain the location of finisher quality
		TooltipOutput := "Finisher progress. Next, please left-click around the 65% complete mark within the Quality bar"
		Loop 120
		{
			Tooltip, %TooltipOutput%
			Sleep 10
		}
		BarLocator := 0
		While (BarLocator < 1)
		{
			MouseGetPos, QualityBarClick_X, QualityBarClick_Y
			PixelGetColor, Color, QualityBarClick_X, QualityBarClick_Y
			ColorComponent_Blue := (Color & 0xFF)
			ColorComponent_Green := ((Color & 0xFF00) >> 8)
			ColorComponent_Red := ((Color & 0xFF0000) >> 16)

			BarConfirmed		:= 0
			If ((ColorComponent_Blue <= 51) && (ColorComponent_Green <= 51) && (ColorComponent_Red <= 51) && (ColorComponent_Blue >= 46) && (ColorComponent_Green >= 46) && (ColorComponent_Red >= 46))
			{
				BarConfirmed		:= 1
				TooltipOutput := "Quality bar detected - please left-click around the 65% complete mark"
			} Else
			{
				BarConfirmed		:= 0
				TooltipOutput := "Quality bar not detected"
			}

			Tooltip, %TooltipOutput%
			Sleep 10

			If (GetKeyState("LButton", "P")) && (BarConfirmed == 1) ; If this statement is true, the user has physically pressed the left mouse key within the Quality bar
			{
				MouseGetPos, QualityBarClick_X, QualityBarClick_Y
				BarLocator := 1
				Break
			}
		}
		ClearTooltip(0)

		; Start the timer
		SessionStartTime := A_TickCount

		Loop %NumberOfExpertRecipes%
		{

			; Set the starting value of all the main variables
			RecipeStartTime				:= A_TickCount
			CurrentDurability			:= StartingDurability
			CurrentCP					:= StartingCP
			CPMultiplier				:= 1
			DurabilityMultiplier		:= 1
			FinisherThreshhold_Progress	:= 0 ; 0 = Insufficient progress to use finisher, 1 = Sufficient progress to use finisher
			FinisherThreshhold_Quality	:= 0 ; 0 = Insufficient quality to use finisher, 1 = Sufficient quality to use finisher
			IQStatus					:= 0 ; 0 = Inner Quiet is not on, 1 = Inner Quiet is on
			FAStatus					:= 0 ; 0 = Final Appraisal is not on, 1 = Final Appraisal is on
			CurrentManipulationStacks	:= 0
			CurrentRecipeNumber			:= A_Index
			TextToLog					:= "`n/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\`nBeginning Crafting Expert Recipe Number " CurrentRecipeNumber "/" NumberOfExpertRecipes "`n\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/"
			DoLogging(TextToLog)
			LogCraftingSpecs()

			Counter_CurrentTurn := 0

			; From the third action forward, use a loop to determine the best ability to use next
			While (CurrentDurability > 0)
			{

				Counter_CurrentTurn	:= Counter_CurrentTurn + 1

				TextToLog			:= "Determining next ability to use (turn number " Counter_CurrentTurn ")"
				;DoLogging(TextToLog)

				; Keep an updated tracker of time spent on this craft
				TurnStartTime := A_TickCount
				RecipeElapsedDuration := FormatTickCountDifference(RecipeStartTime, TurnStartTime)
				SessionElapsedDuration := FormatTickCountDifference(SessionStartTime, TurnStartTime)

				; Reset all of the values
				Condition 				:= ""
				ProgressCheck			:= ""
				AbilityName 			:= ""
				CPCost					:= 0
				DurabilityCost			:= 0
				CPMultiplier			:= 1
				DurabilityMultiplier	:= 1

				; Check the Condition at the beginning of each turn
				Condition				:= CheckConditionOfExpertRecipe(ColorCenter_X, ColorCenter_Y, 0)

				; Check the Progress at the beginning of each turn unless the finisher Progress has been achieved
				If (FinisherThreshhold_Progress < 1)
				{
					FinisherThreshhold_Progress := CheckProgressOfExpertRecipe(ProgressBarClick_X, ProgressBarClick_Y)
				}

				; Check the Quality at the beginning of each turn unless the finisher Quality has been achieved
				FinisherThreshhold_Quality := CheckQualityOfExpertRecipe(QualityBarClick_X, QualityBarClick_Y)

				; Make sure that the durability and CP never inadvertently goes over the maximum
				If (CurrentDurability > StartingDurability)
				{
					TextToLog := "Current Durability is greater than Starting Durability (" CurrentDurability "/" StartingDurability ") - Resetting to Starting Durability"
					;DoLogging(TextToLog)
					CurrentDurability := StartingDurability
				}
				If (CurrentCP > StartingCP)
				{
					TextToLog := "Current CP is greater than Starting CP (" CurrentCP "/" StartingCP ") - Resetting to Starting CP"
					;DoLogging(TextToLog)
					CurrentCP := StartingCP
				}

				; Run the logical statement to determine which ability to use and retrieve AbilityName, DurabilityMultiplier and CPMultiplier
				ObtainAbilityDetails		:= DetermineAbility(Condition, StartingDurability, CurrentDurability, StartingCP, CurrentCP, FinisherCP, CurrentManipulationStacks, FinisherThreshhold_Progress, IQStatus, Counter_CurrentTurn)
				ReturnedAbilityDetails		:= StrSplit(ObtainAbilityDetails,"|")
				AbilityName					:= ReturnedAbilityDetails[1]
				DurabilityMultiplier		:= ReturnedAbilityDetails[2]
				CPMultiplier				:= ReturnedAbilityDetails[3]

				TextToLog	:= "Pulled following information from DetermineAbility function  -  Ability: " AbilityName "  |  Durability Multiplier: " DurabilityMultiplier "  |  CP Multiplier: " CPMultiplier
				;DoLogging(TextToLog)

				; Set the ability to Final Appraisal if the user selects Rapid Synthesis and Final Appraisal is not on
				If (AbilityName == "Rapid Synthesis") && (FAStatus < 1)
				{
					AbilityName	:= "Final Appraisal"
				}

				; Account for the Durability gained from Manipulation (if it is on)
				ManipulationBonus		:= 0
				If (CurrentManipulationStacks >= 1) && (CurrentDurability >= FinisherDurability - 5) && (AbilityName != "Final Appraisal")
				{
					ManipulationBonus	:= 5
				}

				; Check to see if the Durability and CP levels will allow for another ability; if not, move on to the finisher
				ObtainCosts				:= UseCraftingAbility(AbilityName, 0)
				ReturnedCosts			:= StrSplit(ObtainCosts,"|")
				CPCost					:= ReturnedCosts[1]
				DurabilityCost			:= ReturnedCosts[2]
				CPCost_Adjusted			:= Ceil(CPMultiplier * CPCost)
				DurabilityCost_Adjusted	:= Ceil(DurabilityMultiplier * DurabilityCost)

				; Determine how much Durability and CP the user would have if it were to use the specified ability
				ConfirmDurability		:= (CurrentDurability - DurabilityCost_Adjusted + ManipulationBonus)
				ConfirmCP				:= (CurrentCP - CPCost_Adjusted)

				; If there is enough Durability and CP to use the specified ability and the finisher, use the specified ability
				If (ConfirmDurability >= FinisherDurability) && (ConfirmCP >= FinisherCP) && (FinisherThreshhold_Quality < 1)
				{

					; Display the pre-ability stats and wait for 10 seconds before proceeding if the user has show tooltips turned on
					If (ShowTooltips > 0)
					{
						StatusNotification := "Crafting Expert Recipe " CurrentRecipeNumber "/" NumberOfExpertRecipes "`n"
						StatusNotification := StatusNotification "Turn Number: " Counter_CurrentTurn "`n"
						StatusNotification := StatusNotification "Upcoming Ability: " AbilityName "`n"
						StatusNotification := StatusNotification "Current Condition: " Condition "`n"
						If (CPCost < 0)
						{
							StatusNotification := StatusNotification "Current CP: " CurrentCP "/" StartingCP "  |  Upcoming CP Cost: Restore " (0 - CPCost_Adjusted) "  |  Finisher CP: " FinisherCP "`n"
						} Else
						{
							StatusNotification := StatusNotification "Current CP: " CurrentCP "/" StartingCP "  |  Upcoming CP Cost: " CPCost_Adjusted " (" CPMultiplier " x " CPCost ")  |  Finisher CP: " FinisherCP "`n"
						}
						If (DurabilityCost < 0)
						{
							StatusNotification := StatusNotification "Current Durability: " CurrentDurability "/" StartingDurability "  |  Upcoming Durability Cost: Restore " (0 - DurabilityCost_Adjusted) "  |  Finisher Durability: " FinisherDurability "`n"
						} Else
						{
							StatusNotification := StatusNotification "Current Durability: " CurrentDurability "/" StartingDurability "  |  Upcoming Durability Cost: " DurabilityCost_Adjusted " (" DurabilityMultiplier " x " DurabilityCost ")  |  Finisher Durability: " FinisherDurability "`n"
						}
						If (CurrentManipulationStacks > 0)
						{
							StatusNotification := StatusNotification "Manipulation: On (" CurrentManipulationStacks " stacks)`n"
						} Else
						{
							StatusNotification := StatusNotification "Manipulation: Off`n"
						}
						If (IQStatus > 0)
						{
							StatusNotification := StatusNotification "Inner Quiet: On`n"
						} Else
						{
							StatusNotification := StatusNotification "Inner Quiet: Off`n"
						}
						If (FAStatus > 0)
						{
							StatusNotification := StatusNotification "Final Appraisal: On`n"
						} Else
						{
							StatusNotification := StatusNotification "Final Appraisal: Off`n"
						}
						If (FinisherThreshhold_Progress > 0)
						{
							StatusNotification := StatusNotification "Sufficient Progress to use finisher: Yes`n"
						} Else
						{
							StatusNotification := StatusNotification "Sufficient Progress to use finisher: No`n"
						}
						If (FinisherThreshhold_Quality > 0)
						{
							StatusNotification := StatusNotification "Sufficient Quality to use finisher: Yes`n"
						} Else
						{
							StatusNotification := StatusNotification "Sufficient Quality to use finisher: No`n"
						}
						StatusNotification := StatusNotification "Crafts completed since last meal: " CraftsSinceLastMeal "`n`n"
						StatusNotification := StatusNotification "Time elapsed for all recipes: " SessionElapsedDuration "`n"
						StatusNotification := StatusNotification "Time elapsed for this recipe: " RecipeElapsedDuration
						ToolTip, %StatusNotification% ,0 ,0
						TextToLog := "`n=========================================================`n" StatusNotification "`n=========================================================`n"
						DoLogging(TextToLog)
						;KeyWait, LButton, D
						;ClearTooltip(0)
					}

					; Use the specified ability
					ObtainCosts := UseCraftingAbility(AbilityName, 1)

					; Update the current Durability
					If (DurabilityCost > 0)
					{
						TextToLog := "Updated Durability = CurrentDurability (" CurrentDurability ") - DurabilityCost_Adjusted (" DurabilityCost_Adjusted ")"
						;DoLogging(TextToLog)
						CurrentDurability := (CurrentDurability - DurabilityCost_Adjusted)
					} else
					{
						TextToLog := "Updated Durability = CurrentDurability (" CurrentDurability ") - DurabilityCost (" DurabilityCost ")"
						;DoLogging(TextToLog)
						CurrentDurability := (CurrentDurability - DurabilityCost)
					}
					If (CurrentManipulationStacks >= 1) && (CurrentDurability > 0) && (AbilityName != "Final Appraisal") && (AbilityName != "Manipulation")
					{
						TextToLog := "Updated Durability = CurrentDurability (" CurrentDurability ") + Manipulation Bonus (" ManipulationBonus ")"
						;DoLogging(TextToLog)
						CurrentDurability := (CurrentDurability + ManipulationBonus)
					}
					If (CurrentDurability > StartingDurability)
					{
						TextToLog := "Current Durability is greater than Starting Durability (" CurrentDurability "/" StartingDurability ") - Resetting to Starting Durability"
						;DoLogging(TextToLog)
						CurrentDurability := StartingDurability
					}

					; Update the current CP
					If (CPCost > 0)
					{
						TextToLog := "Updated CP = CurrentCP (" CurrentCP ") - CPCost_Adjusted (" CPCost_Adjusted ")"
						;DoLogging(TextToLog)
						CurrentCP := (CurrentCP - CPCost_Adjusted)
					} else
					{
						TextToLog := "Updated CP = CurrentCP (" CurrentCP ") - CPCost (" CPCost ")"
						;DoLogging(TextToLog)
						CurrentCP := (CurrentCP - CPCost)
					}
					If (CurrentCP > StartingCP)
					{
						TextToLog := "Current CP is greater than Starting CP (" CurrentCP "/" StartingCP ") - Resetting to Starting CP"
						;DoLogging(TextToLog)
						CurrentCP := StartingCP
					}

					; Readjust the number of Manipulation stacks as applicable
					If (AbilityName == "Manipulation")
					{
						CurrentManipulationStacks	:= 8
					} else if (CurrentManipulationStacks >= 1) && (AbilityName != "Final Appraisal")
					{
						CurrentManipulationStacks	:= CurrentManipulationStacks - 1
					}

					; Apply Inner Quiet if it was used
					If (AbilityName == "Inner Quiet")
					{
						IQStatus	:= 1
					}

					; Apply or remove Final Appraisal, as applicable (1 = Final Appraisal is on, 0 = Final Appraisal is off)
					If (AbilityName == "Final Appraisal")
					{
						FAStatus	:= 1
					} else
					{
						FAStatus	:= 0
					}

				} else ; Use the finisher to wrap up the craft
				{

					TextToLog	:= "`n|||||||||||||||||||||||||||||||||||||||`n*** ENTERING FINISHER PHASE ***`n|||||||||||||||||||||||||||||||||||||||"
					DoLogging(TextToLog)
					ClearTooltip(5000)

					; Finisher step 1
					AbilityName		:= "Great Strides"
					UseCraftingAbility(AbilityName, 1)

					; Finisher step 2
					AbilityName		:= "Innovation"
					UseCraftingAbility(AbilityName, 1)

					; Finisher step 3
					AbilityName		:= "Observe"
					UseCraftingAbility(AbilityName, 1)

					; Finisher step 4
					AbilityName		:= "Focused Touch"
					UseCraftingAbility(AbilityName, 1)

					; Finisher step 5
					AbilityName		:= "Great Strides"
					UseCraftingAbility(AbilityName, 1)

					; Finisher step 6
					AbilityName		:= "Byregot's Blessing"
					UseCraftingAbility(AbilityName, 1)

					; Finisher step 7
					Loop 2
					{
						AbilityName	:= "Basic Synthesis"
						UseCraftingAbility(AbilityName, 1)
					}
				
					CurrentDurability := 0

				}
			}

			; Log how long it took to complete this recipe
			RecipeEndTime := A_TickCount
			RecipeDuration := FormatTickCountDifference(RecipeStartTime, RecipeEndTime)
			TextToLog := "Expert recipe number " A_Index " of " NumberOfExpertRecipes " completed. It took " RecipeDuration " to complete this expert recipe."
			DoLogging(TextToLog)

			; Eat food if 4 items have been crafted since the last meal
			CraftsSinceLastMeal = CraftsSinceLastMeal + 1
			If (CraftsSinceLastMeal >= 4)
			{
				If ((NumberOfExpertRecipes - A_Index) > 2)
				{
					NumberOfFoodToEat := 2
				} Else
				{
					NumberOfFoodToEat := 1
				}
				EatFood(NumberOfFoodToEat)
				CraftsSinceLastMeal := 0
			}

			; Press the Synthesize button if there are still more expert recipes to craft
			If (A_Index < NumberOfExpertRecipes)
			{
				Random, RandomSleep, 2000, 1500
				Sleep %RandomSleep%
				Loop 3
				{
					ControlSend,, =, ahk_pid %ExePID% ; Press the button that is saved as the hotkey for "Confirm" ("=")
					Random, RandomSleep, 1250, 1500
					Sleep %RandomSleep%
				}
			}
		}

		; Log how long it took to complete all recipes
		SessionEndTime := A_TickCount
		SessionDuration := FormatTickCountDifference(SessionStartTime, SessionEndTime)
		TextToLog := "All expert recipes completed. It took " SessionDuration " to complete all " NumberOfExpertRecipes " expert recipes."
		DoLogging(TextToLog)

	}
Return

; ------------------------------------------------------------
; HOTKEY: Windows-Key + c
; ACTION: Hotkey for testing
#c::
	SetKeyDelay, 25, 0
	CoordMode, Mouse, Screen
	SetDefaultMouseSpeed, 0
	SetControlDelay, -1

	FinisherThreshhold_Progress	:= 0
	ExitLoop		:= 0
	While (ExitLoop < 1)
	{
		MouseGetPos, MouseX, MouseY
		PixelGetColor, Color, MouseX, MouseY
		ColorComponent_Blue := (Color & 0xFF)
		ColorComponent_Green := ((Color & 0xFF00) >> 8)
		ColorComponent_Red := ((Color & 0xFF0000) >> 16)
		TooltipOutput	:= "Left-click the Progress bar (R: " ColorComponent_Red "  |  G: " ColorComponent_Green "  |  B: " ColorComponent_Blue ")  [X: " MouseX "  |  Y: " MouseY "]"
		Tooltip, %TooltipOutput%
		Sleep 10

		; If  (GetKeyState("LButton", "P"))
		; {
		; 	ClearTooltip(0)
		; 	MouseGetPos, ProgressBarClick_X, ProgressBarClick_Y
		; 	Sleep 500
		; 	FinisherThreshhold_Progress := CheckProgressOfExpertRecipe(ProgressBarClick_X, ProgressBarClick_Y)
		; 	If (FinisherThreshhold_Progress < 1)
		; 	{
		; 		ExitLoop := 0
		; 		TextToLog := "Left key clicked, but progress is not ready"
		; 		DoLogging(TextToLog)
		; 	} Else
		; 	{
		; 		ExitLoop := 1
		; 		TextToLog := "Left key clicked, and progress was confirmed; exiting loop"
		; 		DoLogging(TextToLog)
		; 	}
		; }
	}
Return

; ------------------------------------------------------------
; HOTKEY: Windows-Key + v
; ACTION: Hotkey for testing
#v::
	; Require integer-typed user input
	IntegerInput := LoopUntil_UserInputs_PositiveInteger()
	MsgBox, % "Final positive integer value (given by user): [" IntegerInput "]"
Return

; ------------------------------------------------------------
; HOTKEY: Windows-Key + b
; ACTION: Hotkey for testing
#b::

Return

;======================================================================================================================================
;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
;											F  U  N  C  T  I  O  N  S																	
;\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
;======================================================================================================================================

; ------------------------------------------------------------
AwaitModifierKeyup() ; --> 
{
	KeyWait LAlt			; Wait for [ Left-Alt ] to be released
	KeyWait LCtrl			; Wait for [ Left-Control ] to be released
	KeyWait LShift			; Wait for [ Left-Shift ] to be released
	KeyWait LWin			; Wait for [ Left-Win ] to be released
	KeyWait RAlt			; Wait for [ Right-Alt ] to be released
	KeyWait RCtrl			; Wait for [ Right-Control ] to be released
	KeyWait RShift			; Wait for [ Right-Shift ] to be released
	KeyWait RWin			; Wait for [ Right-Win ] to be released
	Sleep 10
}

; ------------------------------------------------------------
BlockMouse() ;--> Block the mouse from being used while the FFXIV window is active and crafting is occurring
{
	Global Block_FFXIV_MouseClicks
	Global VerboseOutput
	CoordMode, Mouse, Screen
	MouseGetPos, , , WinID, control
	WinGetClass, WinClass, ahk_id %WinID%
	KillMouseInteraction := 0
	If (WinClass == "FFXIVGAME") {
		If (Block_FFXIV_MouseClicks == 1) {
			TooltipOutput := "Block mouse interaction: In-game & crafting"
			KillMouseInteraction := 1
		} Else {
			TooltipOutput := "Allow mouse interaction: Not currently crafting"
		}
	} Else {
		TooltipOutput := "Allow mouse interaction: Not in Game"
	}
	If (KillMouseInteraction == 1) {
		BlockInput, MouseMove ; Kill mouse interaction
		ToolTip, %TooltipOutput%
		ClearTooltip(10000)
	} Else {
		BlockInPut, MouseMoveOff ; Restore mouse interaction
		If (VerboseOutput > 0) {
			ToolTip, %TooltipOutput%
			ClearTooltip(10000)
		}
		; BlockInPut, Off	- Restore full interaction
	}
	Return
}

; ------------------------------------------------------------
CheckConditionOfExpertRecipe(ColorCenter_X, ColorCenter_Y, ShowToolTip) ;--> Check the condition of the expert recipe
{
	; Reset all of the values
	Counter_Unknown := 0
	Counter_Centered := 0
	Counter_Good := 0
	Counter_Pliant := 0
	Counter_Normal := 0
	Counter_Sturdy := 0

	; Check the condition bubble for half a second
	Loop 25
	{
		PixelGetColor, Color, ColorCenter_X, ColorCenter_Y, RGB
		ColorComponent_Blue := (Color & 0xFF)
		ColorComponent_Green := ((Color & 0xFF00) >> 8)
		ColorComponent_Red := ((Color & 0xFF0000) >> 16)
		ColorDelta_BlueGreen := Abs(ColorComponent_Blue - ColorComponent_Green)
		ColorDelta_GreenRed := Abs(ColorComponent_Green - ColorComponent_Red)
		ColorDelta_BlueRed := Abs(ColorComponent_Blue - ColorComponent_Red)
		Condition := "???"

		If (ShowToolTip > 0)
		{
			TooltipOutput := "Confirming Condition..."
			Tooltip, %TooltipOutput%
		}

		If ((ColorComponent_Blue<=70) && (ColorComponent_Green<=70) && (ColorComponent_Red<=70))
		{
			Counter_Unknown := Counter_Unknown + 1
		} Else If ((ColorDelta_GreenRed <= 10) && ((ColorComponent_Red - ColorComponent_Blue) >= 20) && ((ColorComponent_Green - ColorComponent_Blue) >= 15))
		{
			Counter_Centered := Counter_Centered + 1
		} Else If (((ColorComponent_Red / ColorComponent_Green) >= 1.1) && ((ColorComponent_Red - ColorComponent_Green) >= 10) && ((ColorComponent_Red / ColorComponent_Blue) >= 1.1) && ((ColorComponent_Red - ColorComponent_Blue) >= 10) && ((ColorComponent_Blue - ColorComponent_Green) >= -5))
		{
			Counter_Good := Counter_Good + 1
		} Else If ((ColorComponent_Green >= 40) && ((ColorComponent_Green - ColorComponent_Blue) >= 15) && ((ColorComponent_Green - ColorComponent_Red) >= 15) && (ColorDelta_BlueRed <= 15))
		{
			Counter_Pliant := Counter_Pliant + 1
		} Else If (((ColorComponent_Blue / ColorComponent_Green) <= 1.4) && ((ColorComponent_Green / ColorComponent_Red) <= 1.4) && ((ColorComponent_Blue / ColorComponent_Red) <= 1.4))
		{
			Counter_Normal := Counter_Normal + 1
		} Else If ( (((ColorComponent_Blue-ColorComponent_Green) >= 10)||((ColorComponent_Blue >= 245) && (ColorComponent_Green >=235))) && ((ColorComponent_Blue - ColorComponent_Red) >= 20) && ((ColorComponent_Green - ColorComponent_Red) >= 5))
		{
			Counter_Sturdy := Counter_Sturdy + 1
		}
		Sleep 10
	
		;TextToLog := "Color Check #" A_Index " ( R: " ColorComponent_Red "  |  G: " ColorComponent_Green "  |  B: " ColorComponent_Blue ")  -  Unknown: " Counter_Unknown "  |  Centered: " Counter_Centered "  |  Good: " Counter_Good "  |  Pliant: " Counter_Pliant "  |  Normal: " Counter_Normal "  |  Sturdy: " Counter_Sturdy
		;DoLogging(TextToLog)
	
	}
	
	; If a given color was present for most of the duration of the confirmation, set the Condition accordingly
	If Counter_Centered >= 20
	{
		Condition := "Centered"
	} Else If Counter_Good >= 20
	{
		Condition := "Good"
	} Else If Counter_Pliant >= 20
	{
		Condition := "Pliant"
	} Else If Counter_Normal >= 20
	{
		Condition := "Normal"
	} Else If Counter_Sturdy >= 20
	{
		Condition := "Sturdy"
	} Else
	{
		Condition := "???"
	}
	
	TextToLog					:= "Condition confirmed: " Condition "(R: " ColorComponent_Red "  |  G: " ColorComponent_Green "  |  B: " ColorComponent_Blue ")"
	;DoLogging(TextToLog)
	
	Return (Condition)
}

; ------------------------------------------------------------
CheckProgressOfExpertRecipe(ProgressBarClick_X, ProgressBarClick_Y) ; --> Check the progress of the expert recipe
{

	PixelGetColor, Color, ProgressBarClick_X, ProgressBarClick_Y
	ColorComponent_Blue := (Color & 0xFF)
	ColorComponent_Green := ((Color & 0xFF00) >> 8)
	ColorComponent_Red := ((Color & 0xFF0000) >> 16)

	If ((ColorComponent_Blue >= 80) && (ColorComponent_Green >= 150) && (ColorComponent_Red >= 70))
	{
		FinisherThreshhold_Progress := 1
		TextToLog := "Progress confirmation: Current progress is sufficient to use the finisher (R: " ColorComponent_Red "  |  G: " ColorComponent_Green "  |  B: " ColorComponent_Blue ") [X: " ProgressBarClick_X "  |  Y: " ProgressBarClick_Y "]"
	} Else
	{
		FinisherThreshhold_Progress := 0
		TextToLog := "Progress confirmation: Current progress is NOT sufficient to use the finisher (R: " ColorComponent_Red "  |  G: " ColorComponent_Green "  |  B: " ColorComponent_Blue ")"
	}
	;DoLogging(TextToLog)
	
	Return (FinisherThreshhold_Progress)
}

; ------------------------------------------------------------
CheckQualityOfExpertRecipe(QualityBarClick_X, QualityBarClick_Y) ; --> Check the quality of the expert recipe
{

	PixelGetColor, Color, QualityBarClick_X, QualityBarClick_Y
	ColorComponent_Blue := (Color & 0xFF)
	ColorComponent_Green := ((Color & 0xFF00) >> 8)
	ColorComponent_Red := ((Color & 0xFF0000) >> 16)

	If ((ColorComponent_Blue >= 60) && (ColorComponent_Green >= 100) && (ColorComponent_Red >= 150))
	{
		FinisherThreshhold_Quality := 1
		TextToLog := "Quality confirmation: Current quality is sufficient to use the finisher (R: " ColorComponent_Red "  |  G: " ColorComponent_Green "  |  B: " ColorComponent_Blue ") [X: " ProgressBarClick_X "  |  Y: " ProgressBarClick_Y "]"
	} Else
	{
		FinisherThreshhold_Quality := 0
		TextToLog := "Quality confirmation: Current quality is NOT sufficient to use the finisher (R: " ColorComponent_Red "  |  G: " ColorComponent_Green "  |  B: " ColorComponent_Blue ")"
	}
	DoLogging(TextToLog)
	
	Return (FinisherThreshhold_Quality)
}

; ------------------------------------------------------------
ClearTooltip(Period) ; --> If called with a positive [ %Period% ], wait [ %Period% ] milliseconds, executes [ %Label% ], then repeats (until explicitly cancelled); if called with a negative [ %Period% ], wait [ %Period% ] milliseconds, executes [ %Label% ], then returns
{
	Label := "RemoveToolTip"
	SetTimer, %Label%, -%Period%
	Return
}

; ------------------------------------------------------------
ConvertStringToInt(StringVar) ; --> Attempt to convert a string-typed variable to an integer
{
	IntVar := ("0" . StringVar) , IntVar += 0
	Return %IntVar%
}

; ------------------------------------------------------------
DetermineAbility(Condition, StartingDurability, CurrentDurability, StartingCP, CurrentCP, FinisherCP, CurrentManipulationStacks, FinisherThreshhold_Progress, IQStatus, Counter_CurrentTurn) ; --> Determine the ability that should be used next in expert recipes
{
	;TooltipOutput				:= "Condition: " Condition "  |  StartingDurability: " StartingDurability "  |  CurrentDurability: " CurrentDurability "  |  StartingCP: " StartingCP "  |  CurrentCP: " CurrentCP "  |  FinisherCP: " FinisherCP "  |  CurrentManipulationStacks: " CurrentManipulationStacks "  |   FinisherThreshhold_Progress: " FinisherThreshhold_Progress
	;ToolTip, %TooltipOutput%
	;ClearTooltip(10000)

	; Condition: Pliant
	If (Condition == "Pliant")
	{
		DurabilityMultiplier	:= 1
		CPMultiplier			:= 0.5
		If (Counter_CurrentTurn > 2)
		{
			If (CurrentManipulationStacks <= 2)
			{
				If (CurrentCP >= (FinisherCP + Ceil(96 * CPMultiplier) + (7 * 2)))
				{
					AbilityName	:= "Manipulation"
				} else if (CurrentCP >= (FinisherCP + Ceil(7 * CPMultiplier)))
				{
						If (CurrentDurability >= StartingDurability)
						{
							AbilityName	:= "Hasty Touch"
						} else {
							AbilityName	:= "Observe"
						}
				} else
				{
					AbilityName	:= "Hasty Touch"
				}
			} else
			{
				If (IQStatus > 0)
				{
					If (CurrentDurability >= StartingDurability)
					{
						AbilityName	:= "Hasty Touch"
					} else if (CurrentCP >= (FinisherCP + Ceil(7 * CPMultiplier)))
					{
						AbilityName	:= "Observe"
					} else
					{
						AbilityName	:= "Hasty Touch"
					}
				} Else
				{
					AbilityName	:= "Inner Quiet"
				}

			}
		} Else If (Counter_CurrentTurn = 2)
		{
			AbilityName := "Veneration"
		} Else
		{
			AbilityName := "Muscle Memory"
		}

	; Condition: Sturdy
	} else if (Condition == "Sturdy")
	{
		DurabilityMultiplier	:= 0.5
		CPMultiplier			:= 1
		If (Counter_CurrentTurn > 2)
		{
			If (FinisherThreshhold_Progress < 1)
			{
				If (CurrentDurability >= 30) && (CurrentManipulationStacks < 1)
				{
					AbilityName		:= "Rapid Synthesis"
				} else if (CurrentDurability >= 25) && (CurrentManipulationStacks >= 1)
				{
					AbilityName		:= "Rapid Synthesis"
				} else
				{
					If (CurrentCP >= (FinisherCP + 96 + (7*2)))
					{
						AbilityName	:= "Observe"
					} else if (CurrentCP >= (FinisherCP + 96 + (7 * 1)))
					{
						If (CurrentManipulationStacks <= 2)
						{
							AbilityName	:= "Manipulation"
						} else
						{
							AbilityName	:= "Observe"
						}
					} else if (CurrentCP >= (FinisherCP + 7))
					{
						AbilityName	:= "Observe"
					} else
					{
						AbilityName	:= "Rapid Synthesis"
					}
				}
			} else
			{
				If (CurrentDurability >= 30) && (CurrentManipulationStacks < 1)
				{
					AbilityName	:= "Hasty Touch"
				} else if (CurrentDurability >= 25) && (CurrentManipulationStacks >= 1)
				{
					AbilityName	:= "Hasty Touch"
				} else
				{
					If (CurrentCP >= (FinisherCP + 96 + (7 * 9)))
					{
						AbilityName	:= "Observe"
					} else if (CurrentCP >= (FinisherCP + 96 + (7 * 8)))
					{
						If (CurrentManipulationStacks <= 2)
						{
							AbilityName	:= "Manipulation"
						} else
						{
							AbilityName	:= "Observe"
						}
					} else if (CurrentCP >= (FinisherCP + 7))
					{
						AbilityName	:= "Observe"
					} else
					{
						AbilityName	:= "Hasty Touch"
					}
				}
			}
		} Else If (Counter_CurrentTurn = 2)
		{
			AbilityName := "Veneration"
		} Else
		{
			AbilityName := "Muscle Memory"
		}

	; Condition: Centered
	} else if (Condition == "Centered")
	{
		DurabilityMultiplier	:= 1
		CPMultiplier			:= 1
		If (Counter_CurrentTurn > 2)
		{
			If (FinisherThreshhold_Progress < 1)
			{
				If (CurrentDurability >= 35) && (CurrentManipulationStacks < 1)
				{
					AbilityName	:= "Rapid Synthesis"
				} else if (CurrentDurability >= 30) && (CurrentManipulationStacks >= 1)
				{
					AbilityName	:= "Rapid Synthesis"
				} else
				{
					If (CurrentCP >= (FinisherCP + 96 + (7 * 9)))
					{
						AbilityName	:= "Observe"
					} else if (CurrentCP >= (FinisherCP + 96 + (7 * 8)))
					{
						If (CurrentManipulationStacks <= 2)
						{
							AbilityName	:= "Manipulation"
						} else
						{
							AbilityName	:= "Observe"
						}
					} else if (CurrentCP >= (FinisherCP + 7))
					{
						AbilityName	:= "Observe"
					} else
					{
						AbilityName	:= "Rapid Synthesis"
					}
				}
			} else
			{
				If (CurrentDurability >= 35) && (CurrentManipulationStacks < 1)
				{
					AbilityName	:= "Hasty Touch"
				} else if (CurrentDurability >= 30) && (CurrentManipulationStacks >= 1)
				{
					AbilityName	:= "Hasty Touch"
				} else
				{
					If (CurrentCP >= (FinisherCP + 96 + (7 * 9)))
					{
						AbilityName	:= "Observe"
					} else if (CurrentCP >= (FinisherCP + 96 + (7 * 8)))
					{
						If (CurrentManipulationStacks <= 2)
						{
							AbilityName	:= "Manipulation"
						} else
						{
							AbilityName	:= "Observe"
						}
					} else if (CurrentCP >= (FinisherCP + 7))
					{
						AbilityName	:= "Observe"
					} else
					{
						AbilityName	:= "Hasty Touch"
					}
				}
			}
		} Else If (Counter_CurrentTurn = 2)
		{
			AbilityName := "Veneration"
		} Else
		{
			AbilityName := "Muscle Memory"
		}

	; Condition: Good
	} else if (Condition == "Good")
	{
		DurabilityMultiplier	:= 1
		CPMultiplier			:= 1
		If (Counter_CurrentTurn > 2)
		{
			AbilityName			:= "Tricks of the Trade"
		} Else If (Counter_CurrentTurn = 2)
		{
			AbilityName := "Veneration"
		} Else
		{
			AbilityName := "Muscle Memory"
		}
	
	; Condition: Normal (or not recognized)
	} else
	{
		DurabilityMultiplier	:= 1
		CPMultiplier			:= 1
		If (Counter_CurrentTurn > 2)
		{
			If (IQStatus < 1)
			{
				AbilityName		:= "Inner Quiet"
			} else
			{
				If (CurrentDurability >= StartingDurability)
				{
					AbilityName		:= "Hasty Touch"
				} else if (CurrentDurability <= FinisherDurability)
				{
					If (CurrentCP >= (FinisherCP + 96 + (7 * 2)))
					{
						AbilityName	:= "Observe"
					} else if (CurrentCP >= (FinisherCP + 96 + (7 * 1)))
					{
						If (CurrentManipulationStacks <= 2)
						{
							AbilityName	:= "Manipulation"
						} else
						{
							AbilityName	:= "Observe"
						}
					} else if (CurrentCP >= (FinisherCP + 7))
					{
						AbilityName	:= "Observe"
					} else
					{
						AbilityName	:= "Hasty Touch"
					}
				} else
				{
					If (CurrentCP >= (FinisherCP + 7))
					{
						AbilityName		:= "Observe"
					} else
					{
						AbilityName		:= "Hasty Touch"
					}
				}
			}
		} Else If (Counter_CurrentTurn = 2)
		{
			AbilityName := "Veneration"
		} Else
		{
			AbilityName := "Muscle Memory"
		}
	}
	
	;TooltipOutput				:= "AbilityName: " AbilityName "  |  DurabilityMultiplier: " DurabilityMultiplier "  |  CPMultiplier: " CPMultiplier
	;ToolTip, %TooltipOutput%
	;ClearTooltip(10000)
	
	Return AbilityName "|" DurabilityMultiplier "|" CPMultiplier
	;Return (AbilityName, DurabilityMultiplier, CPMultiplier)
}

; ------------------------------------------------------------
Disable_FFXIV_MouseEvents() ;--> Shorthand command for disabling mouse-moves and mouse-clicks targeted at the FFXIV window
{
	Global Block_FFXIV_MouseClicks
	Block_FFXIV_MouseClicks := 1
	SetTimer, BlockMouse, 50
	Return
}

; ------------------------------------------------------------
DoLogging(LogOutput) ; --> Function to create a log output
{
	Global DebugMode
	
	Sleep 10
	
	If (DebugMode == 1)
	{
		FormatTime,TIMESTAMP,,yyyy.MM.dd HH:mm:ss
		LogOutputNewLine := "[" TIMESTAMP "]  " LogOutput "`n"
		FilePath_LogFile := A_Desktop "\Logging (" A_ScriptName ").txt"
		FileAppend, %LogOutputNewLine%, %FilePath_LogFile%
	}
	Return
}

; ------------------------------------------------------------
EatFood(NumberOfFoodToEat) ; --> Obtain the CP and Durability cost of an ability an, if commanded, use the ability
{
	SetKeyDelay, 25, -1
	CoordMode, Mouse, Screen
	SetDefaultMouseSpeed, 0
	SetControlDelay, -1
	ExeBasename := "ffxiv_dx11.exe"
	If (ProcessExist(ExeBasename) == True)
	{
		ExePID := GetPID(ExeBasename)
		RelatedHotkey				:= ""
		RelatedModifier				:= ""

		; Leave the crafting window
		ControlSend,, {Esc}, ahk_pid %ExePID% ; Press escape
		Random, RandomSleep, 4050, 4150
		Sleep %RandomSleep%

		; Eat Food
		RelatedHotkey				:= "f"
		RelatedModifier				:= "Ctrl"
		Loop %NumberOfFoodToEat%
		{
			If (RelatedModifier != "")
			{
				ControlSend,, {%RelatedModifier% Down}, ahk_pid %ExePID%
			}
			If (RelatedHotkey != "")
			{
				ControlSend,, %RelatedHotkey%, ahk_pid %ExePID%
				TextToLog	:= "Eat food."
				DoLogging(TextToLog)
			} Else
			{
				TextToLog	:= "Error - No hotkey found for eating food."
				DoLogging(TextToLog)
			}
			If (RelatedModifier != "")
			{
				ControlSend,, {%RelatedModifier% Up}, ahk_pid %ExePID%
			}
			Random, RandomSleep, 4050, 4150
			Sleep %RandomSleep%
		}

		; Return to Craft
		RelatedHotkey				:= "e"
		RelatedModifier				:= "Ctrl"
		If (RelatedModifier != "")
		{
			ControlSend,, {%RelatedModifier% Down}, ahk_pid %ExePID%
		}
		If (RelatedHotkey != "")
		{
			ControlSend,, %RelatedHotkey%, ahk_pid %ExePID%
			TextToLog	:= "Return to crafting after eating " NumberOfFoodToEat " food."
			DoLogging(TextToLog)
		} Else
		{
			TextToLog	:= "Error - No hotkey found for returning to the craft after eating food."
			DoLogging(TextToLog)
		}
		If (RelatedModifier != "")
		{
			ControlSend,, {%RelatedModifier% Up}, ahk_pid %ExePID%
		}
		Random, RandomSleep, 4050, 4150
		Sleep %RandomSleep%
	}
	Return
}

; ------------------------------------------------------------
Enable_FFXIV_MouseEvents() ; --> Shorthand command for enabling mouse-moves and mouse-clicks targeted at the FFXIV window
{
	Global Block_FFXIV_MouseClicks
	Block_FFXIV_MouseClicks := 0
	SetTimer, BlockMouse, Off
	Return
}

; ------------------------------------------------------------
FormatTickCountDifference(StartTime, EndTime) ; --> Turns an unformatted tick count into a easily readably h/m/s timestamp
{
	Returnval := ""
	ElapsedTime_MS := EndTime - StartTime
	FormattedHours := SubStr(0 Floor(ElapsedTime_MS / 3600000), -1)
	FormattedMinutes := SubStr(0 Floor((ElapsedTime_MS - FormattedHours * 3600000) / 60000), -1)
	FormattedSeconds := SubStr(0 Floor((ElapsedTime_MS - FormattedHours * 3600000 - FormattedMinutes * 60000) / 1000), -1)
	FormattedMilliseconds := SubStr(0 ElapsedTime_MS - FormattedHours * 3600000 - FormattedMinutes * 60000 - FormattedSeconds * 1000, -2)
	Returnval := FormattedHours " hours, " FormattedMinutes " minutes, " FormattedSeconds " seconds"
	Return Returnval
}

; ------------------------------------------------------------
GetInput_PositiveInteger(ErrorDisplayType:="TrayTip") ; --> Gets input from user and verifies that it is a positive integer, then runs a loop with the the total number of loop-iterations set equal to the positive integer value previously given by user
{
	InputBox, UserInput, % "Enter a positive integer", % "Loop how many times? (Enter a positive integer)",,350,125
	Input_CancelledOutOf := ErrorLevel
	
	; Convert String to Int
	ErrorText := ""

	UserInput_ToNumber := ConvertStringToInt(UserInput)

	If (Input_CancelledOutOf != 0)
	{
		; ERROR:  User cancelled/declined to enter a value into input-field
		ErrorText := "!! Error !! - User cancelled out of a required input window"

		; Set the return-value to be blank (to denote errors on-return)
		UserInput_ToNumber := ""
	} Else If ((!(UserInput_ToNumber is integer)) || (UserInput_ToNumber==0))
	{
		; ERROR:  Non-integer input by user
		ErrorText := "!! Error !! - Invalid input value:  [" UserInput "]" "`n`n" "Input must be a positive integer"

		; Set the return-value to be blank (to denote errors on-return)
		UserInput_ToNumber := ""

	} Else
	{
		; If the user followed instructions and input a value matching the requested type, then there's no more work to do here
	}

	If (ErrorText != "")
	{
		; Error message exists
		Switch (ErrorDisplayType)
		{
			Case "TrayTip":
				TrayTip, %A_ScriptName%, %ErrorText% ; Toast Notification
			Case "Msgbox":
				Msgbox, % ErrorText ; Popup Message
			Case "Tooltip":
				ToolTip, % ErrorText ; Tooltip next to cursor
			Default:
				; Do nothing by-default (do not show error-message)
		}
	}
	Return %UserInput_ToNumber%
}

; ------------------------------------------------------------
GetPID(ProcName) ; --> Returns PID if process IS found; returns 0 if process is NOT found
{
	Process, Exist, %ProcName%
	Return %ErrorLevel%
}

; ------------------------------------------------------------
LogCraftingSpecs() ; --> Creates a strong of the current expert recipe specs to save to the debug log
{
	; Declare the globals
	Global CurrentDurability
	Global CurrentCP
	Global DurabilityMultiplier
	Global CPMultiplier
	Global FinisherThreshhold_Progress
	Global IQStatus
	Global FAStatus
	Global CurrentManipulationStacks
	Global StartingDurability
	Global StartingCP

	Sleep 10

	TextToLog	:= "Durability: " CurrentDurability "/" StartingDurability " (Durability Multiplier: " DurabilityMultiplier ")"
	TextToLog	:= TextToLog "  |  CP: " CurrentCP "/" StartingCP " (CP Multiplier: " CPMultiplier ")"
	TextToLog	:= TextToLog "  |  Manipulation: " CurrentManipulationStacks "/8"
	TextToLog	:= TextToLog "  |  Inner Quiet: " IQStatus
	TextToLog	:= TextToLog "  |  Final Appraisal: " FAStatus
	TextToLog	:= TextToLog "  |  Finisher Ready: " FinisherThreshhold_Progress

	DoLogging(TextToLog)

	Return
}

; ------------------------------------------------------------
LoopUntil_UserInputs_PositiveInteger() ; --> Perform a while loop that keeps running until either the user gives an input which matches this function-call's requested type, or until this script is killed
{
    ; Require integer-typed user input
    IntegerInput := ""
    While (IntegerInput == "") {
        IntegerInput := GetInput_PositiveInteger()
    }
    Return IntegerInput
}

; ------------------------------------------------------------
ProcessExist(ProcName) ; --> Proxy-function for GetPID(...); returns True if process IS found, returns False if process is NOT found
{
  Return (GetPID(ProcName)>0) ? True : False
}

; ------------------------------------------------------------
RemoveToolTip() ; --> Removes any Tooltips found
{
	ToolTip
	Return
}

; ------------------------------------------------------------
ShowCursorCoordinates(FollowDuration_Seconds) ; --> Displays a tooltip with the coordinates right next to the cursor's current location
{
	CoordMode, Mouse, Screen
	PollDuration_ms := 10
	Loop_Iterations := Floor((1000 * FollowDuration_Seconds) / PollDuration_ms)
	Loop %Loop_Iterations% {
		MouseGetPos, MouseX, MouseY
		Tooltip, x%MouseX% y%MouseY%
		Sleep %PollDuration_ms%
	}
	ClearTooltip(0)
	Return
}

; ------------------------------------------------------------
UseCraftingAbility(AbilityName, UseAbility) ; --> Obtain the CP and Durability cost of an ability an, if commanded, use the ability
{
	SetKeyDelay, 25, -1
	CoordMode, Mouse, Screen
	SetDefaultMouseSpeed, 0
	SetControlDelay, -1
	ExeBasename := "ffxiv_dx11.exe"
	If (ProcessExist(ExeBasename) == True)
	{
		ExePID := GetPID(ExeBasename)
		RelatedHotkey				:= ""
		RelatedModifier				:= ""
		Switch AbilityName
		{
			Case "Basic Touch":
				RelatedHotkey				:= "1"
				CPCost						:= 18
				DurabilityCost				:= 10

			Case "Standard Touch":
				RelatedHotkey				:= "2"
				CPCost						:= 32
				DurabilityCost				:= 10

			Case "Hasty Touch":
				RelatedHotkey				:= "3"
				CPCost						:= 0
				DurabilityCost				:= 10

			Case "Byregot's Blessing":
				RelatedHotkey				:= "4"
				CPCost						:= 24
				DurabilityCost				:= 10

			Case "Precise Touch":
				RelatedHotkey				:= "5"
				CPCost						:= 18
				DurabilityCost				:= 10

			Case "Focused Touch":
				RelatedHotkey				:= "6"
				CPCost						:= 18
				DurabilityCost				:= 10

			Case "Patient Touch":
				RelatedHotkey				:= "7"
				CPCost						:= 6
				DurabilityCost				:= 10

			Case "Prudent Touch":
				RelatedHotkey				:= "8"
				CPCost						:= 25
				DurabilityCost				:= 5

			Case "Prepatory Touch":
				RelatedHotkey				:= "9"
				CPCost						:= 40
				DurabilityCost				:= 20

			Case "Basic Synthesis":
				RelatedHotkey				:= "1"
				RelatedModifier				:= "Shift"
				CPCost						:= 0
				DurabilityCost				:= 10

			Case "Careful Synthesis":
				RelatedHotkey				:= "2"
				RelatedModifier				:= "Shift"
				CPCost						:= 7
				DurabilityCost				:= 10

			Case "Rapid Synthesis":
				RelatedHotkey				:= "3"
				RelatedModifier				:= "Shift"
				CPCost						:= 0
				DurabilityCost				:= 10

			Case "Groundwork":
				RelatedHotkey				:= "4"
				RelatedModifier				:= "Shift"
				CPCost						:= 18
				DurabilityCost				:= 20

			Case "Delicate Synthesis":
				RelatedHotkey				:= "5"
				RelatedModifier				:= "Shift"
				CPCost						:= 32
				DurabilityCost				:= 10

			Case "Master's Mend":
				RelatedHotkey				:= "\"
				RelatedModifier				:= "Shift"
				CPCost						:= 88
				DurabilityCost				:= -30

			Case "Focused Synthesis":
				RelatedHotkey				:= "6"
				RelatedModifier				:= "Shift"
				CPCost						:= 5
				DurabilityCost				:= 10

			Case "Brand of the Elements":
				RelatedHotkey				:= "7"
				RelatedModifier				:= "Shift"
				CPCost						:= 6
				DurabilityCost				:= 10

			Case "Intensive Synthesis":
				RelatedHotkey				:= "8"
				RelatedModifier				:= "Shift"
				CPCost						:= 6
				DurabilityCost				:= 10

			Case "Tricks of the Trade":
				RelatedHotkey				:= "9"
				RelatedModifier				:= "Shift"
				CPCost						:= -20
				DurabilityCost				:= 0

			Case "Inner Quiet":
				RelatedHotkey				:= "1"
				RelatedModifier				:= "Ctrl"
				CPCost						:= 18
				DurabilityCost				:= 0

			Case "Waste Not":
				RelatedHotkey				:= "2"
				RelatedModifier				:= "Ctrl"
				CPCost						:= 56
				DurabilityCost				:= 0

			Case "Waste Not II":
				RelatedHotkey				:= "3"
				RelatedModifier				:= "Ctrl"
				CPCost						:= 98
				DurabilityCost				:= 0

			Case "Great Strides":
				RelatedHotkey				:= "4"
				RelatedModifier				:= "Ctrl"
				CPCost						:= 32
				DurabilityCost				:= 0

			Case "Manipulation":
				RelatedHotkey				:= "5"
				RelatedModifier				:= "Ctrl"
				CPCost						:= 96
				DurabilityCost				:= 0

			Case "Innovation":
				RelatedHotkey				:= "6"
				RelatedModifier				:= "Ctrl"
				CPCost						:= 18
				DurabilityCost				:= 0

			Case "Veneration":
				RelatedHotkey				:= "7"
				RelatedModifier				:= "Ctrl"
				CPCost						:= 18
				DurabilityCost				:= 0

			Case "Name of the Elements":
				RelatedHotkey				:= "8"
				RelatedModifier				:= "Ctrl"
				CPCost						:= 30
				DurabilityCost				:= 0

			Case "Final Appraisal":
				RelatedHotkey				:= "9"
				RelatedModifier				:= "Ctrl"
				CPCost						:= 1
				DurabilityCost				:= 0

			Case "Muscle Memory":
				RelatedHotkey				:= "1"
				RelatedModifier				:= "Alt"
				CPCost						:= 6
				DurabilityCost				:= 10

			Case "Reflect":
				RelatedHotkey				:= "2"
				RelatedModifier				:= "Alt"
				CPCost						:= 24
				DurabilityCost				:= 10

			Case "Trained Eye":
				RelatedHotkey				:= "3"
				RelatedModifier				:= "Alt"
				CPCost						:= 250
				DurabilityCost				:= 10

			Case "Observe":
				RelatedHotkey				:= "4"
				RelatedModifier				:= "Alt"
				CPCost						:= 7
				DurabilityCost				:= 0

			Case "Careful Observation":
				RelatedHotkey				:= "5"
				RelatedModifier				:= "Alt"
				CPCost						:= 0
				DurabilityCost				:= 0

			Default:
				Sleep 3000
		}
		
		If (UseAbility > 0)
		{
			If (RelatedModifier != "")
			{
				ControlSend,, {%RelatedModifier% Down}, ahk_pid %ExePID%
			}
			
			If (RelatedHotkey != "")
			{
				ControlSend,, %RelatedHotkey%, ahk_pid %ExePID%
				TextToLog	:= "Ability used: " AbilityName
				;DoLogging(TextToLog)
			} Else
			{
				TextToLog	:= "Error - No hotkey found for the following ability: " AbilityName
				DoLogging(TextToLog)
			}
			
			If (RelatedModifier != "")
			{
				ControlSend,, {%RelatedModifier% Up}, ahk_pid %ExePID%
			}

			Random, RandomSleep, 3050, 3100
			Sleep %RandomSleep%

		}
	}
	Return CPCost "|" DurabilityCost
}

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