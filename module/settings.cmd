FOR %%a in (PROG_FOLDER) DO (IF NOT DEFINED %%a EXIT /B)
::#########################################################################
:SETTINGS_MENU
::#########################################################################
::CLS
CALL "%MODULE_FOLDER%\PADLINE.CMD"&&SET "$BOX=RT"&&CALL "%MODULE_FOLDER%\BOXDISP.CMD"&&ECHO.                        Settings Configuration&&ECHO.
ECHO. (%##%1%$$%) Pad Type           %@@%PAD %PAD_TYPE%%$$%
ECHO. (%##%2%$$%) Pad Size           %@@%%PAD_SIZE%%$$%
ECHO. (%##%3%$$%) Pad Sequence       %@@%%PAD_SEQ%%$$%
CALL ECHO. (%##%4%$$%) Text Color         %@@%COLOR %%XLR%TXT_COLOR%%%%TXT_COLOR%%$$%
CALL ECHO. (%##%5%$$%) Accent Color       %@@%COLOR %%XLR%ACC_COLOR%%%%ACC_COLOR%%$$%
CALL ECHO. (%##%6%$$%) Button Color       %@@%COLOR %%XLR%BTN_COLOR%%%%BTN_COLOR%%$$%
ECHO. (%##%7%$$%) Fade Out           %@@%%FADE_OUT%%$$%
ECHO. (%##%8%$$%) Pad Box            %@@%%PAD_BOX%%$$%
ECHO.&&ECHO.                         Color ( %##%-%$$% / %##%+%$$% ) Shift
SET "$BOX=RB"&&CALL "%MODULE_FOLDER%\BOXDISP.CMD"&&CALL "%MODULE_FOLDER%\PADLINE.CMD"
ECHO.               Press (%##%Enter%$$%) to return to previous menu&&CALL "%MODULE_FOLDER%\MENUSELECT.CMD"
IF NOT DEFINED SELECT EXIT /B
IF "%SELECT%"=="+" CALL:COLOR_SHIFT_TXT&SET "SELECT="
IF "%SELECT%"=="-" CALL:COLOR_SHIFT_PAD&SET "SELECT="
IF "%SELECT%"=="1" CALL:PAD_TYPE&SET "SELECT="
IF "%SELECT%"=="2" IF "%PAD_SIZE%"=="LARGE" SET "PAD_SIZE=SMALL"&SET "SELECT="
IF "%SELECT%"=="2" IF "%PAD_SIZE%"=="SMALL" SET "PAD_SIZE=LARGE"&SET "SELECT="
IF "%SELECT%"=="3" CALL "%MODULE_FOLDER%\PADLINE.CMD"&&SET "$BOX=RT"&&CALL "%MODULE_FOLDER%\BOXDISP.CMD"&&ECHO.&&ECHO.                  Enter 10 digit color sequence seed&&ECHO.&&ECHO.                   [ %XLR0%0%XLR1%1%XLR2%2%XLR3%3%XLR4%4%XLR5%5%XLR6%6%XLR7%7%XLR8%8%XLR9%9%$$% ]    [ %XLR1%11%XLR2%22%XLR3%33%XLR4%44%XLR5%55%$$% ]&&ECHO.&&SET "$BOX=RB"&&CALL "%MODULE_FOLDER%\BOXDISP.CMD"&&CALL "%MODULE_FOLDER%\PADLINE.CMD"&&SET "$SELECT=COLOR_XXX"&&CALL "%MODULE_FOLDER%\MENUSELECT.CMD"
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
GOTO:SETTINGS_MENU
:FOLDER_MODE
IF "%FOLDER_MODE%"=="UNIFIED" SET "FOLDER_MODE=ISOLATED"&&GOTO:FOLDER_ISOLATED
IF "%FOLDER_MODE%"=="ISOLATED" SET "FOLDER_MODE=UNIFIED"&&GOTO:FOLDER_UNIFIED
:FOLDER_UNIFIED
FOR %%a in (MODULE MENU) DO (IF EXIST "%PROG_FOLDER%\%%a" MOVE /Y "%PROG_FOLDER%\%%a\*.*" "%PROG_FOLDER%">NUL 2>&1)
FOR %%a in (MODULE MENU) DO (IF EXIST "%PROG_FOLDER%\%%a" XCOPY /S /C /Y "%PROG_FOLDER%\%%a" "%PROG_FOLDER%">NUL 2>&1)
FOR %%a in (MODULE MENU) DO (IF EXIST "%PROG_FOLDER%\%%a" RD /Q /S "\\?\%PROG_FOLDER%\%%a">NUL 2>&1)
EXIT /B
:FOLDER_ISOLATED
FOR %%a in (module menu) DO (IF NOT EXIST "%PROG_FOLDER%\%%a" MD "%PROG_FOLDER%\%%a">NUL 2>&1)
FOR %%a in (MENU) DO (IF EXIST "%PROG_FOLDER%\*.%%a" MOVE /Y "%PROG_FOLDER%\*.%%a" "%PROG_FOLDER%\MENU">NUL 2>&1)
FOR /F "TOKENS=*" %%a in ('DIR /A: /B /O:GN "%PROG_FOLDER%\*.CMD"') DO (IF NOT "%%a"=="%ORIG_CMD%" MOVE /Y "%PROG_FOLDER%\%%a" "%PROG_FOLDER%\MODULE">NUL 2>&1)
EXIT /B
:PAD_TYPE
CHCP 65001>NUL
::CLS
CALL "%MODULE_FOLDER%\PADLINE.CMD"&&SET "$BOX=RT"&&CALL "%MODULE_FOLDER%\BOXDISP.CMD"&&ECHO.&&ECHO.                           Choose a pad type&&ECHO.&&ECHO.   (%##%0%$$%)None (%##%1%$$%)◌ (%##%2%$$%)○ (%##%3%$$%)● (%##%4%$$%)□ (%##%5%$$%)■ (%##%6%$$%)░ (%##%7%$$%)▒ (%##%8%$$%)▓ (%##%9%$$%)~ (%##%10%$$%)= (%##%11%$$%)&&ECHO.&&SET "$BOX=RB"&&CALL "%MODULE_FOLDER%\BOXDISP.CMD"&&CALL "%MODULE_FOLDER%\PADLINE.CMD"&&ECHO.               Press (%##%Enter%$$%) to return to previous menu&&SET "$SELECT=SELECTX"&&CALL "%MODULE_FOLDER%\MENUSELECT.CMD"
FOR %%a in (0 1 2 3 4 5 6 7 8 9 10 11) DO (IF "%SELECTX%"=="%%a" SET "PAD_TYPE=%SELECTX%")
EXIT /B
:COLOR_CHOICE
CALL "%MODULE_FOLDER%\PADLINE.CMD"&&SET "$BOX=RT"&&CALL "%MODULE_FOLDER%\BOXDISP.CMD"&&ECHO.&&ECHO.                            Choose a color&&ECHO.&&ECHO.                  [ %XLR0% 0 %XLR1% 1 %XLR2% 2 %XLR3% 3 %XLR4% 4 %XLR5% 5 %XLR6% 6 %XLR7% 7 %XLR8% 8 %XLR9% 9 %$$% ]&&ECHO.&&SET "$BOX=RB"&&CALL "%MODULE_FOLDER%\BOXDISP.CMD"&&CALL "%MODULE_FOLDER%\PADLINE.CMD"&&ECHO.               Press (%##%Enter%$$%) to return to previous menu&&SET "$SELECT=SELECTX"&&CALL "%MODULE_FOLDER%\MENUSELECT.CMD"
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