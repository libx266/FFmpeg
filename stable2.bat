setlocal enabledelayedexpansion

set "source=R:\DDFF\Source\Part2"
set "target=R:\DDFF\Stable"

for %%F in ("%source%\*") do (
    set "input=%%F"
    set "output=%target%\%%~nxF"
    REM Шаг 1: Стабилизация видео
    start /wait /b /belownormal ffmpeg.exe -hwaccel dxva2 -i "!input!" -vf vidstabdetect=stepsize=6:shakiness=9:accuracy=12:result=transforms2.trf -y -hide_banner -f null -
    start /wait /b /belownormal ffmpeg.exe -hwaccel dxva2 -i "!input!" -vf vidstabtransform=input=transforms2.trf:zoom=1.12:smoothing=18 -c:v hevc_amf -quality quality -rc cqp -qp_p 18 -qp_i 18 -c:a "copy" temp2.mp4
    start /wait /b /low ffmpeg.exe -hwaccel dxva2 -i temp2.mp4 -vf scale=1920:1080 -c:v libx265 -crf 26 -preset slow -c:a "copy" "!output!"
    del temp2.mp4
    del transforms2.trf
)