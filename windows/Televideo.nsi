;NSIS Modern User Interface
;Televideo installer
;Written by Andrea Decorte

;--------------------------------
;Include Modern UI

  !include "MUI2.nsh"

;--------------------------------
;General

  ;Name and file
  Name "Televideo 0.44"
  OutFile "TelevideoInstaller-0.44.exe"

  ;Default installation folder
  InstallDir "$PROGRAMFILES\Televideo"
  
  ;Request application privileges for Windows Vista
  RequestExecutionLevel admin
  
;--------------------------------
;Variables

  Var StartMenuFolder

;--------------------------------
;Interface Settings

  !define MUI_ABORTWARNING
  !define MUI_FINISHPAGE
  !define MUI_FINISHPAGE_SHOWREADME "$INSTDIR\televideo.exe"
  !define MUI_TEXT_FINISH_SHOWREADME "Esegui Televideo"


;--------------------------------
;Pages


  !insertmacro MUI_PAGE_DIRECTORY
  !insertmacro MUI_PAGE_COMPONENTS
  !insertmacro MUI_PAGE_STARTMENU Televideo $StartMenuFolder
  !insertmacro MUI_PAGE_INSTFILES
  !insertmacro MUI_PAGE_FINISH
  !insertmacro MUI_UNPAGE_CONFIRM
  !insertmacro MUI_UNPAGE_INSTFILES

;--------------------------------
;Languages

  !insertmacro MUI_LANGUAGE "Italian"
  !insertmacro MUI_LANGUAGE "English" ;first language is the default language
  !insertmacro MUI_LANGUAGE "French"
  !insertmacro MUI_LANGUAGE "German"
  !insertmacro MUI_LANGUAGE "Spanish"

;--------------------------------
;Reserve Files
  
  ;If you are using solid compression, files that are required before
  ;the actual installation should be stored first in the data block,
  ;because this will make your installer start faster.
  
  !insertmacro MUI_RESERVEFILE_LANGDLL

;--------------------------------
;Installer Sections

Section "!File del Programma" SecInstall

  SetOutPath "$INSTDIR"
  
  ;ADD YOUR OWN FILES HERE...
  File "bz2.pyd"
  File "library.zip"
  File "PyQt4.QtCore.pyd"
  File "PyQt4.QtGui.pyd"
  File "PyQt4.QtNetwork.pyd"
  File "python26.dll"
  File "QtCore4.dll"
  File "QtGui4.dll"
  File "QtNetwork4.dll"
  File "select.pyd"
  File "sip.pyd"
  File "televideo.exe"
  File "unicodedata.pyd"
  File "w9xpopen.exe"
  File "Changelog.txt"
  File "README"
  File "COPYING"
  File "televideo.ico"
  File /r "icons"
  
    !insertmacro MUI_STARTMENU_WRITE_BEGIN Televideo
    
    ;Create shortcuts
    CreateDirectory "$SMPROGRAMS\$StartMenuFolder"
	CreateShortCut "$SMPROGRAMS\$StartMenuFolder\Televideo.lnk" "$INSTDIR\televideo.exe" "" "$INSTDIR\televideo.ico" 0
    CreateShortCut "$SMPROGRAMS\$StartMenuFolder\Uninstall.lnk" "$INSTDIR\Uninstall.exe"
  
	!insertmacro MUI_STARTMENU_WRITE_END
  
  ;Create uninstaller
  WriteUninstaller "$INSTDIR\Uninstall.exe"

SectionEnd

Section /o "Icona sul desktop" SecDesktop
  CreateShortcut "$DESKTOP\Televideo.lnk" "$INSTDIR\televideo.exe" "" "$INSTDIR\televideo.ico" 0
SectionEnd

;--------------------------------
;Installer Functions

Function .onInit

  !insertmacro MUI_LANGDLL_DISPLAY

FunctionEnd

;--------------------------------
;Descriptions

  ;USE A LANGUAGE STRING IF YOU WANT YOUR DESCRIPTIONS TO BE LANGAUGE SPECIFIC

  ;Assign descriptions to sections
  !insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
    !insertmacro MUI_DESCRIPTION_TEXT ${SecInstall} "File necessari per il funzionamento del programma"
	!insertmacro MUI_DESCRIPTION_TEXT ${SecDesktop} "Crea un collegamento al Televideo sul tuo Desktop"
  !insertmacro MUI_FUNCTION_DESCRIPTION_END

 
;--------------------------------
;Uninstaller Section

Section "Uninstall"

  ;ADD YOUR OWN FILES HERE...
  Delete $INSTDIR\bz2.pyd
  Delete $INSTDIR\library.zip
  Delete $INSTDIR\PyQt4.QtCore.pyd
  Delete $INSTDIR\PyQt4.QtGui.pyd
  Delete $INSTDIR\PyQt4.QtNetwork.pyd
  Delete $INSTDIR\python26.dll
  Delete $INSTDIR\QtCore4.dll
  Delete $INSTDIR\QtGui4.dll
  Delete $INSTDIR\QtNetwork4.dll
  Delete $INSTDIR\select.pyd
  Delete $INSTDIR\sip.pyd
  Delete $INSTDIR\televideo.exe
  Delete $INSTDIR\unicodedata.pyd
  Delete $INSTDIR\w9xpopen.exe
  Delete $INSTDIR\Changelog.txt
  Delete $INSTDIR\README
  Delete $INSTDIR\COPYING
  Delete $INSTDIR\televideo.ico
  RMDir /r $INSTDIR\icons
  
  Delete "$INSTDIR\Uninstall.exe"

  RMDir /r "$INSTDIR"
  
  !insertmacro MUI_STARTMENU_GETFOLDER Televideo $StartMenuFolder
    
  Delete "$SMPROGRAMS\$StartMenuFolder\Televideo.lnk"
  Delete "$SMPROGRAMS\$StartMenuFolder\Uninstall.lnk"
  RMDir "$SMPROGRAMS\$StartMenuFolder"
  Delete "$DESKTOP\Televideo.lnk" 

SectionEnd

;--------------------------------
;Uninstaller Functions

Function un.onInit

  !insertmacro MUI_UNGETLANGUAGE
  
FunctionEnd
