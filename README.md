# windows batch memo
 ### バッチファイルのメモ-個人用

まずは保存する際に文字のコードセットを選択しなければならない

日本語の場合は932 (shift-JIS)　--文字化けしないため



#### 拡張子を取得する

ファイルをコマンドウィンドウに投げてみてください

```batch
@echo off
set /p str=任意ファイル投入してください
call:GET_FILE_INFO %str%
:GET_FILE_INFO
rem 格納フォルダのフルパス
echo フルパス:%~d1%~p1
rem ファイル名
echo ファイル名:%~n1%~x1
rem 拡張子
echo 拡張子：%~x1
IF %~x1==.xlsx (
 goto XLSX
) ELSE (
 goto OTHER
)
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
set /p str=入力してください
for /f "delims=" %%i in ('dir /b *.*') do (
set "var=%%i" & ren "%%i" "!var:%str%=!")
```

