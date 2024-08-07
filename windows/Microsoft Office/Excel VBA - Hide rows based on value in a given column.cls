' ------------------------------
'
' --> Use ALT+F11 hotkey to open VBA Console
'
' --> Select worksheet (top-left, double click) which you wish to hide rows on
'
' --> Paste the following content into the worksheet's vba console, then save
'
' ------------------------------

Private Sub Worksheet_Activate()
  On Error Resume Next
  Dim LastRow As Long, cell As Range
  Application.EnableEvents = False
  LastRow = Cells(Cells.Rows.Count, "A").End(xlUp).Row
  On Error Resume Next
  For Each cell In Range("A1:A" & LastRow)
    If IsEmpty(cell.Value) Then
      cell.EntireRow.Hidden = False
    ElseIf Not (cell.Value = 0) Then
      cell.EntireRow.Hidden = False
    ElseIf InStr(cell.Value, "X") > 0 Then
      cell.EntireRow.Hidden = False
    ElseIf cell.Value = 0 Then
      cell.EntireRow.Hidden = True
    End If
  Next
  Application.EnableEvents = True
  On Error GoTo 0
End Sub


' ------------------------------
'
' --> Optionally, trigger based on data values change in the worksheet:
'
' ------------------------------

Private Sub Worksheet_Change(ByVal Target As Range)
  ...
End Sub

Private Sub Worksheet_Calculate()
  ...
End Sub

' ------------------------------