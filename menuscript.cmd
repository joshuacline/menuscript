::MenuScript v 006 (c) Joshua Cline - github.com/joshuacline
@ECHO OFF&&SETLOCAL ENABLEDELAYEDEXPANSION&&CHCP 65001>NUL
SET "ERR_MSG="&&SET "ORIG_CD=%CD%"&&SET "$CMD=%0"&&SET "$MENU=%*"
CD /D "%~DP0"&&SET "$CMD=%$CMD:"=%"&&SET "$MENU=%$MENU:"=%"
FOR %%G in ("%$CMD%") DO (SET "ORIG_PATH=%%~dG%%~pG"&&SET "ORIG_CMD=%%~nG")
FOR %%G in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) DO (CALL SET "PROG_FOLDER=%%CD:%%G=%%G%%")
FOR /F "TOKENS=1-2 DELIMS=:" %%a in ("%PROG_FOLDER%") DO (IF "%%b"=="\" SET "PROG_FOLDER=%%a:")
FOR /F "DELIMS=" %%a in ('CMD.EXE /D /U /C ECHO.%ORIG_CMD%^| FIND /V ""') do (IF "%%a"==" " SET "ERR_MSG=Remove the space from %ORIG_CMD%.cmd, then launch again.")
IF NOT EXIST "%PROG_FOLDER%" SET "ERR_MSG=Invalid path or folder name. Relocate, then launch again."
IF "%PROG_FOLDER%"=="%SYSTEMDRIVE%\WINDOWS\SYSTEM32" SET "ERR_MSG=Invalid path or folder name. Relocate, then launch again."
FOR /F "TOKENS=1-9 DELIMS=\" %%a in ("%PROG_FOLDER%") DO (
IF "%%a\%%b\%%c"=="%SystemDrive%\WINDOWS\TEMP" SET "ERR_MSG=Extract zip into a new folder, then launch again."
IF "%%a\%%b\%%d\%%e\%%f"=="%SystemDrive%\USERS\APPDATA\LOCAL\TEMP" SET "ERR_MSG=Extract zip into a new folder, then launch again.")
Reg.exe query "HKU\S-1-5-19\Environment">NUL
IF NOT "%ERRORLEVEL%" EQU "0" SET "ERR_MSG=Right click and run as administrator."
IF NOT DEFINED $MENU SET "ERR_MSG=Type menuscript.cmd "Name-Of-Menu.menu"."
IF DEFINED ERR_MSG ECHO.ERROR: %ERR_MSG%&&PAUSE&&GOTO:QUIT
SET /P $VER=<"%$CMD%"
FOR /F "TOKENS=1-9 DELIMS= " %%a in ("%$VER%") DO (SET "$VER=%%c")
TITLE MenuScript v%$VER%  -  %ORIG_CMD%.cmd
IF EXIST "%PROG_FOLDER%\MENU" (SET "MENU_FOLDER=%PROG_FOLDER%\MENU") ELSE (SET "MENU_FOLDER=%PROG_FOLDER%")
IF EXIST "%PROG_FOLDER%\MODULE" (SET "MODULE_FOLDER=%PROG_FOLDER%\MODULE") ELSE (SET "MODULE_FOLDER=%PROG_FOLDER%")
IF NOT EXIST "%MENU_FOLDER%\%$MENU%" ECHO.&&ECHO. "%MENU_FOLDER%\%$MENU%" does not exist.&&GOTO:QUIT
SET /P $HEAD=<"%MENU_FOLDER%\%$MENU%"
IF NOT "%$HEAD%"=="MENU-SCRIPT" ECHO.&&ECHO. %XLR2%ERROR:%$$% Bad file header, check file.&&ECHO.&&GOTO:QUIT
SET /A "$SESSION+=1"&&FOR %%a in ($LOOP $HALT) DO (SET "%%a=")
IF EXIST "%ORIG_CMD%.ini" FOR /F "eol=- TOKENS=1-2 SKIP=1 DELIMS==" %%a in (%ORIG_CMD%.ini) DO (IF NOT "%%a"=="   " SET "%%a=%%b")
IF EXIST "%MODULE_FOLDER%\initglobal.cmd" CALL "%MODULE_FOLDER%\initglobal.cmd"
SET "$CMD_LAST%$SESSION%=%ORIG_PATH%%ORIG_CMD%"&&SET "$MENU_LAST%$SESSION%=%$MENU%"&&COPY /Y "%MENU_FOLDER%\%$MENU%" "$MENU">NUL
FOR /F "TOKENS=* SKIP=1 DELIMS=" %%a in ($MENU) DO (IF EXIST "$MENU" DEL /Q /F "$MENU">NUL 2>&1
CALL SET "$EXEC=%%a"&&CALL:MENU_PARSE)
SET /A "$SESSION-=1"&&CD /D "%PROG_FOLDER%"&&IF EXIST "%ORIG_CMD%.ini" SET "$NEW="&&FOR /F "eol=- TOKENS=1-2 SKIP=1 DELIMS==" %%a in (%ORIG_CMD%.ini) DO (IF NOT DEFINED $NEW SET "$NEW=1"&&ECHO.%ORIG_CMD% Settings>"%ORIG_CMD%.ini"
IF NOT "%%a"=="   " CALL ECHO.%%a=%%%%a%%>>"%ORIG_CMD%.ini"
)
IF DEFINED $LOOP SET /A "$SESSION+=1"
CALL SET "$CMD=%%$CMD_LAST%$SESSION%%%"&&SET "$CMD_LAST%$SESSION%="
CALL SET "$MENU=%%$MENU_LAST%$SESSION%%%"&&SET "$MENU_LAST%$SESSION%="
IF DEFINED $LOOP SET /A "$SESSION-=1"
IF DEFINED $CMD IF DEFINED $MENU CALL "%$CMD%.cmd" "%$MENU%"
GOTO:QUIT
:MENU_PARSE
IF DEFINED $HALT EXIT /B
%$EXEC%
EXIT /B
:QUIT
CD /D "%ORIG_CD%"&TITLE %SYSTEMDRIVE%\Windows\system32\cmd.exe
EXIT /B