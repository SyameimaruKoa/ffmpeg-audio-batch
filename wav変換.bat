@echo off
chcp 932

rem �I���X�L�b�v�p(�ʏ펞��goto skip�܂ł��R�����g�A�E�g)
@REM set bit=-acodec pcm_s24le
@REM set ar= -ar 48000
@REM goto skip

echo "�ʎq���r�b�g�����w�肵�Ă�������"
choice /c 123 /m "[16bit=1 , 24bit=2 , 32bit=3]"
if %errorlevel%==1 set bit=-acodec pcm_s16le
if %errorlevel%==2 set bit=-acodec pcm_s24le
if %errorlevel%==1 set bit=-acodec pcm_s32le

choice /c 480n /m "44.1��48�����̂܂܂����R���͂�"
if %errorlevel%==1 set ar= -ar 44100
if %errorlevel%==2 set ar= -ar 48000
if %errorlevel%==4 set /P ar= -ar XXXXX�œ��͂��Ă���������

choice /c ns0 /m "���m�������X�e���I�����̂܂܂�"
if %errorlevel%==1 set ac= -ac 1
if %errorlevel%==2 set ac= -ac 2

:skip
if not "%~2"=="" goto 2ormore

:roop
cd /d "%~dp1"
cls
set /a filecount=filecount+1
echo %filecount%�ڂ̃t�@�C�������������
ffmpeg -hide_banner -i "%~1" -vn %ac%%ar% %bit% -f wav "%~dpn1 ffmpeg.wav"
shift
if not "%~1"=="" goto roop
exit

:2ormore
cd /d "%~dp1"
cls
set /a filecount=filecount+1
echo %filecount%�ڂ̃t�@�C�������������
If not exist ffmpeg  mkdir ffmpeg
ffmpeg -hide_banner -i "%~1" -vn %ac%%ar% %bit% -f wav "ffmpeg\%~n1.wav"
shift
if not "%~1"=="" goto 2ormore
pause
exit
