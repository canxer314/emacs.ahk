;;
;; An autohotkey script that provides emacs-like keybinding on Windows
;;
#InstallKeybdHook
#UseHook

; The following line is a contribution of NTEmacs wiki http://www49.atwiki.jp/ntemacs/pages/20.html
SetKeyDelay 0

; turns to be 1 when ctrl-x is pressed
is_pre_x = 0
; turns to be 1 when ctrl-space is pressed
is_pre_spc = 0

; Applications you want to disable emacs-like keybindings
; (Please comment out applications you don't use)
is_target()
{
  IfWinActive,ahk_class ConsoleWindowClass ; Cygwin
    Return 1 
  IfWinActive,ahk_class MEADOW ; Meadow
    Return 1 
  IfWinActive,ahk_class cygwin/x X rl-xterm-XTerm-0
    Return 1
  IfWinActive,ahk_class MozillaUIWindowClass ; keysnail on Firefox
    Return 1
  ; Avoid VMwareUnity with AutoHotkey
  IfWinActive,ahk_class VMwareUnityHostWndClass
    Return 1
  IfWinActive,ahk_class Vim ; GVIM
    Return 1
;  IfWinActive,ahk_class SWT_Window0 ; Eclipse
;    Return 1
;   IfWinActive,ahk_class Xming X
;     Return 1
;   IfWinActive,ahk_class SunAwtFrame
;     Return 1
    IfWinActive,ahk_class Emacs ; NTEmacs
      Return 1  
;   IfWinActive,ahk_class XEmacs ; XEmacs on Cygwin
;     Return 1
  Return 0
}

delete_char()
{
  Send {Del}
  global is_pre_spc = 0
  Return
}
delete_backward_char()
{
  Send {BS}
  global is_pre_spc = 0
  Return
}
kill_line()
{
  Send {ShiftDown}{END}{SHIFTUP}
  Sleep 50 ;[ms] this value depends on your environment
  Send ^x
  global is_pre_spc = 0
  Return
}
open_line()
{
  Send {END}{Enter}{Up}
  global is_pre_spc = 0
  Return
}
quit()
{
  Send {ESC}
  global is_pre_spc = 0
  Return
}
newline()
{
  Send {Enter}
  global is_pre_spc = 0
  Return
}
indent_for_tab_command()
{
  Send {Tab}
  global is_pre_spc = 0
  Return
}
newline_and_indent()
{
  Send {Enter}{Tab}
  global is_pre_spc = 0
  Return
}
isearch_forward()
{
  Send ^f
  global is_pre_spc = 0
  Return
}
isearch_backward()
{
  Send ^f
  global is_pre_spc = 0
  Return
}
kill_region()
{
  Send ^x
  global is_pre_spc = 0
  Return
}
kill_ring_save()
{
  Send ^c
  global is_pre_spc = 0
  Return
}
yank()
{
  Send ^v
  global is_pre_spc = 0
  Return
}
undo()
{
  Send ^z
  global is_pre_spc = 0
  Return
}
find_file()
{
  Send ^o
  global is_pre_x = 0
  Return
}
save_buffer()
{
  Send, ^s
  global is_pre_x = 0
  Return
}
kill_emacs()
{
  Send !{F4}
  global is_pre_x = 0
  Return
}

move_beginning_of_line()
{
  global
  if is_pre_spc
    Send +{HOME}
  Else
    Send {HOME}
  Return
}
move_end_of_line()
{
  global
  if is_pre_spc
    Send +{END}
  Else
    Send {END}
  Return
}
previous_line()
{
  global
  if is_pre_spc
    Send +{Up}
  Else
    Send {Up}
  Return
}
next_line()
{
  global
  if is_pre_spc
    Send +{Down}
  Else
    Send {Down}
  Return
}
forward_char()
{
  global
  if is_pre_spc
    Send +{Right}
  Else
    Send {Right}
  Return
}
backward_char()
{
  global
  if is_pre_spc
    Send +{Left} 
  Else
    Send {Left}
  Return
}
scroll_up()
{
  global
  if is_pre_spc
    Send +{PgUp}
  Else
    Send {PgUp}
  Return
}
scroll_down()
{
  global
  if is_pre_spc
    Send +{PgDn}
  Else
    Send {PgDn}
  Return
}


^x::
  If is_target()
    Send %A_ThisHotkey%
  Else
    is_pre_x = 1
  Return 
^f::
  If is_target()
    Send %A_ThisHotkey%
  Else
  {
    If is_pre_x
      find_file()
    Else
      forward_char()
  }
  Return  
^c::
  If is_target()
    Send %A_ThisHotkey%
  Else
  {
    If is_pre_x
      kill_emacs()
  }
  Return  
^d::
  If is_target()
    Send %A_ThisHotkey%
  Else
    delete_char()
  Return
^h::
  If is_target()
    Send %A_ThisHotkey%
  Else
    delete_backward_char()
  Return
^k::
  If is_target()
    Send %A_ThisHotkey%
  Else
    kill_line()
  Return
;; ^o::
;;   If is_target()
;;     Send %A_ThisHotkey%
;;   Else
;;     open_line()
;;   Return
^g::
  If is_target()
    Send %A_ThisHotkey%
  Else
    quit()
  Return
;; ^j::
;;   If is_target()
;;     Send %A_ThisHotkey%
;;   Else
;;     newline_and_indent()
;;   Return
^m::
  If is_target()
    Send %A_ThisHotkey%
  Else
    newline()
  Return
^i::
  If is_target()
    Send %A_ThisHotkey%
  Else
    indent_for_tab_command()
  Return
^s::
  If is_target()
    Send %A_ThisHotkey%
  Else
  {
    If is_pre_x
      save_buffer()
    Else
      isearch_forward()
  }
  Return
^r::
  If is_target()
    Send %A_ThisHotkey%
  Else
    isearch_backward()
  Return
^w::
  If is_target()
    Send %A_ThisHotkey%
  Else
    kill_region()
  Return
!w::
  If is_target()
    Send %A_ThisHotkey%
  Else
    kill_ring_save()
  Return
^y::
  If is_target()
    Send %A_ThisHotkey%
  Else
    yank()
  Return
^/::
  If is_target()
    Send %A_ThisHotkey%
  Else
    undo()
  Return  
  
;$^{Space}::
^vk20sc039::
  If is_target()
    Send {CtrlDown}{Space}{CtrlUp}
  Else
  {
    If is_pre_spc
      is_pre_spc = 0
    Else
      is_pre_spc = 1
  }
  Return
^@::
  If is_target()
    Send %A_ThisHotkey%
  Else
  {
    If is_pre_spc
      is_pre_spc = 0
    Else
      is_pre_spc = 1
  }
  Return
^a::
  If is_target()
    Send %A_ThisHotkey%
  Else
    move_beginning_of_line()
  Return
^e::
  If is_target()
    Send %A_ThisHotkey%
  Else
    move_end_of_line()
  Return
^p::
  If is_target()
    Send %A_ThisHotkey%
  Else
    previous_line()
  Return
^n::
  If is_target()
    Send %A_ThisHotkey%
  Else
    next_line()
  Return
^b::
  If is_target()
    Send %A_ThisHotkey%
  Else
    backward_char()
  Return
^v::
  If is_target()
    Send %A_ThisHotkey%
  Else
    scroll_down()
  Return
!v::
  If is_target()
    Send %A_ThisHotkey%
  Else
    scroll_up()
  Return

;following section remaps alt-delete keys to mimic OSX
;command-delete deletes whole line
^BS::Send {LShift down}{Home}{LShift Up}{Del}

;alt-function-delete deletes next word
!Delete::Send {LShift down}{LCtrl down}{Right}{Lctrl up}{LShift Up}{Del}
!d::Send {LShift down}{LCtrl down}{Right}{Lctrl up}{LShift Up}{Del}

;move to next word
!f::Send {LCtrl down}{Right}{Lctrl up}

;alt-delete deletes previous word
!BS::Send {LShift down}{LCtrl down}{Left}{Lctrl up}{LShift Up}{Del}

;move to previous word
!b::Send {LCtrl down}{Left}{Lctrl up}

;following section mimics command-q and command-w
;behaviour to close windows
^SC011::^F4 ;w
^SC010::Send {LAlt down}{Ctrl up}{F4}{LAlt up} ;q
; Ctrl+H (cmd+h) to hide window
^SC023::WinMinimize,a ;h


;following section remaps alt-arrow and command-arrow
;keys to mimic OSX behaviour
^Up::Send {Lctrl down}{Home}{Lctrl up}
^Down::Send {Lctrl down}{End}{Lctrl up}
^Left::Send {Home}
^Right::Send {End}
^+Up::Send {Shift down}{Lctrl down}{Home}{Lctrl up}{Shift up}
^+Down::Send {Shift down}{Lctrl down}{End}{Lctrl up}{Shift up}
^+Left::Send {Shift down}{Home}{Shift up}
^+Right::Send {Shift down}{End}{Shift up} 

; Disable start menu on left winkey
LWin & vk07::return
LWin::return ; (or run Launchy)

;select all using win+a
LWin & a::Send {Lctrl down}{Home}{Shift down}{End}{Lctrl up}{Shift up}
RWin & a::Send {Lctrl down}{Home}{Shift down}{End}{Lctrl up}{Shift up}

;copy and paste using win+c win+v win+x
LWin & c::Send {Lctrl down}{c}{Lctrl up}
RWin & c::Send {Lctrl down}{c}{Lctrl up}

LWin & x::Send {Lctrl down}{x}{Lctrl up}
RWin & x::Send {Lctrl down}{x}{Lctrl up}

LWin & v::Send {Lctrl down}{v}{Lctrl up}
RWin & v::Send {Lctrl down}{v}{Lctrl up}

;undo using win+z
LWin & z::Send {Lctrl down}{z}{Lctrl up}
RWin & z::Send {Lctrl down}{z}{Lctrl up}

;find using win+f
LWin & f::Send {Lctrl down}{f}{Lctrl up}
RWin & f::Send {Lctrl down}{f}{Lctrl up}

