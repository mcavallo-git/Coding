#\::
	SetKeyDelay 25
	SetControlDelay -1
	CoordMode, Mouse, Screen
	SetDefaultMouseSpeed, 0
	; SetControlDelay, -1
	SetTitleMatchMode, 2  ; Title must CONTAIN [ WinTitle ] as a substring

	AwaitModifierKeyup()  ; Wait until all modifier keys are released

	; ExeBasename := "ffxiv_dx11.exe"
	WinTitle := "FINAL FANTASY XIV"

	; ExePID := GetPID(ExeBasename)
	ExePID := WinGetPID(WinTitle)

	If (ExePID != "") {  ; WinGetPID  <-- This function returns the Process ID (PID) of the specified window. If there is no matching window, an empty string is returned.

		Loop {

			; Blizzard III
			ControlSend,, {q}, ahk_pid %ExePID%
			TotalSleep := 3370
			Random, RandomSleep, 100, 150
			Sleep %RandomSleep%
			ControlSend,, {q}, ahk_pid %ExePID%
			RemainingSleep := (TotalSleep - RandomSleep)
			Sleep %RemainingSleep%

			; Enochian
			ControlSend,, {2}, ahk_pid %ExePID%
			Sleep 10
			Random, RandomSleep, 100, 150
			Sleep %RandomSleep%

			; Thunder III
			ControlSend,, {r}, ahk_pid %ExePID%
			TotalSleep := 2600
			Random, RandomSleep, 100, 150
			Sleep %RandomSleep%
			ControlSend,, {r}, ahk_pid %ExePID%
			RemainingSleep := (TotalSleep - RandomSleep)
			Sleep %RemainingSleep%

			; Blizzard IV
			ControlSend,, {Shift Down}q{Shift Up}, ahk_pid %ExePID%
			TotalSleep := 2690
			Random, RandomSleep, 100, 150
			Sleep %RandomSleep%
			ControlSend,, {Shift Down}q{Shift Up}, ahk_pid %ExePID%
			RemainingSleep := (TotalSleep - RandomSleep)
			Sleep %RemainingSleep%

			; Fire III
			ControlSend,, {e}, ahk_pid %ExePID%
			TotalSleep := 3370
			Random, RandomSleep, 100, 150
			Sleep %RandomSleep%
			ControlSend,, {e}, ahk_pid %ExePID%
			RemainingSleep := (TotalSleep - RandomSleep)
			Sleep %RemainingSleep%

			Loop 3 {
				; Fire IV
				ControlSend,, {Shift Down}e{Shift Up}, ahk_pid %ExePID%
				TotalSleep := 2690
				Random, RandomSleep, 100, 150
				Sleep %RandomSleep%
				ControlSend,, {Shift Down}e{Shift Up}, ahk_pid %ExePID%
				RemainingSleep := (TotalSleep - RandomSleep)
				Sleep %RemainingSleep%
			}

			; Sharpcast
			ControlSend,, {3}, ahk_pid %ExePID%
			Sleep 10
			Random, RandomSleep, 100, 150
			Sleep %RandomSleep%

  		; Fire
			ControlSend,, {Alt Down}e{Alt Up}, ahk_pid %ExePID%
			TotalSleep := 2400
			Random, RandomSleep, 100, 150
			Sleep %RandomSleep%
			ControlSend,, {Alt Down}e{Alt Up}, ahk_pid %ExePID%
			RemainingSleep := (TotalSleep - RandomSleep)
			Sleep %RemainingSleep%
			
			Loop 3 {
				; Fire IV
				ControlSend,, {Shift Down}e{Shift Up}, ahk_pid %ExePID%
				TotalSleep := 2690
				Random, RandomSleep, 100, 150
				Sleep %RandomSleep%
				ControlSend,, {Shift Down}e{Shift Up}, ahk_pid %ExePID%
				RemainingSleep := (TotalSleep - RandomSleep)
				Sleep %RemainingSleep%
			}

			; Blizzard III
			ControlSend,, {q}, ahk_pid %ExePID%
			TotalSleep := 3370
			Random, RandomSleep, 100, 150
			Sleep %RandomSleep%
			ControlSend,, {q}, ahk_pid %ExePID%
			RemainingSleep := (TotalSleep - RandomSleep)
			Sleep %RemainingSleep%

			; Blizzard IV
			ControlSend,, {Shift Down}q{Shift Up}, ahk_pid %ExePID%
			TotalSleep := 2690
			Random, RandomSleep, 100, 150
			Sleep %RandomSleep%
			ControlSend,, {Shift Down}q{Shift Up}, ahk_pid %ExePID%
			RemainingSleep := (TotalSleep - RandomSleep)
			Sleep %RemainingSleep%

			; Thunder III
			ControlSend,, {r}, ahk_pid %ExePID%
			TotalSleep := 2600
			Random, RandomSleep, 100, 150
			Sleep %RandomSleep%
			ControlSend,, {r}, ahk_pid %ExePID%
			RemainingSleep := (TotalSleep - RandomSleep)
			Sleep %RemainingSleep%

			; Give Enochian enough time to cool down
			Sleep 1000

		}

	}
	Return