@echo off
if "%comparison%"=="yes" goto roop

if not "%file%"=="" goto folderrun
chcp 932
choice /c 480 /m "44.1kHzか48kHzを強制する？"
if %errorlevel%==1 set ar=--rate 44100 
if %errorlevel%==2 set ar=--rate 48000 

echo aac-hcを使う場合は1
echo aac-heを使う場合は2
echo alac  を使う場合は3
choice /c 123
if %errorlevel%==1 set encoder=
if %errorlevel%==2 set encoder= --he
if %errorlevel%==3 set encoder= -A

choice /m "他を指定しますか？"
set V=
if %errorlevel%==2 goto run
echo 引数を入力してください。最後にスペースを入れてください
echo TVBR	-V	品質指定の数
echo CVBR	-v	目標のビットレート
echo ABR	-a	目標のビットレート
echo CBR	-c	目標のビットレート
echo.
echo TVBRの使用可能品質(数字が下がるほど圧縮する)
echo 0 9 18 27 36 45 54 63 73 82 91 100 109 118 127
set /P V=

:run
if "%~x1"=="" goto folder

:roop
cd /d "%~dp1"
cls
set /a filecount=filecount+1
echo %filecount%個目のファイルを処理するよ
If not exist qaac  mkdir qaac
if "%~x1"==".wav" goto aac
if "%~x1"==".m4a" goto aac
if "%~x1"==".mp4" goto aac

:wav
ffmpeg -hide_banner -i "%~1" -vn -c:a alac "qaac\%~n1 ffmpeg.m4a"
qaac64%encoder% "qaac\%~n1 ffmpeg.m4a" %ar%%V%-o "qaac\%~n1 qaac.m4a"
del "qaac\%~n1 ffmpeg.m4a"

rem 比較バッチ用
if "%comparison%"=="yes" exit /b

shift
if not "%~1"=="" goto roop
pause
exit

:aac
qaac64%encoder% "%~1" %ar%%V%-o "qaac\%~n1.m4a"

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
choice /c aw /m "変換元のファイルは、m4a(a) or wav(w)？"
if %errorlevel%==1 set file=m4a
if %errorlevel%==2 set file=wav
choice /m "親フォルダにフォルダを作りますか？"
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
@REM これは昔使ってたラインに通知飛ばす用 ： @REM これは昔使ってたラインに通知飛ばす用 ： call C:\Users\kouki\OneDrive\CUIApplication\notify.bat m4a_end
pause
exit