@echo off & setlocal EnableDelayedExpansion
:main
rem レジストリから見本xlsxファイルパスを取得する
for /f "tokens=2*" %%i in ('reg query "HKCR\.xlsx\Excel.Sheet.12\ShellNew" /v "FileName"') do set XLSX=%%j
rem 今の年月日を取得
set date=%date:~0,4%%date:~5,2%%date:~8,2%
rem iniファイルを読み込み
set INI_FILE_FULLPATH=set.ini
call GetIni.bat  :READ_INI_VAL  "set"   "NAME"  GET_NAME  %INI_FILE_FULLPATH%
call GetIni.bat  :READ_INI_VAL  "set"   "err1"  GET_ERR1  %INI_FILE_FULLPATH%
call GetIni.bat  :READ_INI_VAL  "set"   "err2"  GET_ERR2  %INI_FILE_FULLPATH%
call GetIni.bat  :READ_INI_VAL  "set"   "err3"  GET_ERR3  %INI_FILE_FULLPATH%
call GetIni.bat  :READ_INI_VAL  "set"   "ToJDrive"  GET_ToJDrive  %INI_FILE_FULLPATH%
call GetIni.bat  :READ_INI_VAL  "set"   "ToJDrive2"  GET_ToJDrive2  %INI_FILE_FULLPATH%
call GetIni.bat  :READ_INI_VAL  "set"   "FromLocal"  GET_FromLocal  %INI_FILE_FULLPATH%
call GetIni.bat  :READ_INI_VAL  "set"   "dakenOK"  GET_dakenOK  %INI_FILE_FULLPATH%
call GetIni.bat  :READ_INI_VAL  "set"   "dakenNG"  GET_dakenNG  %INI_FILE_FULLPATH%
call GetIni.bat  :READ_INI_VAL  "set"   "text1"  GET_text1  %INI_FILE_FULLPATH%
call GetIni.bat  :READ_INI_VAL  "set"   "text2"  GET_text2  %INI_FILE_FULLPATH%
call GetIni.bat  :READ_INI_VAL  "set"   "text3"  GET_text3  %INI_FILE_FULLPATH%

:SetMod
echo 1.通常モード
echo 2.古い故障モード
set /p Mod=打鍵モード:
if not "%Mod%"== "1" (
  if not "%Mod%"== "2" (
    goto SetMod
  )
)

rem 入力したエビデンス番号を設定
set /p p=エビデンス番号:

rem 打鍵開始時間を設定
set /p startT=打鍵開始時間（XX:XX）:

rem 動確エビデンスのフォルタを作成
mkdir %date%\#%p%_%date%_動確

rem 見本xlsxは動確エビデンスのフォルタにコピーする
COPY "%XLSX%" "%GET_FromLocal%%date%\#%p%_%date%_動確\ST1_#%p%_動作%GET_text3%_%date%.xlsx

rem 動確エビデンスのフォルタを開く
start %GET_FromLocal%%date%\#%p%_%date%_動確\
start %GET_FromLocal%%date%\#%p%_%date%_動確\ST1_#%p%_動作%GET_text3%_%date%.xlsx
rem 打鍵開始時間を設定
set /p overT=打鍵終了時間（XX:XX）:

:ONNG
set /P STR_OKNG1="打鍵結果は？（1はOK/2はNG）： "
if "%STR_OKNG1%" == "1" (
  cd %GET_FromLocal%%date%\
  set STR_OKNG=OK
  ren "#%p%_%date%_動確" "#%p%_%date%_動確OK"
  if exist #%p%_%date%_動確OK (
    goto riyuu
  ) else (
    echo エビデンスExcalを閉めてください。
    goto ONNG
  )  
)else if "%STR_OKNG1%" == "2" (
  cd %GET_FromLocal%%date%\
  set STR_OKNG=NG
  ren "#%p%_%date%_動確" "#%p%_%date%_動確NG"
  if exist #%p%_%date%_動確NG (
    goto ErrRiyuu
  ) else (
    echo エビデンスExcalを閉めてください。
    goto ONNG
  )  
) else (
  echo 半角1/2を選んで入力してください。
  goto ONNG
)

:riyuu
if "%Mod%" == "1" (
    set STR_Message="%GET_NAME%です。  #%p%  %startT%~%overT%%GET_dakenOK% Redmineとサーバー(%GET_ToJDrive%#%p%_%date%_動確%STR_OKNG%)%GET_text2%" 
	goto Upset
  )else if "%Mod%" == "2" (
    set STR_Message="%GET_NAME%です。  #%p%(古い障害)  %startT%~%overT%%GET_dakenOK% サーバー(%GET_ToJDrive2%#%p%_%GET_text3%_%date%_動確%STR_OKNG%)%GET_text2%" 
	goto Upset
  )

:ErrRiyuu
set /P STR_ErrRiyuu="NG理由："
echo %STR_ErrRiyuu%
if "%Mod%" == "1" (
    goto ErrType1mod
  )else if "%Mod%" == "2" (
    goto ErrType2mod
  )

:ErrType1mod
echo %GET_ERR1%
echo %GET_ERR2%
echo %GET_ERR3%
set /p STR_ERR="NG分類：(1~3)"
if "%STR_ERR%" == "1" (
  set STR_Message="%GET_NAME%です。 #%p%  %startT%~%overT%%GET_dakenNG%  NG理由：%STR_ErrRiyuu%  分類:%GET_ERR1%  Redmineとサーバー(%GET_ToJDrive%#%p%_%date%_動確%STR_OKNG%)%GET_text2%"
)else if "%STR_ERR%" == "2" (
  set STR_Message="%GET_NAME%です。 #%p%  %startT%~%overT%%GET_dakenNG%  NG理由：%STR_ErrRiyuu%  分類:%GET_ERR2%  Redmineとサーバー(%GET_ToJDrive%#%p%_%date%_動確%STR_OKNG%)%GET_text2%"
)else if "%STR_ERR%" == "3" (
  set STR_Message="%GET_NAME%です。 #%p%  %startT%~%overT%%GET_dakenNG%  NG理由：%STR_ErrRiyuu%  分類:%GET_ERR3%  Redmineとサーバー(%GET_ToJDrive%#%p%_%date%_動確%STR_OKNG%)%GET_text2%"
) else (
  echo 半角1/2/3を選んで入力してください。
  goto ErrType1mod
)
goto Upset

:ErrType2mod
echo %GET_ERR1%
echo %GET_ERR2%
echo %GET_ERR3%
set /p STR_ERR="NG分類：(1~3)"
if "%STR_ERR%" == "1" (
  set STR_Message="%GET_NAME%です。 #%p%(古い障害)  %startT%~%overT%%GET_dakenNG%  NG理由：%STR_ErrRiyuu%  分類:%GET_ERR1%  サーバー(%GET_ToJDrive2%#%p%_%GET_text3%_%date%_動確%STR_OKNG%)%GET_text2%"
)else if "%STR_ERR%" == "2" (
  set STR_Message="%GET_NAME%です。 #%p%(古い障害)  %startT%~%overT%%GET_dakenNG%  NG理由：%STR_ErrRiyuu%  分類:%GET_ERR2%  サーバー(%GET_ToJDrive2%#%p%_%GET_text3%_%date%_動確%STR_OKNG%)%GET_text2%"
)else if "%STR_ERR%" == "3" (
  set STR_Message="%GET_NAME%です。 #%p%(古い障害)  %startT%~%overT%%GET_dakenNG%  NG理由：%STR_ErrRiyuu%  分類:%GET_ERR3%  サーバー(%GET_ToJDrive2%#%p%_%GET_text3%_%date%_動確%STR_OKNG%)%GET_text2%" 
) else (
  echo 半角1/2/3を選んで入力してください。
  goto ErrType2mod
)
goto Upset

:Upset
echo %STR_Message%
echo Enterキーを押して打鍵報告クリップボードに入力します。
set /p message=%STR_Message% | clip
set /P STR_INPUT="Jドライブにアップロードしますか？（y/n）： "
if "%STR_INPUT%" == "y" (
  goto JDriveUp
) else if "%STR_INPUT%" == "n" (
  goto End
) else (
  echo 半角y/nを選んで入力してください。
  goto Upset
)

:JDriveUp
if exist J:\SETUP.zip (
  if "%Mod%" == "1" (
    echo Jドライブに接続しています。
    xcopy /i "%GET_FromLocal%%date%\#%p%_%date%_動確%STR_OKNG%" "%GET_ToJDrive%#%p%_%date%_動確%STR_OKNG%"
  ) else if "%Mod%" == "2"  (
    echo Jドライブに接続しています。
    xcopy /i "%GET_FromLocal%%date%\#%p%_%date%_動確%STR_OKNG%" "%GET_ToJDrive2%#%p%_%GET_text3%_%date%_動確%STR_OKNG%"
  )
  pause
  goto End
) else (
  echo Jドライブに接続しません。
  timeout /t 1
  goto JDriveUp
)
:End
exit
