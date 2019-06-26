
;    VIRTUAL DESKTOP SWITCHER
;    Template props go out to: https://autohotkey.com/board/topic/148794-bind-keys-to-switch-virtual-desktops-win-10/

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.

; #Warn  ; Enable warnings to assist with detecting common errors.

SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.

SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


; GO LEFT ONE VIRTUAL DESKTOP
<#1:: sendevent {LCtrl down}{LWin down}{Left down}{Sleep 1}{Left up}{LWin up}{LCtrl up}{Sleep 10}{LCtrl up}{LWin up}{Sleep 10}{LCtrl up}{LWin up} ; Sleep 10 is because the LCTRL and LWIN like to get stuck 'down' sometimes while cpu is handling switching between virtual desktops

; GO RIGHT ONE VIRTUAL DESKTOP
<#2:: sendevent {LCtrl down}{LWin down}{Right down}{Sleep 1}{Right up}{LWin up}{LCtrl up}{Sleep 10}{LCtrl up}{LWin up}{Sleep 10}{LCtrl up}{LWin up} ; Sleep 10 is because the LCTRL and LWIN like to get stuck 'down' sometimes while cpu is handling switching between virtual desktops

; CREATE NEW VIRTUAL DESKTOP
<#F1:: sendevent {LCtrl down}{LWin down}{d down}{Sleep 1}{d up}{LWin up}{LCtrl up}{Sleep 10}{LCtrl up}{LWin up}{Sleep 10}{LCtrl up}{LWin up} ; Sleep 10 is because the LCTRL and LWIN like to get stuck 'down' sometimes while cpu is handling switching between virtual desktops

; KILL CURRENT VIRTUAL DESKTOP
<#escape:: sendevent {LCtrl down}{LWin down}{F4 down}{Sleep 1}{F4 up}{LWin up}{LCtrl up}{Sleep 10}{LCtrl up}{LWin up}{Sleep 10}{LCtrl up}{LWin up} ; Sleep 10 is because the LCTRL and LWIN like to get stuck 'down' sometimes while cpu is handling switching between virtual desktops
