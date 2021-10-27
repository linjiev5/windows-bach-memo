# windows batch memo
 ### バッチファイルのメモ-個人用
まずは保存する際に文字のコードセットを選択しなければならない
日本語の場合は932 (shift-JIS)　--文字化けしないため

#### 拡張子を取得する
ファイルをコマンドウィンドウに投げてみてください
```batch
@echo off
set /p str=任意ファイル投入/入力してください
call:GET_FILE_INFO %str%
:GET_FILE_INFO
echo フルパス:%~d1%~p1
echo ファイル名:%~n1%~x1
echo 拡張子：%~x1
IF %~x1==.xlsx ( goto XLSX ) ELSE ( goto OTHER )
rem 拡張子は.xlsxの場合
:XLSX
echo Excelファイルです
pause
exit

:OTHER
echo Excelではない
pause
exit
```
#### 一括ファイルの名前を削除する
任意文字列をコマンドに入力するだけで、当フォルダ内該当する文字列が含むファイルを一括削除する
```batch
@echo off
Setlocal Enabledelayedexpansion
set /p str=一括削除する文字列を入力してください
for /f "delims=" %%i in ('dir /b *.*') do (
set "var=%%i" & ren "%%i" "!var:%str%=!")
echo %str%をを一括削除しました
pause
```
#### 本日の時間をクリックボードにコピーする
コマンドを実行し、CTRL+Vで本日の日付が貼り付けできる
```batch
echo %date% | clip
pause
```
#### すべてのファイルの名前を取得する
拡張子含む、リストをCSV出力する
```batch
@echo off
dir /b >list.csv
tree /f 
echo csvを作成しました
pause
```

#### Excelのデフォルトを取得する
新規のExcelファイルを作成する、名前指定など使用できる
デフォルトの設定が必要する際に、編集したExcelのテンプレートを作成、コピー元を指定などのアレンジをお勧めします。例えば図形を赤い枠に設定するなど
```batch
@echo off
title 名前指定、新規Excelファイル作成する
set /p p=名前入力してください
rem 本日の日付を取得する
set date=&%date:~,10%
rem ファイル名の後ろに日付を追加する
set fileName=%p%_%date:/=%.xlsx

rem フォルダを作成する、不要な場合は削除する
mkdir %date:/=% & cd %date:/=%

rem Excelテンプレート取得する
for /f "tokens=2*" %%i in ('reg query "HKEY_CLASSES_ROOT\.xlsx\Excel.Sheet.12\ShellNew" /v "FileName"') do set REG_RESULT=%%j

rem テンプレートをコピーし、名前指定する
COPY "%REG_RESULT%" %fileName%
```

#### VBSコード

クリックボードの文字列を変更し、一部をまたクリックボードに返却する

```vbscript
'https://raat.isnet.jp.fujitsu.com/ui/index.php
'クリックボードに保存した最新の文字列を取得する
Set oDOM = CreateObject("htmlfile") 'xmlfile、mhtmlfileも使える
clipboardText = oDOM.parentWindow.clipboardData.getData("text")

'改行削除する
newStr=replace(clipboardText ,vbcrlf,"")

Dim top '上一行の数字
'https://www.jb51.net/article/159913.htm
top = Left(newStr,4) & Mid(newStr,17,4) & Mid(newStr,33,4)
Dim bot '下のパッタン
bot = Mid(newStr,13,1) & Mid(newStr,29,1) & Mid(newStr,45,1)
Dim password
password = top & bot

Dim cmd
cmd = "cmd /c ""echo " & password & "| clip"""
CreateObject("WScript.Shell").Run cmd, 0
'WScript.Echo password
```

