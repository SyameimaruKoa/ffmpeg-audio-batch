@echo off
chcp 932
if not "%~2"=="" goto 2ormore

:roop
%~d1
cd "%~dp1"
cls
set /a filecount=filecount+1
echo %filecount%個目のファイルを処理するよ
ffmpeg -hide_banner -i "%~1" -vn -c:a copy "%~dpn1 ffmpeg.wav"
shift
if not "%~1"=="" goto roop
pause
exit

:2ormore
%~d1
cd "%~dp1"
cls
set /a filecount=filecount+1
echo %filecount%個目のファイルを処理するよ
If not exist ffmpeg  mkdir ffmpeg
ffmpeg -hide_banner -i "%~1" -vn -c:a copy "ffmpeg\%~n1.wav"
shift
if not "%~1"=="" goto 2ormore
pause
exit