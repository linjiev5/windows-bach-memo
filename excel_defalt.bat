@echo off
for /f "tokens=2*" %%i in ('reg query "HKEY_CLASSES_ROOT\.xlsx\Excel.Sheet.12\ShellNew" /v "FileName"') do set REG_RESULT=%%j
pause
@echo %REG_RESULT%
pause