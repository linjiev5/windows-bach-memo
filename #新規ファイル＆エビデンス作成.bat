@echo off
title ��Q�ԍ�����͂��A�G���^�[���Ă�������
set /p p=��Q�ԍ�

:: �{���̎��Ԃ��擾����
set date=&%date:~,10%

:: �t�@�C������ݒ肷��
set fileName=ST1_#%p%_�m�F�G�r�f���X_%date:/=%.xlsx

:: �t�H���_���쐬�A����
mkdir "#%p%_%date:/=%_���m" & cd "#%p%_%date:/=%_���m"

:: �e���v���[�g���R�s�[�A�t�@�C�����Ɏw�肷��
copy "C:\Users\1sn362w\Desktop\lin_workspace\0�Ō�\default\�V�K Microsoft Excel ���[�N�V�[�g.xlsx" "%fileName%"

