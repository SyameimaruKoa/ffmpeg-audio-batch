@echo off
if "%comparison%"=="yes" goto roop

chcp 932
if "%~x1"==".opus" goto decode
echo ビットレートを指定してください。(数字のみkbps単位)
echo 8kbps(最低)、32kbps(低)、64kbps(標準)、96kbps(高品質、既定)、160kbps(最高品質)
echo (声のみの場合はケツに「--speech」を付けるといいかも？)
set bitrate=
rem 選択スキップ用(skipする時はset /Pをコメントアウト)
rem ボイスドラマ圧縮用
@REM set bitrate=64
rem ボイドラあんまり聞かないやつ用
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
rem 元ファイルを消したくない場合は上のifをコメントアウト
del "%~n1 ffmpeg.flac"

rem 比較バッチ用
if "%comparison%"=="yes" exit /b

shift
if not "%~1"=="" goto roop
pause
exit

:opus
opusenc %1 --bitrate %bitrate% "%~n1.opus"
@REM if %errorlevel%==0 del %1
rem 元ファイルを消したくない場合は上のifをコメントアウト
rem 比較バッチ用
if "%comparison%"=="yes" exit /b


shift
if not "%~1"=="" goto roop
timeout /nobreak 3
exit

:2ormoreroop
cd /d "%~dp1"
cls
set /a filecount=filecount+1
echo %filecount%個目のファイルを処理するよ
if "%~x1"==".wav" goto 2ormoreopus
if "%~x1"==".opus" goto 2ormoreopus
if "%~x1"==".flac" goto 2ormoreopus


:2ormorewav
If not exist opusenc  mkdir opusenc
ffmpeg -hide_banner -i "%~1" -vn "opusenc\%~n1 ffmpeg.flac"
opusenc "opusenc\%~n1 ffmpeg.flac" --bitrate %bitrate% "opusenc\%~n1.opus"
del "opusenc\%~n1 ffmpeg.flac"

rem 比較バッチ用
if "%comparison%"=="yes" exit /b

shift
if not "%~1"=="" goto 2ormoreroop
pause
exit

:2ormoreopus
rem フォルダを作成したくない場合は下をコメントアウト
@REM If not exist opusenc  mkdir opusenc
rem フォルダ内に作りたくない場合はコメントアウト(下のifが動かなくなると怖いのでコメントアウトしたのは上側に)
@REM opusenc %1 --bitrate %bitrate% "opusenc\%~n1.opus"
opusenc %1 --bitrate %bitrate% "%~n1.opus"
if %errorlevel%==0 del %1
rem 元ファイルを消したくない場合は上のifをコメントアウト
rem 比較バッチ用
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
@REM これは昔使ってたラインに通知飛ばす用 ： call C:\Users\kouki\OneDrive\CUIApplication\notify.bat opus_end
pause
exit

:decode
cd /d "%~dp1"
cls
set /a filecount=filecount+1
echo "%~1"をデコードします
echo %filecount%個目のファイルを処理するよ
If not exist opusdec  mkdir opusdec
opusdec %1 "opusdec\%~n1.wav"
shift
if not "%~1"=="" goto decode
pause
exit