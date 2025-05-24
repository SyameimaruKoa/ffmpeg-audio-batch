@echo off
if "%comparison%"=="yes" goto roop

if not "%file%"=="" goto folderrun
chcp 932
choice /c 480 /m "44.1kHz��48kHz����������H"
if %errorlevel%==1 set ar=--rate 44100 
if %errorlevel%==2 set ar=--rate 48000 

echo aac-hc���g���ꍇ��1
echo aac-he���g���ꍇ��2
echo alac  ���g���ꍇ��3
choice /c 123
if %errorlevel%==1 set encoder=
if %errorlevel%==2 set encoder= --he
if %errorlevel%==3 set encoder= -A

choice /m "�����w�肵�܂����H"
set V=
if %errorlevel%==2 goto run
echo ��������͂��Ă��������B�Ō�ɃX�y�[�X�����Ă�������
echo TVBR	-V	�i���w��̐�
echo CVBR	-v	�ڕW�̃r�b�g���[�g
echo ABR	-a	�ڕW�̃r�b�g���[�g
echo CBR	-c	�ڕW�̃r�b�g���[�g
echo.
echo TVBR�̎g�p�\�i��(������������قǈ��k����)
echo 0 9 18 27 36 45 54 63 73 82 91 100 109 118 127
set /P V=

:run
if "%~x1"=="" goto folder

:roop
cd /d "%~dp1"
cls
set /a filecount=filecount+1
echo %filecount%�ڂ̃t�@�C�������������
If not exist qaac  mkdir qaac
if "%~x1"==".wav" goto aac
if "%~x1"==".m4a" goto aac
if "%~x1"==".mp4" goto aac

:wav
ffmpeg -hide_banner -i "%~1" -vn -c:a alac "qaac\%~n1 ffmpeg.m4a"
qaac64%encoder% "qaac\%~n1 ffmpeg.m4a" %ar%%V%-o "qaac\%~n1 qaac.m4a"
del "qaac\%~n1 ffmpeg.m4a"

rem ��r�o�b�`�p
if "%comparison%"=="yes" exit /b

shift
if not "%~1"=="" goto roop
pause
exit

:aac
qaac64%encoder% "%~1" %ar%%V%-o "qaac\%~n1.m4a"

rem ��r�o�b�`�p
if "%comparison%"=="yes" exit /b

if "%~nx1"=="bass.wav" del "%~nx1"
if "%~nx1"=="drums.wav" del "%~nx1"
if "%~nx1"=="instrumental.wav" del "%~nx1"
if "%~nx1"=="other.wav" del "%~nx1"
if "%~nx1"=="vocals.wav" del "%~nx1"
shift
if not "%~1"=="" goto roop
pause
exit

:folder
choice /c aw /m "�ϊ����̃t�@�C���́Am4a(a) or wav(w)�H"
if %errorlevel%==1 set file=m4a
if %errorlevel%==2 set file=wav
choice /m "�e�t�H���_�Ƀt�H���_�����܂����H"
if %errorlevel%==1 set foldermake=yes

:folderrun
cd /d %1
if "%foldermake%"=="yes" (
cd ..\
If not exist "%~n1 qaac"  mkdir "%~n1 qaac"
set path=%~1 qaac
cd %1
) else (
If not exist qaac  mkdir qaac
set path=qaac
)
for /r %%i in (*.%file%) do qaac64%encoder% "%%i" %V%-o "%path%\%%~ni.m4a"
timeout /nobreak 10
@REM ����͐̎g���Ă����C���ɒʒm��΂��p �F @REM ����͐̎g���Ă����C���ɒʒm��΂��p �F call C:\Users\kouki\OneDrive\CUIApplication\notify.bat m4a_end
pause
exit