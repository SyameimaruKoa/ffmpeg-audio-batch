@echo off
chcp 932
:roop
%~d1
cd "%~dp1"
cls
set /a filecount=filecount+1
echo %filecount%個目のファイルを処理するよ
If not exist ffmpeg  mkdir ffmpeg
ffmpeg -hide_banner -i "%~1" -vn ^
-af "asplit[f][s];[f]pan=3.1|c0=c0|c1=c1|c2=c2|c3=c3[r];[s]pan=stereo|c0=0.5*c4+0.5*c6|c1=0.5*c5+0.5*c7,compand=attacks=0:decays=0oints=-90/-84|-10/-4|-6/-2|-0/-0.3,aformat=channel_layouts=stereo[d];[r][d]amerge,pan=stereo|FL=.3254FL+.2301FC+.2818BL+.1627BR|FR=.3254FR+.2301FC-.1627BL-.2818BR" ^
"ffmpeg\%~n1.wav"
shift
if not "%~1"=="" goto roop
pause
exit