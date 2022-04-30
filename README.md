# dropbox-sync-state
This is a basic script that creates a keyboard shortcut that changes the sync state of Dropbox between 'actively syncing' and 'syncing paused indefinitely'.

Method 1: Press 'Win + Shift + D' to toggle Dropbox's sync state by simulating clicks and stuff.

Method 2: Press 'Win + Shift + E' to toggle Dropbox's sync state directly by sending a wm_command to the program (currently in development).

As of now, it appears there is no way to (officially) control Dropbox in this way through the command line.


# issues
1. With method 1, the sleep value can sometimes be too short; I've had issues with it even at 500. Just need to hit the hotkey again to get it to work. Also need to ensure the Dropbox icon is leftmost in the system tray.

2. With method 2, sending wm_command 1061 (Pause/Resume syncing) only seems to work if the context menu has been opened since the last 1061 command issuance.


# thoughts
1. I've used the following code snipped to ensure there's only one window that matches the DropboxTrayIcon class:
```ahk
WinGet, WinList, List, ahk_class DropboxTrayIcon
Loop %WinList%
  MsgBox % "Window " A_Index " is " WinList%A_Index% ""
```
so I think it's targeting the right window.

2. My guess is that opening the context menu causes Dropbox to check/update its internal state, and perhaps this is a requirement before it will accept command 1061 again.


# TODO
- Use Winspector Spy to figure out what messages are being sent internally so that I can force it to do this check/update each time before (or perhaps after) issuing command 1061. Or figure out how to target the icon and open and close the context menu real quick.