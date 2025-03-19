FOR %%a in (PROG_FOLDER $BOX) DO (IF NOT DEFINED %%a EXIT /B)
IF NOT DEFINED PAD_BOX SET "PAD_BOX=ENABLED"
IF "%PAD_BOX%"=="DISABLED" EXIT /B
CHCP 65001>NUL&GOTO:BOX_%$BOX%
:BOX_RT
ECHO.%##%╭────────────────────────────────────────────────────────────────────╮%$$%&EXIT /B
:BOX_RB
ECHO.%##%╰────────────────────────────────────────────────────────────────────╯%$$%&EXIT /B
:BOX_ST
ECHO.%##%┌────────────────────────────────────────────────────────────────────┐%$$%&EXIT /B
:BOX_SB
ECHO.%##%└────────────────────────────────────────────────────────────────────┘%$$%&EXIT /B