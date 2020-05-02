#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#Include, .\includes\_$IniLibrary.toolkit
#SingleInstance, Force


    GLOBAL LastRowSent := ""
    GLOBAL LastKeySent := ""
    GLOBAL stackSetStatus := "HIBERNATING..."

GLOBAL FirstHotBarRow := "6"   ;;; this is the number the system presses to actuate the 1st hotbar row to begin casting buffs
GLOBAL SecondHotBarRow := "7"   ;;; this is the number the system presses to actuate the 2nd hotbar row to begin casting buffs
GLOBAL ThirdHotBarRow := "8"   ;;; this is the number the system presses to actuate the 3rd hotbar row to begin casting buffs



GLOBAL ClientCharSlot4 := "NameHere"
GLOBAL ClientCharSlot3 := "Raidmachine"
GLOBAL ClientCharSlot2 := "Raidspirit"
GLOBAL ClientCharSlot1 := "Raidcaptain"



GLOBAL HB1Speed := "8000"
GLOBAL HB2Speed := "8000"
GLOBAL HB3Speed := "8000"




GLOBAL EngineTitle := "LAYERS"
GLOBAL EngineVersion := "4.00.927C"
GLOBAL EngineBuild := "BUILD 235109"


GLOBAL EngineError0x0 := "Missing Files"
GLOBAL EngineError0x1 := "Missing Info"
GLOBAL EngineInfo0x0 := "Reconstruction"



    if FileExist("buff_core.ini")
    {
    ; DebugConfigExist()
    Sleep, 50
    }
    Else {
    MsgBox, 48, %EngineTitle% - %EngineError0x0%, The buff_core.ini file doesn't exist.
    

Ini := new AhkIni(".\buff_core.ini")	;will create new ini if nothing exists
			Msgbox, 64, %EngineTitle% - %EngineInfo0x0%, Configuration File Is Now Being Constructed With Hardcoded Defaults.
Sleep, 500
; ini.write("ENGINE", "AutoUpdateAOIDlist", "0", "`n`    Automatically Update AO Window List `n` `n` `n` `n` `n`")
; ini.write("ENGINE", "AOIA_InstallPath", "Replace_Me", "`n`    Example: `n` D:\Program Files (x86)\AO Item Assistant+ `n` `n` `n`")
; ini.write("ENGINE", "AO_OldEngine_InstallPath", "Replace_Me", "`n`    Example: `n` C:\Program Files (x86)\Funcom\Anarchy Online `n` `n` `n`")
ini.write("MODULE", "Disable_Row_3", "0", "`n`    Toggle enabling execution of Hotbar Row 3 `n`  DEFAULT: 0 `n` `n` `n`")
ini.write("MODULE", "Disable_Row_2", "0", "`n`    Toggle enabling execution of Hotbar Row 2 `n`  DEFAULT: 0 `n`")
ini.write("MODULE", "Disable_Row_1", "0", "`n`    Toggle enabling execution of Hotbar Row 1 `n`  DEFAULT: 0 `n`", "                   ENGINE OPTIONS (Configure these) `n`")
ini.write("ENGINE", "RunWithAdmin", "0", "`n`    Toggle Running With Administrator `n` `n`", "                   ENGINE OPTIONS (Configure these) `n`")
ini.write("CLIENT", "ThirdHotbarRow", "3", "`n`    The number of the third Hotbar Buffing Row `n`  DEFAULT: 3 `n` `n` `n` `n`")
ini.write("CLIENT", "SecondHotbarRow", "2", "`n`    The number of the second Hotbar Buffing Row `n`   DEFAULT: 2 `n` `n` `n` `n`")
ini.write("CLIENT", "FirstHotbarRow", "1", "`n` The number of the first Hotbar Buffing Row (Ex. For Shift+1) `n`  DEFAULT: 1 `n` `n` `n` `n`")
ini.write("CLIENT", "CharacterName_06", "NameHere", "`n`    Sixth Character's Name `n` `n` `n` `n` `n`")
ini.write("CLIENT", "CharacterName_05", "NameHere", "`n`    Fifth Character's Name `n` `n` `n`")
ini.write("CLIENT", "CharacterName_04", "NameHere", "`n`    Fourth Character's Name `n` `n` `n`")
ini.write("CLIENT", "CharacterName_03", "NameHere", "`n`    Third Character's Name `n` `n` `n`")
ini.write("CLIENT", "CharacterName_02", "NameHere", "`n`    Second Character's Name `n` `n` `n`")
ini.write("CLIENT", "CharacterName_01", "Raidcaptain", "`n`    First Character's Name `n`    (ALL FOLLOWING CLIENT CONVARS ARE CASE SENSITIVE) `n` `n` `n` ", "                   CLIENT OPTIONS (Configure these) `n` `n`")
; ini.write("SOUND", "QuickLaunch_AOIA", "1", "`n`    Plays Sound when Quick Launching AOIA `n` `n` `n` `n` `n`")
; ini.write("SOUND", "QuickLaunch_AOoldEngineSteam", "1", "`n`    Plays Sound when Quick Launching AO STEAM `n` `n` `n`")
; ini.write("SOUND", "QuickLaunch_AOoldEngine", "1", "`n`    Plays Sound when Quick Launching AO `n` `n` `n`")
; ini.write("SOUND", "LoopEnd", "1", "`n`    Plays Sound on loop end `n` `n` `n`")
; ini.write("SOUND", "LoopStart", "1", "`n`    Plays Sound on loop start `n` `n` `n`", "                   SOUND OPTIONS (Configure these) `n` `n`")
ini.write("VELOCITY", "Third_HotbarRow_Speed", "8000", "`n`    Speed that the third Hotbar will be executed at `n`  DEFAULT: 8000 `n` `n` `n` `n`")
ini.write("VELOCITY", "Second_HotbarRow_Speed", "8000", "`n`    Speed that the second Hotbar will be executed at `n`  DEFAULT: 8000 `n`")
ini.write("VELOCITY", "First_HotbarRow_Speed", "8000", "`n`    Speed that the first Hotbar will be executed at `n`  DEFAULT: 8000 `n` `n`", "                   DEFAULT KEY LOOPING SPEEDS (MILLISECONDS)`n` `n`")
; ini.write("DEBUG", "AutoAOIDUpdateMsg", "0", "`n`    Output TrayBallon Message On Each Loop `n` `n` `n`", "                   FOR DEVELOPER TESTING (CAN SAFELY IGNORE)`n` `n`")
ini.Save()
Sleep, 500
Reload
        Return
    }






IniRead, ICvarElevate, buff_core.ini, ENGINE, RunWithAdmin, %IniKeyErrorElevate%
If ICvarElevate = 1
{
;                         {[
;;           ELEVATE TO ADMIN UAC PROMPT BELOW
; If the script is not elevated, relaunch as administrator and kill current instance:
 
full_command_line := DllCall("GetCommandLine", "str")
 
if not (A_IsAdmin or RegExMatch(full_command_line, " /restart(?!\S)"))
{
    try ; leads to having the script re-launching itself as administrator
    {
        if A_IsCompiled
            Run *RunAs "%A_ScriptFullPath%" /restart
        else
            Run *RunAs "%A_AhkPath%" /restart "%A_ScriptFullPath%"
    }
    ExitApp
}
;
;                          ]}
}




; IniRead, TabVelocity, buff_core.ini, VELOCITY, TabSpeedDefault, %IniKeyErrorTAB%
; IniRead, EVelocity, buff_core.ini, VELOCITY, ESpeedDefault, %IniKeyErrorE%
; IniRead, RVelocity, buff_core.ini, VELOCITY, RSpeedDefault, %IniKeyErrorR%
; IniRead, FVelocity, buff_core.ini, VELOCITY, FSpeedDefault, %IniKeyErrorF%
; IniRead, GVelocity, buff_core.ini, VELOCITY, GSpeedDefault, %IniKeyErrorG%
; IniRead, JVelocity, buff_core.ini, VELOCITY, JSpeedDefault, %IniKeyErrorJ%
; IniRead, KVelocity, buff_core.ini, VELOCITY, KSpeedDefault, %IniKeyErrorK%
; IniRead, LVelocity, buff_core.ini, VELOCITY, LSpeedDefault, %IniKeyErrorL%
; IniRead, VVelocity, buff_core.ini, VELOCITY, VSpeedDefault, %IniKeyErrorV%
; IniRead, BVelocity, buff_core.ini, VELOCITY, BSpeedDefault, %IniKeyErrorB%
; IniRead, NVelocity, buff_core.ini, VELOCITY, NSpeedDefault, %IniKeyErrorN%
; IniRead, MVelocity, buff_core.ini, VELOCITY, MSpeedDefault, %IniKeyErrorM%
; IniRead, F7Velocity, buff_core.ini, VELOCITY, F7SpeedDefault, %IniKeyErrorF7%




WinGet, aoid, List, Anarchy Online

Gui, Add, Edit, x2 y149 w80 h20 vTabSpeed, %TabVelocity%   

Gui, Add, Button, x110 y426 h19 , SUBMIT

Gui, Add, Text, x280 y180 vLastLoopRow, %LastRowSent%
Gui, Add, Text, x280 y250 vLoopStateText, %stackSetStatus%



Gui, Show, w404 h464, Buff Pallette
Gui, Show, w404 h464, Layers
Gui, Submit, NoHide

WinActivate, Layers




Return



HOME::
SetTimer, IssueHB1all, -100   ;;;  run the next timer only once
SetTimer, IssueHB2all, Off    ;;;  run the next timer only once
SetTimer, IssueHB3all, Off    ;;;  run the next timer only once
; TransitionFromStart()
Return


END::
SetTimer, IssueHB1all, Off   ;;;  run the next timer only once
SetTimer, IssueHB2all, Off   ;;;  run the next timer only once
SetTimer, IssueHB3all, Off   ;;;  run the next timer only once
Reload
Return




IssueHB1all:   ;;; (Issue Hotbar 1 ALL)
IniRead, ICvarDisableRow1, buff_core.ini, MODULE, Disable_Row_1, ;;;%IniKeyErrorElevate%
If(ICvarDisableRow1 = 1)
{
    Sleep, 10
    TransitionFrom1To2()
    SetTimer, IssueHB1all, Off
    Return
}
Else If(ICvarDisableRow1 = 0)
{

    GLOBAL LastRowSent := "1"
    GLOBAL stackSetStatus := "ACTIVE"
    GuiControl, Text, LastLoopRow, %LastRowSent%
    GuiControl, Text, LoopStateText, %stackSetStatus%

TurnAllTimersOff1()
DoShiftHotbarTo1()
Sleep, 1800
GlobalSendKeyF1()
Sleep, 1750
GlobalSendKey1()
Sleep, %HB1Speed%
GlobalSendKey2()
Sleep, %HB1Speed%
GlobalSendKey3()
Sleep, %HB1Speed%
GlobalSendKey4()
Sleep, %HB1Speed%
GlobalSendKey5()
Sleep, %HB1Speed%
GlobalSendKey6()
Sleep, %HB1Speed%
GlobalSendKey7()
Sleep, %HB1Speed%
GlobalSendKey8()
Sleep, %HB1Speed%
GlobalSendKey9()
Sleep, %HB1Speed%
GlobalSendKey0()
Sleep, 1500

TransitionFrom1To2()
SetTimer, IssueHB1all, Off
    Return
}
Else
{
    MsgBox, NULL ERROR   @    { ICvarDisableRow1 } The value parse returned blank.  ;;; Script will now act as though this setting is at 0.
    Return
}
Return


IssueHB2all:   ;;; (Issue Hotbar 2 ALL)
IniRead, ICvarDisableRow2, buff_core.ini, MODULE, Disable_Row_2, ;;;%IniKeyErrorElevate%
If(ICvarDisableRow2 = 1)
{
    Sleep, 10
    TransitionFrom2To3()
    SetTimer, IssueHB2all, Off
    Return
}
Else If(ICvarDisableRow2 = 0)
{
    GLOBAL LastRowSent := "2"
    GLOBAL stackSetStatus := "ACTIVE"
    GuiControl, Text, LastLoopRow, %LastRowSent%
    GuiControl, Text, LoopStateText, %stackSetStatus%

TurnAllTimersOff2()
DoShiftHotbarTo2()
Sleep, 1800
; GlobalSendKeyF1()
; Sleep, %HB2Speed%
GlobalSendKey1()
Sleep, %HB2Speed%
GlobalSendKey2()
Sleep, %HB2Speed%
GlobalSendKey3()
Sleep, %HB2Speed%
GlobalSendKey4()
Sleep, %HB2Speed%
GlobalSendKey5()
Sleep, %HB2Speed%
GlobalSendKey6()
Sleep, %HB2Speed%
GlobalSendKey7()
Sleep, %HB2Speed%
GlobalSendKey8()
Sleep, %HB2Speed%
GlobalSendKey9()
Sleep, %HB2Speed%
GlobalSendKey0()
Sleep, 1500

TransitionFrom2To3()
SetTimer, IssueHB2all, Off
    Return
}
Else
{
    MsgBox, NULL ERROR   @    { ICvarDisableRow2 } The value parse returned blank.  ;;; Script will now act as though this setting is at 0.
    Return
}
Return


IssueHB3all:   ;;; (Issue Hotbar 2 ALL)
IniRead, ICvarDisableRow3, buff_core.ini, MODULE, Disable_Row_3, ;;;%IniKeyErrorElevate%
If(ICvarDisableRow3 = 1)
{
    Sleep, 10
    TransitionFrom3ToEnd()
    SetTimer, IssueHB3all, Off
    Return
}
Else If(ICvarDisableRow3 = 0)
{
    GLOBAL LastRowSent := "3"
    GLOBAL stackSetStatus := "ACTIVE"
    GuiControl, Text, LastLoopRow, %LastRowSent%
    GuiControl, Text, LoopStateText, %stackSetStatus%

TurnAllTimersOff3()
DoShiftHotbarTo3()
Sleep, 1800

; GlobalSendKeyF1()
; Sleep, %HB3Speed%
GlobalSendKey1()
Sleep, %HB3Speed%
GlobalSendKey2()
Sleep, %HB3Speed%
GlobalSendKey3()
Sleep, %HB3Speed%
GlobalSendKey4()
Sleep, %HB3Speed%
GlobalSendKey5()
Sleep, %HB3Speed%
GlobalSendKey6()
Sleep, %HB3Speed%
GlobalSendKey7()
Sleep, %HB3Speed%
GlobalSendKey8()
Sleep, %HB3Speed%
GlobalSendKey9()
Sleep, %HB3Speed%
GlobalSendKey0()
Sleep, 1500

    GLOBAL LastRowSent := ThirdHotBarRow   ;;; make the LastRowSent string equal to the selected third and final buffing hotbar, as we have reached the end of the loop logic
    GLOBAL stackSetStatus := "COMPLETE"
    GuiControl, Text, LoopStateText, %stackSetStatus%
    WinActivate, Layers

TransitionFrom3ToEnd()
SetTimer, IssueHB3all, Off
    Return
}
Else
{
    MsgBox, NULL ERROR   @    { ICvarDisableRow3 } The value parse returned blank.  ;;; Script will now act as though this setting is at 0.
    Return
}
Return





DoShiftHotbarTo1()   ;;;; Activate all character windows, using shift + Row Number, where Row Number = the hotbar row we wish to select for the 1st round of buffs
{
    WinActivate, Anarchy Online - %ClientCharSlot1%
    WinWaitActive, Anarchy Online - %ClientCharSlot1%
    Send {Shift DOWN}
    Sleep, 50
    Send {%FirstHotBarRow%}
    Sleep, 50
    Send {Shift UP}
    Sleep, 800

    WinActivate, Anarchy Online - %ClientCharSlot2%
    WinWaitActive, Anarchy Online - %ClientCharSlot2%
    Send {Shift DOWN}
    Sleep, 50
    Send {%FirstHotBarRow%}
    Sleep, 50
    Send {Shift UP}
    Sleep, 800

    WinActivate, Anarchy Online - %ClientCharSlot3%
    WinWaitActive, Anarchy Online - %ClientCharSlot3%
    Send {Shift DOWN}
    Sleep, 50
    Send {%FirstHotBarRow%}
    Sleep, 50
    Send {Shift UP}
    Sleep, 800

    WinActivate, Anarchy Online - %ClientCharSlot4%
    WinWaitActive, Anarchy Online - %ClientCharSlot4%
    Send {Shift DOWN}
    Sleep, 50
    Send {%FirstHotBarRow%}
    Sleep, 50
    Send {Shift UP}
    Sleep, 800

    WinActivate, Anarchy Online - %ClientCharSlot5%
    WinWaitActive, Anarchy Online - %ClientCharSlot5%
    Send {Shift DOWN}
    Sleep, 50
    Send {%FirstHotBarRow%}
    Sleep, 50
    Send {Shift UP}
    Sleep, 800

    WinActivate, Anarchy Online - %ClientCharSlot6%
    WinWaitActive, Anarchy Online - %ClientCharSlot6%
    Send {Shift DOWN}
    Sleep, 50
    Send {%FirstHotBarRow%}
    Sleep, 50
    Send {Shift UP}
    Sleep, 800
}


DoShiftHotbarTo2()   ;;;; Activate all character windows, using shift + Row Number, where Row Number = the hotbar row we wish to select for the 2nd round of buffs
{
    WinActivate, Anarchy Online - %ClientCharSlot1%
    WinWaitActive, Anarchy Online - %ClientCharSlot1%
    Send {Shift DOWN}
    Sleep, 50
    Send {%SecondHotBarRow%}
    Sleep, 50
    Send {Shift UP}
    Sleep, 800

    WinActivate, Anarchy Online - %ClientCharSlot2%
    WinWaitActive, Anarchy Online - %ClientCharSlot2%
    Send {Shift DOWN}
    Sleep, 50
    Send {%SecondHotBarRow%}
    Sleep, 50
    Send {Shift UP}
    Sleep, 800

    WinActivate, Anarchy Online - %ClientCharSlot3%
    WinWaitActive, Anarchy Online - %ClientCharSlot3%
    Send {Shift DOWN}
    Sleep, 50
    Send {%SecondHotBarRow%}
    Sleep, 50
    Send {Shift UP}
    Sleep, 800

    WinActivate, Anarchy Online - %ClientCharSlot4%
    WinWaitActive, Anarchy Online - %ClientCharSlot4%
    Send {Shift DOWN}
    Sleep, 50
    Send {%SecondHotBarRow%}
    Sleep, 50
    Send {Shift UP}
    Sleep, 800

    WinActivate, Anarchy Online - %ClientCharSlot5%
    WinWaitActive, Anarchy Online - %ClientCharSlot5%
    Send {Shift DOWN}
    Sleep, 50
    Send {%SecondHotBarRow%}
    Sleep, 50
    Send {Shift UP}
    Sleep, 800

    WinActivate, Anarchy Online - %ClientCharSlot6%
    WinWaitActive, Anarchy Online - %ClientCharSlot6%
    Send {Shift DOWN}
    Sleep, 50
    Send {%SecondHotBarRow%}
    Sleep, 50
    Send {Shift UP}
    Sleep, 800
}



DoShiftHotbarTo3()   ;;;; Activate all character windows, using shift + Row Number, where Row Number = the hotbar row we wish to select for the 3rd round of buffs
{
    WinActivate, Anarchy Online - %ClientCharSlot1%
    WinWaitActive, Anarchy Online - %ClientCharSlot1%
    Send {Shift DOWN}
    Sleep, 50
    Send {%ThirdHotBarRow%}
    Sleep, 50
    Send {Shift UP}
    Sleep, 800

    WinActivate, Anarchy Online - %ClientCharSlot2%
    WinWaitActive, Anarchy Online - %ClientCharSlot2%
    Send {Shift DOWN}
    Sleep, 50
    Send {%ThirdHotBarRow%}
    Sleep, 50
    Send {Shift UP}
    Sleep, 800

    WinActivate, Anarchy Online - %ClientCharSlot3%
    WinWaitActive, Anarchy Online - %ClientCharSlot3%
    Send {Shift DOWN}
    Sleep, 50
    Send {%ThirdHotBarRow%}
    Sleep, 50
    Send {Shift UP}
    Sleep, 800

    WinActivate, Anarchy Online - %ClientCharSlot4%
    WinWaitActive, Anarchy Online - %ClientCharSlot4%
    Send {Shift DOWN}
    Sleep, 50
    Send {%ThirdHotBarRow%}
    Sleep, 50
    Send {Shift UP}
    Sleep, 800

    WinActivate, Anarchy Online - %ClientCharSlot5%
    WinWaitActive, Anarchy Online - %ClientCharSlot5%
    Send {Shift DOWN}
    Sleep, 50
    Send {%ThirdHotBarRow%}
    Sleep, 50
    Send {Shift UP}
    Sleep, 800

    WinActivate, Anarchy Online - %ClientCharSlot6%
    WinWaitActive, Anarchy Online - %ClientCharSlot6%
    Send {Shift DOWN}
    Sleep, 50
    Send {%ThirdHotBarRow%}
    Sleep, 50
    Send {Shift UP}
    Sleep, 800
}















; TransitionFromStart()
; {
;     SetTimer, IssueHB1all, -100   ;;;  run the next timer only once
;     ; SetTimer, IssueHB1all, Off
;     ; SetTimer, IssueHB3all, Off
;     ; Return
; }




TurnAllTimersOff1()
{
    SetTimer, IssueHB2all, Off
    SetTimer, IssueHB3all, Off
    ; Return
}

TransitionFrom1To2()
{
    SetTimer, IssueHB2all, -100   ;;;  run the next timer only once
    ; SetTimer, IssueHB1all, Off
    ; SetTimer, IssueHB3all, Off
    ; Return
}









TurnAllTimersOff2()
{
    SetTimer, IssueHB1all, Off
    SetTimer, IssueHB3all, Off
    ; Return
}

TransitionFrom2To3()
{
    SetTimer, IssueHB3all, -100   ;;;  run the next timer only once
    ; SetTimer, IssueHB1all, Off
    ; SetTimer, IssueHB3all, Off
    ; Return
}









TurnAllTimersOff3()
{
    SetTimer, IssueHB1all, Off
    SetTimer, IssueHB2all, Off
    ; Return
}

TransitionFrom3ToEnd()
{
    SetTimer, IssueHB3all, -100   ;;;  run the next timer only once
    ; SetTimer, IssueHB1all, Off
    ; SetTimer, IssueHB3all, Off
    ; Return
}




GlobalSendKeyF1()
{
    GLOBAL LastKeySent := "F1"
ControlSend,ahk_parent, {f1}, Anarchy Online - %ClientCharSlot1%
ControlSend,ahk_parent, {f1}, Anarchy Online - %ClientCharSlot2%
ControlSend,ahk_parent, {f1}, Anarchy Online - %ClientCharSlot3%
ControlSend,ahk_parent, {f1}, Anarchy Online - %ClientCharSlot4%
ControlSend,ahk_parent, {f1}, Anarchy Online - %ClientCharSlot5%
ControlSend,ahk_parent, {f1}, Anarchy Online - %ClientCharSlot6%
}


GlobalSendKey1()
{
    GLOBAL LastKeySent := "1"
ControlSend,ahk_parent, {1}, Anarchy Online - %ClientCharSlot1%
ControlSend,ahk_parent, {1}, Anarchy Online - %ClientCharSlot2%
ControlSend,ahk_parent, {1}, Anarchy Online - %ClientCharSlot3%
ControlSend,ahk_parent, {1}, Anarchy Online - %ClientCharSlot4%
ControlSend,ahk_parent, {1}, Anarchy Online - %ClientCharSlot5%
ControlSend,ahk_parent, {1}, Anarchy Online - %ClientCharSlot6%
}


GlobalSendKey2()
{
        GLOBAL LastKeySent := "2"
ControlSend,ahk_parent, {2}, Anarchy Online - %ClientCharSlot1%
ControlSend,ahk_parent, {2}, Anarchy Online - %ClientCharSlot2%
ControlSend,ahk_parent, {2}, Anarchy Online - %ClientCharSlot3%
ControlSend,ahk_parent, {2}, Anarchy Online - %ClientCharSlot4%
ControlSend,ahk_parent, {2}, Anarchy Online - %ClientCharSlot5%
ControlSend,ahk_parent, {2}, Anarchy Online - %ClientCharSlot6%
}


GlobalSendKey3()
{
            GLOBAL LastKeySent := "3"
ControlSend,ahk_parent, {3}, Anarchy Online - %ClientCharSlot1%
ControlSend,ahk_parent, {3}, Anarchy Online - %ClientCharSlot2%
ControlSend,ahk_parent, {3}, Anarchy Online - %ClientCharSlot3%
ControlSend,ahk_parent, {3}, Anarchy Online - %ClientCharSlot4%
ControlSend,ahk_parent, {3}, Anarchy Online - %ClientCharSlot5%
ControlSend,ahk_parent, {3}, Anarchy Online - %ClientCharSlot6%
}


GlobalSendKey4()
{
                GLOBAL LastKeySent := "4"
ControlSend,ahk_parent, {4}, Anarchy Online - %ClientCharSlot1%
ControlSend,ahk_parent, {4}, Anarchy Online - %ClientCharSlot2%
ControlSend,ahk_parent, {4}, Anarchy Online - %ClientCharSlot3%
ControlSend,ahk_parent, {4}, Anarchy Online - %ClientCharSlot4%
ControlSend,ahk_parent, {4}, Anarchy Online - %ClientCharSlot5%
ControlSend,ahk_parent, {4}, Anarchy Online - %ClientCharSlot6%
}


GlobalSendKey5()
{
                    GLOBAL LastKeySent := "5"
ControlSend,ahk_parent, {5}, Anarchy Online - %ClientCharSlot1%
ControlSend,ahk_parent, {5}, Anarchy Online - %ClientCharSlot2%
ControlSend,ahk_parent, {5}, Anarchy Online - %ClientCharSlot3%
ControlSend,ahk_parent, {5}, Anarchy Online - %ClientCharSlot4%
ControlSend,ahk_parent, {5}, Anarchy Online - %ClientCharSlot5%
ControlSend,ahk_parent, {5}, Anarchy Online - %ClientCharSlot6%
}


GlobalSendKey6()
{
                        GLOBAL LastKeySent := "6"
ControlSend,ahk_parent, {6}, Anarchy Online - %ClientCharSlot1%
ControlSend,ahk_parent, {6}, Anarchy Online - %ClientCharSlot2%
ControlSend,ahk_parent, {6}, Anarchy Online - %ClientCharSlot3%
ControlSend,ahk_parent, {6}, Anarchy Online - %ClientCharSlot4%
ControlSend,ahk_parent, {6}, Anarchy Online - %ClientCharSlot5%
ControlSend,ahk_parent, {6}, Anarchy Online - %ClientCharSlot6%
}


GlobalSendKey7()
{
                            GLOBAL LastKeySent := "7"
ControlSend,ahk_parent, {7}, Anarchy Online - %ClientCharSlot1%
ControlSend,ahk_parent, {7}, Anarchy Online - %ClientCharSlot2%
ControlSend,ahk_parent, {7}, Anarchy Online - %ClientCharSlot3%
ControlSend,ahk_parent, {7}, Anarchy Online - %ClientCharSlot4%
ControlSend,ahk_parent, {7}, Anarchy Online - %ClientCharSlot5%
ControlSend,ahk_parent, {7}, Anarchy Online - %ClientCharSlot6%
}


GlobalSendKey8()
{
                                GLOBAL LastKeySent := "8"
ControlSend,ahk_parent, {8}, Anarchy Online - %ClientCharSlot1%
ControlSend,ahk_parent, {8}, Anarchy Online - %ClientCharSlot2%
ControlSend,ahk_parent, {8}, Anarchy Online - %ClientCharSlot3%
ControlSend,ahk_parent, {8}, Anarchy Online - %ClientCharSlot4%
ControlSend,ahk_parent, {8}, Anarchy Online - %ClientCharSlot5%
ControlSend,ahk_parent, {8}, Anarchy Online - %ClientCharSlot6%
}


GlobalSendKey9()
{
                                    GLOBAL LastKeySent := "9"
ControlSend,ahk_parent, {9}, Anarchy Online - %ClientCharSlot1%
ControlSend,ahk_parent, {9}, Anarchy Online - %ClientCharSlot2%
ControlSend,ahk_parent, {9}, Anarchy Online - %ClientCharSlot3%
ControlSend,ahk_parent, {9}, Anarchy Online - %ClientCharSlot4%
ControlSend,ahk_parent, {9}, Anarchy Online - %ClientCharSlot5%
ControlSend,ahk_parent, {9}, Anarchy Online - %ClientCharSlot6%
}


GlobalSendKey0()
{
                                        GLOBAL LastKeySent := "0"
ControlSend,ahk_parent, {0}, Anarchy Online - %ClientCharSlot1%
ControlSend,ahk_parent, {0}, Anarchy Online - %ClientCharSlot2%
ControlSend,ahk_parent, {0}, Anarchy Online - %ClientCharSlot3%
ControlSend,ahk_parent, {0}, Anarchy Online - %ClientCharSlot4%
ControlSend,ahk_parent, {0}, Anarchy Online - %ClientCharSlot5%
ControlSend,ahk_parent, {0}, Anarchy Online - %ClientCharSlot6%
}