@ECHO OFF

net session >nul 2>&1
if %errorLevel% == 0 (
	goto :runPSscript
) else (
	ECHO Error: Please run script as Administrator
	ECHO.
	goto :endFail
)

:runPSscript
SET here=%~dp0
Powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%here%\win-preconfig-calling-card.ps1"
goto :endSuccess

:endFail
pause
:endSuccess
cmd /c
