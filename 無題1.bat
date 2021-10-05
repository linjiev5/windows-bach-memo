@echo off
Setlocal Enabledelayedexpansion
set /p str="_エビデンス_"
for /f "delims=" %%i in ('dir /b *.*') do (
set "var=%%i" & ren "%%i" "!var:%str%=!")