Windows_RefreshTrayIcons()

; ------------------------------
; Call from PowerShell via:
;
;   Start-Process -Filepath ((Get-Content env:\\ProgramFiles)+(write \AutoHotkey\AutoHotkey.exe)) -ArgumentList ((Get-Content env:\\USERPROFILE)+(write \Documents\GitHub\Coding\ahk\Archive\Windows_RefreshTrayIcons.ahk)) -NoNewWindow;
;
; ------------------------------
;
; Windows_RefreshTrayIcons
;   |--> Removes any 'dead' tray icons from the notification area / system tray
;   |--> Citation:  https://www.autohotkey.com/boards/viewtopic.php?p=156072#p156072
;
Windows_RefreshTrayIcons() {
  WM_MOUSEMOVE := 0x0200  ; https://www.autohotkey.com/docs/v1/misc/SendMessageList.htm
  RB_DetectHiddenWindows := A_DetectHiddenWindows
  DetectHiddenWindows, On
  For Each_Id, Each_Title in ["ahk_class Shell_TrayWnd","ahk_class NotifyIconOverflowWindow"] {
    For Each_Id, Each_ControlName in ["ToolbarWindow321", "ToolbarWindow322", "ToolbarWindow323", "ToolbarWindow324"] {
      For Each_Id, Each_IconSize in [24,32] {
        ControlGetPos, xTray, yTray, wdTray, htTray, % Each_ControlName, % Each_Title
        y := htTray - 10
        While (y > 0) {
          x := wdTray - Each_IconSize/2
          While (x > 0) {
            Point := (y << 16) + x
            PostMessage, % WM_MOUSEMOVE, 0, % Point, % Each_ControlName, % Each_Title
            x -= Each_IconSize/2
          }
          y -= Each_IconSize/2
        }
      }
    }
  }
  DetectHiddenWindows, %RB_DetectHiddenWindows%
}

; ------------------------------------------------------------