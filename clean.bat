@echo off
del build_log.log /q 2>nul
del build_err.log /q 2>nul
del errors.tmp /q 2>nul
del errors.tmp /q 2>nul
rmdir /s /q build 2>nul
rmdir /s /q dist 2>nul
powershell  Remove-Item -Recurse -Force *.egg-info


