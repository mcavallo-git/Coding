
; Thanks to user "dmg" from AutoHotkey Forums
; Original Post: https://autohotkey.com/boards/viewtopic.php?p=22579#p22579

#noenv
#singleinstance, ignore
setbatchlines, -1
setworkingdir, %a_scriptdir%

gosub, osd_create
return
osd_create:
 {
   gui, -caption +toolwindow +alwaysontop +lastfound
   gui, color, 8b0fc6
   gui, font, s10 w600, Arial Bold
   gui, margin, 0, 0
   winset, transcolor, 8b0fc6
   
   n_color := getkeystate("numlock", "t") ? "98cb4a" : "5481E6"
   c_color := getkeystate("capslock", "t") ? "98cb4a" : "5481E6"
   s_color := getkeystate("scrolllock", "t") ? "98cb4a" : "5481E6"

   gui, add, listview, x0 y0 w60 h16 -hdr -e0x200 -multi background%n_color% v_numlock glv altsubmit
   gui, add, text, x0 y0 w60 h16 0x201 cffffff backgroundtrans vtxt_numlock, N

   gui, add, listview, x63 y0 w60 h16 -hdr -e0x200 -multi background%c_color% v_capslock glv altsubmit
   gui, add, text, x63 y0 w60 h16 0x201 cffffff backgroundtrans vtxt_capslock, C

   gui, add, listview, x126 y0 w60 h16 -hdr -e0x200 -multi background%s_color% v_scrolllock glv altsubmit
   gui, add, text, x126 y0 w60 h16 0x201 cffffff backgroundtrans vtxt_scrolllock, S
 }
return

numlock::
capslock::
scrolllock::
 {
   If (!locked_%a_thishotkey%)
    {
      _toggle_key(a_thishotkey)
      soundplay, beep.wav
      color := getkeystate(a_thishotkey, "t") ? "98cb4a" : "5481E6"
      guicontrol, +background%color%, _%a_thishotkey%
      guicontrol, hide, txt_%a_thishotkey%
      guicontrol, show, txt_%a_thishotkey%
    }
   sysget, var_, monitorworkarea
   x := (var_right-190)
   y := (var_bottom-26)
   gui, show, x%x% y%y% na, OSD
   settimer, cancel, -3000
   keywait, % a_thishotkey
 }
return

lv:
{
   If (a_guievent = "normal") or (a_guievent = "doubleclick")
    {
      control := ltrim(a_guicontrol, "_")
      If (!locked_%control%)
       {
         _toggle_key(control)
         soundplay, beep.wav
         color := getkeystate(control, "t") ? "98cb4a" : "5481E6"
         guicontrol, +background%color%, %a_guicontrol%
         guicontrol, hide, txt%a_guicontrol%
         guicontrol, show, txt%a_guicontrol%
       }
      settimer, cancel, -3000
    }
   else if (a_guievent = "rightclick")
    {
      _toggle_lock(ltrim(a_guicontrol, "_"))
      soundplay, click.wav
      settimer, cancel, -3000
    }
 }
return

_toggle_key(key)
 {
   If (key = "capslock")
    {
      setcapslockstate, % getkeystate(key, "t") ? "off" : "on"
    }
   else if (key = "scrolllock")
    {
      setscrolllockstate, % getkeystate(key, "t") ? "off" : "on"
    }
   else if (key = "numlock")
    {
      setnumlockstate, % getkeystate(key, "t") ? "off" : "on"
    }
   return
 }

_toggle_lock(key)
 {
   global locked_numlock, locked_capslock, locked_scrolllock
   If (key = "numlock")
    {
      If (locked_numlock)
       {
         setnumlockstate
         locked_numlock := 0
       }
      else
       {
         setnumlockstate, % getkeystate(key, "t") ? "alwayson" : "alwaysoff"
         locked_numlock := 1
       }
    }
   else if (key = "capslock")
    {
      If (locked_capslock)
       {
         setcapslockstate
         locked_capslock := 0
       }
      else
       {
         setcapslockstate, % getkeystate(key, "t") ? "alwayson" : "alwaysoff"
         locked_capslock := 1
       }
    }
   else if (key = "scrolllock")
    {
      If (locked_scrolllock)
       {
         setscrolllockstate
         locked_scrolllock := 0
       }
      else
       {
         setscrolllockstate, % getkeystate(key, "t") ? "alwayson" : "alwaysoff"
         locked_scrolllock := 1
       }
    }
   return
 }

cancel:
 {
   gui, cancel
 }
return