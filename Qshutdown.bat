@echo off
echo ---------------------------------------------------
echo ":0 for shutdown NOW; :c for Cancel shutdown plan; :Number for min to shutdown"

set/p input= >nul
echo ---------------------------------------------------

set shutdown=C:\Windows\System32\shutdown.exe

if %input% == 0 %shutdown% -s -t 0 & goto end
if %input% == c %shutdown% -a & goto end

set/a time=60*%input%*
if %time% GTR 0 (%shutdown% -s -t %time%) else echo "Error: The time must be int value and bigger than 0."
goto end

:end
Pause
Exit