@echo off
set /p str=コピーするファイルを入れてください

call:GET_FILE_INFO %str%

:GET_FILE_INFO
rem 格納フォルダのフルパス(D:\samplefolder)
echo %~d1%~p1  
rem ファイル名(samplefile.txt)
echo %~n1%~x1  
rem  拡張子(.txt)
echo 拡張子:%~x1 
IF %~x1==.xlsx (
 goto XLSX
) ELSE (
 goto OTHER
)

:XLSX
::拡張子はxlsxの場合
::Jドライブのパスを取得する
set jdrivePath="C:\Users\1sn362w\Desktop\新 しいフォルダー"
copy "%str%" %jdrivePath% 
echo 完了
pause
exit

:OTHER
echo Excelではない
pause
exit

