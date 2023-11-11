@echo off
rem exit

cd "C:\Pr\app\bantu\bantu-sis\exe\Starter\"
del *.txt
cd "C:\Pr\app\bantu\bantu-sis\exe\bin\"
del *.xml
REM pause
     
copy C:\Pr\app\bantu\bantu-sis\Src\DBUpdates\000\000\*.* C:\Pr\app\bantu\bantu-sis\exe\Starter\Update\dbupdates\000\000

rem pause