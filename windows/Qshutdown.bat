@echo off
echo ------------------------------------------------------------------------------
echo :00 for shutdown NOW; :c for Cancel shutdown plan; :Number for min to shutdown
echo ------------------------------------------------------------------------------

:: Here, customize your own parameters to quick shutdown PC.
:: When you change them, remenber to modify the output usage above to aviod missunderstanding.
:: Shutdown program, default: C:\Windows\System32\shutdown.exe
set shutdown=C:\Windows\System32\shutdown.exe
:: para to cancel shutdown plan
set cancel_para=c
:: para to shutdown PC now
set shutdown_now_para=00


:start
set/p input= >nul

if %input% == %shutdown_now_para% %shutdown% -s -t 0 & goto end
if %input% == %cancel_para% %shutdown% -a & goto end

set/a time=60*%input%
if %time% GTR 0 (%shutdown% -s -f -t %time%) else echo Error: The time must be int value and bigger than 0. Input again: & goto start

:end
Pause
Exit
