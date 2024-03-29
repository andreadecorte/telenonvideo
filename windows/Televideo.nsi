;NSIS Modern User Interface
;Televideo installer
;Written by Andrea Decorte

;--------------------------------
;Include Modern UI

  !include "MUI2.nsh"
  ;needed for GetSize
  !include "FileFunc.nsh"

;--------------------------------
;General

  ;Name and file
  Name "Televideo"
  OutFile "TelevideoInstaller-0.45.exe"

  ;Default installation folder
  InstallDir "$PROGRAMFILES\Televideo"
  
  ;Request application privileges for Windows Vista
  RequestExecutionLevel admin
  
  ;Set Compression level
  SetCompressor /SOLID lzma
  
  
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
  File "python27.dll"
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
  File "mingwm10.dll"
  File "libgcc_s_dw2-1.dll"
  File "msvcp90.dll"
  File "SSLEAY32.dll"
  File "LIBEAY32.dll"
  File /r "icons"
  
    !insertmacro MUI_STARTMENU_WRITE_BEGIN Televideo
    
    ;Create shortcuts
    CreateDirectory "$SMPROGRAMS\$StartMenuFolder"
	CreateShortCut "$SMPROGRAMS\$StartMenuFolder\Televideo.lnk" "$INSTDIR\televideo.exe" "" "$INSTDIR\televideo.ico" 0
    CreateShortCut "$SMPROGRAMS\$StartMenuFolder\Uninstall.lnk" "$INSTDIR\Uninstall.exe"
  
	!insertmacro MUI_STARTMENU_WRITE_END
  
  ;Create uninstaller
  WriteUninstaller "$INSTDIR\Uninstall.exe"
  
  ;Write info on registry to add an entry to Add Remove Panel
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Televideo" \
                 "DisplayName" "Televideo"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Televideo" \
                 "UninstallString" "$\"$INSTDIR\uninstall.exe$\""
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Televideo" \
                 "Publisher" "Andrea Decorte"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Televideo" \
                 "URLInfoAbout" "http://http://code.google.com/p/telenonvideo/"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Televideo" \
                 "DisplayIcon" "$INSTDIR\televideo.ico"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Televideo" \
                 "DisplayVersion" "0.45"
  ${GetSize} "$INSTDIR" "/S=0K" $0 $1 $2
  IntFmt $0 "0x%08X" $0
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Televideo" \
                 "EstimatedSize" "$0"				  

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
  Delete $INSTDIR\mingwm10.dll
  Delete $INSTDIR\libgcc_s_dw2-1.dll
  RMDir /r $INSTDIR\icons
  
  Delete "$INSTDIR\Uninstall.exe"

  RMDir /r "$INSTDIR"
  
  !insertmacro MUI_STARTMENU_GETFOLDER Televideo $StartMenuFolder
    
  Delete "$SMPROGRAMS\$StartMenuFolder\Televideo.lnk"
  Delete "$SMPROGRAMS\$StartMenuFolder\Uninstall.lnk"
  RMDir "$SMPROGRAMS\$StartMenuFolder"
  Delete "$DESKTOP\Televideo.lnk"
  
  ;Delete key added on install
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Televideo"  

SectionEnd

;--------------------------------
;Uninstaller Functions

Function un.onInit

  !insertmacro MUI_UNGETLANGUAGE
  
FunctionEnd
