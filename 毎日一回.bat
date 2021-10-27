@echo off
rem 本日の日付を取得する
set date=&%date:~,10%

rem フォルダが存在するかどうかの確認
if exist %date:/=% goto EE

rem フォルダを作成する
mkdir %date:/=% & cd %date:/=%

COPY "C:\Users\1sn362w\Desktop\lin_workspace\batch\#新規ファイル＆エビデンス作成.bat"
mkdir 古い故障 & cd 古い故障
COPY "C:\Users\1sn362w\Desktop\lin_workspace\batch\古い故障に対する.bat"
exit

:EE
echo 本日のフォルダはすでにありました
echo 終了する
pause
exit