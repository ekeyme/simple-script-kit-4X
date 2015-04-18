@echo off
echo ------------------------------------------------------------------------------
echo :00 for shutdown NOW; :c for Cancel shutdown plan; :Number for min to shutdown
echo ------------------------------------------------------------------------------

:start
set/p input= >nul
set shutdown=C:\Windows\System32\shutdown.exe

if %input% == 00 %shutdown% -s -t 0 & goto end
if %input% == c %shutdown% -a & goto end

set/a time=60*%input%
if %time% GTR 0 (%shutdown% -s -t %time%) else echo Error: The time must be int value and bigger than 0. Input again: & goto start

:end
Pause
Exit