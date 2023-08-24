@echo off
setlocal enabledelayedexpansion

set "folder=H:\Games\MeinKampfLegacy\screenshots"
set "folder2="R:\Stabilization\MeinKampfScreenshots"

for %%A in ("%folder%\*.*") do (
    if /I "%%~xA" neq ".avif" (
        start /wait /b /belownormal ffmpeg.exe -i "%%~fA" -c:v av1 -crf 16 -b:v 0 -strict experimental "%folder2%\%%~nA.avif"
    )
)

echo Конвертация завершена!