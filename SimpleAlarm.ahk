#SingleInstance Force
#Persistent
#NoEnv

FormatTime, Current_Time, , HH:mm:ss tt
FormatTime, Current_Hour, , HH
FormatTime, Current_Minute, , mm

Gui, Add, Text, y20, Alarm time (HH:MM)
Gui, Add, Edit, vAlarm_Hour section w25 ys y17 r1, %Current_Hour%
Gui, Add, Edit, vAlarm_Minute section w25 ys r1, %Current_Minute%
Gui, Add, Edit, vAlarm_Message section w250 ys r1, Message
Gui, Add, Button, section ys default w80 y16, Set
Gui, Show, h54, Simple Alarm

Return


ButtonSet:
	Gui, Submit, NoHide
	
	If StrLen(Alarm_Hour) > 2 or StrLen(Alarm_Minute) > 2 or Alarm_Hour > 23 or Alarm_Minute > 59
	{
		MsgBox, Invalid time format
		Return
	}
	
	Gui, Hide
	Alarm_Time = %Alarm_Hour%:%Alarm_Minute%:00
	TrayTip, Simple Alarm, Alarm set to %Alarm_Hour%:%Alarm_Minute%:00`n%Alarm_Message%
	Menu, Tray, Tip, Alarm at %Alarm_Hour%:%Alarm_Minute%:00`n%Alarm_Message%
	SetTimer, Loop, 1000
Return


Loop:
	FormatTime, Current_Time, , HH:mm:ss tt
	If (Alarm_Time = Current_Time)
		Goto, Alarm
Return 


Alarm:
	MsgBox, %Alarm_Message%
	ExitApp
Return


GuiClose:
	ExitApp
Return