IF NOT DEFINED PROG_SOURCE EXIT /B
:DISK_LIST
IF DEFINED QUERY_MSG ECHO.%QUERY_MSG%
FOR /F "TOKENS=1 DELIMS=:" %%G in ("%SystemDrive%") DO (SET "SYS_VOLUME=%%G")
FOR /F "TOKENS=1 DELIMS=:" %%G in ("%PROG_SOURCE%") DO (SET "PROG_VOLUME=%%G")
(ECHO.LIST DISK&&ECHO.Exit)>"$DSK"&&FOR /F "TOKENS=1-5 SKIP=8 DELIMS= " %%a in ('DISKPART /s "$DSK"') DO (
IF "%%a"=="Disk" IF NOT "%%b"=="###" SET "DISKVND="&&(ECHO.select disk %%b&&ECHO.detail disk&&ECHO.list partition&&ECHO.Exit)>"$DSK"&&SET "LTRX=X"&&FOR /F "TOKENS=1-9 SKIP=6 DELIMS={}: " %%1 in ('DISKPART /s "$DSK"') DO (
IF "%%1 %%2"=="Disk %%b" ECHO.&&ECHO.   %@@%Disk%$$% ^(%##%%%b%$$%^)
IF NOT "%%1 %%2"=="Disk %%b" IF NOT DEFINED DISKVND SET "DISKVND=$"&&ECHO.   %%1 %%2 %%3 %%4 %%5
IF "%%1"=="Type" ECHO.    %@@%Type%$$% = %%2
IF "%%1 %%2"=="Disk ID" ECHO.    %@@%UID%$$%  = %%3
IF "%%1 %%3"=="Volume %SYS_VOLUME%" ECHO.  %XLR2%  System Volume%$$%
IF "%%1 %%3"=="Volume %PROG_VOLUME%" ECHO.  %XLR2%  Program Volume%$$%
IF "%%1 %%2 %%3"=="Pagefile Disk Yes" ECHO.  %XLR2%  Active Pagefile%$$%
IF "%%1"=="Partition" IF NOT "%%2"=="###" SET "PARTX=%%2"&&SET "SIZEX=%%4 %%5"&&(ECHO.select disk %%b&&ECHO.select partition %%2&&ECHO.detail partition&&ECHO.Exit)>"$DSK"&&SET "LTRX="&&FOR /F "TOKENS=1-9 SKIP=6 DELIMS=* " %%A in ('DISKPART /s "$DSK"') DO (IF "%%A"=="Volume" IF NOT "%%B"=="###" SET "LTRX=%%C"&&CALL:DISK_CHECK)
IF NOT DEFINED LTRX IF NOT "%%2"=="DiskPart..." ECHO.    %@@%Part %%2%$$% Vol * %%4 %%5))
IF DEFINED DISK_GET CALL:DISK_DETECT>NUL 2>&1
ECHO.
FOR %%a in ($GO LTRX PARTX SIZEX QUERY_MSG DISK_GET) DO (SET "%%a=")
DEL /Q /F "$DSK*">NUL 2>&1
EXIT /B
:DISK_CHECK
SET "$GO="&&FOR %%$ in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) DO (IF "%%$"=="%LTRX%" SET "$GO=1"&&ECHO.    %@@%Part %PARTX%%$$% Vol %@@%%LTRX%%$$% %SIZEX%)
IF NOT DEFINED $GO ECHO.    %@@%Part %PARTX%%$$% Vol * %SIZEX%
EXIT /B