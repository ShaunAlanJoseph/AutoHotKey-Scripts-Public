#SingleInstance, Force
SetBatchLines, -1
SetTitleMatchMode, 2
SetWorkingDir %A_ScriptDir%

if WinActive("ahk_class #32770"){
	toggle := 1
}

xcoord := (A_ScreenWidth - 192) / 2
ycoord := (A_ScreenHeight - 66) / 2

Gui:
Gui, Launchpad:New
Gui, Launchpad:-Caption -DPIScale
Gui, Launchpad:Color, 0c0c0c
if toggle{
	Gui, Launchpad:Add, Picture, gtoggle_button x%xcoord% y%ycoord%, Images\clipboard_button.png
}
else{
	Gui, Launchpad:Add, Picture, gtoggle_button x%xcoord% y%ycoord%, Images\open_file_button.png
}
;----ADD GUI HERE----

;>g>keygui>>;
Gui, Add, Picture, x883 y272 gkey, Images\key.png
;<g<keygui<<;
;----STOP ADDING GUI HERE----
Gui, Launchpad:Show , x0 y0 w%A_ScreenWidth% h%A_ScreenHeight%, Launchpad GUI
WinSet, TransColor, 0c0c0c, A
return

toggle_button:
if toggle{
	toggle := 0
	Gui, Launchpad:Destroy
	goto, Gui
}
else{
	toggle := 1
	Gui, Launchpad:Destroy
	goto, Gui
}
return

#If WinActive("Launchpad GUI")
Esc::
ExitApp
#If
	
LaunchpadGuiClose:
ExitApp

;----ADD FUNCTIONS HERE----

;>f>keyfunc>>;
key:
Gui, Launchpad:Destroy
launchpad("this will work, i bettttt", True)
ExitApp
;<f<keyfunc<<;
;----STOP ADDING FUNCTIONS HERE----

launchpad(path, shouldtoggle := 1){
	if shouldtoggle{
		global toggle
		if toggle{
			Clipboard := path
		}
		else{
			Run, %path%
		}
	}
	else{
		Run, %path%
	}
}