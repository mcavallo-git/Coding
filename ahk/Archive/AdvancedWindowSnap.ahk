/**
 * Advanced Window Snap
 * Snaps the active window to a position within a user-defined grid.
 *
 * @author Andrew Moore <andrew+github@awmoore.com>
 * @contributor jballi
 * @contributor park-brian
 * @contributor shinywong
 * @version 1.2
 */

/**
 * Resizes and moves the active window to a given position on a grid
 * @param {integer} numRows   The number of rows in the grid
 * @param {integer} numCols   The number of columns in the grid
 * @param {integer} row       The specific row within the grid to place the window
 * @param {integer} col       The specific column within the grid to place the window
 *
 * @example (Snap a window to the left third of the screen)
 * SnapActiveWindowGrid(1, 3, 1, 1);
 *
 * @example (Snap a window to the bottom half of the screen)
 * SnapActiveWindowGrid(2, 1, 2, 1);
 */
SnapActiveWindowGrid(numRows, numCols, row, col) {
    SnapActiveWindowGridSpan(numRows, numCols, row, col, 1, 1)
}

/**
 * Resizes and moves the active window to a given position on a grid, applying a rowSpan and colSpan
 * @param {integer} numRows   The number of rows in the grid
 * @param {integer} numCols   The number of columns in the grid
 * @param {integer} row       The specific row within the grid to place the window
 * @param {integer} col       The specific column within the grid to place the window
 * @param {integer} rowSpan   The specific row within the grid to place the window
 * @param {integer} colSpan   The specific column within the grid to place the window
 *
 * @example (Given a 4-column layout, snap a window to the rightmost column)
 * SnapActiveWindowGridSpan(1, 4, 1, 1, 1, 1);
 *
 * @example (Given a 4-column layout, snap a window to the centermost columns)
 * SnapActiveWindowGridSpan(1, 4, 1, 1, 1, 2);
 */
SnapActiveWindowGridSpan(numRows, numCols, row, col, rowSpan, colSpan) {

    WinGet activeWin, ID, A

    activeMon := GetMonitorIndexFromWindow(activeWin)

    SysGet, MonitorWorkArea, MonitorWorkArea, %activeMon%

    ; Determine the width and height of a grid cell
    height := (MonitorWorkAreaBottom - MonitorWorkAreaTop)/numRows
    width := (MonitorWorkAreaRight - MonitorWorkAreaLeft)/numCols

    ; Determine the x and y offsets
    posX  := MonitorWorkAreaLeft + (col - 1) * width
    posY  := MonitorWorkAreaTop + (row - 1) * height

    ; Apply rowSpan/colSpan after determining offsets
    width *= colSpan
    height *= rowSpan

    ; Use WinGetPosEx to determine position/size offsets (to remove gaps around windows)
    WinGetPosEx(activeWin, X, Y, realWidth, realHeight, offsetX, offsetY)

    ; Move and resize the active window
    WinMove, A,, (posX + offsetX), (posY + offsetY), (width + offsetX * -2), (height + (offsetY - 2) * -2)
}

/**
 * GetMonitorIndexFromWindow retrieves the HWND (unique ID) of a given window.
 * @param {Uint} windowHandle
 * @author shinywong
 * @link http://www.autohotkey.com/board/topic/69464-how-to-determine-a-window-is-in-which-monitor/?p=440355
 */
GetMonitorIndexFromWindow(windowHandle) {
    ; Starts with 1.
    monitorIndex := 1

    VarSetCapacity(monitorInfo, 40)
    NumPut(40, monitorInfo)

    if (monitorHandle := DllCall("MonitorFromWindow", "uint", windowHandle, "uint", 0x2))
        && DllCall("GetMonitorInfo", "uint", monitorHandle, "uint", &monitorInfo) {
        monitorLeft   := NumGet(monitorInfo,  4, "Int")
        monitorTop    := NumGet(monitorInfo,  8, "Int")
        monitorRight  := NumGet(monitorInfo, 12, "Int")
        monitorBottom := NumGet(monitorInfo, 16, "Int")
        workLeft      := NumGet(monitorInfo, 20, "Int")
        workTop       := NumGet(monitorInfo, 24, "Int")
        workRight     := NumGet(monitorInfo, 28, "Int")
        workBottom    := NumGet(monitorInfo, 32, "Int")
        isPrimary     := NumGet(monitorInfo, 36, "Int") & 1

        SysGet, monitorCount, MonitorCount

        Loop, %monitorCount% {
            SysGet, tempMon, Monitor, %A_Index%

            ; Compare location to determine the monitor index.
            if ((monitorLeft = tempMonLeft) and (monitorTop = tempMonTop)
                and (monitorRight = tempMonRight) and (monitorBottom = tempMonBottom)) {
                monitorIndex := A_Index
                break
            }
        }
    }

    return %monitorIndex%
}

;------------------------------
;
; Function: WinGetPosEx
;
; Description:
;
;   Gets the position, size, and offset of a window. See the *Remarks* section
;   for more information.
;
; Parameters:
;
;   hWindow - Handle to the window.
;
;   X, Y, Width, Height - Output variables. [Optional] If defined, these
;       variables contain the coordinates of the window relative to the
;       upper-left corner of the screen (X and Y), and the Width and Height of
;       the window.
;
;   Offset_X, Offset_Y - Output variables. [Optional] Offset, in pixels, of the
;       actual position of the window versus the position of the window as
;       reported by GetWindowRect.  If moving the window to specific
;       coordinates, add these offset values to the appropriate coordinate
;       (X and/or Y) to reflect the true size of the window.
;
; Returns:
;
;   If successful, the address of a RECTPlus structure is returned.  The first
;   16 bytes contains a RECT structure that contains the dimensions of the
;   bounding rectangle of the specified window.  The dimensions are given in
;   screen coordinates that are relative to the upper-left corner of the screen.
;   The next 8 bytes contain the X and Y offsets (4-byte integer for X and
;   4-byte integer for Y).
;
;   Also if successful (and if defined), the output variables (X, Y, Width,
;   Height, Offset_X, and Offset_Y) are updated.  See the *Parameters* section
;   for more more information.
;
;   If not successful, FALSE is returned.
;
; Requirement:
;
;   Windows 2000+
;
; Remarks, Observations, and Changes:
;
; * Starting with Windows Vista, Microsoft includes the Desktop Window Manager
;   (DWM) along with Aero-based themes that use DWM.  Aero themes provide new
;   features like a translucent glass design with subtle window animations.
;   Unfortunately, the DWM doesn't always conform to the OS rules for size and
;   positioning of windows.  If using an Aero theme, many of the windows are
;   actually larger than reported by Windows when using standard commands (Ex:
;   WinGetPos, GetWindowRect, etc.) and because of that, are not positioned
;   correctly when using standard commands (Ex: gui Show, WinMove, etc.).  This
;   function was created to 1) identify the true position and size of all
;   windows regardless of the window attributes, desktop theme, or version of
;   Windows and to 2) identify the appropriate offset that is needed to position
;   the window if the window is a different size than reported.
;
; * The true size, position, and offset of a window cannot be determined until
;   the window has been rendered.  See the example script for an example of how
;   to use this function to position a new window.
;
; * 20150906: The "dwmapi\DwmGetWindowAttribute" function can return odd errors
;   if DWM is not enabled.  One error I've discovered is a return code of
;   0x80070006 with a last error code of 6, i.e. ERROR_INVALID_HANDLE or "The
;   handle is invalid."  To keep the function operational during this types of
;   conditions, the function has been modified to assume that all unexpected
;   return codes mean that DWM is not available and continue to process without
;   it.  When DWM is a possibility (i.e. Vista+), a developer-friendly messsage
;   will be dumped to the debugger when these errors occur.
;
; Credit:
;
;   Idea and some code from *KaFu* (AutoIt forum)
;
; Author:
;
;    jballi
;
; Forum Link:
;
;    https://autohotkey.com/boards/viewtopic.php?t=3392
;-------------------------------------------------------------------------------
WinGetPosEx(hWindow,ByRef X="",ByRef Y="",ByRef Width="",ByRef Height="",ByRef Offset_X="",ByRef Offset_Y="") {
    Static Dummy5693
          ,RECTPlus
          ,S_OK:=0x0
          ,DWMWA_EXTENDED_FRAME_BOUNDS:=9

    ;-- Workaround for AutoHotkey Basic
    PtrType:=(A_PtrSize=8) ? "Ptr":"UInt"

    ;-- Get the window's dimensions
    ;   Note: Only the first 16 bytes of the RECTPlus structure are used by the
    ;   DwmGetWindowAttribute and GetWindowRect functions.
    VarSetCapacity(RECTPlus,24,0)
    DWMRC:=DllCall("dwmapi\DwmGetWindowAttribute"
        ,PtrType,hWindow                                ;-- hwnd
        ,"UInt",DWMWA_EXTENDED_FRAME_BOUNDS             ;-- dwAttribute
        ,PtrType,&RECTPlus                              ;-- pvAttribute
        ,"UInt",16)                                     ;-- cbAttribute

    if (DWMRC<>S_OK)
        {
        if ErrorLevel in -3,-4  ;-- Dll or function not found (older than Vista)
            {
            ;-- Do nothing else (for now)
            }
         else
            outputdebug,
               (ltrim join`s
                Function: %A_ThisFunc% -
                Unknown error calling "dwmapi\DwmGetWindowAttribute".
                RC=%DWMRC%,
                ErrorLevel=%ErrorLevel%,
                A_LastError=%A_LastError%.
                "GetWindowRect" used instead.
               )

        ;-- Collect the position and size from "GetWindowRect"
        DllCall("GetWindowRect",PtrType,hWindow,PtrType,&RECTPlus)
        }

    ;-- Populate the output variables
    X:=Left :=NumGet(RECTPlus,0,"Int")
    Y:=Top  :=NumGet(RECTPlus,4,"Int")
    Right   :=NumGet(RECTPlus,8,"Int")
    Bottom  :=NumGet(RECTPlus,12,"Int")
    Width   :=Right-Left
    Height  :=Bottom-Top
    OffSet_X:=0
    OffSet_Y:=0

    ;-- If DWM is not used (older than Vista or DWM not enabled), we're done
    if (DWMRC<>S_OK)
        Return &RECTPlus

    ;-- Collect dimensions via GetWindowRect
    VarSetCapacity(RECT,16,0)
    DllCall("GetWindowRect",PtrType,hWindow,PtrType,&RECT)
    GWR_Width :=NumGet(RECT,8,"Int")-NumGet(RECT,0,"Int")
        ;-- Right minus Left
    GWR_Height:=NumGet(RECT,12,"Int")-NumGet(RECT,4,"Int")
        ;-- Bottom minus Top

    ;-- Calculate offsets and update output variables
    NumPut(Offset_X:=(Width-GWR_Width)//2,RECTPlus,16,"Int")
    NumPut(Offset_Y:=(Height-GWR_Height)//2,RECTPlus,20,"Int")
    Return &RECTPlus
}

; Directional Arrow Hotkeys

; Snap to top half of screen (Win + Alt + Arrows)
; 2 rows, 1 column, first row, first column
#!Up::SnapActiveWindowGrid(2, 1, 1, 1)

; Snap to bottom half of screen
; 2 rows, 1 columns, second row, first column
#!Down::SnapActiveWindowGrid(2, 1, 2, 1)

; Snap to top third of screen (Ctrl + Win + Alt + Arrows)
; 3 rows, 1 column, first row, first column
^#!Up::SnapActiveWindowGrid(3, 1, 1, 1)

; Snap to bottom third of screen
; 3 rows, 1 column, third row, first column
^#!Down::SnapActiveWindowGrid(3, 1, 3, 1)


; Numberpad Hotkeys

; Snap to left fourth of screen (Win + Alt + Numpad)
; 1 row, 4 columns, first row, first column, rowspan 1, colspan 1
#!Numpad4::SnapActiveWindowGrid(1, 4, 1, 1)

; Snap to center half of screen
; 1 row, 4 columns, first row, second column, rowspan 1, colspan 2
#!Numpad5::SnapActiveWindowGridSpan(1, 4, 1, 2, 1, 2)

; Snap to right fourth of screen
; 1 row, 4 columns, first row, fourth column
#!Numpad6::SnapActiveWindowGrid(1, 4, 1, 4)


; Snap to upper third of screen (Win + Alt + Numpad)
; 3 rows, 1 column, first row, first column
^#Numpad8::SnapActiveWindowGrid(3, 1, 1, 1)

; Snap to middle third of screen
; 3 rows, 1 column, second row, first column
^#Numpad5::SnapActiveWindowGrid(3, 1, 2, 1)

; Snap to bottom third of screen
; 3 rows, 1 column, third row, first column
^#Numpad2::SnapActiveWindowGrid(3, 1, 3, 1)


; Snap to top left third of screen (Ctrl + Win + Alt + Numpad)
^#!Numpad7::SnapActiveWindowGrid(3, 3, 1, 1)

; Snap to top middle third of screen
^#!Numpad8::SnapActiveWindowGrid(3, 3, 1, 2)

; Snap to top right third of screen
^#!Numpad9::SnapActiveWindowGrid(3, 3, 1, 3)

; Snap to center left third of screen
^#!Numpad4::SnapActiveWindowGrid(3, 3, 2, 1)

; Snap to center third of screen
^#!Numpad5::SnapActiveWindowGrid(3, 3, 2, 2)

; Snap to center right third of screen
^#!Numpad6::SnapActiveWindowGrid(3, 3, 2, 3)

; Snap to bottom left third of screen
^#!Numpad1::SnapActiveWindowGrid(3, 3, 3, 1)

; Snap to bottom middle third of screen
^#!Numpad2::SnapActiveWindowGrid(3, 3, 3, 2)

; Snap to bottom  right third of screen
^#!Numpad3::SnapActiveWindowGrid(3, 3, 3, 3)


; ------------------------------------------------------------
;
; Citation(s)
;
;   gist.github.com |  "Advanced Window Snap is a script for AutoHotKey that expands upon Windows built-in window-snapping hotkeys. · GitHub"  |  https://gist.github.com/park-brian/f3f790e559e5145b99bf0f19c7928dd8
;
; ------------------------------------------------------------