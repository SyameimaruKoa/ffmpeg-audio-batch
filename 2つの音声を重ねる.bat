@echo off
echo �ŏ��̃t�@�C�������y�Ƃ��Ď蓮�w�肵�Ă�������(�t���p�X)
set /p Music=
:roop
If not exist "C:\Users\kouki\Videos\�G���R�[�h�ς�" mkdir "C:\Users\kouki\Videos\�G���R�[�h�ς�"
If not exist ffmpeg mkdir ffmpeg
cd /d "%~dp1"
ffmpeg -hide_banner -i %Music% -i %1 -filter_complex "[0:a][1:a]amix=inputs=2" -y "ffmpeg\%~n1.flac"
shift
if not "%~1"=="" goto roop
goto exit
exit