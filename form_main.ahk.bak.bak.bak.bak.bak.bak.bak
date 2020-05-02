#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#Include, .\includes\_$IniLibrary.toolkit
#SingleInstance, Force



GLOBAL FirstHotBarRow := "6"   ;;; this is the number the system presses to actuate the 1st hotbar row to begin casting buffs
GLOBAL SecondHotBarRow := "7"   ;;; this is the number the system presses to actuate the 2nd hotbar row to begin casting buffs
GLOBAL ThirdHotBarRow := "8"   ;;; this is the number the system presses to actuate the 3rd hotbar row to begin casting buffs



GLOBAL ClientCharSlot2 := "Raidspirit"
GLOBAL ClientCharSlot1 := "Raidcaptain"



GLOBAL HB1Speed := "8000"
GLOBAL HB2Speed := "8000"
GLOBAL HB3Speed := "8000"





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
ini.write("ENGINE", "RunWithAdmin", "0", "`n`    Toggle Running With Administrator `n` `n`", "                   ENGINE OPTIONS (Configure these) `n`")
ini.write("CLIENT", "ThirdHotbarRow", "3", "`n`    The number of the third Hotbar Buffing Row `n` `n` `n` `n` `n`")
ini.write("CLIENT", "SecondHotbarRow", "2", "`n`    The number of the second Hotbar Buffing Row `n` `n` `n` `n` `n`")
ini.write("CLIENT", "FirstHotbarRow", "1", "`n`    The number of the first Hotbar Buffing Row (Ex. For Shift+1) `n` `n` `n` `n` `n`")
ini.write("CLIENT", "CharacterName_06", "NameHere", "`n`    Plays Sound when Quick Launching AO `n` `n` `n` `n` `n`")
ini.write("CLIENT", "CharacterName_05", "NameHere", "`n`    Plays Sound when Quick Launching AO `n` `n` `n`")
ini.write("CLIENT", "CharacterName_04", "NameHere", "`n`    Plays Sound when Quick Launching AO `n` `n` `n`")
ini.write("CLIENT", "CharacterName_03", "NameHere", "`n`    Plays Sound when Quick Launching AO `n` `n` `n`")
ini.write("CLIENT", "CharacterName_02", "NameHere", "`n`    Plays Sound when Quick Launching AO `n` `n` `n`")
ini.write("CLIENT", "CharacterName_01", "Raidcaptain", "`n`    Current character that sends tabs `n`    (CASE SENSITIVE) `n` `n` `n` ", "                   CLIENT OPTIONS (Configure these) `n` `n`")
; ini.write("SOUND", "QuickLaunch_AOIA", "1", "`n`    Plays Sound when Quick Launching AOIA `n` `n` `n` `n` `n`")
; ini.write("SOUND", "QuickLaunch_AOoldEngineSteam", "1", "`n`    Plays Sound when Quick Launching AO STEAM `n` `n` `n`")
; ini.write("SOUND", "QuickLaunch_AOoldEngine", "1", "`n`    Plays Sound when Quick Launching AO `n` `n` `n`")
; ini.write("SOUND", "LoopEnd", "1", "`n`    Plays Sound on loop end `n` `n` `n`")
; ini.write("SOUND", "LoopStart", "1", "`n`    Plays Sound on loop start `n` `n` `n`", "                   SOUND OPTIONS (Configure these) `n` `n`")
ini.write("VELOCITY", "F7SpeedDefault", "8100", "`n`    F7 Key LoopRate Default Speed `n` `n` `n` `n` `n`")
ini.write("VELOCITY", "FirstBuffRow_Speed", "8000", "`n`    M Key LoopRate Default Speed `n` `n`")
; ini.write("VELOCITY", "NSpeedDefault", "7900", "`n`    N Key LoopRate Default Speed `n` `n`")
; ini.write("VELOCITY", "BSpeedDefault", "7800", "`n`    B Key LoopRate Default Speed `n` `n`")
; ini.write("VELOCITY", "VSpeedDefault", "7700", "`n`    V Key LoopRate Default Speed `n` `n`")
; ini.write("VELOCITY", "LSpeedDefault", "7600", "`n`    L Key LoopRate Default Speed `n` `n`")
; ini.write("VELOCITY", "KSpeedDefault", "7500", "`n`    K Key LoopRate Default Speed `n` `n`")
; ini.write("VELOCITY", "JSpeedDefault", "7400", "`n`    J Key LoopRate Default Speed `n` `n`")
; ini.write("VELOCITY", "GSpeedDefault", "7300", "`n`    G Key LoopRate Default Speed `n` `n`")
; ini.write("VELOCITY", "FSpeedDefault", "7200", "`n`    F Key LoopRate Default Speed `n` `n`")
; ini.write("VELOCITY", "RSpeedDefault", "7100", "`n`    R Key LoopRate Default Speed `n` `n`")
; ini.write("VELOCITY", "ESpeedDefault", "7000", "`n`    E Key LoopRate Default Speed `n` `n`")
ini.write("VELOCITY", "TabSpeedDefault", "5000", "`n`    Tab Key LoopRate Default Speed (RaidLeader) `n` `n` `n`", "                   DEFAULT KEY LOOPING SPEEDS (MILLISECONDS)`n` `n`")
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


Gui, Show, w404 h464, Buff Pallette
Gui, Show, w404 h464, Automation Engine
Gui, Submit, NoHide






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
TurnAllTimersOff1()
DoShiftHotbarTo1()
Sleep, %HB1Speed%
ControlSend,ahk_parent, {1}, Anarchy Online - %ClientCharSlot1%
ControlSend,ahk_parent, {1}, Anarchy Online - %ClientCharSlot2%
ControlSend,ahk_parent, {1}, Anarchy Online - %ClientCharSlot3%
ControlSend,ahk_parent, {1}, Anarchy Online - %ClientCharSlot4%
ControlSend,ahk_parent, {1}, Anarchy Online - %ClientCharSlot5%
ControlSend,ahk_parent, {1}, Anarchy Online - %ClientCharSlot6%
Sleep, %HB1Speed%
ControlSend,ahk_parent, {2}, Anarchy Online - %ClientCharSlot1%
ControlSend,ahk_parent, {2}, Anarchy Online - %ClientCharSlot2%
ControlSend,ahk_parent, {2}, Anarchy Online - %ClientCharSlot3%
ControlSend,ahk_parent, {2}, Anarchy Online - %ClientCharSlot4%
ControlSend,ahk_parent, {2}, Anarchy Online - %ClientCharSlot5%
ControlSend,ahk_parent, {2}, Anarchy Online - %ClientCharSlot6%
Sleep, %HB1Speed%
ControlSend,ahk_parent, {3}, Anarchy Online - %ClientCharSlot1%
ControlSend,ahk_parent, {3}, Anarchy Online - %ClientCharSlot2%
ControlSend,ahk_parent, {3}, Anarchy Online - %ClientCharSlot3%
ControlSend,ahk_parent, {3}, Anarchy Online - %ClientCharSlot4%
ControlSend,ahk_parent, {3}, Anarchy Online - %ClientCharSlot5%
ControlSend,ahk_parent, {3}, Anarchy Online - %ClientCharSlot6%
Sleep, %HB1Speed%
ControlSend,ahk_parent, {4}, Anarchy Online - %ClientCharSlot1%
ControlSend,ahk_parent, {4}, Anarchy Online - %ClientCharSlot2%
ControlSend,ahk_parent, {4}, Anarchy Online - %ClientCharSlot3%
ControlSend,ahk_parent, {4}, Anarchy Online - %ClientCharSlot4%
ControlSend,ahk_parent, {4}, Anarchy Online - %ClientCharSlot5%
ControlSend,ahk_parent, {4}, Anarchy Online - %ClientCharSlot6%
Sleep, %HB1Speed%
ControlSend,ahk_parent, {4}, Anarchy Online - %ClientCharSlot1%
ControlSend,ahk_parent, {4}, Anarchy Online - %ClientCharSlot2%
ControlSend,ahk_parent, {4}, Anarchy Online - %ClientCharSlot3%
ControlSend,ahk_parent, {4}, Anarchy Online - %ClientCharSlot4%
ControlSend,ahk_parent, {4}, Anarchy Online - %ClientCharSlot5%
ControlSend,ahk_parent, {4}, Anarchy Online - %ClientCharSlot6%
Sleep, %HB1Speed%
ControlSend,ahk_parent, {5}, Anarchy Online - %ClientCharSlot1%
ControlSend,ahk_parent, {5}, Anarchy Online - %ClientCharSlot2%
ControlSend,ahk_parent, {5}, Anarchy Online - %ClientCharSlot3%
ControlSend,ahk_parent, {5}, Anarchy Online - %ClientCharSlot4%
ControlSend,ahk_parent, {5}, Anarchy Online - %ClientCharSlot5%
ControlSend,ahk_parent, {5}, Anarchy Online - %ClientCharSlot6%
Sleep, %HB1Speed%
ControlSend,ahk_parent, {6}, Anarchy Online - %ClientCharSlot1%
ControlSend,ahk_parent, {6}, Anarchy Online - %ClientCharSlot2%
ControlSend,ahk_parent, {6}, Anarchy Online - %ClientCharSlot3%
ControlSend,ahk_parent, {6}, Anarchy Online - %ClientCharSlot4%
ControlSend,ahk_parent, {6}, Anarchy Online - %ClientCharSlot5%
ControlSend,ahk_parent, {6}, Anarchy Online - %ClientCharSlot6%
Sleep, %HB1Speed%
ControlSend,ahk_parent, {7}, Anarchy Online - %ClientCharSlot1%
ControlSend,ahk_parent, {7}, Anarchy Online - %ClientCharSlot2%
ControlSend,ahk_parent, {7}, Anarchy Online - %ClientCharSlot3%
ControlSend,ahk_parent, {7}, Anarchy Online - %ClientCharSlot4%
ControlSend,ahk_parent, {7}, Anarchy Online - %ClientCharSlot5%
ControlSend,ahk_parent, {7}, Anarchy Online - %ClientCharSlot6%
Sleep, %HB1Speed%
ControlSend,ahk_parent, {8}, Anarchy Online - %ClientCharSlot1%
ControlSend,ahk_parent, {8}, Anarchy Online - %ClientCharSlot2%
ControlSend,ahk_parent, {8}, Anarchy Online - %ClientCharSlot3%
ControlSend,ahk_parent, {8}, Anarchy Online - %ClientCharSlot4%
ControlSend,ahk_parent, {8}, Anarchy Online - %ClientCharSlot5%
ControlSend,ahk_parent, {8}, Anarchy Online - %ClientCharSlot6%
Sleep, %HB1Speed%
ControlSend,ahk_parent, {9}, Anarchy Online - %ClientCharSlot1%
ControlSend,ahk_parent, {9}, Anarchy Online - %ClientCharSlot2%
ControlSend,ahk_parent, {9}, Anarchy Online - %ClientCharSlot3%
ControlSend,ahk_parent, {9}, Anarchy Online - %ClientCharSlot4%
ControlSend,ahk_parent, {9}, Anarchy Online - %ClientCharSlot5%
ControlSend,ahk_parent, {9}, Anarchy Online - %ClientCharSlot6%
Sleep, %HB1Speed%
ControlSend,ahk_parent, {0}, Anarchy Online - %ClientCharSlot1%
ControlSend,ahk_parent, {0}, Anarchy Online - %ClientCharSlot2%
ControlSend,ahk_parent, {0}, Anarchy Online - %ClientCharSlot3%
ControlSend,ahk_parent, {0}, Anarchy Online - %ClientCharSlot4%
ControlSend,ahk_parent, {0}, Anarchy Online - %ClientCharSlot5%
ControlSend,ahk_parent, {0}, Anarchy Online - %ClientCharSlot6%
Sleep, %HB1Speed%
TransitionFrom1To2()
SetTimer, IssueHB1all, Off
Return


IssueHB2all:   ;;; (Issue Hotbar 2 ALL)
TurnAllTimersOff2()
DoShiftHotbarTo2()
Sleep, %HB2Speed%
ControlSend,ahk_parent, {1}, Anarchy Online - %ClientCharSlot1%
ControlSend,ahk_parent, {1}, Anarchy Online - %ClientCharSlot2%
ControlSend,ahk_parent, {1}, Anarchy Online - %ClientCharSlot3%
ControlSend,ahk_parent, {1}, Anarchy Online - %ClientCharSlot4%
ControlSend,ahk_parent, {1}, Anarchy Online - %ClientCharSlot5%
ControlSend,ahk_parent, {1}, Anarchy Online - %ClientCharSlot6%
Sleep, %HB2Speed%
ControlSend,ahk_parent, {2}, Anarchy Online - %ClientCharSlot1%
ControlSend,ahk_parent, {2}, Anarchy Online - %ClientCharSlot2%
ControlSend,ahk_parent, {2}, Anarchy Online - %ClientCharSlot3%
ControlSend,ahk_parent, {2}, Anarchy Online - %ClientCharSlot4%
ControlSend,ahk_parent, {2}, Anarchy Online - %ClientCharSlot5%
ControlSend,ahk_parent, {2}, Anarchy Online - %ClientCharSlot6%
Sleep, %HB2Speed%
ControlSend,ahk_parent, {3}, Anarchy Online - %ClientCharSlot1%
ControlSend,ahk_parent, {3}, Anarchy Online - %ClientCharSlot2%
ControlSend,ahk_parent, {3}, Anarchy Online - %ClientCharSlot3%
ControlSend,ahk_parent, {3}, Anarchy Online - %ClientCharSlot4%
ControlSend,ahk_parent, {3}, Anarchy Online - %ClientCharSlot5%
ControlSend,ahk_parent, {3}, Anarchy Online - %ClientCharSlot6%
Sleep, %HB2Speed%
ControlSend,ahk_parent, {4}, Anarchy Online - %ClientCharSlot1%
ControlSend,ahk_parent, {4}, Anarchy Online - %ClientCharSlot2%
ControlSend,ahk_parent, {4}, Anarchy Online - %ClientCharSlot3%
ControlSend,ahk_parent, {4}, Anarchy Online - %ClientCharSlot4%
ControlSend,ahk_parent, {4}, Anarchy Online - %ClientCharSlot5%
ControlSend,ahk_parent, {4}, Anarchy Online - %ClientCharSlot6%
Sleep, %HB2Speed%
ControlSend,ahk_parent, {4}, Anarchy Online - %ClientCharSlot1%
ControlSend,ahk_parent, {4}, Anarchy Online - %ClientCharSlot2%
ControlSend,ahk_parent, {4}, Anarchy Online - %ClientCharSlot3%
ControlSend,ahk_parent, {4}, Anarchy Online - %ClientCharSlot4%
ControlSend,ahk_parent, {4}, Anarchy Online - %ClientCharSlot5%
ControlSend,ahk_parent, {4}, Anarchy Online - %ClientCharSlot6%
Sleep, %HB2Speed%
ControlSend,ahk_parent, {5}, Anarchy Online - %ClientCharSlot1%
ControlSend,ahk_parent, {5}, Anarchy Online - %ClientCharSlot2%
ControlSend,ahk_parent, {5}, Anarchy Online - %ClientCharSlot3%
ControlSend,ahk_parent, {5}, Anarchy Online - %ClientCharSlot4%
ControlSend,ahk_parent, {5}, Anarchy Online - %ClientCharSlot5%
ControlSend,ahk_parent, {5}, Anarchy Online - %ClientCharSlot6%
Sleep, %HB2Speed%
ControlSend,ahk_parent, {6}, Anarchy Online - %ClientCharSlot1%
ControlSend,ahk_parent, {6}, Anarchy Online - %ClientCharSlot2%
ControlSend,ahk_parent, {6}, Anarchy Online - %ClientCharSlot3%
ControlSend,ahk_parent, {6}, Anarchy Online - %ClientCharSlot4%
ControlSend,ahk_parent, {6}, Anarchy Online - %ClientCharSlot5%
ControlSend,ahk_parent, {6}, Anarchy Online - %ClientCharSlot6%
Sleep, %HB2Speed%
ControlSend,ahk_parent, {7}, Anarchy Online - %ClientCharSlot1%
ControlSend,ahk_parent, {7}, Anarchy Online - %ClientCharSlot2%
ControlSend,ahk_parent, {7}, Anarchy Online - %ClientCharSlot3%
ControlSend,ahk_parent, {7}, Anarchy Online - %ClientCharSlot4%
ControlSend,ahk_parent, {7}, Anarchy Online - %ClientCharSlot5%
ControlSend,ahk_parent, {7}, Anarchy Online - %ClientCharSlot6%
Sleep, %HB2Speed%
ControlSend,ahk_parent, {8}, Anarchy Online - %ClientCharSlot1%
ControlSend,ahk_parent, {8}, Anarchy Online - %ClientCharSlot2%
ControlSend,ahk_parent, {8}, Anarchy Online - %ClientCharSlot3%
ControlSend,ahk_parent, {8}, Anarchy Online - %ClientCharSlot4%
ControlSend,ahk_parent, {8}, Anarchy Online - %ClientCharSlot5%
ControlSend,ahk_parent, {8}, Anarchy Online - %ClientCharSlot6%
Sleep, %HB2Speed%
ControlSend,ahk_parent, {9}, Anarchy Online - %ClientCharSlot1%
ControlSend,ahk_parent, {9}, Anarchy Online - %ClientCharSlot2%
ControlSend,ahk_parent, {9}, Anarchy Online - %ClientCharSlot3%
ControlSend,ahk_parent, {9}, Anarchy Online - %ClientCharSlot4%
ControlSend,ahk_parent, {9}, Anarchy Online - %ClientCharSlot5%
ControlSend,ahk_parent, {9}, Anarchy Online - %ClientCharSlot6%
Sleep, %HB2Speed%
ControlSend,ahk_parent, {0}, Anarchy Online - %ClientCharSlot1%
ControlSend,ahk_parent, {0}, Anarchy Online - %ClientCharSlot2%
ControlSend,ahk_parent, {0}, Anarchy Online - %ClientCharSlot3%
ControlSend,ahk_parent, {0}, Anarchy Online - %ClientCharSlot4%
ControlSend,ahk_parent, {0}, Anarchy Online - %ClientCharSlot5%
ControlSend,ahk_parent, {0}, Anarchy Online - %ClientCharSlot6%
Sleep, %HB2Speed%
TransitionFrom2To3()
SetTimer, IssueHB2all, Off
Return


IssueHB3all:   ;;; (Issue Hotbar 2 ALL)
TurnAllTimersOff3()
DoShiftHotbarTo3()
Sleep, %HB3Speed%
ControlSend,ahk_parent, {1}, Anarchy Online - %ClientCharSlot1%
ControlSend,ahk_parent, {1}, Anarchy Online - %ClientCharSlot2%
ControlSend,ahk_parent, {1}, Anarchy Online - %ClientCharSlot3%
ControlSend,ahk_parent, {1}, Anarchy Online - %ClientCharSlot4%
ControlSend,ahk_parent, {1}, Anarchy Online - %ClientCharSlot5%
ControlSend,ahk_parent, {1}, Anarchy Online - %ClientCharSlot6%
Sleep, %HB3Speed%
ControlSend,ahk_parent, {2}, Anarchy Online - %ClientCharSlot1%
ControlSend,ahk_parent, {2}, Anarchy Online - %ClientCharSlot2%
ControlSend,ahk_parent, {2}, Anarchy Online - %ClientCharSlot3%
ControlSend,ahk_parent, {2}, Anarchy Online - %ClientCharSlot4%
ControlSend,ahk_parent, {2}, Anarchy Online - %ClientCharSlot5%
ControlSend,ahk_parent, {2}, Anarchy Online - %ClientCharSlot6%
Sleep, %HB3Speed%
ControlSend,ahk_parent, {3}, Anarchy Online - %ClientCharSlot1%
ControlSend,ahk_parent, {3}, Anarchy Online - %ClientCharSlot2%
ControlSend,ahk_parent, {3}, Anarchy Online - %ClientCharSlot3%
ControlSend,ahk_parent, {3}, Anarchy Online - %ClientCharSlot4%
ControlSend,ahk_parent, {3}, Anarchy Online - %ClientCharSlot5%
ControlSend,ahk_parent, {3}, Anarchy Online - %ClientCharSlot6%
Sleep, %HB3Speed%
ControlSend,ahk_parent, {4}, Anarchy Online - %ClientCharSlot1%
ControlSend,ahk_parent, {4}, Anarchy Online - %ClientCharSlot2%
ControlSend,ahk_parent, {4}, Anarchy Online - %ClientCharSlot3%
ControlSend,ahk_parent, {4}, Anarchy Online - %ClientCharSlot4%
ControlSend,ahk_parent, {4}, Anarchy Online - %ClientCharSlot5%
ControlSend,ahk_parent, {4}, Anarchy Online - %ClientCharSlot6%
Sleep, %HB3Speed%
ControlSend,ahk_parent, {4}, Anarchy Online - %ClientCharSlot1%
ControlSend,ahk_parent, {4}, Anarchy Online - %ClientCharSlot2%
ControlSend,ahk_parent, {4}, Anarchy Online - %ClientCharSlot3%
ControlSend,ahk_parent, {4}, Anarchy Online - %ClientCharSlot4%
ControlSend,ahk_parent, {4}, Anarchy Online - %ClientCharSlot5%
ControlSend,ahk_parent, {4}, Anarchy Online - %ClientCharSlot6%
Sleep, %HB3Speed%
ControlSend,ahk_parent, {5}, Anarchy Online - %ClientCharSlot1%
ControlSend,ahk_parent, {5}, Anarchy Online - %ClientCharSlot2%
ControlSend,ahk_parent, {5}, Anarchy Online - %ClientCharSlot3%
ControlSend,ahk_parent, {5}, Anarchy Online - %ClientCharSlot4%
ControlSend,ahk_parent, {5}, Anarchy Online - %ClientCharSlot5%
ControlSend,ahk_parent, {5}, Anarchy Online - %ClientCharSlot6%
Sleep, %HB3Speed%
ControlSend,ahk_parent, {6}, Anarchy Online - %ClientCharSlot1%
ControlSend,ahk_parent, {6}, Anarchy Online - %ClientCharSlot2%
ControlSend,ahk_parent, {6}, Anarchy Online - %ClientCharSlot3%
ControlSend,ahk_parent, {6}, Anarchy Online - %ClientCharSlot4%
ControlSend,ahk_parent, {6}, Anarchy Online - %ClientCharSlot5%
ControlSend,ahk_parent, {6}, Anarchy Online - %ClientCharSlor6%
Sleep, %HB3Speed%
ControlSend,ahk_parent, {7}, Anarchy Online - %ClientCharSlot1%
ControlSend,ahk_parent, {7}, Anarchy Online - %ClientCharSlot2%
ControlSend,ahk_parent, {7}, Anarchy Online - %ClientCharSlot3%
ControlSend,ahk_parent, {7}, Anarchy Online - %ClientCharSlot4%
ControlSend,ahk_parent, {7}, Anarchy Online - %ClientCharSlot5%
ControlSend,ahk_parent, {7}, Anarchy Online - %ClientCharSlot6%
Sleep, %HB3Speed%
ControlSend,ahk_parent, {8}, Anarchy Online - %ClientCharSlot1%
ControlSend,ahk_parent, {8}, Anarchy Online - %ClientCharSlot2%
ControlSend,ahk_parent, {8}, Anarchy Online - %ClientCharSlot3%
ControlSend,ahk_parent, {8}, Anarchy Online - %ClientCharSlot4%
ControlSend,ahk_parent, {8}, Anarchy Online - %ClientCharSlot5%
ControlSend,ahk_parent, {8}, Anarchy Online - %ClientCharSlot6%
Sleep, %HB3Speed%
ControlSend,ahk_parent, {9}, Anarchy Online - %ClientCharSlot1%
ControlSend,ahk_parent, {9}, Anarchy Online - %ClientCharSlot2%
ControlSend,ahk_parent, {9}, Anarchy Online - %ClientCharSlot3%
ControlSend,ahk_parent, {9}, Anarchy Online - %ClientCharSlot4%
ControlSend,ahk_parent, {9}, Anarchy Online - %ClientCharSlot5%
ControlSend,ahk_parent, {9}, Anarchy Online - %ClientCharSlot6%
Sleep, %HB3Speed%
ControlSend,ahk_parent, {0}, Anarchy Online - %ClientCharSlot1%
ControlSend,ahk_parent, {0}, Anarchy Online - %ClientCharSlot2%
ControlSend,ahk_parent, {0}, Anarchy Online - %ClientCharSlot3%
ControlSend,ahk_parent, {0}, Anarchy Online - %ClientCharSlot4%
ControlSend,ahk_parent, {0}, Anarchy Online - %ClientCharSlot5%
ControlSend,ahk_parent, {0}, Anarchy Online - %ClientCharSlot6%
Sleep, %HB3Speed%
TransitionFrom3ToEnd()
SetTimer, IssueHB3all, Off
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