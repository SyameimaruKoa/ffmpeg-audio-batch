@echo off
if "%comparison%"=="yes" goto roop

chcp 932
echo �������w�肵�Ă��������B
echo V2�͖�192kbps
echo V4�͖�160kbps
echo V5�͖�128kbps ���W��
echo V6�͖�112kbps �i�񐄏��j
choice /c 2456
if %errorlevel%==1 set quality=2
if %errorlevel%==2 set quality=4
if %errorlevel%==3 set quality=5
if %errorlevel%==4 set quality=6

choice /m ����r�b�g���[�g���w�肵�܂����H
if %errorlevel%==2 goto maxbitskip
echo ���͕��@�u -B (������)�v
set maxbit=
set /P maxbit=
:maxbitskip

if "%~x1"=="" goto folder



:roop
cd /d "%~dp1"
cls
set /a filecount=filecount+1
echo %filecount%�ڂ̃t�@�C�������������
If not exist lame  mkdir lame
if "%~x1"==".wav" goto mp3
if "%~x1"==".mp3" goto mp3


:wav
ffmpeg -hide_banner -i "%~1" -vn -ac 2 -acodec pcm_s16le -f wav "lame\%~n1 ffmpeg.wav"
lame "lame\%~n1 ffmpeg.wav" -V%quality%%maxbit% "lame\%~n1.mp3"
del "lame\%~n1 ffmpeg.wav"

rem ��r�o�b�`�p
if "%comparison%"=="yes" exit /b

shift
if not "%~1"=="" goto roop
pause
exit

:mp3
lame %1 -V%quality%%maxbit% "lame\%~n1.mp3"

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
cd /d %1
If not exist lame  mkdir lame
for /r %%i in (*.wav) do lame "%%i" -V%quality%%maxbit% "lame\%%~ni.mp3"
timeout /nobreak 10
@REM ����͐̎g���Ă����C���ɒʒm��΂��p �F @REM ����͐̎g���Ă����C���ɒʒm��΂��p �F call C:\Users\kouki\OneDrive\CUIApplication\notify.bat mp3_end
pause
exit