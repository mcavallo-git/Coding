^3::
; get total number of monitors
SysGet, MonitorCount, MonitorCount
; for each monitor open a test gui, which has that single color to find the pixel within, and a maximized background gui to prevent false-positives
MonitorCountx2 := (MonitorCount * 2)
Loop, %MonitorCountx2%
{
	gui, new, ,monitortest%a_index%
	if (a_index <= MonitorCount)
	{
		GradientColorBand("6AA7B6","monitortest.bmp")
		MonNum := a_index
	}
	else
	{
		GradientColorBand("F0F0F0","monitortest.bmp")
		MonNum := a_index - MonitorCount
	}
	gui, add, picture, w10 h10, monitortest.bmp
	gui, show, , monitortest%a_index%
	WinWait, monitortest%a_index%
	WinActivate
	WinWaitActive
	WinGet, windowHandle, ID, monitortest%a_index%
; makes sure monitortest1 is on monitor 1, and monitortest2 is on monitor 2, etc., windows-key-right moves to another monitor
	Loop
	{
		GetMonitorIndexFromWindow(windowHandle, MonitorIndex)
		if (MonitorIndex = MonNum)
			break
		Send, #+{right}
	}
	if (a_index > MonitorCount)
		WinMaximize
}
; see how many currently can't find the pixel in the gui
TestMonitors(MonitorCount,notfoundtotal1)
; if pixel can be found in each, then presumably dpi scale is 100 for each, go to the end of the script
if !notfoundtotal1
	Goto, CleanUp
; get what system thinks is width/height of primary monitor.  If primary monitor is at 150% dpi, then this will be by 1.5x smaller than it really is
currentwidth := a_screenwidth
currentheight := a_screenheight
; create a temporary width/height that would be the true resolution (if dpi scale is 150%)
tempwidth := 1.5*currentwidth
tempheight := 1.5*currentheight
; change it to this temporary resolution
ChangeResolution(tempwidth, tempheight)
; if the system still reads width as 1.5x less than it was just set it to be, either that resolution can't be done or dpi scale is 150%
; in the latter case, when primary monitor later gets fixed later to 100%, later increasing resolution 1.5x should set it to current, true resolution.
if (currentwidth = a_screenwidth)
	doagainlater := "y"
; but if the system does read a resolution change, then there's a good chance primary monitor is at 100% and meant to be at this lower resolution
else
	ChangeResolution(currentwidth, currentheight)
; checks to see if RegValOrig.ini already exists, if so, renames the file in case needed later
ifexist, RegValOrig.ini
{
   FormatTime, TimeString, , yyyyMMdd'_'HHmmss
   newfile := "RegValOrig" TimeString ".ini"
   Filemove, RegValOrig.ini, %newfile%
}
;Create a an ini of the current registry values for ScaleFactors and PerMonitorSettings
GetRegVal()
; rename the ini to "orig" as another one will be created later if reverting with other hotkey.
Filemove, RegVal.ini, RegValOrig.ini
; save clipboard and run powershell for monitor info piped into the clipboard
; powershell from here: https://blogs.technet.microsoft.com/heyscriptingguy/2013/10/03/use-powershell-to-discover-multi-monitor-information/
ClipOrig := ClipboardAll
Clipboard =
Run PowerShell.exe -Command &{((Get-CimInstance -Namespace root\wmi -ClassName WmiMonitorBasicDisplayParams) | Out-String).Trim() | Set-Clipboard},, hide
Clipwait
; regex's to get IDs of the monitors (as seen in Device Manager / Details / Hardware Ids, e.g. LEN40A9, which defaults to 150% scaling) currently connected
; the order doesn't seem to correspond directly to primary, secondary, etc. order from sysget, hence MonitorPossibleName variable
Loop, %MonitorCount%
{
   RegExMatch(clipboard,"DISPLAY\\(.*?)\\", m)
   MonitorPossibleName%a_index% := m1
   StringReplace, clipboard, clipboard, DISPLAY\
}
; restore clipboard, as all we want is monitorpossiblename1, monitorpossiblename2, etc.
Clipboard := ClipOrig
; do a reset of displays, which changes the primary display to a value, and then returns it to current, may not be necessary at this point in script
ResetDisplays(currentwidth,currentheight)
; do registry changes on each monitor, i.e. loop per the monitor count, or until pixel search works on each test gui window, whichever comes first
Loop, %MonitorCount%
{
; start with first monitor from the powershell
   MonPosName = % MonitorPossibleName%a_index%
   Loop
   {
; read from ini which read from the registry the deviceIDs from ScaleFactors
; ScaleFactors IDs are the same as what can be used in PerMonitorSettings, and include DevicesIDs of any monitor that has ever been connected (I think)
; these IDs start with the string from the powershell (e.g. LEN40A90) but then have a much longer string that follows, determined by some method I don't know
	   IniRead, DeviceID, RegValOrig.ini, HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\ScaleFactors, Key%a_index%, %A_Space%
	   if !DeviceID
		   break
; Once a DeviceID has been used it'll be marked in the ini, so it can be skipped next time
	   IniRead, YesOrNo, RegValOrig.ini, HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\ScaleFactors, Key%a_index%Used, %A_Space%
; if the powershell is indeed it at the beginning of the scalefactor id, the position will be 0.
	   StringGetPos, Pos, DeviceID, %MonPosName%
; not used before, and has the powershell id at the beginning, then mark as used and use it
	   If !YesOrNo and (Pos = 0)
		   IniWrite, Yes, RegValOrig.ini, HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\ScaleFactors, Key%a_index%Used
	   Else
		   Continue
; empty the variables that will be used in the subsequent internal loop, in case this is a later external loop
	   HasNonDpiValueName =
	   ValueNum =
; Go through and see if PerMonitorSettings have already been set for this deviceID--until you set them once using "Display settings" they do not exist
	   Loop
	   {
		   IniRead, NameNum, RegValOrig.ini, HKEY_CURRENT_USER\Control Panel\Desktop\PerMonitorSettings\%DeviceID%, Name%a_index%, %A_Space%
		   if !NameNum
			   break
; I'm not sure if there are other possible values in the key than DpiValue, could never find that out, so first need to verify the name is DpiValue 
		   if NameNum = DpiValue
			   IniRead, ValueNum, RegValOrig.ini, HKEY_CURRENT_USER\Control Panel\Desktop\PerMonitorSettings\%DeviceID%, Value%a_index%
; if there are other values than DpiValue, marking it, so that the entire key doesn't get deleted if we need to delete DpiValue
		   else
			   HasNonDpiValueName := "y"
	   }
; Since I'm only testing three possible values 0, -2 (4294967294), and -1 (4294967295), only doing this three times.
; 0 would be the default for that monitor (could be 100% or 150%, there may be others, but 150% is afaik only for high-res modern laptop screens)
; -2 would be two options above default (e.g. my lenovo defaults at 150%, but offers 125% above, -1, 100% above that, -2 -- also 175%, 1, and 200%, 2)
; -1 would be one option above default (other monitors don't have 5 options like my lenovo, and might be 100%, 150% default, 200% -- hence -1, 0, 1)
	   Loop, 3
	   {
		   if a_index = 1
			   TestValue := 0
		   if a_index = 2
			   TestValue := 4294967294
		   if a_index = 3
			   TestValue := 4294967295
; first determine that the testvalue to switch to isn't currently being used in permonitorsettings
		   if (ValueNum != TestValue)
		   {
; no setting at all in permonitorsettings, or a setting of 0, is the same, and results the same with !ValueNum, so if !ValueNum: no point in testing 0
			   if (TestValue = 0) and (!ValueNum)
				   continue
; write the test value to the registry
			   RegWrite, REG_DWORD, HKEY_CURRENT_USER\Control Panel\Desktop\PerMonitorSettings\%DeviceID%, DpiValue, %TestValue%
; reset the displays (i.e. change to a different resolution, and then back, on primary) to pickup the registry change
			   ResetDisplays(currentwidth,currentheight)
; test the monitors to get a total number of not-found pixel searches, if the registry change was helpful, it should switch reduce by one.
			   TestMonitors(MonitorCount,notfoundtotal2)
; if it does, then no need to check the rest of the test values
			   if (notfoundtotal2 < notfoundtotal1)
				   break
; if it doesn't work, and 0/null for original PerMonitorSettings, and no other values in the key for PerMonitorSettings, then delete the whole key 
			   else if (!ValueNum) and (!HasNonDpiValueName)
				   RegDelete, HKEY_CURRENT_USER\Control Panel\Desktop\PerMonitorSettings\%DeviceID%
; if it doesn't work, and 0/null for original PerMonitorSettings (and presumably other values in the key) then delete just DpiValue 
			   else if (!ValueNum)
				   RegDelete, HKEY_CURRENT_USER\Control Panel\Desktop\PerMonitorSettings\%DeviceID%, DpiValue
; if it doesn't work, and there is a value for original PerMonitorSettings, then use that value again
			   else
				   RegWrite, REG_DWORD, HKEY_CURRENT_USER\Control Panel\Desktop\PerMonitorSettings\%DeviceID%, DpiValue, %ValueNum%
		   }
	   }
   }
; if finally pixels are found through each monitor, no need to change/test any more
   if !notfoundtotal2
	  break
; but if the not-found-number has reduced, but not yet completely gone, then make the current number the number to check against in the next loop
   if notfoundtotal2 < notfoundtotal1
	  notfoundtotal1 := notfoundtotal2
}
; again, if the primary monitor was one of the monitors at 150%, this should change it to the proper full resolution.
if doagainlater
	ChangeResolution(tempwidth, tempheight)
; closing the test guis (would close anyway on return, but code may be used elsewhere) and deletting the monitortest.bmp
CleanUp:
Loop, %MonitorCountx2%
	WinClose, monitortest%A_Index%
FileDelete, monitortest.bmp
return



^4::
; checks to see if RegValOrig.ini exists
ifnotexist, RegValOrig.ini
{
	msgbox, needs RegValOrig.ini in script directory, restore/rename file as needed and try again
	return
}
; checks to see if RegVal.ini already exists, if so, renames the file so it doesn't get overwritten (in case user needs it later)
ifexist, RegVal.ini
{
   FormatTime, TimeString, , yyyyMMdd'_'HHmmss
   newfile := "RegVal" TimeString ".ini"
   Filemove, RegVal.ini, %newfile%
}
; gets the current registry values
GetRegVal()
; section names in the ini correspond to keys in PerMonitorSettings, e.g. the devices with set dpi scales, and "ScaleFactors," which we don't need 
IniRead, SectionNamesOrig, RegValOrig.ini
IniRead, SectionNames, RegVal.ini
; first goes through the list of recently created keys
Loop, parse, SectionNames, `n
{
; skipping the ScaleFactors parent key
	if (A_LoopField = "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\ScaleFactors")
		Continue
; selecting a key in the current registry (from the list, from the ini)
	SelKey := A_LoopField 
; clearing the variable for selected key in the old registry
	SelKeyOrig =
; going through old registry keys and seeing if any match the shelected key from the current registry
	Loop, parse, SectionNamesOrig, `n
	{
		if (A_LoopField = SelKey)
		{
; if so, set as selected key in the old registry
			SelKeyOrig := A_LoopField	  
			Break
		}
	}
; if there is no matching key in the old registry, then it must be a recently created key, and thus the entire current key can be safely deleted.
	if !SelKeyOrig
		RegDelete, %SelKey%
}
; go through the list of old registry keys
Loop, parse, SectionNamesOrig, `n
{
; again, skip ScaleFactors parent key
	if (A_LoopField = "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\ScaleFactors")
		Continue
; selecting key in the old registry
	SelKeyOrig := A_LoopField 
; clearing selected key in the current registry
	SelKey =
; going through current registry keys and seeing if any match selected key in old registry
	Loop, parse, SectionNames, `n
	{
		if (A_LoopField = SelKeyOrig)
		{
; if so, set selected key from current registry 
			SelKey := A_LoopField
; clear the ValueNum, which will correspond to a value for DpiValue if it exists in current registry
			ValueNum =
; current registry key section might have a value for DpiValue or none or (possibly, never seen) more than just DpiValue
			Loop
			{
				IniRead, NameNum, RegVal.ini, %SelKey%, Name%a_index%, %A_Space%
; loop breaks when no more names for values found
				if !NameNum
					break
; if the name is "DpiValue" then we want the corresponding value, ValueNum
				if (NameNum = "DpiValue")
					IniRead, ValueNum, RegVal.ini, %SelKey%, Value%a_index%
			}
			Break
		}
	}
; clear the ValueNumOrig, which will correspond to a value for DpiValue if it exists in old registry
	ValueNumOrig =
; go through old registry key section for a DpiValue, and if found set as ValueNumOrig
	Loop
	{
		IniRead, NameNumOrig, RegValOrig.ini, %SelKeyOrig%, Name%a_index%, %A_Space%
		if !NameNumOrig
			break
		if (NameNumOrig = "DpiValue")
			IniRead, ValueNumOrig, RegValOrig.ini, %SelKeyOrig%, Value%a_index%
	}
; if a value is found for DpiValue in old registry, then we add/change it in the new (creates key if needed)
	if ValueNumOrig
		RegWrite, REG_DWORD, %SelKeyOrig%, DpiValue, %ValueNumOrig%
; but if no old value is found, though there is a value in the new registry, then we delete just that value
	else if ValueNum
		RegDelete, %SelKey%, DpiValue
}
; reset displays to make the effects permanent
ResetDisplays(a_screenwidth,a_screenheight)
return




GradientColorBand(RGB,file)
{ 
	hex:="424D3A000000000000003600000028000000010000000100000001"
	. "0018000000000004000000130B0000130B"
	. "00000000000000000000" substr(RGB,5,2) substr(RGB,3,2) substr(RGB,1,2) "00"
	file := FileOpen(File,"rw" )
	Loop 58
	file.WriteUChar("0x" SubStr(hex,2*a_index-1,2))
	File.Close()
	Return 
}


GetMonitorIndexFromWindow(windowHandle, ByRef monitorIndex)
{
	; Starts with 1.
	monitorIndex := 1
	VarSetCapacity(monitorInfo, 40)
	NumPut(40, monitorInfo)
	if (monitorHandle := DllCall("MonitorFromWindow", "uint", windowHandle, "uint", 0x2)) && DllCall("GetMonitorInfo", "uint", monitorHandle, "uint", &monitorInfo) 
	{
		monitorLeft   := NumGet(monitorInfo,  4, "Int")
		monitorTop	:= NumGet(monitorInfo,  8, "Int")
		monitorRight  := NumGet(monitorInfo, 12, "Int")
		monitorBottom := NumGet(monitorInfo, 16, "Int")
		workLeft	  := NumGet(monitorInfo, 20, "Int")
		workTop	   := NumGet(monitorInfo, 24, "Int")
		workRight	 := NumGet(monitorInfo, 28, "Int")
		workBottom	:= NumGet(monitorInfo, 32, "Int")
		isPrimary	 := NumGet(monitorInfo, 36, "Int") & 1
		SysGet, monitorCount, MonitorCount
		Loop, %monitorCount%
		{
			SysGet, tempMon, Monitor, %A_Index%
			; Compare location to determine the monitor index.
			if ((monitorLeft = tempMonLeft) and (monitorTop = tempMonTop) and (monitorRight = tempMonRight) and (monitorBottom = tempMonBottom))
			{
				monitorIndex := A_Index
				break
			}
		}
	}
	return
}

GetRegVal()
{
	ValueNum := 1
	LastSubKey =
	Loop, Reg, HKEY_CURRENT_USER\Control Panel\Desktop\PerMonitorSettings, VR
	{
		if A_LoopRegSubKey = LastSubKey
			ValueNum++
		RegRead, Value
		IniWrite, %A_LoopRegName%, RegVal.ini, %A_LoopRegKey%\%A_LoopRegSubKey%, Name%ValueNum%
		IniWrite, %A_LoopRegType%, RegVal.ini, %A_LoopRegKey%\%A_LoopRegSubKey%, Type%ValueNum%
		IniWrite, %Value%, RegVal.ini, %A_LoopRegKey%\%A_LoopRegSubKey%, Value%ValueNum%
		LastSubKey := A_LoopRegSubKey
	}
	Loop, Reg, HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\ScaleFactors, K
	   IniWrite, %A_LoopRegName%, RegVal.ini, %A_LoopRegKey%\%A_LoopRegSubKey%, Key%A_index%
}

TestMonitors(MonitorCount,ByRef notfoundtotal)
{
	notfoundtotal := 0
	Loop, %MonitorCount%
	{
		WinActivate, monitortest%a_index%
		PixelSearch, , , 0, 0, 60, 60, 0xB6A76A, 0, Fast
		if errorlevel
			notfoundtotal++
	}
}


ResetDisplays(currentwidth,currentheight)
{
	; if dpi for primary is already 150%, changing res to what it thinks it is, will actually register as a shrink in res by 125%
	; e.g. if width is 1920, sys may think it is 1280, and if so, changing to 1280, will make sys think it is 1024
	; thus even though really it has reduced by 1.5 (1920/1280 = 1.5) it will register as 1.25 (1280/1024 = 1.25) and will need 1.5 x 1280 = 1920
	ChangeResolution(currentwidth, currentheight)
	if ((currentwidth/a_screenwidth) = 1.25)
	{
		newwidth := 1.5*currentwidth
		newheight := 1.5*currentheight
		ChangeResolution(newwidth, newheight)
	}
	else
	{
		if (currentwidth != 1280) and (currentheight != 720)
		{
			altwidth := 1280
			altheight := 720
		}
		else
		{
			altwidth := 800
			altheight := 600
		}
		ChangeResolution(altwidth, altheight)
		ChangeResolution(currentwidth, currentheight)
	}
	return
}

ChangeResolution(Screen_Width := 1920, Screen_Height := 1080, Color_Depth := 32)
{
	VarSetCapacity(Device_Mode,156,0)
	NumPut(156,Device_Mode,36) 
	DllCall( "EnumDisplaySettingsA", UInt,0, UInt,-1, UInt,&Device_Mode )
	NumPut(0x5c0000,Device_Mode,40) 
	NumPut(Color_Depth,Device_Mode,104)
	NumPut(Screen_Width,Device_Mode,108)
	NumPut(Screen_Height,Device_Mode,112)
	Return DllCall( "ChangeDisplaySettingsA", UInt,&Device_Mode, UInt,0 )
}
Return

; ------------------------------------------------------------
;
; Citation(s)
;
;   www.autohotkey.com  |  "determine if scaling is not 100% for monitor of a window, change PerMonitorSettings in registry, reflect change, verify - AutoHotkey Community"  |  https://www.autohotkey.com/boards/viewtopic.php?p=163428#p163428
;
; ------------------------------------------------------------