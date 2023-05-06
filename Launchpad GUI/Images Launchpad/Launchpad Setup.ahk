#SingleInstance, Force
SetWorkingDir, %A_ScriptDir%
SetTitleMatchMode, 2
CoordMode, Mouse, Screen
CoordMode, Pixel, Screen

txtpath := "Launchpad GUI.ahk"
prevtxtpath := "Launchpad GUI_previous.ahk"

#Include string functions.ahk

counter := 1

starthere:
FileRead, txtfile, %txtpath%
guidataarray := arrayofstrinbw(txtfile, ";>g>", "gui>>;", ";<g<", "gui<<;", guinamearray)
funcdataarray := arrayofstrinbw(txtfile, ";>f>", "func>>;", ";<f<", "func<<;", funcnamearray)

if newguistr{
	newguistr := ""
	newfuncstr := ""
	newname := ""
	newlaunchpath := ""
	newimgpath := ""
	mx := ""
	my := ""
	counter := guidataarray.length()
}

oldname := ""

Goto, lpsetup

lpsetup:
Gui, lpsetup:New
Gui, lpsetup:-DPIScale
Gui, lpsetup:Font, s15 cblack, Comic Sans MS
if guidataarray.length(){
	guistrtodata(guidataarray[counter], xcoord, ycoord, name, imgpath)
	funcstrtodata(funcdataarray[counter], launchpath, shouldtoggle)
	x1 := 15
	y1 := 15
	Gui, lpsetup:Add, Text, x%x1% y%y1%, name: %name%
	y1 += 40
	Gui, lpsetup:Add, Text, x%x1% y%y1%, xcoord: %xcoord%
	y1 += 40
	Gui, lpsetup:Add, Text, x%x1% y%y1%, ycoord: %ycoord%
	y1 += 40
	Gui, lpsetup:Add, Text, x%x1% y%y1%, imgpath: %imgpath%
	y1 += 40
	Gui, lpsetup:Add, Text, x%x1% y%y1%, launchpath: %launchpath%
	y1 += 40
	Gui, lpsetup:Add, Text, x%x1% y%y1%, should toggle?: %shouldtoggle%
	width := 80
	y1 += 50
	if (counter > 1){
		Gui, lpsetup:Add, Button, x%x1% y%y1% w%width% gprev, ..Prev
	}
	else{
		Gui, lpsetup:Add, Button, x%x1% y%y1% w%width% gprevfirst, ..Prev
	}
	x1 := x1 + width + 20
	width := 90
	if (counter < guidataarray.length()){
		Gui, lpsetup:Add, Button, x%x1% y%y1% w%width% gnext, Next..
	}
	else{
		Gui, lpsetup:Add, Button, x%x1% y%y1% w%width% gnextlast, Next..
	}
	x1 := x1 + width + 20
	width := 150
	Gui, lpsetup:Add, Button, x%x1% y%y1% w%width% geditthis, Edit This!
	x1 := x1 + width + 20
	width := 150
	Gui, lpsetup:Add, Button, x%x1% y%y1% w%width% gaddnew, Add New!
}
else{
	Gui, lpsetup:Add, Text,, You haven't added any buttons yet!
	Gui, lpsetup:Add, Button, gaddnew, Add New!
}
Gui, lpsetup:Show,, Launchpad Setup
return

F4::
ExitApp

next:
Gui, lpsetup:Destroy
counter += 1
Goto, lpsetup
return

prev:
Gui, lpsetup:Destroy
counter -= 1
Goto, lpsetup
return

nextlast:
;MsgBox,, Last, Nothing after this!, 1
Gui, lpsetup:Destroy
counter := 1
Goto, lpsetup
return

prevfirst:
;MsgBox,, First, Nothing before this!, 1
Gui, lpsetup:Destroy
counter := guidataarray.length()
Goto, lpsetup
return

lpsetupGuiClose:
ExitApp

editthis:
Gui, lpsetup:Destroy
Gui, editthis:New
Gui, editthis:-DPIScale
Gui, editthis:Font, s15, Comic Sans MS
x1 := 15
y1 := 15
Gui, editthis:Add, Text, x%x1% y%y1%, Name: (AlphaNum / _ / -)
y1 += 40
Gui, editthis:Add, Edit, x%x1% y%y1% vname, %name%
y1 += 45
Gui, editthis:Add, Text, x%x1% y%y1%, Img Path:
y1 += 40
Gui, editthis:Add, Edit, x%x1% y%y1% h43 vimgpath -WantReturn, %imgpath%
y1 += 45
Gui, editthis:Add, Text, x%x1% y%y1%, xcoord:
y1 += 40
Gui, editthis:Add, Edit, x%x1% y%y1% vxcoord, %xcoord%
y1 += 45
Gui, editthis:Add, Text, x%x1% y%y1%, ycoord:
y1 += 40
Gui, editthis:Add, Edit, x%x1% y%y1% vycoord, %ycoord%
y1 += 45
Gui, editthis:Add, Text, x%x1% y%y1%, Launch path:
y1 += 40
Gui, editthis:Add, Edit, x%x1% y%y1% vlaunchpath -WantReturn, %launchpath%
y1 += 45
Gui, editthis:Add, CheckBox, x%x1% y%y1% vnewshouldtoggle Checked, Should it toggle?
y1 += 50
width := 170
Gui, editthis:Add, Button, x%x1% y%y1% w%width% geditdelete, ☠Delete?☠
x1 := x1 + width + 20
width := 100
Gui, editthis:Add, Button, x%x1% y%y1% w%width% geditthisimgpos, Img Pos
x1 := 15
y1 += 65
width := 100
Gui, editthis:Add, Button, x%x1% y%y1% w%width% geditthiscancel, Cancel
x1 := x1 + width + 20
width := 150
Gui, editthis:Add, Button, x%x1% y%y1% w%width% geditthisconfirm Default, Confirm
Gui, editthis:Show,, Editing
if !oldname{
	oldname := name
}
return

editthiscancel:
editthisGuiClose:
Gui, editthis:Destroy
Goto, lpsetup
return

editthisimgpos:
Gui, editthis:Hide
Gui, editthis2:New
Gui, editthis2:-DPIScale
Gui, editthis2:Font, s15, Comic Sans MS
Gui, editthis2:Add, Text,, Entering image positioning mode!`nClick using Middle Mouse Button or hover curosor and press =`nPress Enter once the image is at the desired location.
Gui, editthis2:Add, Button, geditimgpos Default, OK
Gui, editthis2:Show,, Image Positioning
return

editimgpos:
Gui, editthis:Submit
Gui, editthis:Destroy
Gui, editthis2:Destroy
imgpositioning := 2
imgpath(imgpath)
return

editthisconfirm:
Gui, editthis:Submit
Gui, editthis:Destroy
imgpath(imgpath)
editedguistr := ";>g>" name "gui>>;`nGui, Add, Picture, x" xcoord " y" ycoord " g" name ", " imgpath "`n;<g<" name "gui<<;`n"
editedfuncstr := ";>f>" name "func>>;`n" name ":`nGui, Launchpad:Destroy`nlaunchpad(""" launchpath """, " shouldtoggle ")`nExitApp`n;<f<" name "func<<;`n"
FileDelete, %prevtxtpath%
FileAppend, %txtfile%, %prevtxtpath%
startstr := ";>g>" oldname "gui>>;"
endstr := ";<g<" oldname "gui<<;"
endstrlen := StrLen(endstr)
startstr := InStr(txtfile, startstr)
endstr := InStr(txtfile, endstr)
startstr := SubStr(txtfile, 1, startstr - 1)
endstr := SubStr(txtfile, endstr + endstrlen + 2)
txtfile := startstr editedguistr endstr
startstr := ";>f>" oldname "func>>;"
endstr := ";<f<" oldname "func<<;"
endstrlen := StrLen(endstr)
startstr := InStr(txtfile, startstr)
endstr := InStr(txtfile, endstr)
startstr := SubStr(txtfile, 1, startstr - 1)
endstr := SubStr(txtfile, endstr + endstrlen + 2)
txtfile := startstr editedfuncstr endstr
FileDelete, %txtpath%
FileAppend, %txtfile%, %txtpath%
Goto, starthere
return

editdelete:
Gui, editthis:Hide
Gui, editthis2:New
Gui, editthis2:-DPIScale
Gui, editthis2:Font, s15, Comic Sans MS
x1 := 15
y1 := 15
Gui, editthis2:Add, Text, x%x1% y%y1%, Confirm Deletion?
y1 += 40
width := 100
Gui, editthis2:Add, Button, x%x1% y%y1% w%width% geditdelno Default, No
x1 := x1 + width + 20
width := 100
Gui, editthis2:Add, Button, x%x1% y%y1% w%width% geditdelyes, Yes
return

editdelno:
editthis2GuiClose:
Gui, editthis2:Destroy
Gui, editthis:Show
return

editdelyes:
Gui, editthis:Destroy
Gui, editthis2:Destroy
FileDelete, %prevtxtpath%
FileAppend, %txtfile%, %prevtxtpath%
startstr := ";>g>" oldname "gui>>;"
endstr := ";<g<" oldname "gui<<;"
endstrlen := StrLen(endstr)
startstr := InStr(txtfile, startstr)
endstr := InStr(txtfile, endstr)
startstr := SubStr(txtfile, 1, startstr - 1)
endstr := SubStr(txtfile, endstr + endstrlen + 2)
txtfile := startstr endstr
startstr := ";>f>" oldname "func>>;"
endstr := ";<f<" oldname "func<<;"
endstrlen := StrLen(endstr)
startstr := InStr(txtfile, startstr)
endstr := InStr(txtfile, endstr)
startstr := SubStr(txtfile, 1, startstr - 1)
endstr := SubStr(txtfile, endstr + endstrlen + 2)
txtfile := startstr endstr
FileDelete, %txtpath%
FileAppend, %txtfile%, %txtpath%
Goto, starthere
return

addnew:
Gui, lpsetup:Destroy
Gui, addnew:New
Gui, addnew:-DPIScale
Gui, addnew:Font, s15, Comic Sans MS
x1 := 15
y1 := 15
Gui, addnew:Add, Text, x%x1% y%y1%, Name: (AlphaNum / _ / -)
y1 += 40
Gui, addnew:Add, Edit, x%x1% y%y1% vnewname
y1 += 45
Gui, addnew:Add, Text, x%x1% y%y1%, Img Path:
y1 += 40
Gui, addnew:Add, Edit, x%x1% y%y1% vnewimgpath -WantReturn
y1 += 50
width := 100
Gui, addnew:Add, Button, x%x1% y%y1% w%width% gaddnewcancel, Cancel
x1 := x1 + width + 20
width := 100
Gui, addnew:Add, Button, x%x1% y%y1% w%width% gaddnewnext Default, Next
Gui, addnew:Show,, Add New
return

addnewcancel:
addnewGuiClose:
Gui, addnew:Destroy
Goto, lpsetup
return

addnewnext:
Gui, addnew:Submit
Gui, addnew:Destroy
imgpath(newimgpath)
Gui, imgposn:New
Gui, imgposn:-DPIScale
Gui, imgposn:Font, s15, Comic Sans MS
Gui, imgposn:Add, Text,, Entering image positioning mode!`nClick using Middle Mouse Button or hover curosor and press =`nPress Enter once the image is at the desired location.
Gui, imgposn:Add, Button, gimgposnok Default, OK
Gui, imgposn:Show,, Image Positioning
return

imgposnGuiClose:
Gui, imgposn:Destroy
Goto, addnew
return

imgposnok:
Gui, imgposn:Destroy
imgpositioning := 1
return

addnew2:
Gui, addnew2:New
Gui, addnew2:-DPIScale
Gui, addnew2:Font, s15, Comic Sans MS
x1 := 15
y1 := 15
Gui, addnew2:Add, Text, x%x1% y%y1%, Name: (AlphaNum / _ / -)
y1 += 40
Gui, addnew2:Add, Edit, x%x1% y%y1% vnewname, %newname%
y1 += 45
Gui, addnew2:Add, Text, x%x1% y%y1%, Img Path:
y1 += 40
Gui, addnew2:Add, Edit, x%x1% y%y1% ReadOnly, %newimgpath%
y1 += 45
Gui, addnew2:Add, Text, x%x1% y%y1%, xcoord:
y1 += 40
Gui, addnew2:Add, Edit, x%x1% y%y1% vmx, %mx%
y1 += 45
Gui, addnew2:Add, Text, x%x1% y%y1%, ycoord:
y1 += 40
Gui, addnew2:Add, Edit, x%x1% y%y1% vmy, %my%
y1 += 45
Gui, addnew2:Add, Text, x%x1% y%y1%, Launch path:
y1 += 40
Gui, addnew2:Add, Edit, x%x1% y%y1% vnewlaunchpath
y1 += 45
Gui, addnew2:Add, CheckBox, x%x1% y%y1% vnewshouldtoggle Checked, Should it toggle?
y1 += 50
width := 100
Gui, addnew2:Add, Button, x%x1% y%y1% w%width% gaddnew2cancel, Cancel
x1 := x1 + width + 20
width := 120
Gui, addnew2:Add, Button, x%x1% y%y1% w%width% gaddnew2confirm Default, Confirm
Gui, addnew2:Show,, Add New 2
return

addnew2cancel:
addnew2GuiClose:
Gui, addnew2:Destroy
Goto, addnew
return

addnew2confirm:
Gui, addnew2:Submit
Gui, addnew2:Destroy
imgpath(newimgpath)
if newshouldtoggle{
	newshouldtoggle := "True"
}
else{
	newshouldtoggle := "False"
}
newguistr := ";>g>" newname "gui>>;`nGui, Add, Picture, x" mx " y" my " g" newname ", " newimgpath "`n;<g<" newname "gui<<;`n;----STOP ADDING GUI HERE----"
newfuncstr := ";>f>" newname "func>>;`n" newname ":`nGui, Launchpad:Destroy`nlaunchpad(""" newlaunchpath """, " newshouldtoggle ")`nExitApp`n;<f<" newname "func<<;`n;----STOP ADDING FUNCTIONS HERE----"
FileDelete, %prevtxtpath%
FileAppend, %txtfile%, %prevtxtpath%
txtfile := StrReplace(txtfile, ";----STOP ADDING GUI HERE----", newguistr)
txtfile := StrReplace(txtfile, ";----STOP ADDING FUNCTIONS HERE----", newfuncstr)
FileDelete, %txtpath%
FileAppend, %txtfile%, %txtpath%
Goto, starthere
return

#If imgpositioning
=::	
MButton::
MouseGetPos, mx, my
if (imgpositioning == 1){
	showimg(newimgpath, mx, my)
}
else{
	showimg(imgpath, mx, my)
}
return

Enter::
Gui, imgposn:Destroy
if (imgpositioning == 1){
	imgpositioning := 0
	Goto, addnew2
}
else{
	imgpositioning := 0
	xcoord := mx
	ycoord := my
	Goto, editthis
}
return 

Esc::
if (imgpositioning == 1){
	imgpositioning := 0
	Goto, addnew
}
else{
	imgpositioning := 0
	Goto, editthis
}
return
#If

#If WinActive("Add New")
Esc::
Goto, lpsetup
return
#If

guistrtodata(string, ByRef xcoord, ByRef ycoord, ByRef name, ByRef imgpath){
	string := StrReplace(string, "Gui, Add, Picture, ")
	imgpath := SubStr(string, InStr(string, ",") + 2)
	imgpath := Trim(imgpath, " `n`t")
	xcoord := getstrinbw(string, "x", " y")
	ycoord := getstrinbw(string, "y", " g")
	name := getstrinbw(string, "g", ",")
}

funcstrtodata(string, ByRef launchpath, ByRef shouldtoggle){
	launchpath := getstrinbw(string, "launchpad(""", """, ")
	shouldtoggle := getstrinbw(string, """, ", ")")
}

showimg(imgpath, xcoord, ycoord){
	Gui, imgposn:Destroy
	Gui, imgposn:New
	Gui, imgposn:-Caption -DPIScale
	Gui, imgposn:Color, 0c0c0c
	Gui, imgposn:Add, Picture, x%xcoord% y%ycoord%, %imgpath%
	Gui, imgposn:Show, x0 y0 w%A_ScreenWidth% h%A_ScreenHeight%, imgposn
	WinSet, TransColor, 0c0c0c, A
}

imgpath(ByRef imgpath){
	if (!InStr(imgpath, ":") and !InStr(imgpath, "Images\")){
		imgpath := "Images\" imgpath
	}
}