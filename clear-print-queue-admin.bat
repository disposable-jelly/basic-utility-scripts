@ECHO OFF

net session >nul 2>&1
if %errorLevel% == 0 (
	goto :clearPrintQueue
) else (
	ECHO Error: Please run script as Administrator
	ECHO.
	goto :endFail
)

:clearPrintQueue

sc stop Spooler >nul 2>&1
echo Spooler stopped.
echo.
timeout 1 >nul

del /S /Q "C:\Windows\System32\spool\PRINTERS\*"
echo.
timeout 1 >nul

sc start Spooler >nul 2>&1
echo Spooler re-started.
echo.

:endFail
cmd /k