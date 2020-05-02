#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


IniRead, ICvarCHAR01, buff_core.ini, CLIENT, CharacterName_01, ;;;%IniKeyErrorElevate%
IniRead, ICvarCHAR02, buff_core.ini, CLIENT, CharacterName_02, ;;;%IniKeyErrorElevate%
IniRead, ICvarCHAR03, buff_core.ini, CLIENT, CharacterName_03, ;;;%IniKeyErrorElevate%
IniRead, ICvarCHAR04, buff_core.ini, CLIENT, CharacterName_04, ;;;%IniKeyErrorElevate%
IniRead, ICvarCHAR05, buff_core.ini, CLIENT, CharacterName_05, ;;;%IniKeyErrorElevate%
IniRead, ICvarCHAR06, buff_core.ini, CLIENT, CharacterName_06, ;;;%IniKeyErrorElevate%

IniRead, HB1SpeedMult, buff_core.ini, VELOCITY, First_HotbarRow_Speed, ;;;%IniKeyErrorElevate%
IniRead, HB2SpeedMult, buff_core.ini, VELOCITY, Second_HotbarRow_Speed, ;;;%IniKeyErrorElevate%
IniRead, HB3SpeedMult, buff_core.ini, VELOCITY, Third_HotbarRow_Speed, ;;;%IniKeyErrorElevate%








GLOBAL cl_char01 := "Anarchy Online - " . ICvarCHAR01

MsgBox, %cl_char01%

    If WinExist(cl_char01)
    {
            MsgBox, WIN EXIST
    }
    Else
    {
            MsgBox, NO WIN EXIST
    }

ExitApp