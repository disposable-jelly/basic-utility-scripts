@ECHO OFF

:: Script to disable the services of tuneup tools and some Windows services
:: v1.4  //  12/12/25

:: double colons are comments, single colons are section names

title Disable Tuneup Services

ECHO Script to disable tuneup tools and unnecessary Windows services
ECHO     -------------------------------------------------------
ECHO.

:: here the list of services are defined as variables

setlocal enabledelayedexpansion
set svc[0]=SysMain
set svc[1]=DiagTrack
set svc[2]=CCleanerPerformanceOptimizerService
set svc[3]=GUBootService
set svc[4]=GUMemfilesService
set svc[5]=GUPMService
set svc[6]=MacriumService

:: this section counts the number of services for future use in for loops

set /a index=0
:countLoop
if defined svc[%index%] (
	set /a index+=1
	goto :countLoop
	)

:: we need to subtract one from the count so that count number matches the Nth number in the list since it starts at zero
set /a index=%index%-1

:: this loop checks if the service exists on the computer
:: it steps through the list of services starting at 0, incrementing by 1, and ending after the index number
:: "find" looks at the output of the sc query, returns 1 if the service exists-
:: (it finds output that would be there if the service is there), and 0 if not
:: the services to check are now in new variables made here

:svcExistLoop
for /l %%s in (0,1,%index%) do (

	for /f %%e in ('sc query !svc[%%s]! ^| find /c ^"TYPE^"') do set svcExists=%%e
	if !svcExists! == 1 (
		set svcEX[%%s]=!svc[%%s]!
	) else (
		set svcEX[%%s]=skipMe
	)

)


:: checks if the script is running as admin, if not it ends early
net session >nul 2>&1
if %errorLevel% == 0 (
	goto :disableServices
) else (
	ECHO Error: Please run script as Administrator
	ECHO.
	goto :end
)


:: this is where the services are disabled
:: steps through the same numbers of the new variables

:disableServices

for /l %%s in (0,1,%index%) do (

	if !svcEX[%%s]! == skipMe (
		ECHO !svc[%%s]!
		ECHO   Service not found, skipping.
		ECHO.
	) else (

	for /f "tokens=4" %%a in ('sc qc !svcEX[%%s]! ^| findstr START_TYPE') do set svcStart1=%%a
	for /f "tokens=4" %%b in ('sc query !svcEX[%%s]! ^| findstr STATE') do set svcState1=%%b

	sc config !svcEX[%%s]! start= disabled >nul 2>&1
	sc stop !svcEX[%%s]! >nul 2>&1
	timeout 1 >nul

	for /f "tokens=4" %%c in ('sc qc !svcEX[%%s]! ^| findstr START_TYPE') do set svcStart2=%%c
	for /f "tokens=4" %%d in ('sc query !svcEX[%%s]! ^| findstr STATE') do set svcState2=%%d

	ECHO !svcEX[%%s]!
	ECHO   was set to start !svcStart1! and was !svcState1!, is now !svcStart2! and !svcState2!.
	ECHO.

)
)


:: these are prompts after the services are disabled to open msconfig and services.msc

:choiceMSCONFIG
choice /c YN /m "Would you like to open msconfig?"

if %errorLevel% == 1 (
	msconfig
) else (
	ECHO.
	goto :choiceSERVICES
)
ECHO.

:choiceSERVICES
choice /c YN /m "Would you like to open services?"

if %errorLevel% == 1 (
	services.msc
) else (
	goto :end
)

:end
ECHO.
endlocal
cmd /k
