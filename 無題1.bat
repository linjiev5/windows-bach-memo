@echo off
Setlocal Enabledelayedexpansion
set /p str="_�G�r�f���X_"
for /f "delims=" %%i in ('dir /b *.*') do (
set "var=%%i" & ren "%%i" "!var:%str%=!")