::MenuScript v 005 (C) Joshua Cline - All rights reserved
@ECHO OFF&&SETLOCAL ENABLEDELAYEDEXPANSION&&CHCP 65001>NUL
SET "ERR_MSG="&&CD /D "%~DP0"&&SET /P VER_CUR=<"%0"
SET "ORIG_CD=%CD%"&&FOR %%G in ("%0") DO (SET "ORIG_CMD=%%~nG%%~xG")
FOR /F "TOKENS=1-9 DELIMS= " %%a in ("%VER_CUR%") DO (SET "VER_CUR=%%c")
TITLE MenuScript v%VER_CUR% github.com/joshuacline&&SET "$ARG=%*"
FOR %%G in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) DO (CALL SET "PROG_FOLDER=%%CD:%%G=%%G%%")
FOR /F "TOKENS=1-2 DELIMS=:" %%a in ("%PROG_FOLDER%") DO (IF "%%b"=="\" SET "PROG_FOLDER=%%a:"
FOR /F "DELIMS=" %%$ in ('CMD.EXE /D /U /C ECHO.%%b^| FIND /V ""') do (IF "%%$"==" " SET "ERR_MSG=Remove the space from the path, then launch again."))
IF NOT EXIST "%PROG_FOLDER%" SET "ERR_MSG=Invalid path or folder name. Relocate, then launch again."
IF "%PROG_FOLDER%"=="%SYSTEMDRIVE%\WINDOWS\SYSTEM32" SET "ERR_MSG=Invalid path or folder name. Relocate, then launch again."
SET "PATH_TEMP="&&FOR /F "TOKENS=1-9 DELIMS=\" %%a in ("%PROG_FOLDER%") DO (
IF "%%a\%%b\%%c"=="%SystemDrive%\WINDOWS\TEMP" SET "ERR_MSG=Extract zip into a new folder, then launch again."
IF "%%a\%%b\%%d\%%e\%%f"=="%SystemDrive%\USERS\APPDATA\LOCAL\TEMP" SET "ERR_MSG=Extract zip into a new folder, then launch again.")
Reg.exe query "HKU\S-1-5-19\Environment">NUL
IF NOT "%ERRORLEVEL%" EQU "0" SET "ERR_MSG=Right click and run as administrator."
IF NOT DEFINED $ARG SET "ERR_MSG=Type menuscript.cmd "Name-Of-Menu.menu"."
IF DEFINED ERR_MSG ECHO.ERROR: %ERR_MSG%&&PAUSE&&GOTO:QUIT
SET "$ARG=%$ARG:"=%"&&SET "FOLDER_MODE=UNIFIED"&&IF EXIST "%PROG_FOLDER%\MODULE" IF EXIST "%PROG_FOLDER%\MENU" SET "FOLDER_MODE=ISOLATED"
IF "%FOLDER_MODE%"=="ISOLATED" FOR %%a in (MODULE MENU) DO (SET "%%a_FOLDER=%PROG_FOLDER%\%%a")
IF "%FOLDER_MODE%"=="UNIFIED" FOR %%a in (MODULE MENU) DO (SET "%%a_FOLDER=%PROG_FOLDER%")
IF NOT EXIST "%MENU_FOLDER%\%$ARG%" ECHO.&&ECHO. "%MENU_FOLDER%\%$ARG%" does not exist.&&GOTO:QUIT
SET /P $HEAD=<"%MENU_FOLDER%\%$ARG%"
IF NOT "%$HEAD%"=="MENU-SCRIPT" ECHO.&&ECHO. %XLR2%ERROR:%$$% Bad file header, check file.&&ECHO.&&GOTO:QUIT
FOR %%a in ($MENU $CMD $LOOP $HALT $CHOICE $PICK $FOLD $FILT) DO (SET "%%a=")
IF EXIST "menuscript.ini" FOR /F "eol=- TOKENS=1-2 SKIP=1 DELIMS==" %%a in (menuscript.ini) DO (IF NOT "%%a"=="   " SET "%%a=%%b")
IF NOT DEFINED XLR0 SET "XLR0=[97m"&&SET "XLR1=[31m"&&SET "XLR2=[91m"&&SET "XLR3=[33m"&&SET "XLR4=[93m"&&SET "XLR5=[92m"&&SET "XLR6=[96m"&&SET "XLR7=[94m"&&SET "XLR8=[34m"&&SET "XLR9=[95m"
IF NOT DEFINED CUR_SESSION SET "CUR_SESSION=0"
IF DEFINED CUR_SESSION SET /A "CUR_SESSION+=1"
SET "MENU_LAST%CUR_SESSION%=%$ARG%"
COPY /Y "%MENU_FOLDER%\%$ARG%" "$MENU">NUL&&SET "$DEL="&&FOR /F "TOKENS=* SKIP=1 DELIMS=" %%a in ($MENU) DO (IF NOT DEFINED $DEL SET "$DEL=1"&&DEL /Q /F "$MENU">NUL 2>&1
CALL SET "$CMD=%%a"&&CALL:CMD_ITEM)
SET /A "CUR_SESSION-=1"
IF DEFINED $LOOP SET /A "CUR_SESSION+=1"
CALL SET "$ARG=%%MENU_LAST%CUR_SESSION%%%"&&SET "MENU_LAST%CUR_SESSION%="
IF DEFINED $LOOP SET /A "CUR_SESSION-=1"
CD /D "%PROG_FOLDER%"
IF NOT EXIST "menuscript.ini" ECHO.MenuScript Settings>"menuscript.ini"
IF EXIST "menuscript.ini" SET "$NEW="&&FOR /F "eol=- TOKENS=1-2 SKIP=1 DELIMS==" %%a in (menuscript.ini) DO (
IF NOT DEFINED $NEW SET "$NEW=1"&&ECHO.MenuScript Settings>"menuscript.ini"
IF NOT "%%a"=="   " CALL ECHO.%%a=%%%%a%%>>"menuscript.ini"
)
IF EXIST "$MENU" DEL /Q /F "$MENU">NUL 2>&1
IF DEFINED $ARG CALL menuscript.cmd "%$ARG%"
GOTO:QUIT
:CMD_ITEM
%$CMD%
EXIT /B
:QUIT
CD /D "%ORIG_CD%"
EXIT /B