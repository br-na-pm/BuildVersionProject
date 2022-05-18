;!include "SetupPC.nsh"
!include "SetupBuildVersion_TS.nsh"

Var nsiPVI_OptionsFileName
Var nsiPVI_ErrorText

; Text resources for section text (component selection)

LangString BuildVersionShortText ${LANG_GERMAN} "${ProductNameShort} ${Version}"
LangString BuildVersionShortText ${LANG_ENGLISH} "${ProductNameShort} ${Version}"
LangString BuildVersionLongText ${LANG_GERMAN} "${ProductNameLong} ${Version}"
LangString BuildVersionLongText ${LANG_ENGLISH} "${ProductNameLong} ${Version}"

LangString mappFrameworkProductName ${LANG_ENGLISH} "mappFramework"
LangString mappFrameworkProductName ${LANG_GERMAN} "mappFramework"

LangString BuildVersionBaseShortText ${LANG_GERMAN} "Solution Hauptpaket"
LangString BuildVersionBaseShortText ${LANG_ENGLISH} "Solution main package"
;LangString BuildVersionBaseLongText ${LANG_GERMAN} "Trak Map Widget - Technology Solution / Hilfe"
;LangString BuildVersionBaseLongText ${LANG_ENGLISH} "Trak Map Widget - Technology Solution / Help"

LangString MenuShortText ${LANG_GERMAN} "Start Menü Eintrag"
LangString MenuShortText ${LANG_ENGLISH} "Start Menu entry"
LangString MenuLongText ${LANG_GERMAN} "Eintrag in das Startmenü"
LangString MenuLongText ${LANG_ENGLISH} "Entry into the start menu"

LangString BuildVersionEndShortText ${LANG_GERMAN} "BuildVersion Ende"
LangString BuildVersionEndShortText ${LANG_ENGLISH} "BuildVersion end"
LangString BuildVersionEndLongText ${LANG_GERMAN} "BuildVersion Ende"
LangString BuildVersionEndLongText ${LANG_ENGLISH} "BuildVersion end"


; Variable declarationen for sections
!insertmacro VariableForSection "BuildVersion"
	!insertmacro VariableForSection "BuildVersionBase"
	
!insertmacro VariableForSection "BuildVersionEnd"

Section # Remove old
	;SetOutPath "$INSTDIR\${ProductNameShort}"
	;RMDir /r "$INSTDIR\${ProductNameShort}"

	;SetOutPath "$VersionBaseFolder\AS\TechnologySolutions\BuildVersion"
	;RMDir /r "$VersionBaseFolder\AS\TechnologySolutions\BuildVersion\V1.0.9.001"
SectionEnd

; Dummy section for the start of the root group
Section "$(BuildVersionLongText)" BuildVersion
SectionEnd


Section "$(BuildVersionBaseShortText)" BuildVersionBase

	;!insertmacro WaitForProcessToClose "BuildVersion2.exe" "mappView Import Tool"

;	SetOutPath "$INSTDIR\${ProductNameShort}"
;	File /r "SetupData\BuildVersionLogo.ico"
;	File /r "SetupData\Launch Simulation.exe"
;	File /r "SetupData\VisuKioskMode.exe"

;	SetOutPath "$INSTDIR\${ProductNameShort}\ImporterProgram"
;	File /r "SetupData\ImporterProgram\*.*"

	;!insertmacro InstallHelp "$VersionBaseFolder" "SetupData\Help"

;	SetOutPath "$VersionBaseFolder\Samples"
;	File /r "Sample\*.*"

	SetOutPath "$VersionBaseFolder\AS\TechnologyPackages\$(mappFrameworkProductName)"
    FindFirst $0 $1 "$VersionBaseFolder\AS\TechnologyPackages\$(mappFrameworkProductName)\*.*.*"
	Var /GLOBAL frameworkPath
    loop:
		StrCmp $1 "" done
		StrCpy $frameworkPath $1
        ;RMDir /r "$VersionBaseFolder\AS\TechnologyPackages\${ProductNameShort}\$1"
        FindNext $0 $1
        Goto loop
    done:
		SetOutPath "$VersionBaseFolder\AS\TechnologyPackages\$(mappFrameworkProductName)\$frameworkPath\Framework"
		File /r "..\build\*.zip"
    FindClose $0
	
	!insertmacro InstallHelp "$VersionBaseFolder" "..\Help\"

	;File /r "build\*.zip"
	;SetOutPath "$VersionBaseFolder\AS\TechnologySolutions\${ProductNameShort}"
	;File /r "TechnologySolution\*.*"

;	SetOutPath "$INSTDIR\AS\Library"
;	File /r "Compiled Library\*.*"

SectionEnd

;Section "$(BuildVersionSampleShortText)" Sample
;	SetOutPath "$VersionBaseFolder\Samples"
;	File /r "Sample\*.*"
;SectionEnd

;Section "$(BuildVersionTSShortText)" TS
;	SetOutPath "$VersionBaseFolder\AS\TechnologySolutions\${ProductNameShort}"
;	File /r "TechnologySolution\*.*"
;SectionEnd

;Section "$(BuildVersionLibShortText)" Lib
;	SetOutPath "$INSTDIR\AS\Library"
;	File /r "Compiled Library\*.*"
;SectionEnd


; Dummy section for the end of the root group
Section "$(BuildVersionEndShortText)" BuildVersionEnd

SectionEnd

; description text (LongText) for component selection
!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
	!insertmacro SetDescriptionTextforMUI "BuildVersion"
	!insertmacro SetDescriptionTextforMUI "BuildVersionBase"
;	!insertmacro SetDescriptionTextforMUI "Sample"
;	!insertmacro SetDescriptionTextforMUI "TS"
;	!insertmacro SetDescriptionTextforMUI "Lib"
;	!insertmacro SetDescriptionTextforMUI "Menu"

;	!insertmacro SetDescriptionTextforMUI "ARsim"
;	!insertmacro SetDescriptionTextforMUI "StarterProjectSim"
;	!insertmacro SetDescriptionTextforMUI "ARsimShortcut"
;	!insertmacro SetDescriptionTextforMUI "ARsimStart"

;	!insertmacro SetDescriptionTextforMUI "PanelSetup"
;	!insertmacro SetDescriptionTextforMUI "PanelSetupPkg"

!insertmacro MUI_FUNCTION_DESCRIPTION_END


;!insertmacro CreateUninstaller "$VersionBaseFolder\AS\TechnologySolutions\${ProductNameShort}"

Section "un.Uninstaller"
	RMDir /r "$VersionBaseFolder\AS\TechnologySolutions\${ProductNameShort}"
SectionEnd

;!insertmacro CreateUninstaller "$INSTDIR\${ProductNameShort}"

Section "un.Uninstaller"
	RMDir /r "$INSTDIR\${ProductNameShort}"
SectionEnd


Function OnInit
	; check Windows-Version
	; at least Windows VISTA SP 2 or Windows 7 SP1 or Windows Server 2008 R2 must be available.
	${IfNot} ${AtLeastWin2008R2}
		${If} ${IsWinVista}
		${AndIf} ${AtLeastServicePack} 2
		${Else}
			${If} ${IsWin7}
			${AndIf} ${AtLeastServicePack} 1
			${Else}
				!insertmacro GenerateError ${ErrorCode_WrongOS} "$(LangWrongOS)"
			${EndIf}
		${EndIf}
	${EndIf}

	; initializing section Flags
	; Flags are defined as follows:
	; SF_SELECTED   1
	; SF_SECGRP     2
	; SF_SECGRPEND  4
	; SF_BOLD       8
	; SF_RO         16  ReadOnly
	; SF_EXPAND     32
	; SF_PSELECTED  64
	StrCpy $BuildVersionSectionRO 3

		StrCpy $BuildVersionBaseSectionRO 17
	;	StrCpy $SampleSectionRO 1
	;	StrCpy $TSSectionRO 1
	;	StrCpy $LibSectionRO 17
	;	StrCpy $MenuSectionRO 1
	;	StrCpy $ARsimSectionRO 2
	;		StrCpy $StarterProjectSimSectionRO 0
	;		StrCpy $ARsimShortcutSectionRO 0
	;		StrCpy $ARsimStartSectionRO 0
	;	StrCpy $ARsimEndSectionRO 4
	;	StrCpy $PanelSetupSectionRO 2
	;		StrCpy $PanelSetupPkgSectionRO 0
	;	StrCpy $PanelEndSectionRO 4
	StrCpy $BuildVersionEndSectionRO 4

	; initializing Selection IDs for Sections
	StrCpy $BuildVersionSelectionID "BuildVersion"
	StrCpy $BuildVersionBaseSelectionID "BuildVersionBase"
	;StrCpy $SampleSelectionID "Sample"
	;StrCpy $TSSelectionID "TS"
	;StrCpy $LibSelectionID "Lib"
		
	; initializing Section Flags
	!insertmacro ReadAndSetSectionFlag "BuildVersion" "BuildVersion"
	!insertmacro ReadAndSetSectionFlag "BuildVersionBase" "BuildVersion"
	;!insertmacro ReadAndSetSectionFlag "Sample" "BuildVersion"
	;!insertmacro ReadAndSetSectionFlag "TS" "BuildVersion"
	;!insertmacro ReadAndSetSectionFlag "Lib" "BuildVersion"
	;!insertmacro ReadAndSetSectionFlag "Menu" "BuildVersion"

	;!insertmacro ReadAndSetSectionFlag "ARsim" "BuildVersion"
	;!insertmacro ReadAndSetSectionFlag "PanelSetupPkg" "BuildVersion"
	;!insertmacro ReadAndSetSectionFlag "StarterProjectSim" "BuildVersion"
	;!insertmacro ReadAndSetSectionFlag "ARsimShortcut" "BuildVersion"
	;!insertmacro ReadAndSetSectionFlag "ARsimStart" "BuildVersion"
	;!insertmacro ReadAndSetSectionFlag "ARsimEnd" "BuildVersion"

	;!insertmacro ReadAndSetSectionFlag "PanelSetup" "BuildVersion"
	;!insertmacro ReadAndSetSectionFlag "PanelSetupPkg" "BuildVersion"
	;!insertmacro ReadAndSetSectionFlag "PanelEnd" "BuildVersion"
	!insertmacro ReadAndSetSectionFlag "BuildVersionEnd" "BuildVersion"

	; check command line parameter "-O=" in case it's selected
	Call DoOptionFileHandling
FunctionEnd

Function DoOptionFileHandling
	${GetOptions} $CommandLine "-O=" $nsiPVI_OptionsFileName
	${If} "$nsiPVI_OptionsFileName" != ""
		${If} ${FileExists} "$nsiPVI_OptionsFileName"
			!insertmacro ReadSectionFlagFromFile "$nsiPVI_OptionsFileName" "BuildVersion" "BuildVersionBase"
			;!insertmacro ReadSectionFlagFromFile "$nsiPVI_OptionsFileName" "BuildVersion" "Sample"
			;!insertmacro ReadSectionFlagFromFile "$nsiPVI_OptionsFileName" "BuildVersion" "TS"
			;!insertmacro ReadSectionFlagFromFile "$nsiPVI_OptionsFileName" "BuildVersion" "Lib"
			;!insertmacro ReadSectionFlagFromFile "$nsiPVI_OptionsFileName" "BuildVersion" "Menu"
			;!insertmacro ReadSectionFlagFromFile "$nsiPVI_OptionsFileName" "BuildVersion" "PanelSetupPkg"
			;!insertmacro ReadSectionFlagFromFile "$nsiPVI_OptionsFileName" "BuildVersion" "StarterProjectSim"
			;!insertmacro ReadSectionFlagFromFile "$nsiPVI_OptionsFileName" "BuildVersion" "ARsimShortcut"
			;!insertmacro ReadSectionFlagFromFile "$nsiPVI_OptionsFileName" "BuildVersion" "ARsimStart"
		${Else}
			!insertmacro FormatString1 "$(ErrorFileNotFound)" "$nsiPVI_OptionsFileName" $nsiPVI_ErrorText
			!insertmacro GenerateError "${ErrorCode_FileNotFound}" $nsiPVI_ErrorText
		${EndIf}
	${EndIf}
FunctionEnd


Function .onComponentsPre
	${If} "$IsSilent" == "${TRUE}"
	${OrIf} "$IsReduced" == "${TRUE}"
		Abort
	${EndIf}
FunctionEnd

Function .onComponentsLeave
	!insertmacro GetAndWriteSectionFlag "BuildVersion" "BuildVersion"
	!insertmacro GetAndWriteSectionFlag "BuildVersionBase" "BuildVersion"
	;!insertmacro GetAndWriteSectionFlag "Sample" "BuildVersion"
	;!insertmacro GetAndWriteSectionFlag "TS" "BuildVersion"
	;!insertmacro GetAndWriteSectionFlag "Lib" "BuildVersion"
	;!insertmacro GetAndWriteSectionFlag "Menu" "BuildVersion"
	;!insertmacro GetAndWriteSectionFlag "ARsim" "BuildVersion"
	;!insertmacro GetAndWriteSectionFlag "StarterProjectSim" "BuildVersion"
	;!insertmacro GetAndWriteSectionFlag "ARsimShortcut" "BuildVersion"
	;!insertmacro GetAndWriteSectionFlag "ARsimStart" "BuildVersion"
	;!insertmacro GetAndWriteSectionFlag "PanelSetup" "BuildVersion"
	;!insertmacro GetAndWriteSectionFlag "PanelSetupPkg" "BuildVersion"

FunctionEnd
