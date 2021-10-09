@echo off & setlocal EnableDelayedExpansion
:main
rem ���W�X�g�����猩�{xlsx�t�@�C���p�X���擾����
for /f "tokens=2*" %%i in ('reg query "HKCR\.xlsx\Excel.Sheet.12\ShellNew" /v "FileName"') do set XLSX=%%j
rem ���̔N�������擾
set date=%date:~0,4%%date:~5,2%%date:~8,2%
rem ini�t�@�C����ǂݍ���
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
echo 1.�ʏ탂�[�h
echo 2.�Â��̏Ⴢ�[�h
set /p Mod=�Ō����[�h:
if not "%Mod%"== "1" (
  if not "%Mod%"== "2" (
    goto SetMod
  )
)

rem ���͂����G�r�f���X�ԍ���ݒ�
set /p p=�G�r�f���X�ԍ�:

rem �Ō��J�n���Ԃ�ݒ�
set /p startT=�Ō��J�n���ԁiXX:XX�j:

rem ���m�G�r�f���X�̃t�H���^���쐬
mkdir %date%\#%p%_%date%_���m

rem ���{xlsx�͓��m�G�r�f���X�̃t�H���^�ɃR�s�[����
COPY "%XLSX%" "%GET_FromLocal%%date%\#%p%_%date%_���m\ST1_#%p%_����%GET_text3%_%date%.xlsx

rem ���m�G�r�f���X�̃t�H���^���J��
start %GET_FromLocal%%date%\#%p%_%date%_���m\
start %GET_FromLocal%%date%\#%p%_%date%_���m\ST1_#%p%_����%GET_text3%_%date%.xlsx
rem �Ō��J�n���Ԃ�ݒ�
set /p overT=�Ō��I�����ԁiXX:XX�j:

:ONNG
set /P STR_OKNG1="�Ō����ʂ́H�i1��OK/2��NG�j�F "
if "%STR_OKNG1%" == "1" (
  cd %GET_FromLocal%%date%\
  set STR_OKNG=OK
  ren "#%p%_%date%_���m" "#%p%_%date%_���mOK"
  if exist #%p%_%date%_���mOK (
    goto riyuu
  ) else (
    echo �G�r�f���XExcal��߂Ă��������B
    goto ONNG
  )  
)else if "%STR_OKNG1%" == "2" (
  cd %GET_FromLocal%%date%\
  set STR_OKNG=NG
  ren "#%p%_%date%_���m" "#%p%_%date%_���mNG"
  if exist #%p%_%date%_���mNG (
    goto ErrRiyuu
  ) else (
    echo �G�r�f���XExcal��߂Ă��������B
    goto ONNG
  )  
) else (
  echo ���p1/2��I��œ��͂��Ă��������B
  goto ONNG
)

:riyuu
if "%Mod%" == "1" (
    set STR_Message="%GET_NAME%�ł��B  #%p%  %startT%~%overT%%GET_dakenOK% Redmine�ƃT�[�o�[(%GET_ToJDrive%#%p%_%date%_���m%STR_OKNG%)%GET_text2%" 
	goto Upset
  )else if "%Mod%" == "2" (
    set STR_Message="%GET_NAME%�ł��B  #%p%(�Â���Q)  %startT%~%overT%%GET_dakenOK% �T�[�o�[(%GET_ToJDrive2%#%p%_%GET_text3%_%date%_���m%STR_OKNG%)%GET_text2%" 
	goto Upset
  )

:ErrRiyuu
set /P STR_ErrRiyuu="NG���R�F"
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
set /p STR_ERR="NG���ށF(1~3)"
if "%STR_ERR%" == "1" (
  set STR_Message="%GET_NAME%�ł��B #%p%  %startT%~%overT%%GET_dakenNG%  NG���R�F%STR_ErrRiyuu%  ����:%GET_ERR1%  Redmine�ƃT�[�o�[(%GET_ToJDrive%#%p%_%date%_���m%STR_OKNG%)%GET_text2%"
)else if "%STR_ERR%" == "2" (
  set STR_Message="%GET_NAME%�ł��B #%p%  %startT%~%overT%%GET_dakenNG%  NG���R�F%STR_ErrRiyuu%  ����:%GET_ERR2%  Redmine�ƃT�[�o�[(%GET_ToJDrive%#%p%_%date%_���m%STR_OKNG%)%GET_text2%"
)else if "%STR_ERR%" == "3" (
  set STR_Message="%GET_NAME%�ł��B #%p%  %startT%~%overT%%GET_dakenNG%  NG���R�F%STR_ErrRiyuu%  ����:%GET_ERR3%  Redmine�ƃT�[�o�[(%GET_ToJDrive%#%p%_%date%_���m%STR_OKNG%)%GET_text2%"
) else (
  echo ���p1/2/3��I��œ��͂��Ă��������B
  goto ErrType1mod
)
goto Upset

:ErrType2mod
echo %GET_ERR1%
echo %GET_ERR2%
echo %GET_ERR3%
set /p STR_ERR="NG���ށF(1~3)"
if "%STR_ERR%" == "1" (
  set STR_Message="%GET_NAME%�ł��B #%p%(�Â���Q)  %startT%~%overT%%GET_dakenNG%  NG���R�F%STR_ErrRiyuu%  ����:%GET_ERR1%  �T�[�o�[(%GET_ToJDrive2%#%p%_%GET_text3%_%date%_���m%STR_OKNG%)%GET_text2%"
)else if "%STR_ERR%" == "2" (
  set STR_Message="%GET_NAME%�ł��B #%p%(�Â���Q)  %startT%~%overT%%GET_dakenNG%  NG���R�F%STR_ErrRiyuu%  ����:%GET_ERR2%  �T�[�o�[(%GET_ToJDrive2%#%p%_%GET_text3%_%date%_���m%STR_OKNG%)%GET_text2%"
)else if "%STR_ERR%" == "3" (
  set STR_Message="%GET_NAME%�ł��B #%p%(�Â���Q)  %startT%~%overT%%GET_dakenNG%  NG���R�F%STR_ErrRiyuu%  ����:%GET_ERR3%  �T�[�o�[(%GET_ToJDrive2%#%p%_%GET_text3%_%date%_���m%STR_OKNG%)%GET_text2%" 
) else (
  echo ���p1/2/3��I��œ��͂��Ă��������B
  goto ErrType2mod
)
goto Upset

:Upset
echo %STR_Message%
echo Enter�L�[�������đŌ��񍐃N���b�v�{�[�h�ɓ��͂��܂��B
set /p message=%STR_Message% | clip
set /P STR_INPUT="J�h���C�u�ɃA�b�v���[�h���܂����H�iy/n�j�F "
if "%STR_INPUT%" == "y" (
  goto JDriveUp
) else if "%STR_INPUT%" == "n" (
  goto End
) else (
  echo ���py/n��I��œ��͂��Ă��������B
  goto Upset
)

:JDriveUp
if exist J:\SETUP.zip (
  if "%Mod%" == "1" (
    echo J�h���C�u�ɐڑ����Ă��܂��B
    xcopy /i "%GET_FromLocal%%date%\#%p%_%date%_���m%STR_OKNG%" "%GET_ToJDrive%#%p%_%date%_���m%STR_OKNG%"
  ) else if "%Mod%" == "2"  (
    echo J�h���C�u�ɐڑ����Ă��܂��B
    xcopy /i "%GET_FromLocal%%date%\#%p%_%date%_���m%STR_OKNG%" "%GET_ToJDrive2%#%p%_%GET_text3%_%date%_���m%STR_OKNG%"
  )
  pause
  goto End
) else (
  echo J�h���C�u�ɐڑ����܂���B
  timeout /t 1
  goto JDriveUp
)
:End
exit
