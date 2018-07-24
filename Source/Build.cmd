@echo off
setlocal
echo Build
echo =======
echo.
echo Performs a build of one configuration then copies the output
echo to a solution local build directory, ready for release.
echo.

rem * Check syntax
if "%~1" == "" (
	echo Configuration name parameter is required.
	endlocal
	exit /b 1
)
set ConfigurationName=%~1

echo.
echo %ConfigurationName% Build...

echo.
echo Initializing Visual Studio environment...
call "%~dp0Dependencies\Variables.cmd"
if %errorlevel% neq 0 goto Error

echo.
echo Delete old files...
if exist "%~dp0Temp\Build\%ConfigurationName%" (
	rmdir "%~dp0Temp\Build\%ConfigurationName%" /s /q
	if %errorlevel% gtr 1 goto error
)

echo.
echo Compiling %ConfigurationName% build...
msbuild "%~dp0Code for PowerShell.sln" /p:Configuration=%ConfigurationName%
if %errorlevel% neq 0 goto error

echo.
echo Copying PowerShell modules...
robocopy "%~dp0Modules" "%~dp0Temp\Build\%ConfigurationName%\Modules" /s *.psm1 *.psd1
if %errorlevel% gtr 7 goto error

echo.
echo Copying documentation...
robocopy "%~dp0Documentation" "%~dp0Temp\Build\%ConfigurationName%\Documentation"
if %errorlevel% gtr 7 goto error

echo.
echo Copying version references...
md "%~dp0Temp\Build\%ConfigurationName%\Version"
if %errorlevel% neq 0 goto error
copy "%~dp0Version.txt" "%~dp0Temp\Build\%ConfigurationName%\Version\CodeForPowerShell.Version.txt"
if %errorlevel% neq 0 goto error

echo.
echo %ConfigurationName% build successful.
endlocal
exit /b 0

:Error
echo Error %errorlevel%!
echo.
echo Note: Visual Studio must be closed before running this script to prevent build errors from locked files and caches.
endlocal
exit /b 1
