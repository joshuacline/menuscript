FOR %%a in (PROG_SOURCE $BOX) DO (IF NOT DEFINED %%a EXIT /B)
GOTO:BOX_%$BOX%
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