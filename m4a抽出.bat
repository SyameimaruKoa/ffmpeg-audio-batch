@echo off
chcp 932
if not "%~2"=="" goto 2ormore

:roop
cls
set /a filecount=filecount+1
echo %filecount%個目のファイルを処理するよ
ffmpeg -hide_banner -i %1 -vn -c:a copy "%~dpn1 ffmpeg.m4a"
exiftool -api largefilesupport=1 -tagsfromfile %1 -all:all -overwrite_original "%~dpn1 ffmpeg.m4a"
shift
if not "%~1"=="" goto roop
pause
exit

:2ormore
cd /d "%~dp1"
cls
set /a filecount=filecount+1
echo %filecount%個目のファイルを処理するよ
If not exist ffmpeg  mkdir ffmpeg
ffmpeg -hide_banner -i %1 -vn -c:a copy "ffmpeg\%~n1.m4a"
exiftool -api largefilesupport=1 -tagsfromfile %1 -all:all -overwrite_original "ffmpeg\%~n1.m4a"
shift
if not "%~1"=="" goto 2ormore
pause
exit