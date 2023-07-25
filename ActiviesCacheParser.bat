@echo off

setlocal enabledelayedexpansion
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableActivityFeed" >nul 2>&1
if %errorlevel% equ 0 (
    echo The user is using an ActiviesCache Bypass!
    pause>nul
) else (
    goto activiescache
)
endlocal


:activiescache
cls
set "searchDir=C:\Users\%USERNAME%\AppData\Local\ConnectedDevicesPlatform"
set "fileName=activitiescache.db"

for /f "delims=" %%G in ('dir /b /s /od "%searchDir%\%fileName%" 2^>nul') do (
    set "activitiesCachePath=%%G"
    goto :found
)

:found
if defined activitiesCachePath (
    echo Activities Cache Path: "%activitiesCachePath%"
) else (
    echo File not found.
)


mkdir %appdata%\SS\Automatic 
cls
set "url=https://f001.backblazeb2.com/file/EricZimmermanTools/net6/WxTCmd.zip"
set "output=%appdata%\SS\Automatic\WxTCmd.zip"
set "zipFile=%appdata%\SS\Automatic\WxTCmd.zip"
set "extractDir=%appdata%\SS\Automatic"

curl -o "%output%" "%url%"
ping localhost -n 3 >nul
powershell -Command "Expand-Archive -Path '%zipFile%' -DestinationPath '%extractDir%' -Force"
cls
setlocal enabledelayedexpansion
mkdir %appdata%\SS\Automatic\WxTCmd 2>nul
cd %appdata%\SS\Automatic
WxTCmd.exe -f "%activitiesCachePath%" --csv %appdata%\SS\Automatic\WxTCmd
cd %appdata%\SS\Automatic\WxTCmd
del *_*_Activity_PackageIDs.csv
del *_*_Activity.csv
cd %appdata%\SS\Automatic
del SQLite.interop.dll
set "folderPath=%appdata%\SS\Automatic\WxTCmd"

set "activityop="
set "count=0"
for %%F in ("%folderPath%\*") do (
    set /a count+=1
    set "activityop=%%F"
)


cls
mkdir %appdata%\SS\Automatic\Timelineexplorer 2>nul
set "url=https://f001.backblazeb2.com/file/EricZimmermanTools/net6/TimelineExplorer.zip"
set "output=%appdata%\SS\Automatic\TimelineExplorer.zip"
set "zipFile=%appdata%\SS\Automatic\TimelineExplorer.zip"
set "extractDir=%appdata%\SS\Automatic\"
curl -o "%output%" "%url%"
ping localhost -n 3 >nul
powershell -Command "Expand-Archive -Path '%zipFile%' -DestinationPath '%extractDir%' -Force"
cls
setlocal enabledelayedexpansion
set "timelineExePath=%appdata%\SS\Automatic\TimelineExplorer\TimelineExplorer.exe"
start "" "%timelineExePath%" "%activityop%"
echo Press Any key to leave!
pause>nul
( del /q /f "%~f0" >nul 2>&1 & exit /b 0  )