; This script allows me to start Dropbox sync if it is paused, or pause sync indefinetly if it is active.
;
; Written by Andrew Ballin -- April 2022


#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
#SingleInstance Force
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
DetectHiddenWindows, On



; Win + Shift + D
#+d::
; gets current active window
curWindowID := WinExist("A")

; gets current mouse position
CoordMode, Mouse, Screen
MouseGetPos, xpos, ypos

; change dropbox syncing-state
Send, #b ; focuses on system tray
Send, {Right} ; assumes Dropbox button is the 1st icon from left
Send, {Enter}
Sleep 500 ; takes sometime for the context menu to open...
Send, {Up 6}
Send, {Enter}

; return mouse to original position
MouseMove, %xpos%, %ypos%, 0

; reactivates originally active window
WinActivate, ahk_id %curWindowID%

return



; Win + Shift + E
#+e::
; opens and quickly closes the context menu of the Dropbox icon (equivalent to Ctrl + Click on the icon)
dllcall("keybd_event", int, 162, int, 29, int, 0, int, 0) ; CTRL down
PostMessage, 0x0414,, 0x0201,, ahk_class DropboxTrayIcon ; WM_LBUTTONDOWN
PostMessage, 0x0414,, 0x0202,, ahk_class DropboxTrayIcon ; WM_LBUTTONUP
dllcall("keybd_event", int, 162, int, 29, int, 2, int, 0) ; CTRL up
Sleep 1 ; needed otherwise Esc will be sent too fast
Send {Esc}

PostMessage, 0x111, 1061 ,,, ahk_class DropboxTrayIcon ; send Resume/Pause syncing command

return
