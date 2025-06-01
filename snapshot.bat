@echo off
setlocal

:: Set date and time variables
for /f "tokens=1-3 delims=/- " %%a in ('date /t') do (
    set YYYY=%%c
    set MM=%%a
    set DD=%%b
)
for /f "tokens=1-2 delims=: " %%a in ('time /t') do (
    set HH=%%a
    set MN=%%b
)

:: Handle 12-hour format AM/PM
set HH=%HH: =0%
if /i "%time:~9,2%"=="PM" (
    if not "%HH%"=="12" set /a HH=HH+12
)
if /i "%time:~9,2%"=="AM" (
    if "%HH%"=="12" set HH=00
)

set DATE=%YYYY%-%MM%-%DD%
set TIME=%HH%-%MN%-00

set SNAPSHOT_DIR=%~dp0snapshots\%DATE%
mkdir "%SNAPSHOT_DIR%"

:: Run ffmpeg to capture snapshot
ffmpeg -rtsp_transport tcp -i "rtsp://admin:pk@0639544615@ramrome.thddns.net:3381/stream1" -vframes 1 "%SNAPSHOT_DIR%\snapshot_%TIME%.jpg"

:: Copy latest snapshot to root snapshots folder
copy /Y "%SNAPSHOT_DIR%\snapshot_%TIME%.jpg" "%~dp0snapshots\latest.jpg"

endlocal
