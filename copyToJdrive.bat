@echo off
set /p str=�R�s�[����t�@�C�������Ă�������

call:GET_FILE_INFO %str%

:GET_FILE_INFO
rem �i�[�t�H���_�̃t���p�X(D:\samplefolder)
echo %~d1%~p1  
rem �t�@�C����(samplefile.txt)
echo %~n1%~x1  
rem  �g���q(.txt)
echo �g���q:%~x1 
IF %~x1==.xlsx (
 goto XLSX
) ELSE (
 goto OTHER
)

:XLSX
::�g���q��xlsx�̏ꍇ
::J�h���C�u�̃p�X���擾����
set jdrivePath="C:\Users\1sn362w\Desktop\�V �����t�H���_�["
copy "%str%" %jdrivePath% 
echo ����
pause
exit

:OTHER
echo Excel�ł͂Ȃ�
pause
exit

