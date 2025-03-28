REM ------------ VARS --------------
SET EXE_FILE = "D:\App\Arch\FreeFileSync\FreeFileSync.exe"
REM SET EXE_FILE = "C:\Program Files\FreeFileSync\FreeFileSync.exe"

REM --------------------------------

REM --------- UPDATES -------------
%EXE_FILE% "C:\Pr\app\bantu\bantu-sis\Src\Controle\atu db updates Exe BatchRun.ffs_batch"
%EXE_FILE% "C:\Pr\app\bantu\bantu-sis\Src\Controle\atu db updates Inst BatchRun.ffs_batch"

REM ---------- TAB VIEWS EXE ----------
%EXE_FILE% "C:\Pr\app\bantu\bantu-sis\Src\Controle\atu tabviews Exe.ffs_batch"
%EXE_FILE% "C:\Pr\app\bantu\bantu-sis\Src\Controle\atu tabviews Inst.ffs_batch"

REM ---------- VERSOES SIS EXE ----------
%EXE_FILE% "C:\Pr\app\bantu\bantu-sis\Src\Controle\atu sis updates Exe BatchRun.ffs_batch"
%EXE_FILE% "C:\Pr\app\bantu\bantu-sis\Src\Controle\atu sis updates Inst BatchRun.ffs_batch"

rem pause

rem copy "C:\Pr\app\bantu\bantu-sis\Src\Externos\DBUpdates\000\000" "C:\Pr\app\bantu\bantu-sis\Exe\Inst\Update\DBUpdates\000\000"
rem pause
