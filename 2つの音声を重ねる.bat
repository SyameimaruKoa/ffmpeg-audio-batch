@echo off
echo 最初のファイルを音楽として手動指定してください(フルパス)
set /p Music=
:roop
If not exist "C:\Users\kouki\Videos\エンコード済み" mkdir "C:\Users\kouki\Videos\エンコード済み"
If not exist ffmpeg mkdir ffmpeg
cd /d "%~dp1"
ffmpeg -hide_banner -i %Music% -i %1 -filter_complex "[0:a][1:a]amix=inputs=2" -y "ffmpeg\%~n1.flac"
shift
if not "%~1"=="" goto roop
goto exit
exit