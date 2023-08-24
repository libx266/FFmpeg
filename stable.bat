setlocal enabledelayedexpansion

set "source=R:\DDFF\Source\Part1"
set "target=R:\DDFF\Stable"

for %%F in ("%source%\*") do (
    set "input=%%F"
    set "output=%target%\%%~nxF"
    REM Шаг 1: Стабилизация видео
    start /wait /b /belownormal ffmpeg.exe -hwaccel dxva2 -i "!input!" -vf vidstabdetect=stepsize=6:shakiness=9:accuracy=12:result=transforms.trf -y -hide_banner -f null -
    start /wait /b /belownormal ffmpeg.exe -hwaccel dxva2 -i "!input!" -vf vidstabtransform=input=transforms.trf:zoom=1.12:smoothing=18 -c:v hevc_amf -quality quality -rc cqp -qp_p 18 -qp_i 18 -c:a "copy" temp.mp4
    start /wait /b /low ffmpeg.exe -hwaccel dxva2 -i temp.mp4 -vf scale=1920:1080 -c:v libx265 -crf 26 -preset slow -c:a "copy" "!output!"
    del temp.mp4
    del transforms.trf
)