@echo off
if "%comparison%"=="yes" goto roop

chcp 932
echo 音質を指定してください。
echo V2は約192kbps
echo V4は約160kbps
echo V5は約128kbps ＜標準
echo V6は約112kbps （非推奨）
choice /c 2456
if %errorlevel%==1 set quality=2
if %errorlevel%==2 set quality=4
if %errorlevel%==3 set quality=5
if %errorlevel%==4 set quality=6

choice /m 上限ビットレートを指定しますか？
if %errorlevel%==2 goto maxbitskip
echo 入力方法「 -B (○○○)」
set maxbit=
set /P maxbit=
:maxbitskip

if "%~x1"=="" goto folder



:roop
cd /d "%~dp1"
cls
set /a filecount=filecount+1
echo %filecount%個目のファイルを処理するよ
If not exist lame  mkdir lame
if "%~x1"==".wav" goto mp3
if "%~x1"==".mp3" goto mp3


:wav
ffmpeg -hide_banner -i "%~1" -vn -ac 2 -acodec pcm_s16le -f wav "lame\%~n1 ffmpeg.wav"
lame "lame\%~n1 ffmpeg.wav" -V%quality%%maxbit% "lame\%~n1.mp3"
del "lame\%~n1 ffmpeg.wav"

rem 比較バッチ用
if "%comparison%"=="yes" exit /b

shift
if not "%~1"=="" goto roop
pause
exit

:mp3
lame %1 -V%quality%%maxbit% "lame\%~n1.mp3"

rem 比較バッチ用
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
@REM これは昔使ってたラインに通知飛ばす用 ： @REM これは昔使ってたラインに通知飛ばす用 ： call C:\Users\kouki\OneDrive\CUIApplication\notify.bat mp3_end
pause
exit