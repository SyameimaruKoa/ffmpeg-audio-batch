@echo off
chcp 932

echo aac-hc���g���ꍇ��1
echo aac-he���g���ꍇ��2
echo alac  ���g���ꍇ��3
choice /c 123
if %errorlevel%==1 set encoder=
if %errorlevel%==2 set encoder= --he
if %errorlevel%==3 set encoder= -A

choice /m "�����w�肵�܂����H"
set V=
if %errorlevel%==2 goto parallelrun
echo ��������͂��Ă��������B�Ō�ɃX�y�[�X�����Ă�������
echo TVBR	-V	�i���w��̐�
echo CVBR	-v	�ڕW�̃r�b�g���[�g
echo ABR	-a	�ڕW�̃r�b�g���[�g
echo CBR	-c	�ڕW�̃r�b�g���[�g
echo.
echo TVBR�̎g�p�\�i��
echo 0 9 18 27 36 45 54 63 73 82 91 100 109 118 127
set /P V=
:parallelrun
start call "..\AAC�ϊ� - �����p.bat" %1 %file%
if not "%~2"=="" start call "..\AAC�ϊ� - �����p.bat" %2 %file%
if not "%~3"=="" start call "..\AAC�ϊ� - �����p.bat" %3 %file%
if not "%~4"=="" start call "..\AAC�ϊ� - �����p.bat" %4 %file%
if not "%~5"=="" start call "..\AAC�ϊ� - �����p.bat" %5 %file%
exit /b