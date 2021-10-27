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