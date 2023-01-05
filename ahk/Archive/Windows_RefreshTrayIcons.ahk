Windows_RefreshTrayIcons()

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

; MsgBox, % "A_CoordModeToolTip : [" A_CoordModeToolTip "]" "`n" "A_CoordModePixel : [" A_CoordModePixel "]" "`n" "A_CoordModeMouse : [" A_CoordModeMouse "]" "`n" "A_CoordModeCaret : [" A_CoordModeCaret "]" "`n" "A_CoordModeMenu : [" A_CoordModeMenu "]" "`n"

MsgBox % "Point: [" Point "]" "`n" "x: [" x "]" "`n" "y: [" y "]" "`n" "xTray: [" xTray "]" "`n" "yTray: [" yTray "]" "`n" "wdTray: [" wdTray "]" "`n" "htTray: [" htTray "]" "`n" "Each_IconSize: [" Each_IconSize "]"

            ; PostMessage, % WM_MOUSEMOVE, 0, % Point, % Each_ControlName, % Each_Title
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