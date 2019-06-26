;
;   ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;   ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;   ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
;
;
;    [ Crusaders of Light ] Scripts
;
;       NOTE: These click-coordinates refer to screen-positions in-game running on the following setup:
;							   Nox (Android Emulation Software, Free) set to 800x600 device resolution, maximized (NOT full-screen), parent device (PC) set to 1920x1080 resolution


; - Nox
;				MouseClick,Left,1899,1001   ; Nox - View running apps
;				MouseClick,Left,724,972   	; Nox - Crusaders App on Bottom Bar (Second-to-leftmost app on app-bar - Position 2/5 from the left)


; - Logging In
;				MouseClick,Left,935,921     ; "Start Game" (Crusaders opening menu)
;				MouseClick,Left,1385,967    ; "Start Adventure" (AKA Choose-Character)
;       MouseClick,Left,1484,815    ; Respawn Here
;       MouseClick,Left,1389,943    ; Revive at Respawn Point


; - Questing
;       MouseClick,Left,415,199     ; Click Top-Quest-Item (on the left side of the window) 
;				MouseClick,Left,1324,742		; 	-1-		Hits the "Accept Quest"/"Complete Quest" (while talking to an NPC)
;					^^ Three-Piece						; 	-2-		Hits the 3-5s Quest popups near the Skills (bottom-right) - but most of those click themselves anyway
;						 												; 	-3-		Hits "Buy" on vendors, hopefully
;       MouseClick,Left,1183,846    ; "Use" (Open) any { Chests, Bags of Silver, Quest-Items, etc. }


; - Party (Team)
;       MouseClick,Left,290,472     ; Toggle-able "<" , ">" Party/Quest Slide-Out
;       MouseClick,Left,293,366     ; Open Team Window
;				MouseClick,Left,1533,221    ; Close Team Window
;       MouseClick,Left,1229,785    ; "Follow Leader"
;       MouseClick,Left,1413,783    ; "Leave Team"
;       MouseClick,Left,1052,646    ; "Confirm" the "Are you sure you want to leave the team?" popup
;       MouseClick,Left,817,649     ; "Decline" the "Exit Game?" action
;       MouseClick,Left,837,645     ; Refuse Party Invite


; - Adventure
;       MouseClick,Left,1186,70     ; Open "Adventure" Window ("ADVENT" at the top)
;       MouseClick,Left,1531,221    ; Close "Adventure" Window


;		-- Events
;       	MouseClick,Left,775,875     ; "Events" tab on "Adventure" popup
;       		MouseClick,Left,526,369     ; "Daily Events" sub-tab on the "Events" tab
;       			MouseClick,Left,1115,332    ; Start Drag Location for the "Daily Events" Tab
;       			MouseClick,Left,1115,630    ; End Drag Location for the "Daily Events" Tab
;       			MouseClick,Left,1429,358    ; "Go" button on the "Trial Quest" item
;       				MouseClick,Left,1209,761    ; "Auto-match" button on the "Trial Quest" popup
;       					MouseClick,Left,823,649    ; Respond "No" to the "Lead your own team?" popup


;		-- Raid
;					MouseClick,Left,390,893     ; "Raid" tab on "Adventure" popup
;						MouseClick,Left,525,290   	; "Scar Plains" sub-choice under the "Raid" tab
;						MouseClick,Left,525,380   	; "Dire Galleon" sub-choice under the "Raid" tab
;						MouseClick,Left,525,460   	; "Ancestral Altar" sub-choice under the "Raid" tab
;						MouseClick,Left,525,545   	; "Goblint Camp" sub-choice under the "Raid" tab


; - Combat
;       MouseClick,Left,1588,212    ; Auto Fight (Minimap-PC-Icon)
;       MouseClick,Left,333,87      ; Target Self (Portrait)
;       MouseClick,Left,1411,990    ; Target Enemy (Crosshairs)
;       MouseClick,Left,1467,905    ; Basic Attack
;       MouseClick,Left,1333,947    ; Skill 1  *Mystic Galaxy*
;       MouseClick,Left,1335,837    ; Skill 2  *Purifying Blast*
;       MouseClick,Left,1411,761    ; Skill 3  *Dreadfall*
;       MouseClick,Left,1523,743    ; Skill 4  *Dread Blast*
;       MouseClick,Left,1545,637    ; Path Skill  *Void Spirit Rain*
;       MouseClick,Left,1558,983    ; Special Skill  *Light Sigil*
;       (See LOGGING IN Above)			; Respawn Here
;       (See LOGGING IN Above)			; Revive at Respawn Point


; - Bag
;       MouseClick,Left,1514,279    ; "Bag" button (just below Mini-Map)
;       MouseClick,Left,1591,279    ; Toggle-able "<" , ">" Options Slide-Out (next to "Bag"), which contain menu-items (in reading-order):
;                                                                {Skill, Equip, Char, Achvts, Trade, Rewards, Beasts, Ranking, Guild}
;
;		-- Rewards
;       MouseClick,Left,1573,499    ; "Rewards" on the popout menu's 3x3 grid
;       MouseClick,Left,529,294     ; Top of drag (Rewards sub-menu Options)
;       MouseClick,Left,529,545     ; Bottom of drag (Rewards Menu Options)
;       MouseClick,Left,530,549     ; "Online Giftpacks" sub-menu under "Rewards"
;       MouseClick,Left,1392,379    	; "Collect" the top gift
;       MouseClick,Left,1183,846    	; 		^^ "Use" (Open) any { Chests, Bags of Silver, Quest-Items, etc. }
;       MouseClick,Left,528,291     ; "Daily Login" sub-menu under "Rewards"
;       MouseClick,Left,854,381     	; Top of SINGLE-ROW Drag (Daily Reward Page)
;       MouseClick,Left,854,491     	; Bottom of SINGLE-ROW Drag(Daily Reward Page)
;       MouseClick,Left,854, 381     	; Daily Rewards Grid - Row 1 Col 1 - Exact Center (Use vals to determine other rows)
;       MouseClick,Left,854, 491    	; Daily Rewards Grid - Row 2 Col 1 - Exact Center (Use vals to determine other rows)
;       MouseClick,Left,994, 381    	; Daily Rewards Grid - Row 1 Col 2
;       MouseClick,Left,1126, 381    	; Daily Rewards Grid - Row 1 Col 3
;       MouseClick,Left,1262, 381    	; Daily Rewards Grid - Row 1 Col 4
;       MouseClick,Left,1400, 381    	; Daily Rewards Grid - Row 1 Col 5
;       MouseClick,Left,1183,846    	   ; 		^^ "Use" (Open) any { Chests, Bags of Silver, Quest-Items, etc. }
;       MouseClick,Left,1530, 222   ; Close "Rewards" Window


; - Death
;				"Respawn Here"
;						Top-Left Corner: 1348,797
;						Bottom-Right Corner: 1544,841
;				"Res at Res. Point"
;						Top-Left Corner: 1348,933
;						Bottom-Right Corner: 1544,977
;				"?" (icon to avoid -- on top-left corner of the "Death" bottom-right-corner popup)
;						Top-Left Corner (stay away): 1307,698             ; NOTE: There is a "?" with a circle around it (button) located on the respawn box which will likely be inadvertently
;						Bottom-Right Corner (stay away): 1351,738         ; triggered multiple times, but heres the dimensions of a square area around it to stay away from
;				"Re-login" (stay away): 1105,981         ; >BUT< there	a "Re-login" button on the "?"'s popup box, which may prove to be useful


; - Movement
;       MouseClick,Left,1566,837    ; Jump
;       MouseClick,Left,454,869,1,0,D   ; Walk Left 1/3
;       MouseMove,-100,5,0,R            ; Walk Left 2/3
;       MouseClick,Left,0,0,1,0,U,R     ; Walk Left 3/3
;       MouseClickDrag,Left,600,540,1400,540    ; Turn Camera


;   ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
;    ACTION:    Crusaders of Light  -  TRAILS  -  Restart Nox & Crusaders LAST
;    HOTKEY:    Windows-Key + z
;
#t::
#a::
			CoordMode,Mouse,Screen
			SetDefaultMouseSpeed, 0
	Loop {
		Loop 5 {
			Crusaders_LeaveTeam()    		; Leave Current Party/Team
			Crusaders_NewTrialsTeam()   ; Auto-Find a Trials Quests Team
			Crusaders_TeamPlayer(1)   	; Be a Team player
		}
		Crusaders_RestartGame()       ; Restart Nox & Crusaders both
	}
	Return
;
;   ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
;    ACTION:    Crusaders of Light  -  TRAILS  -  Restart Nox & Crusaders FIRST
;    HOTKEY:    Windows-Key + a
#k::
	Loop {
		Crusaders_RestartGame()         ; Restart Nox & Crusaders both
		Loop 5 {
			Crusaders_LeaveTeam()    			; Leave Current Party/Team
			Crusaders_NewTrialsTeam()   	; Auto-Find a Trials Quests Team
			Crusaders_TeamPlayer(1)   		; Be a Team player
		}
	}
	Return
;
;   ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
;    ACTION:    Crusaders of Light  -  RAIDS - Get a Fresh Group
;    HOTKEY:    Windows-Key + d
;    HOTKEY:    Windows-Key + a
#d::
	Loop {
		Loop 5 {
			Crusaders_LeaveTeam()    			; Leave Current Party/Team
			Crusaders_NewDungeonTeam(4)   ; Only do the 4th Raid (Goblins)
			Crusaders_TeamPlayer(1)   		; Be a Team player
		}
		Crusaders_RestartGame()         ; Restart Nox & Crusaders both
	}
	Return
;    ACTION:    Crusaders of Light  -  ^^^ RAIDS - ALREADY IN A GROUP THOUGH
;    HOTKEY:    Control + Alt + d
!^d::
	Loop {
		Loop 5 {
			Crusaders_TeamPlayer(1)    		; Be a Team player
			Crusaders_LeaveTeam()    			; Leave Current Party/Team
			Crusaders_NewDungeonTeam(4)   ; Only do the 4th Raid (Goblins)
		}
		Crusaders_RestartGame()         ; Restart Nox & Crusaders both
	}
	Return
;
;   ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
;    ACTION:    Crusaders of Light  -  Farm the top quest on the left (usually main)
;    HOTKEY:    Windows-Key + r
#r:: 
	Crusaders_GetRewards()
	Return
;
;   ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
;    ACTION:    Crusaders of Light  -  Farm the top quest on the left (usually main)
;    HOTKEY:    Windows-Key + q
#q:: 
	Loop {
	; Do Trial Quests
		Crusaders_RestartGame()
		Crusaders_GetRewards()
		Loop 5 {
			Crusaders_LeaveTeam()    			; Leave Current Party/Team
			Crusaders_NewTrialsTeam()   	; Auto-Find a Trials Quests Team
			Crusaders_TeamPlayer(1)   		; Be a Team player
		}
		; Do Raids
		Crusaders_RestartGame()
		Loop 2 {
			Loop 4 {
				Crusaders_LeaveTeam()    			; Leave Current Party/Team
				Crusaders_NewDungeonTeam(A_Index)   ; Do every Raid
				Crusaders_TeamPlayer(1)    		; Be a Team player
			}
		}
		; Do Main Quests
		Crusaders_RestartGame()
		Loop 10 {
			Crusaders_DoMainQuests()
			Crusaders_ClearScreen()
			Sleep 5000
		}
	}
	Return
;
;   ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
;    ACTION:    Crusaders of Light  -  Solo Reputation Farmer
;    HOTKEY:    Windows-Key + 0
#9::
#0::
	Loop {
		Crusaders_AttackCycle_VoidSpiritRain()
	}
	Return
;   ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
;// FUNCTION:    Crusaders of Light  -  Use a skill (switch-style statement)
;
Crusaders_UseSkill(skill_name) {
			CoordMode,Mouse,Screen
			SetDefaultMouseSpeed, 0
			SetControlDelay, -1
			WinGetTitle, Title, A
	skill_coords := {}
	if (skill_name = "Special") { ; Special Skill  *Light Sigil*
		skill_coords_x := 1558
		skill_coords_y := 983
	} else if (skill_name = "Path") { ; Path Skill  *Void Spirit Rain* (not automatically triggered by autoplay)
		skill_coords_x := 1545
		skill_coords_y := 637
	} else if (skill_name = "1") { ; Skill 1  *Mystic Galaxy*
		skill_coords_x := 1333
		skill_coords_y := 947
	} else if (skill_name = "2") { ; Skill 2  *Purifying Blast*
		skill_coords_x := 1335
		skill_coords_y := 837
	} else if (skill_name = "3") { ; Skill 3  *Dreadfall*
		skill_coords_x := 1411
		skill_coords_y := 761
	} else if (skill_name = "4") { ; Skill 4  *Dread Blast*
		skill_coords_x := 1523
		skill_coords_y := 743
	}
	ControlClick, x%skill_coords_x% y%skill_coords_y%, %Title%
	Return
}
;
;   ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
;// FUNCTION:    Crusaders of Light  -  Quest Farmer  ---  Hit ALL the random popups!
Crusaders_DoMainQuests() {
	CoordMode,Mouse,Screen
	SetDefaultMouseSpeed, 0
	SetControlDelay, -1
	WinGetTitle, Title, A
	Crusaders_RespawnHere()
	Sleep 1000
	Crusaders_ReviveAtSpawn()
	Sleep 1000
	; Click Top-Quest-Item (on the left side of the window) 
	x_loc := 415
	y_loc := 199
	ControlClick, x%x_loc% y%y_loc%, %Title%
	Sleep 500
	Loop 2 {
		; THR ; -1- Hits the "Accept Quest"/"Complete Quest" (while talking to an NPC)
		; EE- ; -2- Hits the 3-5s Quest popups near the Skills (bottom-right) - but most of those click themselves anyway
		; FER ; -3- Hits "Buy" on vendors, hopefully
		x_loc := 1324
		y_loc := 742
		ControlClick, x%x_loc% y%y_loc%, %Title%
		Sleep 500
	}
	; "Submit" button for {Quest-Items that you must hand to an NPC to complete the quest}
	x_loc := 527
	y_loc := 783
	ControlClick, x%x_loc% y%y_loc%, %Title%
	Sleep 500
	; "Use" (Open) any { Quest-Items, Chests, Bags of Silver, etc. }
	x_loc := 1183
	y_loc := 846
	ControlClick, x%x_loc% y%y_loc%, %Title%
	Sleep 500
	Crusaders_RefuseTeamInvite()
	Sleep 500
	Return
}
;
;   ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
;// FUNCTION:    Crusaders of Light  -  Skill Rotation is based around *Void Spirit Rain* Cooldown
;// PERFECTLY TIMED AROUND VOID SPIRIT RAIN FOR AOE DMG --- Make Small tweaks at best moving forwards
Crusaders_AttackCycle_VoidSpiritRain() {
		SetDefaultMouseSpeed, 0
		Crusaders_UseSkill("Special")  ; Special Skill  *Light Sigil*
		Sleep 1250
		Crusaders_UseSkill("Path")  ; Path Skill  *Void Spirit Rain*
		Sleep 1000
		Crusaders_RefuseTeamInvite()
		Sleep 500
		Crusaders_RespawnHere()
		Sleep 250
		Crusaders_UseSkill("3")  ; Skill 3  *Dreadfall*
		Sleep 1250
		Crusaders_UseSkill("4")  ; Skill 4  *Dread Blast*
		Sleep 1000
		Crusaders_UseSkill("2")  ; Skill 2  *Purifying Blast*
		Sleep 2250
		Loop 3 {
			MouseClickDrag,Left,600,540,1400,540  ; Turn Camera
			Sleep 10
			Loop 20 {
				MouseClick,Left,1411,990  ; Target Enemy (Crosshairs)
				Sleep 10
				MouseClick,Left,1467,905  ; Basic Attack
				Sleep 100
			}
		}
		MouseClick,Left,333,87  ; Target Self
		Sleep 1000
		Crusaders_UseSkill("1")  ; Skill 1  *Mystic Galaxy*
		Sleep 1000
	Return
}
;
;   ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
;// FUNCTION:    Crusaders of Light  -  General Ranger Attack Cycle
;
Crusaders_AttackCycle_Ranger() {
		SetDefaultMouseSpeed, 0
		Crusaders_UseSkill("Special")  ; Special Skill
		Sleep 1250
		Crusaders_UseSkill("Path")  ; Path Skill
		Sleep 1000
		Crusaders_RefuseTeamInvite()
		Sleep 500
		Crusaders_RespawnHere()
		Sleep 250
		Crusaders_UseSkill("3")  ; Skill 3
		Sleep 1250
		Crusaders_UseSkill("4")  ; Skill 4
		Sleep 1000
		Crusaders_UseSkill("2")  ; Skill 2
		Sleep 2250
		Loop 3 {
			MouseClickDrag,Left,600,540,1400,540  ; Turn Camera Around
			Sleep 10
			Loop 16 {
				MouseClick,Left,1411,990  ; Target Enemy (Crosshairs)
				Sleep 10
				MouseClick,Left,1467,905  ; Basic Attack
				Sleep 100
			}
		}
		; MouseClick,Left,333,87  ; Target Self
		; Sleep 1000
		Crusaders_UseSkill("1")  ; Skill 1
		Sleep 1000
	Return
}
;
;   ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
;// FUNCTION:    Crusaders of Light  -  Follow Leader (Manually, via Team Menu)
Crusaders_RestartGame() {
			CoordMode,Mouse,Screen
			SetDefaultMouseSpeed, 0
			SetControlDelay, -1
			Title=NoxPlayer
	Crusaders_HideCursor()
	Runwait, taskkill /im Nox.exe /f    ; Kill Nox
	Sleep 1000
	Run "C:\Program Files (x86)\Nox\bin\Nox.exe"    ; Run Nox
	WinWait, NoxPlayer
	Loop 10 {
		Sleep 1000
		x_restore_nox = 1875
		y_restore_nox = 13
		MouseClick,Left,%x_restore_nox%,%y_restore_nox% ; Restore Nox if it is maximized
		Sleep 1000
		WinMove, NoxPlayer,,0,0, 1345, 1038 ; Move Nox to have the maximize button in a know location
		Sleep 1000
		; Manually Maximize the Nox instance (Nox glitches out when AutoHotkey throws it WinMaximize command(s))
		x_maximize_nox = 1299
		y_maximize_nox = 14
		ControlClick, x%x_maximize_nox% y%y_maximize_nox%, %Title%
		Sleep 1000
	}
	x_open_crusaders_app = 724
	y_open_crusaders_app = 972
	ControlClick, x%x_open_crusaders_app% y%y_open_crusaders_app%, %Title%    ; Run Crusaders of Light
	Sleep 60000
	x_start_game = 935
	y_start_game = 921
	ControlClick, x%x_start_game% y%y_start_game%, %Title%    ; "Start Game" (Opening Menu, takes you to Choose Character screen)
	Sleep 10000
	x_start_adventure = 1385,967
	y_start_adventure = 967
	ControlClick, x%x_start_adventure% y%y_start_adventure%, %Title%    ; "Start Adventure" (Choose Character screen, selects character)
	Sleep 20000
	Crusaders_RespawnHere()
	Sleep 2000
	Crusaders_ReviveAtSpawn()
	Sleep 2500
	Crusaders_ClearScreen()
	Return
}
;
;   ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
;// FUNCTION:    Crusaders of Light  -  Clear Menus off the screen && don't exit game
;
Crusaders_ClearScreen() {
			CoordMode,Mouse,Screen
			SetDefaultMouseSpeed, 0
			SetControlDelay, -1
			WinGetTitle, Title, A
	escape_count := 2
	Loop %escape_count% {
		Send {Escape}    ; Clear Menus off the screen (Also brings up "Exit Game?" Popup if no menus on-screen)
		Sleep 500
	}
	x_dont_exit = 817
	y_dont_exit = 649
	ControlClick, x%x_dont_exit% y%y_dont_exit%, %Title%,,Left,%escape_count%    ; "Decline" the "Exit Game?" action * 4
	Sleep 1000
	Return
}
;
;   ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
;// FUNCTION:    Crusaders of Light  -  Leave Team
;
Crusaders_LeaveTeam() {
			CoordMode,Mouse,Screen
			SetDefaultMouseSpeed, 0 				; Move the mouse instantly
			SetControlDelay, -1
			WinGetTitle, Title, A
	Crusaders_ClearScreen()
	; // Take a step to ensure that we're not already on follow-mode
		Crusaders_TakeAStep()
		Sleep 3000
	; // Leave the party / team
		x_team_menu = 293
		y_team_menu = 366
		Crusaders_ClearScreen()
		ControlClick, x%x_team_menu% y%y_team_menu%, %Title%,,Left,2    ; Open Team Window
		Sleep 250
		x_slideout_toggle = 290
		y_slideout_toggle = 472
		ControlClick, x%x_slideout_toggle% y%y_slideout_toggle%, %Title%    ; Toggle Sidebar Slideout ">"
		Sleep 500
		ControlClick, x%x_team_menu% y%y_team_menu%, %Title%,,Left,2    ; Retry Opening the Team Window (in-case it was closed the first time)
		Sleep 250
		x_leave_team = 1413
		y_leave_team = 783
		ControlClick, x%x_leave_team% y%y_leave_team%, %Title%    ; "Leave Team"
		Sleep 250
		x_confirm_leave = 1052
		y_confirm_leave = 646
		ControlClick, x%x_confirm_leave% y%y_confirm_leave%, %Title%    ; "Confirm" the "Are you sure you want to leave the team?" popup
		Sleep 250
		x_close_team_window = 1533
		y_close_team_window = 221
		ControlClick, x%x_close_team_window% y%y_close_team_window%, %Title%    ; Close Team Window
	; Crusaders_ClearScreen()
	Sleep 2000
	Return
}
;
;   ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
;// FUNCTION:    Crusaders of Light  -  Get a new team for "Trial Quest" Daily Events
;
Crusaders_NewTrialsTeam() {
			CoordMode,Mouse,Screen
			SetDefaultMouseSpeed, 0
			SetControlDelay, -1
			WinGetTitle, Title, A
	Crusaders_ClearScreen()
	Sleep 2000
	; "Advent" button at the top
	x_advent_button = 1186
	y_advent_button = 70
	ControlClick, x%x_advent_button% y%y_advent_button%, %Title%
	Sleep 2000
	; "Events" tab on "Adventure" popup
	x_events_tab = 775
	y_events_tab = 875
	ControlClick, x%x_events_tab% y%y_events_tab%, %Title%
	Sleep 1000
	; "Daily Events" sub-tab on the "Events" tab
	x_daily_subtab = 526
	y_daily_subtab = 369
	ControlClick, x%x_daily_subtab% y%y_daily_subtab%, %Title%
	Sleep 1000
	; Click the Activity Rewards
	x_daily_subtab = 888
	y_daily_subtab = 750
	Click_Timeout := 250
	Loop 5 {
		ControlClick, x%x_daily_subtab% y%y_daily_subtab%, %Title%
		Sleep %Click_Timeout%
		Crusaders_OpenObtainedChest()
		Sleep %Click_Timeout%
		x_daily_subtab += 144
	}
	Sleep 500
	; Drag the "Daily Events" menu to show "Trial Quest"
	Loop 3 {
		MouseClick,Left,1115,332,1,0,D
		MouseMove,0,300,0,R
		MouseClick,Left,0,0,1,0,U,R
		Sleep 750
	}
	; "Go" to the "Trial Quest" Event Groups
	x_go_trials = 1023 ; 1023=topleft_downone ;1418 topright
	y_go_trials = 507 ;507=topleft_downone ;346 topright
	ControlClick, x%x_go_trials% y%y_go_trials%, %Title%
	Sleep 1500
	; "Auto-match" button on the "Trial Quest" popup
	; 	// NOTE: BUTTON GETS TOGGLED FROM "Okay" TO "Cancel" (of sorts) once-pressed, so only press it exactly once
	x_automatch_me = 1209
	y_automatch_me = 761
	ControlClick, x%x_automatch_me% y%y_automatch_me%, %Title%
	Sleep 500
	; Respond "No" to the "Lead your own team?" popup
	x_no_team_lead = 823
	y_no_team_lead = 649
	ControlClick, x%x_no_team_lead% y%y_no_team_lead%, %Title%
	Sleep 500
	; Close Adventure Window
	x_close_advent_window = 1531
	y_close_advent_window = 221
	ControlClick, x%x_close_advent_window% y%y_close_advent_window%, %Title%
	Sleep 500
	Return
}
;
;   ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
;// FUNCTION:    Crusaders of Light  -  Get Rewards
;
Crusaders_GetRewards() {
			CoordMode,Mouse,Screen
			SetDefaultMouseSpeed, 0
			SetControlDelay, -1
			; WinGetTitle, Title, A
			Title = "NoxPlayer"
	Click_Timeout := 250
	Crusaders_ClearScreen()
	Sleep %Click_Timeout%
	Loop 2 {
		; Toggle-able "<" , ">" Options Slide-Out (next to "Bag")
		x_btn = 1591
		y_btn = 279
		; ControlClick, x%x_btn% y%y_btn%, %Title%
		MouseClick,Left, %x_btn%, %y_btn%
		Sleep 750
		; "Rewards" on the popout menu's 3x3 grid
		x_btn = 1573
		y_btn = 499
		; ControlClick, x%x_btn% y%y_btn%, %Title%
		MouseClick,Left, %x_btn%, %y_btn%
		Sleep 750
	}
	Sleep 1000
	
	; Down-Pull/Drag the "Rewards" sub-menu choices to get to the top choice (control-case)
	Loop 3 {
		MouseClick,Left,529,294,1,0,D
		MouseMove,0,300,0,R
		MouseClick,Left,0,0,1,0,U,R
		Sleep %Click_Timeout%
	}
	
	; "Daily Login" sub-menu under "Rewards"
	x_btn = 528
	y_btn = 291
	; ControlClick, x%x_btn% y%y_btn%, %Title%
	MouseClick,Left, %x_btn%, %y_btn%
	Sleep 750
	
	; Click all possible "Daily Login" boxes
	Loop 3 {
		; First, drag the "Daily Login" rewards-page all the way to the top (control-case)
		MouseClick,Left,854,381,1,0,D
		MouseMove,0,300,0,R
		MouseClick,Left,0,0,1,0,U,R
		Sleep %Click_Timeout%
	}
	Loop 2 {
	giftbox_baseline_x := 854
	giftbox_reward_x = %giftbox_baseline_x%
	giftbox_baseline_y := 381
	giftbox_reward_y = %giftbox_baseline_y%
		; Second, Get all items on the first page
		Loop 4 {
			Loop 5 {
				; ControlClick, x%giftbox_reward_x% y%giftbox_reward_y%, %Title%
				MouseClick,Left, %giftbox_reward_x%, %giftbox_reward_y%
				Sleep %Click_Timeout%
				Crusaders_OpenObtainedChest()
				Sleep %Click_Timeout%
				giftbox_reward_x += 136
			}
			giftbox_reward_x = %giftbox_baseline_x%
			giftbox_reward_y += 110
		}
		; Drag-up on the rewards page to the bottom page (setup all other items to be re-clicked)
		Loop 3 {
			MouseClick,Left,854,711,1,0,D
			MouseMove,854,381,0
			MouseClick,Left,0,0,1,0,U,R
			Sleep %Click_Timeout%
		}
	}

	; "Daily Login" sub-menu under "Rewards"
			; MouseClick,Left,530,549     ; "Online Giftpacks" sub-menu
	x_btn = 530
	y_btn = 460
	; ControlClick, x%x_btn% y%y_btn%, %Title%
	MouseClick,Left, %x_btn%, %y_btn%
	Sleep 1000
	
	; Open all "Daily Login" gifts
	Loop 7 {
		; "Collect" the top gift 
		x_btn = 1392
		y_btn = 403
		; ControlClick, x%x_btn% y%y_btn%, %Title%
		MouseClick,Left, %x_btn%, %y_btn%
		Sleep %Click_Timeout%
		Crusaders_OpenObtainedChest()
		Sleep %Click_Timeout%
	}
	
	; Close "Rewards" Window
			; MouseClick,Left,1530, 222   ; Close "Rewards" Window
	x_btn = 1531
	y_btn = 221
	; ControlClick, x%x_btn% y%y_btn%, %Title%
	MouseClick,Left, %x_btn%, %y_btn%
	Sleep 500
	
	Crusaders_ClearScreen()
	
	Return
	
}
;
;   ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
;// FUNCTION:    Crusaders of Light  -  "Use" (Open) any { Chests, Bags of Silver, Quest-Items, etc. }
;
Crusaders_OpenObtainedChest() {
			CoordMode,Mouse,Screen
			SetDefaultMouseSpeed, 0
			SetControlDelay, -1
			WinGetTitle, Title, A
	x_btn = 1183
	y_btn = 846
	Loop 3 {
		ControlClick, x%x_btn% y%y_btn%, %Title%
		Sleep 50
	}
	Return
}
;
;   ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
;// FUNCTION:    Crusaders of Light  -  Get a new team for "Raid" Events
;
Crusaders_NewDungeonTeam(Raid_1_to_4) {
			CoordMode,Mouse,Screen
			SetDefaultMouseSpeed, 0
			SetControlDelay, -1
			WinGetTitle, Title, A
	Crusaders_ClearScreen()
	Sleep 2000
	Crusaders_RefuseTeamInvite()    ; Kill any Party Invites
	x_advent_button = 1182
	y_advent_button = 68
	ControlClick, x%x_advent_button% y%y_advent_button%, %Title%    ; "Advent" button at the top
	Sleep 2000
	x_raid_tab = 390
	y_raid_tab = 893
	ControlClick, x%x_raid_tab% y%y_raid_tab%, %Title%    ; "Raid" tab on "Adventure" popup
	Sleep 1000
	if (Raid_1_to_4 = 1) {          ; "Scar Plains" Raid
		x_raid_choice = 525
		y_raid_choice = 290
	} else if (Raid_1_to_4 = 2) {   ; "Dire Galleon" Raid
		x_raid_choice = 525
		y_raid_choice = 380
	} else if (Raid_1_to_4 = 3) {   ; "Ancestral Altar" Raid
		x_raid_choice = 525
		y_raid_choice = 460
	} else {                        ; "Goblint Camp" Raid
		x_raid_choice = 525
		y_raid_choice = 545
	}
	ControlClick, x%x_raid_choice% y%y_raid_choice%, %Title%    ; Choose Dungeon on the "Raid" tab
	Sleep 1000
	x_go_raid = 1323
	y_go_raid = 717
	ControlClick, x%x_go_raid% y%y_go_raid%, %Title%    ; "Go" button on the Raids (while also not hitting any next buttons)
	Sleep 1000		; // NOTE: THIS CETS TOGGLED TO 'Cancel matchmaking' -- cannot press this an even number of times (cancels itself otherwise)
	x_automatch_me = 1209
	y_automatch_me = 761
	ControlClick, x%x_automatch_me% y%y_automatch_me%, %Title%    ; "Auto-match" button on the "Raid" popup
	Sleep 1000
	x_no_team_lead = 823
	y_no_team_lead = 649
	ControlClick, x%x_no_team_lead% y%y_no_team_lead%, %Title%    ; Respond "No" to the "Lead your own team?" popup
	Sleep 1000
	Crusaders_ClearScreen()
	Sleep 2000
	Return
}
;
;   ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
;// FUNCTION:    Crusaders of Light  -  Team Player (Raid-Auto-Attack)
;
Crusaders_TeamPlayer(usePathSkill) {
			CoordMode,Mouse,Screen
			SetDefaultMouseSpeed, 0
			SetControlDelay, -1
			WinGetTitle, Title, A
	x_chests := 1183    ; "Use" Chests, Bags of Silver, etc. to clear the popup
	y_chests := 846     ; "Use" Chests, Bags of Silver, etc. to clear the popup	
	y_top := 31         ; Top Edge of Game-Screen
	y_bot := 1037       ; Bottom Edge of Game-Screen
	x_left := 271       ; Left Edge of Game-Screen
	x_right := 1608     ; Right Edge of Game-Screen
	y_steps := 20
	y_step_size := (y_bot - y_top) / y_steps
	y_curr_bot := y_bot
	Crusaders_ClearScreen()
	Loop %y_steps% {
		Sleep 500
		Crusaders_TakeAStep()    ; Jiggle the Stick / Walk left slightly
		Sleep 1500
		if (usePathSkill=1) {
			Crusaders_UseSkill("Path")   ; Path-Specific Skill
			Sleep 1500
		}
		Crusaders_FollowLeader()    ; Auto-Fight / Follow Leader
		Sleep 5000    ; Allow for loading screen transitions
		Crusaders_ClearScreen()
		y_curr_top := y_curr_bot - y_step_size
		MouseMove,%x_left%,%y_curr_bot%,0
		Loop 2 {
			MouseMove,%x_right%,%y_curr_bot%,10    ; Make a box of where we're about to do a progress-ish bar (bottom means beginning, top means done)
			MouseMove,%x_right%,%y_curr_top%,5
			MouseMove,%x_left%,%y_curr_top%,10
			MouseMove,%x_left%,%y_curr_bot%,5
		}
		move_speed = 1
		x_steps := 100
		current_x := x_left
		x_step_size := (x_right-x_left)/x_steps
		; // Dance the mouse around while we're running the Function
		Loop %x_steps% {
			completion := A_Index / x_steps
			; current_x := x_left + x_diff * completion
			current_x += x_step_size
			if (Mod(A_index,2) = 0) {
				Random, y_rand, %y_curr_top%, %y_curr_bot%
				MouseMove,%current_x%,%y_rand%,%move_speed%
			} else {
				MouseMove,%current_x%,%y_curr_top%,%move_speed%
			}
			if (Mod(A_index,25) = 0) {
				Crusaders_OpenLoot()
			}
			if (Mod(A_index,50) = 0) {
				if (usePathSkill=1) {
					Crusaders_UseSkill("Path")   ; Path-Specific Skill
				}
			}
			ControlClick, x%x_chests% y%y_chests%, %Title%
		}
		Crusaders_RespawnHere()        ; Respawn Here
		Sleep 500
		Crusaders_ReviveAtSpawn()        ; Revive at Respawn Point
		Sleep 500
		y_curr_bot := y_curr_top
	}
	Return
}
;
;   ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
;// FUNCTION:    Crusaders of Light  -  Move the mouse cursor off of the screen's real-estate
;
Crusaders_HideCursor() {
			CoordMode,Mouse,Screen
			SetDefaultMouseSpeed, 0
			SetControlDelay, -1
			WinGetTitle, Title, A
	MouseMove,1757,469,0
}
;
;   ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
;// FUNCTION:    Crusaders of Light  -  Take a Step to the Left (Jiggle the Movement Stick - cancel team follows, guarantee a good/fresh follow)
;
Crusaders_TakeAStep() {
			CoordMode,Mouse,Screen
			SetDefaultMouseSpeed, 0
			SetControlDelay, -1
			WinGetTitle, Title, A
	MouseClick,Left,454,869,1,0,D    ; Jiggle the Stick
	MouseMove,-100,5,0,R
	MouseClick,Left,-1,0,1,0,U,R
	Crusaders_HideCursor()
	Return
}
;
;   ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
;// FUNCTION:    Crusaders of Light  -  Auto-Fight (Minimap-PC-Icon)
;
Crusaders_AutoFight() {
			CoordMode,Mouse,Screen
			SetDefaultMouseSpeed, 0
			SetControlDelay, -1
			WinGetTitle, Title, A
	x_autofight_follow := 1588
	y_autofight_follow := 212
	ControlClick, x%x_autofight_follow% y%y_autofight_follow%, %Title%
	Return
}
;
;   ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
;// FUNCTION:    Crusaders of Light  -  Follow Leader (Manually, via Team Menu)
;
Crusaders_FollowLeader() {
			CoordMode,Mouse,Screen
			SetDefaultMouseSpeed, 0
			SetControlDelay, -1
			WinGetTitle, Title, A
	x_team_menu = 293
	y_team_menu = 366
	ControlClick, x%x_team_menu% y%y_team_menu%, %Title%    ; Open Team Window
	Sleep 100
	x_slideout_toggle = 290
	y_slideout_toggle = 472
	ControlClick, x%x_slideout_toggle% y%y_slideout_toggle%, %Title%    ; Toggle Sidebar Slideout ">"
	Sleep 500
	ControlClick, x%x_team_menu% y%y_team_menu%, %Title%,,Left,2    ; Retry Opening the Team Window (in-case it was closed the first time)
	Sleep 750
	x_follow_leader = 1229
	y_follow_leader = 785
	ControlClick, x%x_follow_leader% y%y_follow_leader%, %Title%    ; "Follow Leader"   (So Manual it's like the Flinstones, but SO much more reliable)
	Sleep 250
	x_close_team_window = 1533
	y_close_team_window = 221
	ControlClick, x%x_close_team_window% y%y_close_team_window%, %Title%    ; Close Team Window
	Return
}
;
;   ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
;// FUNCTION:    Crusaders of Light  -  Use Path-Specific Skill (not automatically triggered by autoplay)
;
; Crusaders_UsePathSkill() {d
			; CoordMode,Mouse,Screen
			; SetDefaultMouseSpeed, 0
			; SetControlDelay, -1
			; WinGetTitle, Title, A
	; x_path_skill = 1545
	; y_path_skill = 637
	; ControlClick, x%x_path_skill% y%y_path_skill%, %Title%    ; Path-Specific Skill
	; Return
; }
;   ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
;// FUNCTION:    Crusaders of Light  -  Refuse any Team Invitations
;
Crusaders_RefuseTeamInvite() {
			CoordMode,Mouse,Screen
			SetDefaultMouseSpeed, 0
			SetControlDelay, -1
			WinGetTitle, Title, A
	x_refuse_invite := 837
	y_refuse_invite := 645
	ControlClick, x%x_refuse_invite% y%y_refuse_invite%, %Title%    ; Refuse Party Invite
	Return
}
;
;   ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
;// FUNCTION:    Crusaders of Light  -  "Use" (Open up any) Chests, Bags of Silver, etc. that drop
;
Crusaders_OpenLoot() {
			CoordMode,Mouse,Screen
			SetDefaultMouseSpeed, 0
			SetControlDelay, -1
			WinGetTitle, Title, A
	x_chests := 1183
	y_chests := 846
	ControlClick, x%x_chests% y%y_chests%, %Title%
	Return
}
;
;   ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
;// FUNCTION:    Crusaders of Light  -  "Respawn Here" --- Fixed to avoid clicking Skills
;
Crusaders_RespawnHere() {
			CoordMode,Mouse,Screen
			SetDefaultMouseSpeed, 0
			SetControlDelay, -1
			WinGetTitle, Title, A
	x_respawn_here := 1484
	y_respawn_here := 815
	ControlClick, x%x_respawn_here% y%y_respawn_here%, %Title%
	Return
}
;
;   ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
;// FUNCTION:    Crusaders of Light  -  "Revive at Respawn Point" --- Fixed to avoid clicking Skills
Crusaders_ReviveAtSpawn() {
			CoordMode,Mouse,Screen
			SetDefaultMouseSpeed, 0
			SetControlDelay, -1
			WinGetTitle, Title, A
	x_revive_at_spawn := 1389
	y_revive_at_spawn := 943
	ControlClick, x%x_revive_at_spawn% y%y_revive_at_spawn%, %Title%
	Return
}
;