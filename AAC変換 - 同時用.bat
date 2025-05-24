@echo off
%~d1
cd %1
If not exist ..\qaac  mkdir ..\qaac
for /r %%i in (*.wav) do qaac64%encoder% "%%i" %ar%%V%-o "..\qaac\%%~ni.m4a"
@REM これは昔使ってたラインに通知飛ばす用 ： @REM これは昔使ってたラインに通知飛ばす用 ： call C:\Users\kouki\OneDrive\CUIApplication\notify.bat m4a_end
exit