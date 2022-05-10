# dropbox-sync-state
This is a basic script that creates a keyboard shortcut that changes the sync state of Dropbox between 'actively syncing' and 'syncing paused indefinitely'.

Method 1: Press 'Win + Shift + D' to toggle Dropbox's sync state by simulating clicks and stuff.

Method 2: Press 'Win + Shift + E' to toggle Dropbox's sync state directly by sending a wm_command to the program (currently in development).

As of now, it appears there is no way to (officially) control Dropbox in this way through the command line.


# issues
1. With method 1, the sleep value can sometimes be too short; I've had issues with it even at 500. Just need to hit the hotkey again to get it to work. Also need to ensure the Dropbox icon is leftmost in the system tray.

2. Sometimes `Send {Esc}` doesn't work to close the context menu in method 2.


# notes/thoughts
1. I think Dropbox needs to 'update its internal state' before it can receive 1061 again. Opening the context menu (Ctrl + Click on Dropbox SysTray icon, or highlight and hit Enter) and closing it (e.g. Esc) seems to trigger this update.

2. I used systray.ahk to get a bunch of info about the Dropbox instance in the SysTray:
- Class = DropboxTrayIcon
- cmdID = 17179869187 (0x400000003)
- hIcon = 226167573 (0xD7B0B15)
- hWnd = 10423346 (0x9F0C32)
- idx = 0
- msgID = 54043195528446996 (0xC0000000000414)
- pID = 24292
- Process = Dropbox.exe
- Tray = Shell_TrayWnd
- uID = 4483945857024 (0x41400000000)
Studying the code, it seemed that we only needed 0x0414 for PostMessage; I imagine the other bits are ignored (something to do with little vs big Endian encoding?). Wasn't able to find what this message means though...

If the script stops working, perhaps these values changed.

3. I would've liked to send 1061 and then 'update the internal state', but it seems it doesn't work in this order; not sure why... So the script currently updates the internal state and then sends 1061. I could update the state again afterwards, but this didn't seem necessary (hopefully).


Sources:
- https://www.autohotkey.com/boards/viewtopic.php?t=1229
- https://gist.github.com/tmplinshi/83c52a9dffe65c105803d026ca1a07da


# TODO
- Use Winspector Spy to figure out what messages are being sent internally so that I can force it to do this check/update each time before (or perhaps after) issuing command 1061 without needing to open the context menu for a more elegant solution.

- Test if replacing `Send {Esc}` with a suitable `dllcall("keybd_event", ...` will allow me to get rid of the Sleep line.


# other random pages I had open that might be useful in the future
- https://www.autohotkey.com/boards/viewtopic.php?t=67373
- https://www.autohotkey.com/board/topic/15918-extract-informations-about-trayicons/
- https://www.autohotkey.com/board/topic/791-system-tray-operation/
- https://www.autohotkey.com/boards/viewtopic.php?t=1229
- https://social.msdn.microsoft.com/Forums/en-US/c26b444c-0bab-4c37-b1be-95f66e87477f/how-to-send-key-combination-such-as-quotctrl-alt-fquot?forum=netfxbcl
