VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "TimestampAmPmShorthandConverter"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
Attribute VB_Description = "Microsoft Excel VBA - TimestampShorthandConverter (shorthand time entry conversion into full timestamp-datetime) + AmPmShorthandConverter (shorthand conversion time entries between AM & PM)"
' GLOBAL VARIABLES
Dim BREAKPOINT As Integer 'set this to 1 or 0 whenever you need a breakpoint in the middle of code (to check vals, etc.)
Dim LAST_VALUE 'Keeps Old_Data when cell is changed (to revert back to)
Dim RUN_MACRO As Integer ' >=1 Runs Macro, <=0 Stops Macro
'
Public Sub Worksheet_SelectionChange(ByVal Target As Range)
    LAST_VALUE = Target.Value
'
    RUN_MACRO = 1
'               1  ===>   RUN MACRO
'               0  ===>  STOP MACRO
'
End Sub
'
Sub enableEvents()
    Application.enableEvents = True
End Sub
'
Sub disableEvents()
    Application.enableEvents = False
End Sub
disableEvents
'
Private Sub Worksheet_Change(ByVal Target As Excel.Range)
    On Error Resume Next 'Stop any possible runtime errors and halting code
    If (RUN_MACRO = 1) Then
        ' ------------------------------------------------------------
        '
        '   Macro is Enabled
        '
        '     Continue with logic processing (disable this macro by setting variable "RUN_MACRO" to a value of "0")
        '
        Dim USER_JUST_PASTED_SOMETHING As Integer ' Value of "0"="Previous action was a manual/user data entry (such as a keypress)"  ///  Value of "1"="Previous action was a paste or autofill"
        Dim UNDO_LIST As String ' Get the undo List to capture the last action performed by user
        UndoList = Application.CommandBars("Standard").Controls("&Undo").List(1)
        '
        ' Determine the previous action's type
        '
        If (Left(UndoList, 5) = "Paste") Then
            USER_JUST_PASTED_SOMETHING = 1 ' Previous action was a paste or autofill
        Else
            USER_JUST_PASTED_SOMETHING = 0  ' Previous action was a manual/user data entry (such as a keypress)
        End If
        If (USER_JUST_PASTED_SOMETHING = 0) Then ' Previous action was a manual/user data entry (such as a keypress)
            Application.enableEvents = False  ' Disable page events from being able to fire this macro (to avoid an infinite loop scenario)
            '
            ' Define the Range of Cells covered by this Macro
            '
            If ((Not Intersect(Target, Range("C1:Z500")) Is Nothing) And (Target.Cells.Count = 1) And (Len(Target.Value) > 0)) Then
                Dim REPLACEMENT_VALUE ' Value to Overwrite Cell-Value with
                Dim DO_REPLACEMENT As Integer ' Value of "0"="Do not replace the cell's contents"  ///  Value of "1"="Replace the cell's contents"
                DO_REPLACEMENT = 1
                '
                ' Determine if the cell (whose edit triggered this macro) contained or did not contain a value before the edit occurred
                '
                Dim VALID_LAST_VALUE
                If ((Not IsEmpty(LAST_VALUE)) And (IsNumeric(LAST_VALUE)) And (LAST_VALUE > 0)) Then
                    VALID_LAST_VALUE = 1  ' The cell (whose edit triggered this macro) contained a value before the edit occurred
                Else
                    VALID_LAST_VALUE = 0  ' The cell (whose edit triggered this macro) did not contain a value before the edit occurred
                End If
                If ((IsNumeric(Target.Value)) And (Target.Value > 0) And (Target.Value <> 0)) Then
                    If (Target.Value < 1) Then
                        ' ------------------------------------------------------------
                        '
                        '   Handler for time-based entries:
                        '
                        '     Use the value entered by user, directly (including inline colons)  -  Example(s):  "1:43"-left-at->"1:43"
                        '
                        REPLACEMENT_VALUE = Target.Value
                    Else
                        ' ------------------------------------------------------------
                        '
                        '   Handler for numeric entries:
                        '
                        '     TimestampShorthandConverter - Shorthand time entry conversion into full timestamp/datetime  -  Example(s):  "5"-converted-to->"05:00" (5am),  "14"-converted-to->"14:00" (2pm)
                        '
                        Dim VALID_PARSED_TIME As Integer
                        Dim PARSED_MINUTES As Integer
                        Dim PARSED_HOURS As Integer
                        If (Target.Value <= 23) Then
                            PARSED_MINUTES = 0  'input formatted as just an hour, i.e "5"->5am or "14"->2pm
                            PARSED_HOURS = Target.Value
                            VALID_PARSED_TIME = 1
                        Else
                            PARSED_MINUTES = Target.Value Mod 100
                            PARSED_HOURS = (Target.Value - PARSED_MINUTES) / 100
                            If (PARSED_MINUTES < 60) And (PARSED_HOURS > 0) Then
                                VALID_PARSED_TIME = 1
                            End If
                        End If
                        If (VALID_PARSED_TIME = 1) Then
                            REPLACEMENT_VALUE = (PARSED_HOURS + PARSED_MINUTES / 60) / 24
                        Else
                            DO_REPLACEMENT = 0
                        End If
                    End If
                Else
                    ' ------------------------------------------------------------
                    '
                    '   Handler for NON-numeric entries:
                    '
                    '     AmPmShorthandConverter - Shorthand conversion of time entries between AM & PM
                    '
                    If ((VALID_LAST_VALUE = 1) And (Target.Value > 0) And (Len(Target.Value) < 3)) Then
                        '
                        ' Switch time between AM/PM (If there was a value in the cell prior to entering non-numeric value)
                        '
                        If (LAST_VALUE < 0.5) Then
                            REPLACEMENT_VALUE = LAST_VALUE + 0.5  'switch AM to PM by typing any characters
                        Else
                            REPLACEMENT_VALUE = LAST_VALUE - 0.5  'switch PM to AM by typing any characters
                        End If
                    Else
                        '
                        ' Allow generic entries for empty cells
                        '
                        DO_REPLACEMENT = 0
                        Target.NumberFormat = "@"
                    End If
                End If
                '
                ' Only replace the cell's value if the macro logic (ran above, previous to this point in the macro) has deemed it appropriate
                '
                If (DO_REPLACEMENT = 1) Then
                    '
                    ' Replace the cell's contents
                    '
                    Target.Value = REPLACEMENT_VALUE
                    Target.NumberFormat = "h:mm AM/PM"
                Else
                    '
                    ' Do not replace the cell's contents
                    '
                    Target.NumberFormat = "@"
                End If
            End If
        Else
            '
            ' Previous action was a paste or autofill
            '
        End If
    Else
        ' ------------------------------------------------------------
        '
        '   Macro is Disabled
        '
        '     Do nothing if disabled (enable this macro by setting variable "RUN_MACRO" to a value of "1")
        '
    End If
    Application.enableEvents = True ' Re-Enable page events to be able to fire this macro (again)
    On Error GoTo 0 'Allow run time errors again
End Sub
'
