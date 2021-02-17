@echo off
call :CleanEnv
call :UnitTest
call :BuildAll
call :PrintBuildFailed
call :PrintWarning
goto :exit

::==============================================Exit============================================================================
:Exit
pause
exit


::==============================================UnitTest======================================================================
:UnitTest
python -m pytest
if not %ERRORLEVEL% == 0 (
    echo Unit test failed
    call :CleanEnv
    goto :exit
) 
echo Unit test passed
GoTo :EOF


::==============================================BuildAll======================================================================
:BuildAll
call :PrintTitle Build all modules
for /r "setups" %%i in (*.py) do call :SingleBuild %%i
GoTo :EOF


::==============================================SingleBuild====================================================================
:SingleBuild
call :LogSubTitle    %~nx1    build_log.log

echo|set /p="build %~nx1    "
python %1 bdist_wheel >>build_log.log 2>>warning.tmp
call :GetFileSize    warning.tmp
if not %size% == 0 (
    call :LogSubTitle    %~nx1    build_err.log
    type warning.tmp >> build_err.log
)
del /q warning.tmp
if %ERRORLEVEL% == 0 (
    echo.	Pass
) else (
    
    echo.	Fail
    echo build %~nx1	Fail>>errors.tmp
)
GoTo :EOF


::==============================================PrintTitle======================================================================
:PrintTitle
For /F %%A In ('powershell -NoP "Write-Host('=' * (($(Get-Host).UI.RawUI.WindowSize.Width - 3 - $('%*').length)/2))"') Do Set "separator=%%A"
Echo %separator% %* %separator%
GoTo :EOF


::==============================================LogSubTitle======================================================================
:LogSubTitle
For /F %%A In ('powershell -NoP "Write-Host('-' * (($(Get-Host).UI.RawUI.WindowSize.Width - 3 - $('%1').length)/2))"') Do Set "separator=%%A"
Echo %separator% %1 %separator%>>%2
GoTo :EOF

::==============================================PrintBuildFailed======================================================================
:PrintBuildFailed
if exist errors.tmp  (
    call :PrintTitle Build Failed
    type errors.tmp
    del errors.tmp /q
)
GoTo :EOF


::==============================================PrintWarning====================================================================
:PrintWarning
if exist build_err.log (
    call :PrintTitle WARNING
    type build_err.log
)
GoTo :EOF


::==============================================CleanEnv====================================================================
:CleanEnv
del build_log.log /q 2>nul
del build_err.log /q 2>nul
del errors.tmp /q 2>nul
del errors.tmp /q 2>nul
rmdir /s /q build 2>nul
rmdir /s /q dist 2>nul
powershell  Remove-Item -Recurse -Force *.egg-info
set "errors= "
GoTo :EOF


::==============================================GetFileSize====================================================================
:GetFileSize
set "size=%~z1"
GoTo :EOF