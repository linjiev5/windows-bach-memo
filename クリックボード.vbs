'https://raat.isnet.jp.fujitsu.com/ui/index.php
'�N���b�N�{�[�h�ɕۑ������ŐV�̕�������擾����
Set oDOM = CreateObject("htmlfile") 'xmlfile�Amhtmlfile���g����
clipboardText = oDOM.parentWindow.clipboardData.getData("text")

'���s�폜����
newStr=replace(clipboardText ,vbcrlf,"")

Dim top '���s�̐���
'https://www.jb51.net/article/159913.htm
top = Left(newStr,4) & Mid(newStr,17,4) & Mid(newStr,33,4)
Dim bot '���̃p�b�^��
bot = Mid(newStr,13,1) & Mid(newStr,29,1) & Mid(newStr,45,1)
Dim password
password = top & bot

Dim cmd
cmd = "cmd /c ""echo " & password & "| clip"""
CreateObject("WScript.Shell").Run cmd, 0
'WScript.Echo password