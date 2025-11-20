; ------------------------------
;
;   WINDOW:  [ Xbox Console Companion ]
;   STATUS:  [ ACTIVE ]
;
#HotIf WinActive("Xbox Console Companion")
  ;
  ;   HOTKEY:  WinKey + F5  (while [ Xbox Console Companion ] is active)
  ;   ACTION:  Xbox - Download & delete game clips & screenshots
  ;
  #F5::
  {
    Xbox_ExportCaptures()
    Return
  }
#HotIf


; ------------------------------
;
; Xbox_ExportCaptures
;   |--> Win10 download & delete Game Clips / Screenshots via "Xbox Console Companion" Win10 App
;
Xbox_ExportCaptures() {
  global DebugMode
  CoordMode "Mouse", "Screen"
  SetControlDelay -1
  SetDefaultMouseSpeed 0
  SetKeyDelay 0, -1
  SetTitleMatchMode 2  ; Title must [ CONTAIN ] the given WinTitle
  AwaitModifierKeyup()  ; Wait until all modifier keys are released
  ; ------------------------------
  ;
  ; Runtime Options
  ;

  MaxFilesToDownload := 0  ; 0 = Unlimited
  ; MaxFilesToDownload := 2

  Download_GameClips := 0
  Download_Screenshots := 0

  ; ------------------------------

  ; Download Game clips?
  A_MsgBoxResult := MsgBox("Download Game Clips?", A_ScriptName " - " A_ThisFunc,3)
  If (A_MsgBoxResult = "Yes") {
    Download_GameClips := 1
  }

  ; Download Screenshots ?
  If (A_MsgBoxResult != "Cancel") {
    A_MsgBoxResult := MsgBox("Download Screenshots?", A_ScriptName " - " A_ThisFunc,3)
    If (A_MsgBoxResult = "Yes") {
      Download_Screenshots := 1
    }
  }

  ; ------------------------------

  If ((Download_GameClips != 0) || (Download_Screenshots != 0)) {

    WinTitle := "Xbox Console Companion"

    ; Win_ahk_id := WinGetID("A")
    Win_ahk_id := WinGetID(WinTitle)
    Win_hwnd := ("ahk_id " Win_ahk_id)

    WinTitle := WinGetTitle(Win_hwnd)
    Win_ahk_class := WinGetClass(Win_hwnd)
    Win_ahk_exe := WinGetProcessName(Win_hwnd)
    Win_ahk_pid := WinGetPID(Win_hwnd)
    Win_size_state := WinGet_SizeState(Win_hwnd)

    ; Win10_ahk_id := WinGet_ahk_id(WinTitle)
    Win10_ahk_id := WinGet_ahk_id(Win_hwnd)
    Win10_title := WinGetTitle("ahk_id " Win10_ahk_id)
    Win10_ahk_class := WinGetClass("ahk_id " Win10_ahk_id)
    Win10_ahk_pid := WinGetPID("ahk_id " Win10_ahk_id)
    Win10_ahk_exe := WinGetProcessName("ahk_id " Win10_ahk_id)

    Win_MinMaxState := WinGetMinMax(Win_hwnd)
    Tooltip_Header := A_ThisFunc "`n" "----------"
    TickCount_RuntimeStart := A_TickCount

    Count_FilesProcessed := 0

    Color_Buffering_GameClips := "0x2E2E2E"
    Color_Buffering_Screenshots := "0x171717"
    Color_DL_Button_NotDownloading := "0x171717"
    Color_DL_Button_Downloading := "0x595758"
    Color_Loaded_CapturesPage := "0xFFFFFF"
    Color_Loaded_OnXboxLiveTab := "0xFFFFFF"

    Loop 2 {

      If (A_Index == 1) {
        Download_MediaType := "Game clips"   ;  Download "Game clips"
      } Else {
        Download_MediaType := "Screenshots"  ;  Download "Screenshots"
      }

      If ((Download_MediaType == "Game clips") && (Download_GameClips == 0)) {
        ;
        ; If option "Download_GameClips" is disabled (set to 0), skip downloading/deleting Xbox Live Game clips
        ;
        Continue
      } Else If ((Download_MediaType == "Screenshots") && (Download_Screenshots == 0)) {
        ;
        ; If option "Download_Screenshots" is disabled (set to 0), skip downloading/deleting Xbox Live Screenshots
        ;
        Continue
      } Else {
        Tooltip_StartupJobs := Tooltip_Header
        If (Download_MediaType == "Game clips") {
          WaitDuration_MediaType := 1.5
        } Else {
          WaitDuration_MediaType := 1.0
        }
        Loop 4 {
          Tooltip_NewStats := ""
          If (A_Index == 1) {
            ; ------------------------------
            ;
            ; Resizing 'Xbox Console Companion' Window
            ;
            Tooltip_NewStats := ( "Prepping Xbox window..." )
            ToolTip ( Tooltip_StartupJobs "`n" Tooltip_NewStats ), 1, 1
            WinActivate(Win_hwnd)
            Sleep 500
            If (Win_size_state != "restored") {
              WinActivate(Win_hwnd)
              WinRestore(Win_hwnd)
              Sleep 1000
            }
            WinActivate(Win_hwnd)
            ;
            ; Move the window to specified x/y position and resize it to have specified width/height
            ;
            WinMove(-7,0,1280,800,WinTitle)
            Sleep 500
            Tooltip_StartupJobs := ( Tooltip_StartupJobs "`n" Tooltip_NewStats "  Done" )
            Sleep 500
          } Else If (A_Index == 2) {
            ; ------------------------------
            ;
            ; Loading 'Captures' tab ...
            ;
            TickCount_LoadCaptures := A_TickCount
            WinActivate(Win_hwnd)
            MouseClick "Left", 23, 314  ; Load 'Captures' tab (left-panel)
            Sleep 500
            Loop {
              Sleep 100
              WaitDuration_Seconds := Round(((A_TickCount-TickCount_LoadCaptures)/1000), 1)
              Tooltip_NewStats := ( "Loading 'Captures' (tab): " WaitDuration_Seconds "s ..." )
              ToolTip ( Tooltip_StartupJobs "`n" Tooltip_NewStats ), 1, 1
              If ( WaitDuration_Seconds > 0.5 ) {  ; Wait a minimum short-duration per download
                WinActivate(Win_hwnd)
                ;
                ; Check the color of each pixel in a 2-D horizontal line which passes over the "On This PC" and "On Xbox Live" tab name texts
                ;   |--> Keep checking until a white color (0xFFFFFF) is found somewhere along said coordinate line (which denotes the page has loaded)
                ;
                If (PixelSearch(&Px, &Py, 61, 140, 280, 140, Color_Loaded_CapturesPage, 0)) {
                  Tooltip_StartupJobs := ( Tooltip_StartupJobs "`n" Tooltip_NewStats "  Done" )
                  ToolTip ( Tooltip_StartupJobs ), 1, 1
                  Sleep 500
                  Break
                } Else {
                  Continue
                }
              }
            }
          } Else If (A_Index == 3) {
            ; ------------------------------
            ;
            ; Loading 'On Xbox Live' (tab)...
            ;
            TickCount_LoadXboxLive := A_TickCount
            WinActivate(Win_hwnd)
            MouseClick "Left", 220, 138  ; Load 'On Xbox Live' tab (top-option within 'Captures')
            Sleep 500
            Loop {
              Sleep 100
              WaitDuration_Seconds := Round(((A_TickCount-TickCount_LoadXboxLive)/1000), 1)
              Tooltip_NewStats := ( "Loading 'On Xbox Live' (tab): " WaitDuration_Seconds "s ..." )
              ToolTip ( Tooltip_StartupJobs "`n" Tooltip_NewStats ), 1, 1
              If ( WaitDuration_Seconds > 0.5 ) {  ; Wait a minimum short-duration per download
                ;
                ; Check the color of each pixel in a 2-D horizontal line which passes over the "By date" and "Everything" dropdown texts
                ;   |--> Keep checking until a white color (0xFFFFFF) is found somewhere along said coordinate line (which denotes the tab has loaded)
                ;
                WinActivate(Win_hwnd)
                If ( (PixelSearch(&Px, &Py, 61, 180, 280, 180, Color_Loaded_OnXboxLiveTab, 0)) || (WaitDuration_Seconds > 20) ) {
                  Tooltip_StartupJobs := ( Tooltip_StartupJobs "`n" Tooltip_NewStats "  Done" )
                  ToolTip ( Tooltip_StartupJobs ), 1, 1
                  Sleep 500
                  Break
                } Else {
                  Continue
                }
              }
            }
          } Else If (A_Index == 4) {
            If (Download_MediaType == "Game clips") {
              ; ------------------------------
              ;
              ; Loading 'Game clips' (filter)...
              ;
              Tooltip_NewStats := ( "Showing 'Game clips' (filter) ..." )
              ToolTip ( Tooltip_StartupJobs "`n" Tooltip_NewStats ), 1, 1
              WinActivate(Win_hwnd)
              MouseClick "Left", 221, 181  ; Show 'Game clips', only - (under the "Everything v" dropdown/filter - second option from the top)
              Sleep 500
              WinActivate(Win_hwnd)
              Send "{Up}"
              Sleep 250
              WinActivate(Win_hwnd)
              Send "{Up}"
              Sleep 250
              WinActivate(Win_hwnd)
              Send "{Down}"
              Sleep 250
              WinActivate(Win_hwnd)
              Send "{Enter}"
              Tooltip_StartupJobs := ( Tooltip_StartupJobs "`n" Tooltip_NewStats "  Done" )
              ToolTip ( Tooltip_StartupJobs ), 1, 1
              Sleep 1000
            } Else {
              ; ------------------------------
              ;
              ; Loading 'Screenshots' (filter)...
              ;
              Tooltip_NewStats := ( "Showing 'Screenshots' (filter) ..." )
              ToolTip ( Tooltip_StartupJobs "`n" Tooltip_NewStats ), 1, 1
              WinActivate(Win_hwnd)
              MouseClick "Left", 221, 181  ; Show 'Screeshots', only - (under the "Everything v" dropdown/filter - bottom option)
              Sleep 500
              WinActivate(Win_hwnd)
              Send "{Down}"
              Sleep 250
              WinActivate(Win_hwnd)
              Send "{Down}"
              Sleep 250
              WinActivate(Win_hwnd)
              Send "{Enter}"
              Tooltip_StartupJobs := ( Tooltip_StartupJobs "`n" Tooltip_NewStats "  Done" )
              ToolTip ( Tooltip_StartupJobs ), 1, 1
              Sleep 1000
            }
          }
        }
        Loop {
          Tooltip_EachFile_Stats := Tooltip_Header
          Tooltip_EachFile_Stats := Tooltip_EachFile_Stats "`n" "Net " Download_MediaType " processed: " Count_FilesProcessed
          Total_RuntimeDuration_Seconds := Round(((A_TickCount-TickCount_RuntimeStart)/1000), 1)
          Tooltip_EachFile_Stats := Tooltip_EachFile_Stats "`n" "Net Runtime Duration: " Total_RuntimeDuration_Seconds "s"
          MediaFile_Iteration := A_Index
          TickCount_FileExists := A_TickCount
          NextDownloadExists_Passed := 0
          Buffer_Passed := 0
          Download_Passed := 0
          ; ------------------------------
          ;
          ; Processing File #x / y
          ;
          If (MaxFilesToDownload > 0) {
            ;
            ; If option "MaxFilesToDownload" is set no a non-zero value, use its value as the maximum number of files to be downloaded
            ;
            Tooltip_EachFile_Stats := Tooltip_EachFile_Stats "`n" "Processing File # " MediaFile_Iteration "/" MaxFilesToDownload ":"
            If (MediaFile_Iteration >= MaxFilesToDownload) {
              Break
            }
          } Else {
            Tooltip_EachFile_Stats := Tooltip_EachFile_Stats "`n" "Processing File # " MediaFile_Iteration ":"
          }
          ; ------------------------------
          ;
          ; File-check duration ...
          ;
          Loop {
            Sleep 100
            WaitDuration_Seconds := Round(((A_TickCount-TickCount_FileExists)/1000), 1)
            Tooltip_NewStats := ( "File-check duration: " WaitDuration_Seconds "s ..." )
            ToolTip ( Tooltip_EachFile_Stats "`n" Tooltip_NewStats ), 1, 1
            If ( WaitDuration_Seconds > WaitDuration_MediaType ) {  ; Wait a minimum short-duration per download
              WinActivate(Win_hwnd)
              ;
              ; Check the color of each pixel in a 2-D horizontal line which passes over the top Game clip / Screenshot's filename text
              ;   |--> Keep checking until a white color (0xFFFFFF) is found somewhere along said coordinate line (which denotes the file line item has become selectable)
              ;
              If ( PixelSearch(&Px, &Py, 165, 280, 355, 280, 0xFFFFFF, 43) ) {
                NextDownloadExists_Passed := 1
                Tooltip_EachFile_Stats := ( Tooltip_EachFile_Stats "`n" Tooltip_NewStats "  Done" )
                ToolTip ( Tooltip_EachFile_Stats ), 1, 1
                Break
              } Else {
                If (WaitDuration_Seconds > 10) {
                  ;
                  ; Top row-item (filename) not found - Assume no more files exist
                  ;
                  NextDownloadExists_Passed := 0
                  Tooltip_EachFile_Stats := ( Tooltip_EachFile_Stats "`n" Tooltip_NewStats "  Not found" )
                  ToolTip ( Tooltip_EachFile_Stats ), 1, 1
                  Break
                } Else {
                  Continue
                }
              }
            }
          }
          ; ------------------------------
          ;
          ; Buffering...
          ;
          If ( NextDownloadExists_Passed == 1 ) {
            TickCount_StartBuffer := A_TickCount
            Loop {
              Sleep 100
              WaitDuration_Seconds := Round(((A_TickCount-TickCount_StartBuffer)/1000), 1)
              Tooltip_NewStats := ( "Buffer duration: " WaitDuration_Seconds "s ..." )
              ToolTip ( Tooltip_EachFile_Stats "`n" Tooltip_NewStats ), 1, 1
              If ( WaitDuration_Seconds > WaitDuration_MediaType ) {  ; Wait a minimum short-duration per download
                ; Check the thumbnail's 4 corners to see if they all match the gray buffering (loading) overlay's color
                WinActivate(Win_hwnd)
                Color_Thumbnail_BotLeft := PixelGetColor(425, 470)
                Color_Thumbnail_TopLeft := PixelGetColor(425, 215)
                Color_Thumbnail_TopRight := PixelGetColor(900, 215)
                Color_Thumbnail_BotRight := PixelGetColor(900, 470)
                If ((Color_Thumbnail_BotLeft == Color_Buffering_GameClips) && (Color_Thumbnail_TopLeft == Color_Buffering_GameClips) && (Color_Thumbnail_TopRight == Color_Buffering_GameClips) && (Color_Thumbnail_BotRight == Color_Buffering_GameClips)) {
                  Continue  ; Still Buffering (Game clip)
                } Else If ((Color_Thumbnail_BotLeft == Color_Buffering_Screenshots) && (Color_Thumbnail_TopLeft == Color_Buffering_Screenshots) && (Color_Thumbnail_TopRight == Color_Buffering_Screenshots) && (Color_Thumbnail_BotRight == Color_Buffering_Screenshots)) {
                  Continue  ; Still Buffering (Screenshot)
                } Else {
                  Buffer_Passed := 1
                  Tooltip_EachFile_Stats := ( Tooltip_EachFile_Stats "`n" Tooltip_NewStats "  Done" )
                  ToolTip ( Tooltip_EachFile_Stats ), 1, 1
                  Sleep 1000
                  Break
                }
              }
            }
            ; ------------------------------
            ;
            ; Downloading...
            ;
            TickCount_StartDownload := A_TickCount
            DownloadBtn_XPos_LeftInterior := 418  ; Same xpos for [ Game clips ] & [ Screenshots ]
            DownloadBtn_XPos_Center := 542  ; Same xpos for [ Game clips ] & [ Screenshots ]
            If (Download_MediaType == "Game clips") {
              DownloadBtn_YPos_Center := 772  ; Game clips
            } Else {
              DownloadBtn_YPos_Center := 730  ; Screenshots
            }
            Loop {
              If (A_Index == 1) {
                WinActivate(Win_hwnd)
                MouseClick "Left", DownloadBtn_XPos_Center, DownloadBtn_YPos_Center  ; Click "Download" on currently-selected  file
              }
              Sleep 100
              WaitDuration_Seconds := Round(((A_TickCount-TickCount_StartDownload)/1000), 1)
              Tooltip_NewStats := ( "Download duration: " WaitDuration_Seconds "s ..." )
              ToolTip ( Tooltip_EachFile_Stats "`n" Tooltip_NewStats ), 1, 1
              If ( WaitDuration_Seconds > WaitDuration_MediaType ) {  ; Wait a minimum short-duration per download
                MouseMove 0, 0
                ; Check the leftmost side of the "Download" button to see if it is still downloading the current file (it turns a lighter gray, 0x595758, while downloading, compared to its base of 0x171717)
                WinActivate(Win_hwnd)
                Color_DL_Button_LeftSide := PixelGetColor(DownloadBtn_XPos_LeftInterior, DownloadBtn_YPos_Center)
                If (Color_DL_Button_LeftSide == Color_DL_Button_NotDownloading) {
                  Download_Passed := 1
                  Tooltip_EachFile_Stats := ( Tooltip_EachFile_Stats "`n" Tooltip_NewStats "  Done" )
                  ToolTip ( Tooltip_EachFile_Stats ), 1, 1
                  Sleep 1500
                  Break
                }
              }
            }
          }
          ; ------------------------------
          ;
          ; Deleting...
          ;
          If ((NextDownloadExists_Passed == 1) && (Buffer_Passed == 1) && (Download_Passed == 1)) {
            DeleteBtn_XPos_TrashCan := 853  ; Same xpos for [ Game clips ] & [ Screenshots ]
            If (Download_MediaType == "Game clips") {
              DeleteBtn_YPos_Center := 731  ; Game clips
            } Else {
              DeleteBtn_YPos_Center := 618  ; Screenshots
            }
            Tooltip_NewStats := "Deleting ..."
            ToolTip ( Tooltip_EachFile_Stats "`n" Tooltip_NewStats ), 1, 1
            WinActivate(Win_hwnd)
            MouseClick "Left", DeleteBtn_XPos_TrashCan, DeleteBtn_YPos_Center  ; Click "Delete" once download has finished
            Sleep 1000
            Tooltip_NewStats := Tooltip_NewStats " Confirming ..."
            ToolTip ( Tooltip_EachFile_Stats "`n" Tooltip_NewStats ), 1, 1
            WinActivate(Win_hwnd)
            MouseClick "Left", 519, 449  ; Confirm file-deletion (via "OK" button on popup)
            Sleep 500
            Tooltip_EachFile_Stats := ( Tooltip_EachFile_Stats "`n" Tooltip_NewStats "  Done" )
            ToolTip ( Tooltip_EachFile_Stats ), 1, 1
            Sleep 1500
            Count_FilesProcessed := Count_FilesProcessed + 1
          } Else {
            Tooltip_NewStats := "Info:  "
            If (NextDownloadExists_Passed != 1) {
              Tooltip_NewStats := Tooltip_NewStats "`n" "All " Download_MediaType " have been downloaded"
            } Else {
              If (Buffer_Passed != 1) {
                Tooltip_NewStats := Tooltip_NewStats "`n" "Error:  Buffering unable to complete"
              }
              If (Download_Passed != 1) {
                Tooltip_NewStats := Tooltip_NewStats "`n" "Error:  Download unable to complete"
              }
            }
            Tooltip_EachFile_Stats := ( Tooltip_EachFile_Stats "`n" Tooltip_NewStats )
            ToolTip ( Tooltip_EachFile_Stats ), 1, 1
            Sleep 2500
            Break
          }
        }
        ; ------------------------------
        ;
        ; Net Files Processed  &&  Net Runtime Duration
        ;
        Tooltip_Closer_Stats := Tooltip_Header
        Tooltip_Closer_Stats := Tooltip_EachFile_Stats "`n" "Net Files Processed: " Count_FilesProcessed
        Total_RuntimeDuration_Seconds := Round(((A_TickCount-TickCount_RuntimeStart)/1000), 1)
        Tooltip_Closer_Stats := Tooltip_EachFile_Stats "`n" "Net Runtime Duration: " Total_RuntimeDuration_Seconds "s"
        ToolTip ( Tooltip_Closer_Stats ), 1, 1
        Sleep 2000
      }
    }
    ; ------------------------------
    ;
    ; Count & timestamp files in the output directory then show the output directory  -  https://www.autohotkey.com/docs/v2/lib/LoopFiles.htm
    ;
    Count_FilesInOutputDir := 0
    Fullpath_Output_XboxCaptures := ( EnvGet("USERPROFILE") "\Videos\Captures" )
    Loop Files (Fullpath_Output_XboxCaptures "\*")
    {
      ; Exclude files matching a given regex pattern - https://www.autohotkey.com/docs/v2/lib/RegExMatch.htm
      RegexPattern_Exclude := "(.*).(ini|lnk)$"
      If (!RegExMatch(A_LoopFileFullPath, RegexPattern_Exclude)) {
        Count_FilesInOutputDir++
      }
    }
    ; Even if no files were processed, check to see if there are any files to rename
    If ((Count_FilesProcessed > 0) || (Count_FilesInOutputDir > 0)) {
      ; Run the timestamping script (renames files to their basename plus their metadata created-on date)
      Tooltip_Closer_Stats := Tooltip_Closer_Stats "`n" "Count_FilesInOutputDir = [ " Count_FilesInOutputDir " ]"
      Tooltip_Closer_Stats := Tooltip_Closer_Stats "`n" "Running metadata-timestamper script..."
      ToolTip ( Tooltip_Closer_Stats ), 1, 1
      Run("wsl.exe /bin/bash -c 'sync_cloud_infrastructure; bulk_rename_based_on_media_creation_date --dry-run 0;'")
      Sleep 2000
      ; Open the output videos directory
      Tooltip_Closer_Stats := Tooltip_Closer_Stats "`n" "Opening output directory..."
      ToolTip ( Tooltip_Closer_Stats ), 1, 1
      Run(Fullpath_Output_XboxCaptures)
      Sleep 2000
      Tooltip_Closer_Stats := ( Tooltip_Closer_Stats "`n" "Runtime complete for '" Download_MediaType "'" )
      ToolTip ( Tooltip_Closer_Stats ), 1, 1
      Sleep 2000
    }
    ClearTooltip(10000)
  }
  Return
}

