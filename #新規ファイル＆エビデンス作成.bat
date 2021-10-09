@echo off
title 障害番号を入力し、エンターしてください
set /p p=障害番号

:: 本日の時間を取得する
set date=&%date:~,10%

:: ファイル名を設定する
set fileName=ST1_#%p%_確認エビデンス_%date:/=%.xlsx

:: フォルダを作成、入る
mkdir "#%p%_%date:/=%_動確" & cd "#%p%_%date:/=%_動確"

:: テンプレートをコピー、ファイル名に指定する
copy "C:\Users\1sn362w\Desktop\lin_workspace\0打鍵\default\新規 Microsoft Excel ワークシート.xlsx" "%fileName%"

