cd /d %~dp1
If not exist mpeg mkdir ffmpeg
ffmpeg -i %1 -filter_complex "channelsplit=channel_layout=7.1[FL][FR][FC][LFE][BL][BR][SL][SR]" -map "[FL]" "ffmpeg\%~n1-1front_left.flac" -map "[FR]" "ffmpeg\%~n1-2front_right.flac" -map "[FC]" "ffmpeg\%~n1-3front_center.flac" -map "[LFE]" "ffmpeg\%~n1-4lfe.flac" -map "[BL]" "ffmpeg\%~n1-5back_left.flac" -map "[BR]" "ffmpeg\%~n1-6back_right.flac" -map "[SL]" "ffmpeg\%~n1-7side_left.flac" -map "[SR]" "ffmpeg\%~n1-8side_right.flac"
pause
exit