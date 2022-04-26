# dropbox-sync-state
This is a basic script that creates a keyboard shortcut that changes the sync state of Dropbox between 'actively syncing' and 'syncing paused indefinitely'.

Press 'Win + Shift + D' to toggle Dropbox's sync state.

It was quite annoying to have to do this by moving the mouse and clicking.

As of now, it appears there is no way to (officially) control Dropbox in this way through the command line.


# issues
1. The sleep value can sometimes be too short; I've had issues with it even at 500. Just need to hit the hotkey again to get it to work.

2. The current method is very inelligent. Need to figure out more direct method for controlling this feature. Having trouble figuring out how to target the Dropbox button in the system tray in a location-independent way. Doesn't seem like I can access it through the Windows toolbar's controls...