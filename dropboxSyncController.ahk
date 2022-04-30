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
PostMessage, 0x111, 1061 ,,, ahk_class DropboxTrayIcon ; Resume/Pause syncing
; PostMessage, 0x111, 1024 ,,, ahk_class DropboxTrayIcon ; Open Dropbox Folder


return
