@ECHO OFF

:: check if running as adminitrator
net session >nul 2>&1
if %errorLevel% == 0 (
	goto :Acrobat
) else (
	ECHO Error: Please run script as Administrator
	ECHO.
	goto :endFail
)

:Acrobat

:: check if Acrobat is running, and if so close it
:: error level 1 means it's not running, 0 means it is

tasklist | find /I "acrobat.exe">nul

if %errorlevel% == 1 (
	echo "Clearing cache..."
	goto :clearCache
) else (
	echo "Closing Acrobat..."
	taskkill /f /im acrobat.exe>nul
	timeout 1 >nul
	echo.
	echo "Acrobat closed, clearing cache..."
	timeout 1 >nul
	goto :clearCache
)

:clearCache

:: del only deletes files, not directories

del /S /Q "%HOMEPATH%\AppData\LocalLow\Adobe\AcroCef\DC\Acrobat\Cache\Cache\Cache_Data\*">nul
del /S /Q "%HOMEPATH%\AppData\LocalLow\Adobe\AcroCef\DC\Acrobat\Cache\Code Cache\js\*">nul
del /S /Q "%HOMEPATH%\AppData\LocalLow\Adobe\AcroCef\DC\Acrobat\Cache\Code Cache\js\index-dir\*">nul
timeout 1 >nul
echo.
echo "Acrobat cache cleared."
echo.

:endFail
cmd /k