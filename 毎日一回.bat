@echo off
rem �{���̓��t���擾����
set date=&%date:~,10%

rem �t�H���_�����݂��邩�ǂ����̊m�F
if exist %date:/=% goto EE

rem �t�H���_���쐬����
mkdir %date:/=% & cd %date:/=%

COPY "C:\Users\1sn362w\Desktop\lin_workspace\batch\#�V�K�t�@�C�����G�r�f���X�쐬.bat"
mkdir �Â��̏� & cd �Â��̏�
COPY "C:\Users\1sn362w\Desktop\lin_workspace\batch\�Â��̏�ɑ΂���.bat"
exit

:EE
echo �{���̃t�H���_�͂��łɂ���܂���
echo �I������
pause
exit