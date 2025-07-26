@echo off
chcp 932

echo aac-hcを使う場合は1
echo aac-heを使う場合は2
echo alac  を使う場合は3
choice /c 123
if %errorlevel%==1 set encoder=
if %errorlevel%==2 set encoder= --he
if %errorlevel%==3 set encoder= -A

choice /m "他を指定しますか？"
set V=
if %errorlevel%==2 goto parallelrun
echo 引数を入力してください。最後にスペースを入れてください
echo TVBR	-V	品質指定の数
echo CVBR	-v	目標のビットレート
echo ABR	-a	目標のビットレート
echo CBR	-c	目標のビットレート
echo.
echo TVBRの使用可能品質
echo 0 9 18 27 36 45 54 63 73 82 91 100 109 118 127
set /P V=
:parallelrun
start call "..\AAC変換 - 同時用.bat" %1 %file%
if not "%~2"=="" start call "..\AAC変換 - 同時用.bat" %2 %file%
if not "%~3"=="" start call "..\AAC変換 - 同時用.bat" %3 %file%
if not "%~4"=="" start call "..\AAC変換 - 同時用.bat" %4 %file%
if not "%~5"=="" start call "..\AAC変換 - 同時用.bat" %5 %file%
exit /b