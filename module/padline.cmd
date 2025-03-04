IF NOT DEFINED PROG_FOLDER EXIT /B
:PAD_LINE
IF NOT DEFINED PAD_TYPE SET "PAD_TYPE=1"
IF NOT DEFINED ACC_COLOR SET "ACC_COLOR=4"
IF NOT DEFINED BTN_COLOR SET "BTN_COLOR=2"
IF NOT DEFINED TXT_COLOR SET "TXT_COLOR=0"
IF NOT DEFINED PAD_SIZE SET "PAD_SIZE=LARGE"
IF NOT DEFINED PAD_SEQ SET "PAD_SEQ=6666622222"
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