@echo off
setlocal enabledelayedexpansion

:: Setze den Pfad zum OneDrive-Desktop
set "DESKTOP=C:\Users\basti\OneDrive\Desktop"
echo Desktop-Pfad: %DESKTOP%

:: Überprüfe, ob der Desktop-Ordner existiert
if not exist "%DESKTOP%" (
    echo Fehler: Der OneDrive-Desktop-Ordner wurde nicht gefunden.
    echo Bitte überprüfen Sie den Pfad: %DESKTOP%
    pause
    exit /b 1
)

:: Definiere die Ordner
set "FOLDERS=Games Videos Bilder Musik Allgemein"

:: Erstelle die Ordner, falls sie nicht existieren
for %%F in (%FOLDERS%) do (
    if not exist "%DESKTOP%\%%F" (
        mkdir "%DESKTOP%\%%F"
        if errorlevel 1 (
            echo Fehler beim Erstellen des Ordners %%F.
        ) else (
            echo Ordner %%F wurde erfolgreich erstellt.
        )
    ) else (
        echo Ordner %%F existiert bereits.
    )
)

:: Sortiere die Dateien
for %%F in ("%DESKTOP%\*.*") do (
    set "ext=%%~xF"
    set "moved=0"
    
    if /i "!ext!"==".exe" set "dest=Games" & set "moved=1"
    if /i "!ext!"==".mp4" set "dest=Videos" & set "moved=1"
    if /i "!ext!"==".avi" set "dest=Videos" & set "moved=1"
    if /i "!ext!"==".mkv" set "dest=Videos" & set "moved=1"
    if /i "!ext!"==".jpg" set "dest=Bilder" & set "moved=1"
    if /i "!ext!"==".png" set "dest=Bilder" & set "moved=1"
    if /i "!ext!"==".gif" set "dest=Bilder" & set "moved=1"
    if /i "!ext!"==".mp3" set "dest=Musik" & set "moved=1"
    if /i "!ext!"==".wav" set "dest=Musik" & set "moved=1"
    if /i "!ext!"==".flac" set "dest=Musik" & set "moved=1"
    
    if !moved!==1 (
        move "%%F" "%DESKTOP%\!dest!"
        if errorlevel 1 (
            echo Fehler beim Verschieben von %%~nxF in den Ordner !dest!.
        ) else (
            echo %%~nxF wurde erfolgreich in den Ordner !dest! verschoben.
        )
    ) else (
        if not "%%~nxF"=="organize_onedrive_desktop.bat" (
            move "%%F" "%DESKTOP%\Allgemein"
            if errorlevel 1 (
                echo Fehler beim Verschieben von %%~nxF in den Ordner Allgemein.
            ) else (
                echo %%~nxF wurde erfolgreich in den Ordner Allgemein verschoben.
            )
        )
    )
)

echo OneDrive-Desktop-Organisation abgeschlossen.
pause