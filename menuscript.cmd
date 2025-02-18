::MenuScript v 004 (C) Joshua Cline - All rights reserved
@ECHO OFF&&SETLOCAL ENABLEDELAYEDEXPANSION&&CHCP 65001>NUL
SET "ARG1=%*"&&SET "ORIG_CMD=%0"&&SET "VER_GET=%0"&&CALL:GET_PROGVER
SET "ORIG_CD=%CD%"&&CD /D "%~DP0"&&CALL:GET_INIT
IF DEFINED ERR_MSG ECHO.ERROR: %ERR_MSG%&&PAUSE&&GOTO:QUIT
IF DEFINED ARG1 SET "ARG1=%ARG1:"=%"&&CALL:SETS_HANDLER&&GOTO:MENU_RUN
::#########################################################################
:MAIN_MENU
::#########################################################################
@ECHO OFF&&CLS&&CALL:SETS_HANDLER&&CALL:CLEAN&&CALL:PAD_LINE&&CALL:BOX_RT
ECHO.                               MenuScript&&ECHO.&&ECHO.  %@@%AVAILABLE MENUs:%$$%&&ECHO.&&SET "$FOLD=%MENU_FOLDER%"&&SET "$FILT=*.MENU"&&SET "$DISP=BAS"&&CALL:FILE_LIST
ECHO.&&CALL:BOX_RB&&CALL:PAD_LINE&&ECHO. (%##%Q%$$%)uit              (%##%R%$$%)un              (%##%E%$$%)dit              (%##%O%$$%)ptions&&CALL:PAD_LINE
CALL:PAD_PREV&&CALL:MENU_SELECT
IF NOT DEFINED SELECT GOTO:MAIN_MENU
IF "%SELECT%"=="~" SET&&PAUSE
IF "%SELECT%"=="Q" GOTO:QUIT
IF "%SELECT%"=="O" GOTO:SETTINGS_MENU
IF "%SELECT%"=="R" SET "$LNCH=Open"&&GOTO:MENU_LAUNCH
IF "%SELECT%"=="E" SET "$LNCH=Edit"&&GOTO:MENU_LAUNCH
GOTO:MAIN_MENU
:MENU_LAUNCH
CLS&&CALL:PAD_LINE&&CALL:BOX_RT&&ECHO.                               %$LNCH% Menu&&ECHO.&&ECHO.  %@@%AVAILABLE MENUs:%$$%&&ECHO.&&SET "$FOLD=%MENU_FOLDER%"&&SET "$FILT=*.MENU"&&CALL:FILE_LIST&&ECHO.&&CALL:BOX_RB&&CALL:PAD_LINE&&CALL:PAD_PREV&&CALL:MENU_SELECT
IF "%$LNCH%"=="Edit" IF DEFINED $PICK START NOTEPAD "%$PICK%"
IF "%$LNCH%"=="Open" IF DEFINED $CHOICE CALL menuscript.cmd "%$CHOICE%"
GOTO:MAIN_MENU
:MENU_RUN
SET "$CHOICE=%ARG1%"&&IF NOT EXIST "%MENU_FOLDER%\%ARG1%" SET "$CHOICE="&&ECHO.&&ECHO. Type menuscript.cmd "NameOfMenu.menu".
IF NOT DEFINED $CHOICE GOTO:QUIT
SET "HEAD_CHECK=%MENU_FOLDER%\%$CHOICE%"&&CALL:GET_HEAD
IF DEFINED ERROR GOTO:QUIT
IF NOT DEFINED CUR_SESSION SET "CUR_SESSION=0"
IF DEFINED CUR_SESSION SET /A "CUR_SESSION+=1"
SET "MENU_LAST%CUR_SESSION%=%$CHOICE%"&&SET "$MENU=%MENU_FOLDER%\%$CHOICE%"&&CALL:LIST_FILE&&SET /A "CUR_SESSION-=1"
IF DEFINED $LOOP SET /A "CUR_SESSION+=1"
CALL SET "$CHOICE=%%MENU_LAST%CUR_SESSION%%%"&&SET "MENU_LAST%CUR_SESSION%="
IF DEFINED $LOOP SET /A "CUR_SESSION-=1"
IF DEFINED $CHOICE CALL menuscript.cmd "%$CHOICE%"
GOTO:QUIT
:PAD_LINE
CALL SET "@@=%%XLR%ACC_COLOR%%%"&&CALL SET "##=%%XLR%BTN_COLOR%%%"&&CALL SET "$$=%%XLR%TXT_COLOR%%%"&&IF "%PAD_TYPE%"=="0" ECHO.%$$%&&EXIT /B
CHCP 65001>NUL
IF "%PAD_TYPE%"=="0" SET "PADX= "
IF "%PAD_TYPE%"=="1" SET "PADX=◌"
IF "%PAD_TYPE%"=="2" SET "PADX=○"
IF "%PAD_TYPE%"=="3" SET "PADX=●"
IF "%PAD_TYPE%"=="4" SET "PADX=□"
IF "%PAD_TYPE%"=="5" SET "PADX=■"
IF "%PAD_TYPE%"=="6" SET "PADX=░"
IF "%PAD_TYPE%"=="7" SET "PADX=▒"
IF "%PAD_TYPE%"=="8" SET "PADX=▓"
IF "%PAD_TYPE%"=="9" SET "PADX=~"
IF "%PAD_TYPE%"=="10" SET "PADX=="
IF "%PAD_TYPE%"=="11" SET "PADX=#"
SET "PAD_SEQX=%PAD_SEQ%"&&IF NOT "%PAD_SEQ%X"=="%PAD_SEQX%X" SET "XNTX=0"&&SET "XLRX="&&FOR /F "DELIMS=" %%G IN ('CMD.EXE /D /U /C ECHO.%PAD_SEQ%^| FIND /V ""') do (CALL SET "XLRX=%%G"&&CALL:COLOR_ASSIGN&&CALL SET /A "XNTX+=1")
IF "%PAD_SIZE%"=="LARGE" SET "PAD_BLK=%PADX%%PADX%%PADX%%PADX%%PADX%%PADX%%PADX%%PADX%%PADX%%PADX%"
IF "%PAD_SIZE%"=="SMALL" SET "PAD_BLK=%#0%%PADX%%#1%%PADX%%#2%%PADX%%#3%%PADX%%#4%%PADX%%#5%%PADX%%#6%%PADX%%#7%%PADX%%#8%%PADX%%#9%%PADX%"
IF "%PAD_SIZE%"=="LARGE" ECHO.%#0%%PAD_BLK%%#1%%PAD_BLK%%#2%%PAD_BLK%%#3%%PAD_BLK%%#4%%PAD_BLK%%#5%%PAD_BLK%%#6%%PAD_BLK%%$$%
IF "%PAD_SIZE%"=="SMALL" ECHO.%PAD_BLK%%PAD_BLK%%PAD_BLK%%PAD_BLK%%PAD_BLK%%PAD_BLK%%PAD_BLK%%$$%
SET "#Z=%$$%"&&SET "#0=%#1%"&SET "#1=%#2%"&SET "#2=%#3%"&SET "#3=%#4%"&SET "#4=%#5%"&SET "#5=%#6%"&SET "#6=%#7%"&SET "#7=%#8%"&SET "#8=%#9%"&SET "#9=%#0%"&&SET "PAD_BLK="&&SET "PADX="
EXIT /B
:COLOR_ASSIGN
IF DEFINED XNTX CALL SET "#%XNTX%=%%XLR%XLRX%%%"
EXIT /B
:BOX_RT
IF "%PAD_BOX%"=="DISABLED" EXIT /B
CALL:BOX_DISP&ECHO.%##%╭────────────────────────────────────────────────────────────────────╮%$$%&EXIT /B
:BOX_RB
IF "%PAD_BOX%"=="DISABLED" EXIT /B
CALL:BOX_DISP&ECHO.%##%╰────────────────────────────────────────────────────────────────────╯%$$%&EXIT /B
:BOX_ST
IF "%PAD_BOX%"=="DISABLED" EXIT /B
CALL:BOX_DISP&ECHO.%##%┌────────────────────────────────────────────────────────────────────┐%$$%&EXIT /B
:BOX_SB
IF "%PAD_BOX%"=="DISABLED" EXIT /B
CALL:BOX_DISP&ECHO.%##%└────────────────────────────────────────────────────────────────────┘%$$%&EXIT /B
:BOX_DISP
CHCP 65001>NUL
IF NOT DEFINED PAD_BOX SET "PAD_BOX=ENABLED"
EXIT /B
:FILE_LIST
SET "$EMPTY=1"&&SET "$XNT="&&FOR %%a in (1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99) DO (IF DEFINED $ITEM%%a SET "$ITEM%%a=")
IF NOT DEFINED $DISP SET "$DISP=NUM"
IF "%$DISP%"=="NUM" SET "$PICKER=1"
IF EXIST "%$FOLD%\%$FILT%" SET "$EMPTY="&&FOR /F "TOKENS=*" %%a in ('DIR /A: /B /O:GN "%$FOLD%\%$FILT%"') DO (IF NOT "%%a"=="$MENU" CALL SET /A "$XNT+=1"&&CALL SET "$CLM$=%%a"&&CALL:FILE_LISTX)
IF DEFINED $EMPTY ECHO.  EMPTY..
FOR %%a in ($EMPTY $DISP $XNT) DO (SET "%%a=")
EXIT /B
:FILE_LISTX
CALL SET "$ITEM%$XNT%=%$CLM$%"
IF EXIST "%$FOLD%\%$CLM$%\*" (SET "$LCLR1=%@@%"&&SET "$LCLR2=%$$%") ELSE (SET "$LCLR1="&&SET "$LCLR2=")
IF "%$DISP%"=="NUM" FOR /F "TOKENS=*" %%# in ("%$CLM$%") DO (ECHO. %$$%^( %##%%$XNT%%$$% ^) %$LCLR1%%%#%$LCLR2%)
IF "%$DISP%"=="BAS" FOR /F "TOKENS=*" %%# in ("%$CLM$%") DO (ECHO.   %$LCLR1%%%#%$LCLR2%)
EXIT /B
:LIST_FILE
IF NOT DEFINED $MENU GOTO:LIST_FILE_END
IF NOT EXIST "%$MENU%" GOTO:LIST_FILE_END
SET "HEAD_CHECK=%$MENU%"&&CALL:GET_HEAD
IF DEFINED ERROR GOTO:LIST_FILE_END
COPY /Y "%$MENU%" "$MENU">NUL 2>&1
FOR /F "TOKENS=* SKIP=1 DELIMS=" %%a in ($MENU) DO (CALL SET "$CMD=%%a"&&CALL:CMD_ITEM)
:LIST_FILE_END
IF EXIST "$MENU" DEL /Q /F "$MENU">NUL 2>&1
FOR %%a in ($MENU $CMD) DO (SET "%%a=")
EXIT /B
:CMD_ITEM
%$CMD%
EXIT /B
:MENU_SELECT
IF NOT DEFINED $CASE SET "$CASE=UPPER"
IF NOT DEFINED $CHECK SET "$CHECK=MENU"
IF NOT DEFINED $SELECT SET "$SELECT=SELECT"
SET "ERROR="&&SET "%$SELECT%="&&SET "SELECT_VAR="&&SET /P "SELECT_VAR=$>>"
IF "%FADE_OUT%"=="GRAY" COLOR 08
IF "%FADE_OUT%"=="TAN" COLOR 06
IF NOT DEFINED SELECT_VAR SET "ERROR=1"
IF NOT DEFINED ERROR SET "SELECT_VAR=%SELECT_VAR:"=%"
IF NOT DEFINED ERROR SET "CHECK_VAR=%SELECT_VAR%"&&CALL:CHECK
IF NOT DEFINED ERROR IF "%$CASE%"=="ANY" SET "%$SELECT%=%SELECT_VAR%"
IF NOT DEFINED ERROR FOR %%$ in (UPPER LOWER) DO (IF "%%$"=="%$CASE%" SET "CAPS_SET=%$SELECT%"&&SET "CAPS_VAR=%SELECT_VAR%"&&CALL:CAPS_SET)
FOR %%a in (SELECT_VAR %$SELECT%) DO (IF NOT DEFINED %%a SET "ERROR=1")
IF "%SELECT_VAR%"=="=" SET "ERROR=1"
IF DEFINED ERROR SET "%$SELECT%="&&IF DEFINED VERBOSE FOR /F "TOKENS=*" %%a in ("%SELECT_VAR% ") DO (ECHO. %XLR4%ERROR:%$$% input [ %XLR4%%%a%$$%] is invalid)
FOR %%a in ($CHOICE $CASE $CHECK $SELECT SELECT_VAR VERBOSE) DO (SET "%%a=")
ECHO.%$$%&&CALL SET "$CHOICE=%%$ITEM%SELECT%%%"
IF NOT DEFINED $PICKER EXIT /B
FOR %%a in ($PICKER $PICK $PATH $BODY $EXT) DO (SET "%%a=")
IF NOT DEFINED $CHOICE SET "ERROR=1"&&EXIT /B
IF NOT EXIST "%$FOLD%\%$CHOICE%" SET "ERROR=1"&&EXIT /B
IF EXIST "%$FOLD%\%$CHOICE%" SET "$PICK=%$FOLD%\%$CHOICE%"
IF NOT DEFINED ERROR FOR %%G in ("%$PICK%") DO (SET "$PATH=%%~dG%%~pG"&&SET "$BODY=%%~nG"&&SET "$EXT=%%~xG")
IF NOT DEFINED ERROR FOR %%G in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) DO (CALL SET "$EXT=%%$EXT:%%G=%%G%%")
EXIT /B
:CAPS_SET
IF NOT DEFINED CAPS_VAR SET "%CAPS_SET%="&&SET "CAPS_SET="&&SET "CAPS_VAR="&&SET "$CASE="&&EXIT /B
IF NOT DEFINED $CASE SET "$CASE=UPPER"
IF "%$CASE%"=="LOWER" FOR %%G in (a b c d e f g h i j k l m n o p q r s t u v w x y z) DO (CALL SET "CAPS_VAR=%%CAPS_VAR:%%G=%%G%%")
IF "%$CASE%"=="UPPER" FOR %%G in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) DO (CALL SET "CAPS_VAR=%%CAPS_VAR:%%G=%%G%%")
IF "%CAPS_VAR%"=="a=a" SET "CAPS_VAR="
IF "%CAPS_VAR%"=="A=A" SET "CAPS_VAR="
CALL SET "%CAPS_SET%=%CAPS_VAR%"&&SET "CAPS_SET="&&SET "CAPS_VAR="&&SET "$CASE="
EXIT /B
:CHECK
SET "ERROR="&&IF NOT DEFINED CHECK_VAR SET "ERROR=1"
IF "%$CHECK%"=="NUM" SET "CHECK_FLT=0 1 2 3 4 5 6 7 8 9 ^""
IF "%$CHECK%"=="LTR" SET "CHECK_FLT=A B C D E F G H I J K L M N O P Q R S T U V W X Y Z a b c d e f g h i j k l m n o p q r s t u v w x y z ^""
IF "%$CHECK%"=="ALPHA" SET "CHECK_FLT=0 1 2 3 4 5 6 7 8 9 A B C D E F G H I J K L M N O P Q R S T U V W X Y Z a b c d e f g h i j k l m n o p q r s t u v w x y z ^""
IF "%$CHECK%"=="MENU" SET "CHECK_FLT=0 1 2 3 4 5 6 7 8 9 A B C D E F G H I J K L M N O P Q R S T U V W X Y Z a b c d e f g h i j k l m n o p q r s t u v w x y z @ # $ . - _ + = ~ ^* ^""
IF "%$CHECK%"=="MOST" SET "CHECK_FLT=0 1 2 3 4 5 6 7 8 9 A B C D E F G H I J K L M N O P Q R S T U V W X Y Z a b c d e f g h i j k l m n o p q r s t u v w x y z @ # $ ^\ ^/ ^: ^( ^) ^[ ^] ^{ ^} ^. ^- ^_ ^+ ^= ^~ ^* ^%% ^""
IF NOT DEFINED ERROR FOR /F "DELIMS=" %%$ in ('CMD.EXE /D /U /C ECHO."%CHECK_VAR%"^| FIND /V ""') do (SET "$GO="&&FOR %%a in (%CHECK_FLT%) DO (
IF "[%%$]"=="[*]" IF NOT DEFINED NO_ASTRK SET "$GO=1"
IF "[%%$]"=="[ ]" IF NOT DEFINED NO_SPACE SET "$GO=1"
IF "[%%a]"=="[%%$]" SET "$GO=1")
IF NOT DEFINED $GO SET "ERROR=1")
FOR %%a in ($CHECK CHECK_VAR CHECK_FLT NO_SPACE NO_ASTRK) DO (SET "%%a=")
EXIT /B
:GET_INIT
SET "ERR_MSG="&&FOR %%G in ("%ORIG_CMD%") DO (SET "ORIG_CMD=%%~nG%%~xG")
FOR /F "TOKENS=*" %%a in ("%CD%") DO (SET "CAPS_SET=PROG_FOLDER"&&SET "CAPS_VAR=%%a"&&CALL:CAPS_SET)
FOR /F "TOKENS=1-2 DELIMS=:" %%a IN ("%PROG_FOLDER%") DO (IF "%%b"=="\" SET "PROG_FOLDER=%%a:"
FOR /F "DELIMS=" %%$ in ('CMD.EXE /D /U /C ECHO.%%b^| FIND /V ""') do (IF "%%$"==" " SET "ERR_MSG=Remove the space from the path or folder name, then launch again."))
IF NOT EXIST "%PROG_FOLDER%" SET "ERR_MSG=Invalid path or folder name. Relocate, then launch again."
IF "%PROG_FOLDER%"=="%SYSTEMDRIVE%\WINDOWS\SYSTEM32" SET "ERR_MSG=Invalid path or folder name. Relocate, then launch again."
SET "PATH_TEMP="&&FOR /F "TOKENS=1-9 DELIMS=\" %%a IN ("%PROG_FOLDER%") DO (IF "%%a\%%b\%%c"=="%SystemDrive%\WINDOWS\TEMP" SET "PATH_TEMP=1"
IF "%%a\%%b\%%d\%%e\%%f"=="%SystemDrive%\USERS\APPDATA\LOCAL\TEMP" SET "PATH_TEMP=1")
IF DEFINED PATH_TEMP SET "ERR_MSG=This should not be run from a temp folder. Extract zip into a new folder, then launch again."
Reg.exe query "HKU\S-1-5-19\Environment">NUL
IF NOT "%ERRORLEVEL%" EQU "0" SET "ERR_MSG=Right click and run as administrator."
SET "LANG_PASS="&&FOR /F "TOKENS=4-5 DELIMS= " %%a IN ('DIR') DO (IF "%%a %%b"=="bytes free" SET "LANG_PASS=1")
IF NOT DEFINED LANG_PASS SET "ERR_MSG=Non-english host language/locale."
EXIT /B
:GET_PROGVER
IF NOT DEFINED VER_SET SET "VER_SET=VER_CUR"
IF EXIST "%VER_GET%" SET /P VER_CHK=<"%VER_GET%"
SET "%VER_SET%="&&FOR /F "TOKENS=1-3 DELIMS= " %%A IN ("%VER_CHK%") DO (SET "%VER_SET%=%%C")
IF NOT DEFINED %VER_SET% SET "ERROR=1"
SET "VER_CHK="&&SET "VER_GET="&&SET "VER_SET="&&EXIT /B
:GET_HEAD
SET "ERROR="&&SET "$HEAD="&&IF NOT DEFINED HEAD_CHECK EXIT /B
SET /P $HEAD=<"%HEAD_CHECK%"
IF NOT "%$HEAD%"=="MENU-SCRIPT" SET "ERROR=1"
IF DEFINED ERROR ECHO.&&ECHO. %XLR2%ERROR:%$$% Bad file header, check file.&&ECHO.&&CALL:TIMER_POINT3
SET "HEAD_CHECK="&&EXIT /B
:TIMER
FOR /F "TOKENS=3 DELIMS=:." %%a in ("%TIME%") DO (IF NOT "%%a"=="%TIMER_LAST%" SET "TIMER_LAST=%%a"&&SET /A "TIMER-=1"&&IF DEFINED TIMER_MSG CLS&&CALL ECHO.%TIMER_MSG%)
IF NOT "%TIMER%"=="0" GOTO:TIMER
SET "TIMER="&&SET "TIMER_LAST="&&SET "TIMER_MSG="&&EXIT /B
:TIMER_POINT3
FOR /F "TOKENS=1-9 DELIMS=:." %%a in ("%TIME%") DO (FOR /F "DELIMS=" %%G IN ('CMD.EXE /D /U /C CALL ECHO.%%d') DO (CALL SET "TIMER_X=%%G"))
FOR %%a in (2 5 8) DO (IF "%TIMER_X%"=="%%a" SET "TIMER_X="&&EXIT /B)
GOTO:TIMER_POINT3
:CLEAN
IF NOT EXIST "$*" EXIT /B
FOR %%G in (MENU DSK) DO (IF EXIST "$%%G*" DEL /Q /F "$%%G*">NUL 2>&1)
EXIT /B
:PAD_PREV
ECHO.               Press (%##%Enter%$$%) to return to previous menu
EXIT /B
:PAUSED
IF NOT DEFINED NO_PAUSE SET /P "PAUSED=.                      Press (%##%Enter%$$%) to continue..."
SET "NO_PAUSE="&&EXIT /B
:SETS_HANDLER
SET "PROG_SOURCE=%PROG_FOLDER%"&&IF NOT DEFINED PROG_FOLDER0 SET "PROG_FOLDER0=%PROG_FOLDER%"
CD /D "%PROG_FOLDER%"&&IF EXIST "menuscript.ini" IF NOT DEFINED $ETS SET "$ETS=1"&&FOR /F "eol=- TOKENS=1-2 DELIMS==" %%a in (menuscript.ini) DO (IF NOT "%%a"=="   " SET "%%a=%%b")
IF NOT DEFINED PAD_TYPE SET "PAD_TYPE=1"
IF NOT DEFINED ACC_COLOR SET "ACC_COLOR=4"
IF NOT DEFINED BTN_COLOR SET "BTN_COLOR=2"
IF NOT DEFINED TXT_COLOR SET "TXT_COLOR=0"
IF NOT DEFINED FADE_OUT SET "FADE_OUT=GRAY"
IF NOT DEFINED PAD_SIZE SET "PAD_SIZE=LARGE"
IF NOT DEFINED PAD_SEQ SET "PAD_SEQ=6666622222"
ECHO.MenuScript v %VER_CUR% Settings>"menuscript.ini"
FOR %%a in (PAD_BOX PAD_TYPE PAD_SIZE PAD_SEQ TXT_COLOR ACC_COLOR BTN_COLOR FADE_OUT FOLDER_MODE) DO (CALL ECHO.%%a=%%%%a%%>>"menuscript.ini")
SET "FOLDER_MODE=UNIFIED"&&IF EXIST "%PROG_SOURCE%\MODULE" IF EXIST "%PROG_SOURCE%\MENU" SET "FOLDER_MODE=ISOLATED"
IF "%FOLDER_MODE%"=="ISOLATED" FOR %%a in (MODULE MENU) DO (SET "%%a_FOLDER=%PROG_SOURCE%\%%a")
IF "%FOLDER_MODE%"=="UNIFIED" FOR %%a in (MODULE MENU) DO (SET "%%a_FOLDER=%PROG_SOURCE%")
IF NOT DEFINED XLR0 SET "XLR0=[97m"&&SET "XLR1=[31m"&&SET "XLR2=[91m"&&SET "XLR3=[33m"&&SET "XLR4=[93m"&&SET "XLR5=[92m"&&SET "XLR6=[96m"&&SET "XLR7=[94m"&&SET "XLR8=[34m"&&SET "XLR9=[95m"&&CALL:PAD_LINE>NUL 2>&1
FOR %%a in (ERROR $LOOP $HALT $CHOICE $PICK $FOLD $FILT) DO (SET "%%a=")
EXIT /B
::#########################################################################
:SETTINGS_MENU
::#########################################################################
CLS&&CALL:SETS_HANDLER&&CALL:PAD_LINE&&CALL:BOX_RT&&ECHO.                        Settings Configuration&&ECHO.
ECHO. (%##%1%$$%) Appearance&&ECHO. (%##%2%$$%) Folder Mode  %@@%%FOLDER_MODE%%$$%&&ECHO.&&CALL:BOX_RB&&CALL:PAD_LINE
CALL:PAD_PREV&&CALL:MENU_SELECT
IF NOT DEFINED SELECT GOTO:MAIN_MENU
IF "%SELECT%"=="1" GOTO:APPEARANCE
IF "%SELECT%"=="2" CALL:FOLDER_MODE
GOTO:SETTINGS_MENU
:FOLDER_MODE
IF "%FOLDER_MODE%"=="UNIFIED" SET "FOLDER_MODE=ISOLATED"&&GOTO:FOLDER_ISOLATED
IF "%FOLDER_MODE%"=="ISOLATED" SET "FOLDER_MODE=UNIFIED"&&GOTO:FOLDER_UNIFIED
:FOLDER_UNIFIED
FOR %%a in (MODULE MENU) DO (IF EXIST "%PROG_SOURCE%\%%a" MOVE /Y "%PROG_SOURCE%\%%a\*.*" "%PROG_SOURCE%">NUL 2>&1)
FOR %%a in (MODULE MENU) DO (IF EXIST "%PROG_SOURCE%\%%a" XCOPY /S /C /Y "%PROG_SOURCE%\%%a" "%PROG_SOURCE%">NUL 2>&1)
FOR %%a in (MODULE MENU) DO (IF EXIST "%PROG_SOURCE%\%%a" RD /Q /S "\\?\%PROG_SOURCE%\%%a">NUL 2>&1)
EXIT /B
:FOLDER_ISOLATED
FOR %%a in (module menu) DO (IF NOT EXIST "%PROG_SOURCE%\%%a" MD "%PROG_SOURCE%\%%a">NUL 2>&1)
FOR %%a in (MENU) DO (IF EXIST "%PROG_SOURCE%\*.%%a" MOVE /Y "%PROG_SOURCE%\*.%%a" "%PROG_SOURCE%\MENU">NUL 2>&1)
FOR /F "TOKENS=*" %%a in ('DIR /A: /B /O:GN "%PROG_SOURCE%\*.CMD"') DO (IF NOT "%%a"=="%ORIG_CMD%" MOVE /Y "%PROG_SOURCE%\%%a" "%PROG_SOURCE%\MODULE">NUL 2>&1)
EXIT /B
:APPEARANCE
CLS&&CALL:SETS_HANDLER&&CALL:PAD_LINE&&CALL:BOX_RT&&ECHO.                              Appearance&&ECHO.
ECHO. (%##%1%$$%) Pad Type           %@@%PAD %PAD_TYPE%%$$%&&ECHO. (%##%2%$$%) Pad Size           %@@%%PAD_SIZE%%$$%&&ECHO. (%##%3%$$%) Pad Sequence       %@@%%PAD_SEQ%%$$%&&CALL ECHO. (%##%4%$$%) Text Color         %@@%COLOR %%XLR%TXT_COLOR%%%%TXT_COLOR%%$$%&&CALL ECHO. (%##%5%$$%) Accent Color       %@@%COLOR %%XLR%ACC_COLOR%%%%ACC_COLOR%%$$%&&CALL ECHO. (%##%6%$$%) Button Color       %@@%COLOR %%XLR%BTN_COLOR%%%%BTN_COLOR%%$$%&&CALL ECHO. (%##%7%$$%) Fade Out           %@@%%FADE_OUT%%$$%&&ECHO. (%##%8%$$%) Pad Box            %@@%%PAD_BOX%%$$%&&ECHO.&&ECHO.                         Color ( %##%-%$$% / %##%+%$$% ) Shift&&CALL:BOX_RB&&CALL:PAD_LINE
CALL:PAD_PREV&&CALL:MENU_SELECT
IF NOT DEFINED SELECT GOTO:SETTINGS_MENU
IF "%SELECT%"=="+" CALL:COLOR_SHIFT_TXT&SET "SELECT="
IF "%SELECT%"=="-" CALL:COLOR_SHIFT_PAD&SET "SELECT="
IF "%SELECT%"=="1" CALL:PAD_TYPE&SET "SELECT="
IF "%SELECT%"=="2" IF "%PAD_SIZE%"=="LARGE" SET "PAD_SIZE=SMALL"&SET "SELECT="
IF "%SELECT%"=="2" IF "%PAD_SIZE%"=="SMALL" SET "PAD_SIZE=LARGE"&SET "SELECT="
IF "%SELECT%"=="3" CALL:PAD_LINE&&CALL:BOX_RT&&ECHO.&&ECHO.                  Enter 10 digit color sequence seed&&ECHO.&&ECHO.                   [ %XLR0%0%XLR1%1%XLR2%2%XLR3%3%XLR4%4%XLR5%5%XLR6%6%XLR7%7%XLR8%8%XLR9%9%$$% ]    [ %XLR1%11%XLR2%22%XLR3%33%XLR4%44%XLR5%55%$$% ]&&ECHO.&&CALL:BOX_RB&&CALL:PAD_LINE&&SET "$SELECT=COLOR_XXX"&&CALL:MENU_SELECT
IF "%SELECT%"=="3" SET "XNTX="&&FOR /F "DELIMS=" %%G IN ('CMD.EXE /D /U /C ECHO.%COLOR_XXX%^| FIND /V ""') do (CALL SET /A "XNTX+=1")
IF "%SELECT%"=="3" IF "%XNTX%"=="10" SET "PAD_SEQ=%COLOR_XXX%"&&SET "COLOR_XXX="&SET "SELECT="
IF "%SELECT%"=="4" SET "COLOR_TMP=TXT_COLOR"&&CALL:COLOR_CHOICE&SET "SELECT="
IF "%SELECT%"=="5" SET "COLOR_TMP=ACC_COLOR"&&CALL:COLOR_CHOICE&SET "SELECT="
IF "%SELECT%"=="6" SET "COLOR_TMP=BTN_COLOR"&&CALL:COLOR_CHOICE&SET "SELECT="
IF "%SELECT%"=="7" IF "%FADE_OUT%"=="GRAY" SET "FADE_OUT=TAN"&SET "SELECT="
IF "%SELECT%"=="7" IF "%FADE_OUT%"=="TAN" SET "FADE_OUT=DISABLED"&SET "SELECT="
IF "%SELECT%"=="7" IF "%FADE_OUT%"=="DISABLED" SET "FADE_OUT=GRAY"&SET "SELECT="
IF "%SELECT%"=="8" IF "%PAD_BOX%"=="DISABLED" SET "PAD_BOX=ENABLED"&SET "SELECT="
IF "%SELECT%"=="8" IF "%PAD_BOX%"=="ENABLED" SET "PAD_BOX=DISABLED"&SET "SELECT="
GOTO:APPEARANCE
:PAD_TYPE
CHCP 65001>NUL
CLS&&CALL:PAD_LINE&&CALL:BOX_RT&&ECHO.&&ECHO.                           Choose a pad type&&ECHO.&&ECHO.   (%##%0%$$%)None (%##%1%$$%)◌ (%##%2%$$%)○ (%##%3%$$%)● (%##%4%$$%)□ (%##%5%$$%)■ (%##%6%$$%)░ (%##%7%$$%)▒ (%##%8%$$%)▓ (%##%9%$$%)~ (%##%10%$$%)= (%##%11%$$%)&&ECHO.&&CALL:BOX_RB&&CALL:PAD_LINE&&CALL:PAD_PREV&&SET "$SELECT=SELECTX"&&CALL:MENU_SELECT
FOR %%a in (0 1 2 3 4 5 6 7 8 9 10 11) DO (IF "%SELECTX%"=="%%a" SET "PAD_TYPE=%SELECTX%")
EXIT /B
:COLOR_CHOICE
CALL:PAD_LINE&&CALL:BOX_RT&&ECHO.&&ECHO.                            Choose a color&&ECHO.&&ECHO.                  [ %XLR0% 0 %XLR1% 1 %XLR2% 2 %XLR3% 3 %XLR4% 4 %XLR5% 5 %XLR6% 6 %XLR7% 7 %XLR8% 8 %XLR9% 9 %$$% ]&&ECHO.&&CALL:BOX_RB&&CALL:PAD_LINE&&CALL:PAD_PREV&&SET "$SELECT=SELECTX"&&CALL:MENU_SELECT
FOR %%a in (0 1 2 3 4 5 6 7 8 9) DO (IF "%SELECTX%"=="%%a" SET "%COLOR_TMP%=%SELECTX%")
SET "COLOR_TMP="&&EXIT /B
:COLOR_SHIFT_PAD
FOR /F "DELIMS=" %%G in ('CMD.EXE /D /U /C ECHO.%PAD_SEQ%^| FIND /V ""') do (SET "XXX_XXX=%%G"&&SET /A "PAD_XNT+=1"&&CALL:PAD_XNT)
SET "PAD_SEQ=%PAD_SHIFT%"&&FOR %%a in (PAD_SHIFT PAD_XNT XXX_XXX) DO (SET "%%a=")
EXIT /B
:COLOR_SHIFT_TXT
FOR %%a in (TXT_COLOR ACC_COLOR BTN_COLOR) DO (SET /A "%%a+=1")
IF "%TXT_COLOR%"=="10" SET "TXT_COLOR=0"
IF "%ACC_COLOR%"=="10" SET "ACC_COLOR=0"
IF "%BTN_COLOR%"=="10" SET "BTN_COLOR=0"
EXIT /B
:PAD_XNT
IF %PAD_XNT% GTR 10 EXIT /B
SET /A "XXX_XXX+=1"&&IF "%XXX_XXX%"=="9" SET "XXX_XXX=0"
SET "PAD_SHIFT=%PAD_SHIFT%%XXX_XXX%"
EXIT /B
:QUIT
CD /D "%ORIG_CD%"
EXIT /B