@echo off
if "%comparison%"=="yes" goto roop

chcp 932
if "%~x1"==".opus" goto decode
echo �r�b�g���[�g���w�肵�Ă��������B(�����̂�kbps�P��)
echo 8kbps(�Œ�)�A32kbps(��)�A64kbps(�W��)�A96kbps(���i���A����)�A160kbps(�ō��i��)
echo (���݂̂̏ꍇ�̓P�c�Ɂu--speech�v��t����Ƃ��������H)
set bitrate=
rem �I���X�L�b�v�p(skip���鎞��set /P���R�����g�A�E�g)
rem �{�C�X�h���}���k�p
@REM set bitrate=64
rem �{�C�h������܂蕷���Ȃ���p
@REM set bitrate=32 --speech
set /P bitrate=

if "%~x1"=="" goto folder
if not "%~2"=="" goto 2ormoreroop

:roop
cd /d "%~dp1"
cls
if "%~x1"==".wav" goto opus
if "%~x1"==".opus" goto opus
if "%~x1"==".flac" goto opus



:wav
ffmpeg -hide_banner -i "%~1" -vn "%~n1 ffmpeg.flac"
opusenc "%~n1 ffmpeg.flac" --bitrate %bitrate% "%~n1.opus"
if %errorlevel%==0 del %1
rem ���t�@�C�������������Ȃ��ꍇ�͏��if���R�����g�A�E�g
del "%~n1 ffmpeg.flac"

rem ��r�o�b�`�p
if "%comparison%"=="yes" exit /b

shift
if not "%~1"=="" goto roop
pause
exit

:opus
opusenc %1 --bitrate %bitrate% "%~n1.opus"
@REM if %errorlevel%==0 del %1
rem ���t�@�C�������������Ȃ��ꍇ�͏��if���R�����g�A�E�g
rem ��r�o�b�`�p
if "%comparison%"=="yes" exit /b


shift
if not "%~1"=="" goto roop
timeout /nobreak 3
exit

:2ormoreroop
cd /d "%~dp1"
cls
set /a filecount=filecount+1
echo %filecount%�ڂ̃t�@�C�������������
if "%~x1"==".wav" goto 2ormoreopus
if "%~x1"==".opus" goto 2ormoreopus
if "%~x1"==".flac" goto 2ormoreopus


:2ormorewav
If not exist opusenc  mkdir opusenc
ffmpeg -hide_banner -i "%~1" -vn "opusenc\%~n1 ffmpeg.flac"
opusenc "opusenc\%~n1 ffmpeg.flac" --bitrate %bitrate% "opusenc\%~n1.opus"
del "opusenc\%~n1 ffmpeg.flac"

rem ��r�o�b�`�p
if "%comparison%"=="yes" exit /b

shift
if not "%~1"=="" goto 2ormoreroop
pause
exit

:2ormoreopus
rem �t�H���_���쐬�������Ȃ��ꍇ�͉����R�����g�A�E�g
@REM If not exist opusenc  mkdir opusenc
rem �t�H���_���ɍ�肽���Ȃ��ꍇ�̓R�����g�A�E�g(����if�������Ȃ��Ȃ�ƕ|���̂ŃR�����g�A�E�g�����̂͏㑤��)
@REM opusenc %1 --bitrate %bitrate% "opusenc\%~n1.opus"
opusenc %1 --bitrate %bitrate% "%~n1.opus"
if %errorlevel%==0 del %1
rem ���t�@�C�������������Ȃ��ꍇ�͏��if���R�����g�A�E�g
rem ��r�o�b�`�p
if "%comparison%"=="yes" exit /b

if "%~nx1"=="bass.wav" del "%~nx1"
if "%~nx1"=="drums.wav" del "%~nx1"
if "%~nx1"=="instrumental.wav" del "%~nx1"
if "%~nx1"=="other.wav" del "%~nx1"
if "%~nx1"=="vocals.wav" del "%~nx1"
shift
if not "%~1"=="" goto 2ormoreroop
pause
exit

:folder
cd /d %1
If not exist opusenc  mkdir opusenc
for /r %%i in (*.wav) do opusenc "%%i" --bitrate %bitrate% "opusenc\%%~ni.opus"
timeout /nobreak 10
@REM ����͐̎g���Ă����C���ɒʒm��΂��p �F call C:\Users\kouki\OneDrive\CUIApplication\notify.bat opus_end
pause
exit

:decode
cd /d "%~dp1"
cls
set /a filecount=filecount+1
echo "%~1"���f�R�[�h���܂�
echo %filecount%�ڂ̃t�@�C�������������
If not exist opusdec  mkdir opusdec
opusdec %1 "opusdec\%~n1.wav"
shift
if not "%~1"=="" goto decode
pause
exit