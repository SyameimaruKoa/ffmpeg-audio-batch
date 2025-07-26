@echo off
chcp 932
:roop
ffmpeg -hide_banner -i %1 -i %2 -i %3 -c copy ^
-map 0:v:0 ^
-map 2:a:0 ^
-map 1:a:0 ^
-metadata:s:a:0 title="ステレオ" ^
-metadata:s:a:1 title="モノラル" ^
"C:\Users\kouki\Videos\エンコード済み\%~n1 Multitrack.mp4"
shift
shift
shift
if not "%~1"=="" goto roop
pause
exit /b