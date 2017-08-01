
@echo off
title Kolibri windows debug info
echo This script will print info about current Kolibri installation
echo "Your HOMEDRIVE\HOMEPATH is %HOMEDRIVE%%HOMEPATH%"
echo "The Kolibri configs directory is %HOMEDRIVE%%HOMEPATH%\.kolibri"
echo "The Kolibri content directory is %HOMEDRIVE%%HOMEPATH%\.kolibri\content"

rem echo "ifconfig:::"
rem ipconfig /all

rem echo "Internet connectivity"
rem ping learningequality.org
rem ping 23.253.32.238

rem For each file in your folder
echo Files in your .kolibri/ directory:
for %%a in ("%HOMEPATH%\.kolibri\*") do (
  echo "%%a"
)


rem echo Kolibri settings .kolibri/kolibri_settings.json:
rem type %HOMEPATH%\.kolibri\kolibri_settings.json


echo ContentNode Files in content\storage:
cd /D "%HOMEDRIVE%%HOMEPATH%\.kolibri\content\storage"
dir /a-d /r /b /s

echo Content databases in content\databases:
cd /D %HOMEDRIVE%%HOMEPATH%\.kolibri\content\databases
dir /a-d /b /s

echo Media drive contents:
rem Mode con cols=100 lines=20 & Color 9E
wmic LOGICALDISK where driveType=2 get deviceID > wmic.txt
for /f "skip=1" %%b IN ('type wmic.txt') DO (echo %%b & dir /a-d /r /b /s %%b)
rem Del wmic.txt



pause