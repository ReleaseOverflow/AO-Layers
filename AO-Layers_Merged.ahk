#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance, Force


class AhkIni

{

	__New(IniFile)

	{

		;[Section]_[section]_=com

		;[section]_key_=com

		;[section]_key



		this.file := {} , this.listing := {} , this.Inifile := Inifile , listct := 1 , trending_com := "top"

		

		if !FileExist(Inifile)

			FileAppend,% emptyvar,% Inifile

		

		this.listing[1] := "top_=com"



		loop, read,% IniFile

		{

			cl := Trim(A_loopreadline)

			if Instr(cl, "[") = 1

			{

				this.file[cl] := cl

				trending_com := cl "_" cl, trending_sec := cl

				

				this.listing[listct := listct+1] := cl	;section

				this.listing[listct := listct+1] := cl "_" cl "_=com" 		;section comment

			}

			else if Instr(cl, ";") = 1

			{

				cl := Trim( Substr(cl,2) )

		

				if ( com_bk != trending_com "_=com" )

					this.file[com_bk] := Substr( this.file[com_bk] , 1, -1)

				com_bk := trending_com "_=com"

				

				this.file[com_bk] .= cl "`n"

			}

			else if Instr(cl, "=")

			{

				key := Trim( Substr(cl, 1, Instr(cl, "=")-1) )

				value := Trim( Substr( cl, Instr(cl, "=")+1 ) )

				

				this.file[trending_sec "_" key] := value , trending_com := trending_sec "_" key

				this.file[trending_sec "_" key "_=com"] := ""

				

				this.listing[listct := listct+1] := trending_sec "_" key

				this.listing[listct := listct+1] := trending_sec "_" key "_=com"

 			}

		}

		

		this.file[com_bk] := Rtrim(this.file[com_bk], "`n")

	}



	;Read()

	;	If section="", the list of section separated by linefeeds is returned

	;	If key="" , the list of keys in the section separated by LFs is returned



	Read(Section="", Key="", Byref Key_com="", ByRef Sec_com="")

	{

		IF Section = 

		{

			for k, v in this.listing

				if ( Instr(v, "]", 0, 0) == StrLen(v))

					toreturn .= Substr(this.file[v], 2, -1) "`r`n"

			return Substr(toreturn, 1, -2)

		}

		Else if key = 

		{

			Section := "[" Section "]"



			for k, v in this.listing

				if ( Instr(v, Section) == 1 ) && ( v != Section )

					if ( Substr(v, -4) != "_=com" )

						toreturn .= Substr(v, Instr(v, "]_", 0, 0)+2) "`r`n"

			return SubStr(toreturn, 1, -2)

		}

		else

		{

			Section := "[" Section "]"

			Key_com := this.file[Section "_" key "_=com"]

			Sec_com := this.file[Section "_" Section "_=com"]

			return this.file[Section "_" key]

		}

	}



	;Write()

	;	Specify Key_com // Sec_com as a space to delete existing linked comments to a key // section

	;	To not disturb existing comments, don't pass the Key_com and Sec_com params i.e. pass them as blank



	Write(Section, Key, Value, Key_com="", Sec_com="")

	{

		Section := "[" Section "]"

		

		if ( this.file[Section] == "" )

		{

			listingct := this.listing.MaxIndex()

			this.listing[listingct+1] := Section

			this.listing[listingct+2] := Section "_" Section "_=com"

			this.listing[listingct+3] := Section "_" Key

			this.listing[listingct+4] := Section "_" key "_=com"

		}

		else if ( this.file[Section "_" Key] == "" )

		{

			for k, v in this.listing

				if Instr(v, Section) = 1

				{

					ins_index := A_Index+1		;insert +1 after this

					break

				}

				

			list_index := this.listing.maxindex()

			loop,% list_index - ins_index

				this.listing[list_index+3-A_index] := this.listing[list_index+1-A_index]

			

			this.listing[ins_index+1] := Section "_" Key

			this.listing[ins_index+2] := Section "_" Key "_=com"

		}

		

		this.file[Section] := Section

		if Sec_com = %A_space%

			this.file[Section "_" Section "_=com"] := ""

		else if Sec_com != 

			this.file[Section "_" Section "_=com"] := Sec_com



		this.file[Section "_" Key] := value

		

		if Key_com = %A_space%

			this.file[Section "_" Key "_=com"] := ""

		else if Key_com != 

			this.file[Section "_" Key "_=com"] := Key_com

		return

	}

	

	;Delete()

	;	If section="" , the whole Ini file data will get deleted



	Delete(Section="", Key="")

	{

		Section := "[" Section "]"



		If Section = []

		{

			FileDelete,% this.Inifile

			FileAppend,% emtpyvar,% this.Inifile

		}

		else if Key = 

		{

			for keyC, valueC in this.listing

				if Instr(valueC, Section) = 1

					R := this.file.Remove(valueC) , R := this.listing.Remove(keyC)

		} 

		else

			R := this.file.Remove(Section "_" Key) , R := this.file.Remove(Section "_" Key "_=com")

	}

	

	;Save()

	;	Saves the changes made in memory to the file



	Save()

	{

		FileDelete,% this.Inifile

		

		for k, v in this.listing

		{

			if ( ( temp := this.file[v] ) != "" )

			{

				if ( Substr(v, -4) == "_=com" )

				{

					loop, parse, temp, `n

						temp2 .= ";" A_LoopField "`n"

					temp2 := Substr(temp2, 1, -1)

					retfile .= "`n" temp2 , temp2 := ""

				}

				else if Instr(v, "]") == Strlen(v)

					retfile .= "`n`n" temp

				else

					retfile .= "`n" Substr(v, Instr(v, "]", 0, 0)+2) " = " temp

			}

		}

		FileAppend,% Trim(retfile, "`n"),% this.Inifile

		;return Trim(retfile, "`n")

	}

}

;;;;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
;;;;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
;;;;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\



    GLOBAL LastRowSent := "NULL"
    GLOBAL LastKeySent := ""
    GLOBAL stackSetStatus := "HIBERNATING..."

    GLOBAL DebugLoopWidthA := "300"
    GLOBAL DebugLoopWidth := "350"


GLOBAL DebugLoopStringA := "[ACTION]:  Doing Shift+1,  on Current Row:" . A_Space . A_Space . LastRowSent
GLOBAL DebugLoopStringB := "[ACTION]:  Doing Shift+2,  on Current Row:" . A_Space . A_Space . LastRowSent
GLOBAL DebugLoopStringC := "[ACTION]:  Doing Shift+3,  on Current Row:" . A_Space . A_Space . LastRowSent


GLOBAL DebugLoopStringF1 := "[ACTION]:  Sending {F1} key Globally,  on Current Row:" . A_Space . A_Space . LastRowSent
GLOBAL DebugLoopString1 := "[ACTION]:  Sending {1} key Globally,  on Current Row:" . A_Space . A_Space . LastRowSent
GLOBAL DebugLoopString2 := "[ACTION]:  Sending {2} key Globally,  on Current Row:" . A_Space . A_Space . LastRowSent
GLOBAL DebugLoopString3 := "[ACTION]:  Sending {3} key Globally,  on Current Row:" . A_Space . A_Space . LastRowSent
GLOBAL DebugLoopString4 := "[ACTION]:  Sending {4} key Globally,  on Current Row:" . A_Space . A_Space . LastRowSent
GLOBAL DebugLoopString5 := "[ACTION]:  Sending {5} key Globally,  on Current Row:" . A_Space . A_Space . LastRowSent
GLOBAL DebugLoopString6 := "[ACTION]:  Sending {6} key Globally,  on Current Row:" . A_Space . A_Space . LastRowSent
GLOBAL DebugLoopString7 := "[ACTION]:  Sending {7} key Globally,  on Current Row:" . A_Space . A_Space . LastRowSent
GLOBAL DebugLoopString8 := "[ACTION]:  Sending {8} key Globally,  on Current Row:" . A_Space . A_Space . LastRowSent
GLOBAL DebugLoopString9 := "[ACTION]:  Sending {9} key Globally,  on Current Row:" . A_Space . A_Space . LastRowSent
GLOBAL DebugLoopString0 := "[ACTION]:  Sending {0} key Globally,  on Current Row:" . A_Space . A_Space . LastRowSent








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
ini.write("MODULE", "Disable_Row_3", "0", "`n`    Toggle enabling execution of Hotbar Row 3 `n`  DEFAULT: 0 `n`")
ini.write("MODULE", "Disable_Row_2", "0", "`n`    Toggle enabling execution of Hotbar Row 2 `n`  DEFAULT: 0 `n`")
ini.write("MODULE", "Disable_Row_1", "1", "`n`    Toggle enabling execution of Hotbar Row 1 `n`  DEFAULT: 1 `n`", "                   MODULE OPTIONS (Configure these) `n`")
ini.write("ENGINE", "RunWithAdmin", "0", "`n`    Toggle Running With Administrator `n` `n`", "                   ENGINE OPTIONS (Mostly Ignore these) `n`")
ini.write("CLIENT", "ThirdHotbarRow", "3", "`n`    The number of the third Hotbar Buffing Row `n`  DEFAULT: 3 `n` `n` `n` `n`")
ini.write("CLIENT", "SecondHotbarRow", "2", "`n`    The number of the second Hotbar Buffing Row `n`   DEFAULT: 2 `n` `n` `n` `n`")
ini.write("CLIENT", "FirstHotbarRow", "1", "`n` The number of the first Hotbar Buffing Row (Ex. For Shift+1) `n`  DEFAULT: 1 `n` `n` `n` `n`")
ini.write("CLIENT", "CharacterName_06", "NameHere", "`n`    Sixth Character's Name `n` `n` `n` `n` `n`")
ini.write("CLIENT", "CharacterName_05", "NameHere", "`n`    Fifth Character's Name `n` `n` `n`")
ini.write("CLIENT", "CharacterName_04", "NameHere", "`n`    Fourth Character's Name `n` `n` `n`")
ini.write("CLIENT", "CharacterName_03", "NameHere", "`n`    Third Character's Name `n` `n` `n`")
ini.write("CLIENT", "CharacterName_02", "NameHere", "`n`    Second Character's Name `n` `n` `n`")
ini.write("CLIENT", "CharacterName_01", "Raidcaptain", "`n`    First Character's Name `n`    (ALL FOLLOWING CLIENT CONVARS ARE CASE SENSITIVE) `n` `n` `n` ", "                   CLIENT OPTIONS (Configure these) `n` `n`")
ini.write("VELOCITY", "Third_HotbarRow_Speed", "8000", "`n`    Speed that the third Hotbar will be executed at `n`  DEFAULT: 8000 `n` `n` `n` `n`")
ini.write("VELOCITY", "Second_HotbarRow_Speed", "8000", "`n`    Speed that the second Hotbar will be executed at `n`  DEFAULT: 8000 `n`")
ini.write("VELOCITY", "First_HotbarRow_Speed", "8000", "`n`    Speed that the first Hotbar will be executed at `n`  DEFAULT: 8000 `n` `n`", "                   DEFAULT KEY LOOPING SPEEDS (MILLISECONDS)`n` `n`")
ini.write("DEBUG", "Performance_Mode", "1", "`n`    Perform a window minimize after each Row Change `n` This is because non-minimized AO windows EAT performance `n` `n`", "                   PERFOMANCE AND DEBUG (For Issues)`n` `n`")
ini.Save()
Sleep, 500
Reload
        Return
    }


IniRead, PerformanceMode, buff_core.ini, DEBUG, Performance_Mode ,  ;;; Default]
GLOBAL Performance_Mode := PerformanceMode



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



IniRead, ICvarCHAR01, buff_core.ini, CLIENT, CharacterName_01, ;;;%IniKeyErrorElevate%
IniRead, ICvarCHAR02, buff_core.ini, CLIENT, CharacterName_02, ;;;%IniKeyErrorElevate%
IniRead, ICvarCHAR03, buff_core.ini, CLIENT, CharacterName_03, ;;;%IniKeyErrorElevate%
IniRead, ICvarCHAR04, buff_core.ini, CLIENT, CharacterName_04, ;;;%IniKeyErrorElevate%
IniRead, ICvarCHAR05, buff_core.ini, CLIENT, CharacterName_05, ;;;%IniKeyErrorElevate%
IniRead, ICvarCHAR06, buff_core.ini, CLIENT, CharacterName_06, ;;;%IniKeyErrorElevate%

IniRead, HB1SpeedMult, buff_core.ini, VELOCITY, First_HotbarRow_Speed, ;;;%IniKeyErrorElevate%
IniRead, HB2SpeedMult, buff_core.ini, VELOCITY, Second_HotbarRow_Speed, ;;;%IniKeyErrorElevate%
IniRead, HB3SpeedMult, buff_core.ini, VELOCITY, Third_HotbarRow_Speed, ;;;%IniKeyErrorElevate%



IniRead, 1HBRow, buff_core.ini, CLIENT, FirstHotBarRow, ;;;%IniKeyErrorElevate%
IniRead, 2HBRow, buff_core.ini, CLIENT, SecondHotBarRow, ;;;%IniKeyErrorElevate%
IniRead, 3HBRow, buff_core.ini, CLIENT, ThirdHotbarRow, ;;;%IniKeyErrorElevate%




IniRead, cl_CharSlot1, buff_core.ini, CLIENT, CharacterName_01
GLOBAL ClientCharSlot1 := cl_CharSlot1

IniRead, cl_CharSlot2, buff_core.ini, CLIENT, CharacterName_02
GLOBAL ClientCharSlot2 := cl_CharSlot2

IniRead, cl_CharSlot3, buff_core.ini, CLIENT, CharacterName_03
GLOBAL ClientCharSlot3 := cl_CharSlot3

IniRead, cl_CharSlot4, buff_core.ini, CLIENT, CharacterName_04
GLOBAL ClientCharSlot4 := cl_CharSlot4

IniRead, cl_CharSlot5, buff_core.ini, CLIENT, CharacterName_05
GLOBAL ClientCharSlot5 := cl_char05

IniRead, cl_CharSlot6, buff_core.ini, CLIENT, CharacterName_06
GLOBAL ClientCharSlot6 := cl_char06







GLOBAL FirstHotBarRow := 1HBRow   ;;; this is the number the system presses to actuate the 1st hotbar row to begin casting buffs
GLOBAL SecondHotBarRow := 2HBRow  ;;; this is the number the system presses to actuate the 2nd hotbar row to begin casting buffs
GLOBAL ThirdHotBarRow := 3HBRow   ;;; this is the number the system presses to actuate the 3rd hotbar row to begin casting buffs



GLOBAL cl_char01 := "Anarchy Online - " . ICvarCHAR01
GLOBAL cl_char02 := "Anarchy Online - " . ICvarCHAR02
GLOBAL cl_char03 := "Anarchy Online - " . ICvarCHAR03
GLOBAL cl_char04 := "Anarchy Online - " . ICvarCHAR04
GLOBAL cl_char05 := "Anarchy Online - " . ICvarCHAR05
GLOBAL cl_char06 := "Anarchy Online - " . ICvarCHAR06


GLOBAL HB1Speed := HB1SpeedMult
GLOBAL HB2Speed := HB2SpeedMult
GLOBAL HB3Speed := HB3SpeedMult

;;;;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
;;;;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
;;;;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\




WinGet, aoid, List, Anarchy Online

Gui, Add, Button, x1 y1 w1 h1 , 

Gui, Add, Edit, x35 y119 w80 h20 vE1, %ICvarCHAR01%   
Gui, Add, Edit, x152 y119 w80 h20 vE2, %ICvarCHAR02%   
Gui, Add, Edit, x267 y119 w80 h20 vE3, %ICvarCHAR03%   
Gui, Add, Edit, x35 y170 w80 h20 vE4, %ICvarCHAR04%   
Gui, Add, Edit, x152 y170 w80 h20 vE5, %ICvarCHAR05%   
Gui, Add, Edit, x267 y170 w80 h20 vE6, %ICvarCHAR06%   


Gui, Add, Edit, x307 y310 w62 h20 vV1, %HB1Speed%   
Gui, Add, Edit, x307 y340 w62 h20 vV2, %HB2Speed%   
Gui, Add, Edit, x307 y370 w62 h20 vV3, %HB3Speed%   

Gui, Add, Button, x20 y215 w346 h50 gSubmitChars, SUBMIT  CHARACTER  NAMES
Gui, Add, Button, x252 y395 w130 h23 gSubmitSpeeds, SUBMIT SPEEDS
Gui, Add, Button, x20 y391 w120 h50 gSubmitMinimize, MINIMIZE AO WINDOWS
Gui, Add, Button, x144 y391 w90 h30 gSubmitHelp, HELP
Gui, Add, Button, x20 y285 w170 h103 gSubmitStart, START
Gui, Add, Button, x190 y285 w60 h103 gSubmitStop, STOP



Gui, Add, Text, x300 y425 vLastLoopRow, %LastRowSent%
Gui, Add, Text, x300 y445 vLoopStateText, %stackSetStatus%


Gui, Add, Text, x265 y287, HOTBAR ROW SPEED
Gui, Add, Text, x260 y312, ROW 1:
Gui, Add, Text, x260 y343, ROW 2:
Gui, Add, Text, x260 y373, ROW 3:
Gui, Add, Text, x372 y315, MS
Gui, Add, Text, x372 y345, MS
Gui, Add, Text, x372 y375, MS
Gui, Add, Text, x198 y425, CURRENT ROW   :
Gui, Add, Text, x196 y445, CURRENT STATE :
Gui, Add, Text, x6 y445, by: Jake
Gui, Add, Text, x137 y96, BUFFING CHARACTERS

Size=20
Gui, Font, s%size%
Gui, Add, Text, x145 y26 w180 h60 vTitleText, LAYERS



Gui, Show, w390 h464, Layers
Gui, Submit, NoHide

WinActivate, Layers




Return  ;;; stop execution from proceeding past this point without permission or direction
;;;;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
;;;;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
;;;;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\




SubmitMinimize:
Sleep, 50
WinActivate, Anarchy Online - %ClientCharSlot6%
Sleep, 10
WinMinimize, Anarchy Online - %ClientCharSlot6%

Sleep, 50
WinActivate, Anarchy Online - %ClientCharSlot5%
Sleep, 10
WinMinimize, Anarchy Online - %ClientCharSlot5%

Sleep, 50
WinActivate, Anarchy Online - %ClientCharSlot4%
Sleep, 10
WinMinimize, Anarchy Online - %ClientCharSlot4%

Sleep, 50
WinActivate, Anarchy Online - %ClientCharSlot3%
Sleep, 10
WinMinimize, Anarchy Online - %ClientCharSlot3%

Sleep, 50
WinActivate, Anarchy Online - %ClientCharSlot2%
Sleep, 10
WinMinimize, Anarchy Online - %ClientCharSlot2%

Sleep, 50
WinActivate, Anarchy Online - %ClientCharSlot1%
Sleep, 10
WinMinimize, Anarchy Online - %ClientCharSlot1%
Sleep, 200
SetTitleMatchMode, 2
Sleep, 500
WinMinimize, Anarchy Online - 
Sleep, 50
SetTitleMatchMode, 1
Return


SubmitHelp:
Run, "https://github.com/ReleaseOverflow/AO-Layers/wiki"
Return

SubmitChars:
Gui, Submit, NoHide
IniWrite, %A_Space%%E1%, buff_core.ini, CLIENT, CharacterName_01
IniWrite, %A_Space%%E2%, buff_core.ini, CLIENT, CharacterName_02
IniWrite, %A_Space%%E3%, buff_core.ini, CLIENT, CharacterName_03
IniWrite, %A_Space%%E4%, buff_core.ini, CLIENT, CharacterName_04
IniWrite, %A_Space%%E5%, buff_core.ini, CLIENT, CharacterName_05
IniWrite, %A_Space%%E6%, buff_core.ini, CLIENT, CharacterName_06
Sleep, 100
IniRead, cl_CharSlot1, buff_core.ini, CLIENT, CharacterName_01
GLOBAL ClientCharSlot1 := cl_CharSlot1

IniRead, cl_CharSlot2, buff_core.ini, CLIENT, CharacterName_02
GLOBAL ClientCharSlot2 := cl_CharSlot2

IniRead, cl_CharSlot3, buff_core.ini, CLIENT, CharacterName_03
GLOBAL ClientCharSlot3 := cl_CharSlot3

IniRead, cl_CharSlot4, buff_core.ini, CLIENT, CharacterName_04
GLOBAL ClientCharSlot4 := cl_CharSlot4

IniRead, cl_CharSlot5, buff_core.ini, CLIENT, CharacterName_05
GLOBAL ClientCharSlot5 := cl_char05

IniRead, cl_CharSlot6, buff_core.ini, CLIENT, CharacterName_06
GLOBAL ClientCharSlot6 := cl_char06
Return

SubmitSpeeds:
Gui, Submit, NoHide
IniWrite, %A_Space%%V1%, buff_core.ini, VELOCITY, First_HotbarRow_Speed
IniWrite, %A_Space%%V2%, buff_core.ini, VELOCITY, Second_HotbarRow_Speed
IniWrite, %A_Space%%V3%, buff_core.ini, VELOCITY, Third_HotbarRow_Speed
Return


HOME::
SubmitStart:
SetTimer, IssueHB1all, -100   ;;;  run the next timer only once
SetTimer, IssueHB2all, Off    ;;;  run the next timer only once
SetTimer, IssueHB3all, Off    ;;;  run the next timer only once
; TransitionFromStart()
Return


END::
SubmitStop:
SetTimer, IssueHB1all, Off   ;;;  run the next timer only once
SetTimer, IssueHB2all, Off   ;;;  run the next timer only once
SetTimer, IssueHB3all, Off   ;;;  run the next timer only once
Reload
Return

;;;;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
;;;;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
;;;;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\



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
    SplashTextOff
    GLOBAL LastRowSent := "1"
    GLOBAL stackSetStatus := "ACTIVE"
    GuiControl, Text, LastLoopRow, %LastRowSent%
    GuiControl, Text, LoopStateText, %stackSetStatus%
TurnAllTimersOff1()
UpdateDebugStrings()
UpdateSpeedMult()
DoShiftHotbarTo1()

Sleep, 1000
WinActivate, Layers
; PerformanceMinimize()
Sleep, 1860
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
Else If(ICvarDisableRow2 = 0) ;;and (ICvarDisableRow1 = 1)
{
    SplashTextOff
    GLOBAL LastRowSent := "2"
    GLOBAL stackSetStatus := "ACTIVE"
    GuiControl, Text, LastLoopRow, %LastRowSent%
    GuiControl, Text, LoopStateText, %stackSetStatus%

TurnAllTimersOff2()
UpdateDebugStrings()
UpdateSpeedMult()
DoShiftHotbarTo2()

Sleep, 1000
WinActivate, Layers
; PerformanceMinimize()
Sleep, 1860
GlobalSendKeyF1()
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
    SplashTextOff
    GLOBAL LastRowSent := "3"
    GLOBAL stackSetStatus := "ACTIVE"
    GuiControl, Text, LastLoopRow, %LastRowSent%
    GuiControl, Text, LoopStateText, %stackSetStatus%

TurnAllTimersOff3()
UpdateDebugStrings()
UpdateSpeedMult()
DoShiftHotbarTo3()

Sleep, 1000
WinActivate, Layers
; PerformanceMinimize()
Sleep, 1860
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
    GuiControl, Text, LastLoopRow, %LastRowSent%
    GuiControl, Text, LoopStateText, %stackSetStatus%

DoShiftHotbarTo1()
PerformanceMinimize()
SplashTextOff
WinActivate, Layers
TransitionFrom3ToEnd()
SetTimer, IssueHB3all, Off
    Return
}
Else
{
    SplashTextOff
    MsgBox, NULL ERROR   @    { ICvarDisableRow3 } The value parse returned blank.  ;;; Script will now act as though this setting is at 0.
    Return
}
Return

;;;;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
;;;;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
;;;;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\




DoShiftHotbarTo1()   ;;;; Activate all character windows, using shift + Row Number, where Row Number = the hotbar row we wish to select for the 1st round of buffs
{
    SplashTextOn, %DebugLoopWidthA%, , %DebugLoopStringA%


IniRead, ICvarCHAR01, buff_core.ini, CLIENT, CharacterName_01, ;;;%IniKeyErrorElevate%
IniRead, ICvarCHAR02, buff_core.ini, CLIENT, CharacterName_02, ;;;%IniKeyErrorElevate%
IniRead, ICvarCHAR03, buff_core.ini, CLIENT, CharacterName_03, ;;;%IniKeyErrorElevate%
IniRead, ICvarCHAR04, buff_core.ini, CLIENT, CharacterName_04, ;;;%IniKeyErrorElevate%
IniRead, ICvarCHAR05, buff_core.ini, CLIENT, CharacterName_05, ;;;%IniKeyErrorElevate%
IniRead, ICvarCHAR06, buff_core.ini, CLIENT, CharacterName_06, ;;;%IniKeyErrorElevate%

GLOBAL cl_char01 := "Anarchy Online - " . ICvarCHAR01
GLOBAL cl_char02 := "Anarchy Online - " . ICvarCHAR02
GLOBAL cl_char03 := "Anarchy Online - " . ICvarCHAR03
GLOBAL cl_char04 := "Anarchy Online - " . ICvarCHAR04
GLOBAL cl_char05 := "Anarchy Online - " . ICvarCHAR05
GLOBAL cl_char06 := "Anarchy Online - " . ICvarCHAR06

        If WinExist(cl_char01)
    {
    WinActivate, Anarchy Online - %ClientCharSlot1%
    WinWaitActive, Anarchy Online - %ClientCharSlot1%
    Send {Shift DOWN}
    Sleep, 50
    Send {%FirstHotBarRow%}
    Sleep, 50
    Send {Shift UP}
    Sleep, 800
     PerformanceMinimize_1()
    Sleep, 50
    }
    Else
    {
            Sleep, 10
    }

        If WinExist(cl_char02)
    {
    WinActivate, Anarchy Online - %ClientCharSlot2%
    WinWaitActive, Anarchy Online - %ClientCharSlot2%
    Send {Shift DOWN}
    Sleep, 50
    Send {%FirstHotBarRow%}
    Sleep, 50
    Send {Shift UP}
    Sleep, 800
     PerformanceMinimize_2()
    Sleep, 50
    }
    Else
    {
            Sleep, 10
    }

        If WinExist(cl_char03)
    {
    WinActivate, Anarchy Online - %ClientCharSlot3%
    WinWaitActive, Anarchy Online - %ClientCharSlot3%
    Send {Shift DOWN}
    Sleep, 50
    Send {%FirstHotBarRow%}
    Sleep, 50
    Send {Shift UP}
    Sleep, 800
     PerformanceMinimize_3()
    Sleep, 50
    }
    Else
    {
            Sleep, 10
    }

        If WinExist(cl_char04)
    {
    WinActivate, Anarchy Online - %ClientCharSlot4%
    WinWaitActive, Anarchy Online - %ClientCharSlot4%
    Send {Shift DOWN}
    Sleep, 50
    Send {%FirstHotBarRow%}
    Sleep, 50
    Send {Shift UP}
    Sleep, 800
     PerformanceMinimize_4()
    Sleep, 50
    }
    Else
    {
            Sleep, 10
    }

        If WinExist(cl_char05)
    {
    WinActivate, Anarchy Online - %ClientCharSlot5%
    WinWaitActive, Anarchy Online - %ClientCharSlot5%
    Send {Shift DOWN}
    Sleep, 50
    Send {%FirstHotBarRow%}
    Sleep, 50
    Send {Shift UP}
    Sleep, 800
     PerformanceMinimize_5()
    Sleep, 50
    }
    Else
    {
            Sleep, 10
    }

        If WinExist(cl_char06)
    {
    WinActivate, Anarchy Online - %ClientCharSlot6%
    WinWaitActive, Anarchy Online - %ClientCharSlot6%
    Send {Shift DOWN}
    Sleep, 50
    Send {%FirstHotBarRow%}
    Sleep, 50
    Send {Shift UP}
    Sleep, 800
     PerformanceMinimize_6()
    Sleep, 50
    }
    Else
    {
            Sleep, 10
    }
    

    Return
}


DoShiftHotbarTo2()   ;;;; Activate all character windows, using shift + Row Number, where Row Number = the hotbar row we wish to select for the 2nd round of buffs
{
    SplashTextOn, %DebugLoopWidthA%, , %DebugLoopStringB%

IniRead, ICvarCHAR01, buff_core.ini, CLIENT, CharacterName_01, ;;;%IniKeyErrorElevate%
IniRead, ICvarCHAR02, buff_core.ini, CLIENT, CharacterName_02, ;;;%IniKeyErrorElevate%
IniRead, ICvarCHAR03, buff_core.ini, CLIENT, CharacterName_03, ;;;%IniKeyErrorElevate%
IniRead, ICvarCHAR04, buff_core.ini, CLIENT, CharacterName_04, ;;;%IniKeyErrorElevate%
IniRead, ICvarCHAR05, buff_core.ini, CLIENT, CharacterName_05, ;;;%IniKeyErrorElevate%
IniRead, ICvarCHAR06, buff_core.ini, CLIENT, CharacterName_06, ;;;%IniKeyErrorElevate%

GLOBAL cl_char01 := "Anarchy Online - " . ICvarCHAR01
GLOBAL cl_char02 := "Anarchy Online - " . ICvarCHAR02
GLOBAL cl_char03 := "Anarchy Online - " . ICvarCHAR03
GLOBAL cl_char04 := "Anarchy Online - " . ICvarCHAR04
GLOBAL cl_char05 := "Anarchy Online - " . ICvarCHAR05
GLOBAL cl_char06 := "Anarchy Online - " . ICvarCHAR06

    If WinExist(cl_char01)
    {
    WinActivate, Anarchy Online - %ClientCharSlot1%
    WinWaitActive, Anarchy Online - %ClientCharSlot1%
    Sleep, 150
    Send {Shift DOWN}
    Sleep, 250
    Send {%SecondHotBarRow%}
    Sleep, 250
    Send {Shift UP}
    Sleep, 800
     PerformanceMinimize_1()
    Sleep, 50
    }
    Else
    {
            Sleep, 10
    }

        If WinExist(cl_char02)
    {
    WinActivate, Anarchy Online - %ClientCharSlot2%
    WinWaitActive, Anarchy Online - %ClientCharSlot2%
    Sleep, 150
    Send {Shift DOWN}
    Sleep, 250
    Send {%SecondHotBarRow%}
    Sleep, 250
    Send {Shift UP}
    Sleep, 800
     PerformanceMinimize_2()
    Sleep, 50
    }
    Else
    {
            Sleep, 10
    }

        If WinExist(cl_char03)
    {
    WinActivate, Anarchy Online - %ClientCharSlot3%
    WinWaitActive, Anarchy Online - %ClientCharSlot3%
    Sleep, 150
    Send {Shift DOWN}
    Sleep, 250
    Send {%SecondHotBarRow%}
    Sleep, 250
    Send {Shift UP}
    Sleep, 800
     PerformanceMinimize_3()
    Sleep, 50
    }
    Else
    {
            Sleep, 10
    }

        If WinExist(cl_char04)
    {
    WinActivate, Anarchy Online - %ClientCharSlot4%
    WinWaitActive, Anarchy Online - %ClientCharSlot4%
    Sleep, 150
    Send {Shift DOWN}
    Sleep, 250
    Send {%SecondHotBarRow%}
    Sleep, 250
    Send {Shift UP}
    Sleep, 800
     PerformanceMinimize_4()
    Sleep, 50
    }
    Else
    {
            Sleep, 10
    }

        If WinExist(cl_char05)
    {
    WinActivate, Anarchy Online - %ClientCharSlot5%
    WinWaitActive, Anarchy Online - %ClientCharSlot5%
    Sleep, 150
    Send {Shift DOWN}
    Sleep, 250
    Send {%SecondHotBarRow%}
    Sleep, 250
    Send {Shift UP}
    Sleep, 800
     PerformanceMinimize_5()
    Sleep, 50
    }
    Else
    {
            Sleep, 10
    }

        If WinExist(cl_char06)
    {
    WinActivate, Anarchy Online - %ClientCharSlot6%
    WinWaitActive, Anarchy Online - %ClientCharSlot6%
    Sleep, 150
    Send {Shift DOWN}
    Sleep, 250
    Send {%SecondHotBarRow%}
    Sleep, 250
    Send {Shift UP}
    Sleep, 800
     PerformanceMinimize_6()
    Sleep, 50
    }
    Else
    {
            Sleep, 10
    }
     

    Return
}



DoShiftHotbarTo3()   ;;;; Activate all character windows, using shift + Row Number, where Row Number = the hotbar row we wish to select for the 3rd round of buffs
{
    SplashTextOn, %DebugLoopWidthA%, , %DebugLoopStringC%

IniRead, ICvarCHAR01, buff_core.ini, CLIENT, CharacterName_01, ;;;%IniKeyErrorElevate%
IniRead, ICvarCHAR02, buff_core.ini, CLIENT, CharacterName_02, ;;;%IniKeyErrorElevate%
IniRead, ICvarCHAR03, buff_core.ini, CLIENT, CharacterName_03, ;;;%IniKeyErrorElevate%
IniRead, ICvarCHAR04, buff_core.ini, CLIENT, CharacterName_04, ;;;%IniKeyErrorElevate%
IniRead, ICvarCHAR05, buff_core.ini, CLIENT, CharacterName_05, ;;;%IniKeyErrorElevate%
IniRead, ICvarCHAR06, buff_core.ini, CLIENT, CharacterName_06, ;;;%IniKeyErrorElevate%

GLOBAL cl_char01 := "Anarchy Online - " . ICvarCHAR01
GLOBAL cl_char02 := "Anarchy Online - " . ICvarCHAR02
GLOBAL cl_char03 := "Anarchy Online - " . ICvarCHAR03
GLOBAL cl_char04 := "Anarchy Online - " . ICvarCHAR04
GLOBAL cl_char05 := "Anarchy Online - " . ICvarCHAR05
GLOBAL cl_char06 := "Anarchy Online - " . ICvarCHAR06

        If WinExist(cl_char01)
    {
    WinActivate, Anarchy Online - %ClientCharSlot1%
    WinWaitActive, Anarchy Online - %ClientCharSlot1%
    Send {Shift DOWN}
    Sleep, 50
    Send {%ThirdHotBarRow%}
    Sleep, 50
    Send {Shift UP}
    Sleep, 800
     PerformanceMinimize_1()
    Sleep, 50
    }
    Else
    {
            Sleep, 10
    }

        If WinExist(cl_char02)
    {
    WinActivate, Anarchy Online - %ClientCharSlot2%
    WinWaitActive, Anarchy Online - %ClientCharSlot2%
    Send {Shift DOWN}
    Sleep, 50
    Send {%ThirdHotBarRow%}
    Sleep, 50
    Send {Shift UP}
    Sleep, 800
     PerformanceMinimize_2()
    Sleep, 50
    }
    Else
    {
            Sleep, 10
    }

        If WinExist(cl_char03)
    {
    WinActivate, Anarchy Online - %ClientCharSlot3%
    WinWaitActive, Anarchy Online - %ClientCharSlot3%
    Send {Shift DOWN}
    Sleep, 50
    Send {%ThirdHotBarRow%}
    Sleep, 50
    Send {Shift UP}
    Sleep, 800
     PerformanceMinimize_3()
    Sleep, 50
    }
    Else
    {
            Sleep, 10
    }

        If WinExist(cl_char04)
    {
    WinActivate, Anarchy Online - %ClientCharSlot4%
    WinWaitActive, Anarchy Online - %ClientCharSlot4%
    Send {Shift DOWN}
    Sleep, 50
    Send {%ThirdHotBarRow%}
    Sleep, 50
    Send {Shift UP}
    Sleep, 800
     PerformanceMinimize_4()
    Sleep, 50
    }
    Else
    {
            Sleep, 10
    }

        If WinExist(cl_char05)
    {
    WinActivate, Anarchy Online - %ClientCharSlot5%
    WinWaitActive, Anarchy Online - %ClientCharSlot5%
    Send {Shift DOWN}
    Sleep, 50
    Send {%ThirdHotBarRow%}
    Sleep, 50
    Send {Shift UP}
    Sleep, 800
     PerformanceMinimize_5()
    Sleep, 50
    }
    Else
    {
            Sleep, 10
    }

        If WinExist(cl_char06)
    {
    WinActivate, Anarchy Online - %ClientCharSlot6%
    WinWaitActive, Anarchy Online - %ClientCharSlot6%
    Send {Shift DOWN}
    Sleep, 50
    Send {%ThirdHotBarRow%}
    Sleep, 50
    Send {Shift UP}
    Sleep, 800
     PerformanceMinimize_6()
    Sleep, 50
    }
    Else
    {
            Sleep, 10
    }
     

    Return
}


;;;;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
;;;;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
;;;;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\



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


;;;;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
;;;;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
;;;;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\



GlobalSendKeyF1()
{
    ; SplashTextOn, , , GLOBAL KEY SENT: F1
    SplashTextOn, %DebugLoopWidth%, , %DebugLoopStringF1%
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
    ; SplashTextOn, , , GLOBAL KEY SENT: 1
    SplashTextOn, %DebugLoopWidth%, , %DebugLoopString1%
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
    ; SplashTextOn, , , GLOBAL KEY SENT: 2
    SplashTextOn, %DebugLoopWidth%, , %DebugLoopString2%
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
    ; SplashTextOn, , , GLOBAL KEY SENT: 3
    SplashTextOn, %DebugLoopWidth%, , %DebugLoopString3%
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
    ; SplashTextOn, , , GLOBAL KEY SENT: 4
    SplashTextOn, %DebugLoopWidth%, , %DebugLoopString4%
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
    ; SplashTextOn, , , GLOBAL KEY SENT: 5
    SplashTextOn, %DebugLoopWidth%, , %DebugLoopString5%
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
    ; SplashTextOn, , , GLOBAL KEY SENT: 6
    SplashTextOn, %DebugLoopWidth%, , %DebugLoopString6%
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
    ; SplashTextOn, , , GLOBAL KEY SENT: 7
    SplashTextOn, %DebugLoopWidth%, , %DebugLoopString7%
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
    ; SplashTextOn, , , GLOBAL KEY SENT: 8
    SplashTextOn, %DebugLoopWidth%, , %DebugLoopString8%
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
    ; SplashTextOn, , , GLOBAL KEY SENT: 9
    SplashTextOn, %DebugLoopWidth%, , %DebugLoopString9%
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
    ; SplashTextOn, , , GLOBAL KEY SENT: 0
    SplashTextOn, %DebugLoopWidth%, , %DebugLoopString0%
                                        GLOBAL LastKeySent := "0"
ControlSend,ahk_parent, {0}, Anarchy Online - %ClientCharSlot1%
ControlSend,ahk_parent, {0}, Anarchy Online - %ClientCharSlot2%
ControlSend,ahk_parent, {0}, Anarchy Online - %ClientCharSlot3%
ControlSend,ahk_parent, {0}, Anarchy Online - %ClientCharSlot4%
ControlSend,ahk_parent, {0}, Anarchy Online - %ClientCharSlot5%
ControlSend,ahk_parent, {0}, Anarchy Online - %ClientCharSlot6%
}

;;;;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
;;;;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
;;;;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\




PerformanceMinimize()  ;;; This is a hotfix(?)
{
    IniRead, PerformanceMode, buff_core.ini, DEBUG, Performance_Mode,  ;;; Default]
    ; GLOBAL Performance_Mode := PerformanceMode
    If(PerformanceMode = 1)
    {
        MsgBox, Did Performance Minimize!
Sleep, 50
WinActivate, Anarchy Online - %ClientCharSlot6%
Sleep, 10
WinMinimize, Anarchy Online - %ClientCharSlot6%

Sleep, 50
WinActivate, Anarchy Online - %ClientCharSlot5%
Sleep, 10
WinMinimize, Anarchy Online - %ClientCharSlot5%

Sleep, 50
WinActivate, Anarchy Online - %ClientCharSlot4%
Sleep, 10
WinMinimize, Anarchy Online - %ClientCharSlot4%

Sleep, 50
WinActivate, Anarchy Online - %ClientCharSlot3%
Sleep, 10
WinMinimize, Anarchy Online - %ClientCharSlot3%

Sleep, 50
WinActivate, Anarchy Online - %ClientCharSlot2%
Sleep, 10
WinMinimize, Anarchy Online - %ClientCharSlot2%

Sleep, 50
WinActivate, Anarchy Online - %ClientCharSlot1%
Sleep, 10
WinMinimize, Anarchy Online - %ClientCharSlot1%
Sleep, 200
SetTitleMatchMode, 2
Sleep, 500
WinMinimize, Anarchy Online - 
Sleep, 50
SetTitleMatchMode, 1
    }
    Else
    {
        MsgBox, Did Not Performance Minimize!
        Sleep 10
        Return
    }
    Return
}
;;;;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
;;;;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
;;;;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\


PerformanceMinimize_1()  ;;; called after the script runs the first shift+1 hotbar row change on character number one, then executed sequentially after each loop, in then ext same place
{
    IniRead, PerformanceMode, buff_core.ini, DEBUG, Performance_Mode ,  ;;; Default]
    GLOBAL Performance_Mode := PerformanceMode
    If(Performance_Mode = 1)
    {
    WinMinimize, Anarchy Online - %ClientCharSlot1%    ;; minimize window 1 because we just completed it, etc.
    ; WinMinimize, Anarchy Online - %ClientCharSlot2%  ;; don't minimize 2, because that is the next window we will activate, etc.
    WinMinimize, Anarchy Online - %ClientCharSlot3%
    WinMinimize, Anarchy Online - %ClientCharSlot4%
    WinMinimize, Anarchy Online - %ClientCharSlot5%
    WinMinimize, Anarchy Online - %ClientCharSlot6%
        ; Return
    }
    Else
    {
        Sleep 10
        Return
    }
    Return
}

PerformanceMinimize_2()
{
    IniRead, PerformanceMode, buff_core.ini, DEBUG, Performance_Mode ,  ;;; Default]
    GLOBAL Performance_Mode := PerformanceMode
    If(Performance_Mode = 1)
    {
    WinMinimize, Anarchy Online - %ClientCharSlot1%
    WinMinimize, Anarchy Online - %ClientCharSlot2%
    ; WinMinimize, Anarchy Online - %ClientCharSlot3%
    WinMinimize, Anarchy Online - %ClientCharSlot4%
    WinMinimize, Anarchy Online - %ClientCharSlot5%
    WinMinimize, Anarchy Online - %ClientCharSlot6%
        ; Return
    }
    Else
    {
        Sleep 10
        Return
    }
    Return
}

PerformanceMinimize_3()
{
    IniRead, PerformanceMode, buff_core.ini, DEBUG, Performance_Mode ,  ;;; Default]
    GLOBAL Performance_Mode := PerformanceMode
    If(Performance_Mode = 1)
    {
    WinMinimize, Anarchy Online - %ClientCharSlot1%
    WinMinimize, Anarchy Online - %ClientCharSlot2%
    WinMinimize, Anarchy Online - %ClientCharSlot3%
    ; WinMinimize, Anarchy Online - %ClientCharSlot4%
    WinMinimize, Anarchy Online - %ClientCharSlot5%
    WinMinimize, Anarchy Online - %ClientCharSlot6%
        ; Return
    }
    Else
    {
        Sleep 10
        Return
    }
    Return
}

PerformanceMinimize_4()
{
    IniRead, PerformanceMode, buff_core.ini, DEBUG, Performance_Mode ,  ;;; Default]
    GLOBAL Performance_Mode := PerformanceMode
    If(Performance_Mode = 1)
    {
    WinMinimize, Anarchy Online - %ClientCharSlot1%
    WinMinimize, Anarchy Online - %ClientCharSlot2%
    WinMinimize, Anarchy Online - %ClientCharSlot3%
    WinMinimize, Anarchy Online - %ClientCharSlot4%
    ; WinMinimize, Anarchy Online - %ClientCharSlot5%
    WinMinimize, Anarchy Online - %ClientCharSlot6%
        ; Return
    }
    Else
    {
        Sleep 10
        Return
    }
    Return
}

PerformanceMinimize_5()
{
    IniRead, PerformanceMode, buff_core.ini, DEBUG, Performance_Mode ,  ;;; Default]
    GLOBAL Performance_Mode := PerformanceMode
    If(Performance_Mode = 1)
    {
    WinMinimize, Anarchy Online - %ClientCharSlot1%
    WinMinimize, Anarchy Online - %ClientCharSlot2%
    WinMinimize, Anarchy Online - %ClientCharSlot3%
    WinMinimize, Anarchy Online - %ClientCharSlot4%
    WinMinimize, Anarchy Online - %ClientCharSlot5%
    ; WinMinimize, Anarchy Online - %ClientCharSlot6%
        ; Return
    }
    Else
    {
        Sleep 10
        Return
    }
    Return
}

PerformanceMinimize_6()
{
    IniRead, PerformanceMode, buff_core.ini, DEBUG, Performance_Mode ,  ;;; Default]
    GLOBAL Performance_Mode := PerformanceMode
    If(Performance_Mode = 1)
    {
    WinMinimize, Anarchy Online - %ClientCharSlot1%
    WinMinimize, Anarchy Online - %ClientCharSlot2%
    WinMinimize, Anarchy Online - %ClientCharSlot3%
    WinMinimize, Anarchy Online - %ClientCharSlot4%
    WinMinimize, Anarchy Online - %ClientCharSlot5%
    ; WinMinimize, Anarchy Online - %ClientCharSlot6%
    Sleep, 100
    WinActivate, Anarchy Online - %ClientCharSlot1%
    Sleep, 100
    WinMinimize, Anarchy Online - %ClientCharSlot6%
        ; Return
    }
    Else
    {
        Sleep 10
        Return
    }
    Return
}

;;;;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
;;;;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
;;;;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\



UpdateSpeedMult()
{
IniRead, HB1SpeedMult, buff_core.ini, VELOCITY, First_HotbarRow_Speed, ;;;%IniKeyErrorElevate%
IniRead, HB2SpeedMult, buff_core.ini, VELOCITY, Second_HotbarRow_Speed, ;;;%IniKeyErrorElevate%
IniRead, HB3SpeedMult, buff_core.ini, VELOCITY, Third_HotbarRow_Speed, ;;;%IniKeyErrorElevate%
GLOBAL HB1Speed := HB1SpeedMult
GLOBAL HB2Speed := HB2SpeedMult
GLOBAL HB3Speed := HB3SpeedMult
Return
}

UpdateDebugStrings()
{
GLOBAL DebugLoopStringA := "[ACTION]:  Doing Shift+1,  on Current Row:" . A_Space . A_Space . LastRowSent
GLOBAL DebugLoopStringB := "[ACTION]:  Doing Shift+2,  on Current Row:" . A_Space . A_Space . LastRowSent
GLOBAL DebugLoopStringC := "[ACTION]:  Doing Shift+3,  on Current Row:" . A_Space . A_Space . LastRowSent


GLOBAL DebugLoopStringF1 := "[ACTION]:  Sending {F1} key Globally,  on Current Row:" . A_Space . A_Space . LastRowSent
GLOBAL DebugLoopString1 := "[ACTION]:  Sending {1} key Globally,  on Current Row:" . A_Space . A_Space . LastRowSent
GLOBAL DebugLoopString2 := "[ACTION]:  Sending {2} key Globally,  on Current Row:" . A_Space . A_Space . LastRowSent
GLOBAL DebugLoopString3 := "[ACTION]:  Sending {3} key Globally,  on Current Row:" . A_Space . A_Space . LastRowSent
GLOBAL DebugLoopString4 := "[ACTION]:  Sending {4} key Globally,  on Current Row:" . A_Space . A_Space . LastRowSent
GLOBAL DebugLoopString5 := "[ACTION]:  Sending {5} key Globally,  on Current Row:" . A_Space . A_Space . LastRowSent
GLOBAL DebugLoopString6 := "[ACTION]:  Sending {6} key Globally,  on Current Row:" . A_Space . A_Space . LastRowSent
GLOBAL DebugLoopString7 := "[ACTION]:  Sending {7} key Globally,  on Current Row:" . A_Space . A_Space . LastRowSent
GLOBAL DebugLoopString8 := "[ACTION]:  Sending {8} key Globally,  on Current Row:" . A_Space . A_Space . LastRowSent
GLOBAL DebugLoopString9 := "[ACTION]:  Sending {9} key Globally,  on Current Row:" . A_Space . A_Space . LastRowSent
GLOBAL DebugLoopString0 := "[ACTION]:  Sending {0} key Globally,  on Current Row:" . A_Space . A_Space . LastRowSent
Return
}


GuiClose:
ExitApp