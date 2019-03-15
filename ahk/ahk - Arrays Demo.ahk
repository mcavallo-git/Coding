;
;   ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;
; AutoHotkey - Using/Setting Arrays
;
;    Reference:   https://autohotkey.com/board/topic/77221-associative-array-of-objects-help/
;
;   ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;

; EXAMPLE 1

; vars "ProfileList" & "ProfileInfo" instantiated as new, empty objects
ProfileList := {}
ProfileInfo := {}


ProfileInfo.Name := "MyName"
ProfileInfo.Password := "MyPassword"
ProfileInfo.Server := "TheServer"

ProfileList[ProfileInfo.Name] := ProfileInfo 

ProfileInfo := {}
;   |
;   |--> var "ProfileInfo" now a refers to an separate, empty object - Its old object is not freed b/c var "ProfileList" still has a refers to it

MsgBox, % "Here is the Password for MyName: " ProfileList["MyName"].Password

MsgBox, % "Here is the Password for AnotherName: " ProfileList["AnotherName"].Password

; You could also do a sort of shorthand thing that avoids needing ProfileInfo altogether (almost what sinkfaze did):
ProfileList["AnotherName"] := { Name:"AnotherName", Password:"AnotherPassword", Server:"ThatServer" }

;
;   ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;

; EXAMPLE 2

Jack := {profession: "teacher"
         , height: "tall"
         , country: "USA"
         , city: "New York"}

Paul := {profession: "cook"
         , height: "short"
         , country: "UK"
         , city: "London"}

Bill := {profession: "designer"
         , height: "short"
         , country: "Canada"
         , city: "Toronto"}

Max := {profession: "driver"
        , height: "tall"
        , country: "USA"
        , city: "Dallas"}

Bill := {profession: "policeman"
         , height: "tall"
         , country: "Australia"
         , city: "Canberra"}

Person := {Jack: Jack
           , Paul: Paul
           , Bill: Bill
           , Max: Max
           , Bill: Bill}


MsgBox, % Person.Jack.city

;
;   ----------------------------------------------------------------------------------------------------------------------------------------------------------------
;