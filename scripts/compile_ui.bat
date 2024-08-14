@ECHO OFF

FOR %%I IN ("%~dp0.") DO (
    FOR %%J IN ("%%~dpI.") DO (
        SET PARENT_DIR=%%~dpnxJ
    )
)

SET UI_DIR=%PARENT_DIR%\src\app\ui
SET MODULES_DIR=%PARENT_DIR%\src\app\modules
SET APP_DIR=%PARENT_DIR%\src\app

ECHO Compiling resource file...

pyside6-rcc %APP_DIR%\resources.qrc -o %MODULES_DIR%\resources_rc.py

ECHO Finished compiling resource file!

ECHO Compiling .ui files...

FOR %%f IN (%UI_DIR%\*.ui) DO ( 
    pyside6-uic %UI_DIR%\%%~nf.ui -o %MODULES_DIR%\ui_%%~nf.py
)

ECHO Finished compiling .ui files!

ECHO Correcting generated files...

FOR /F "delims=" %%f IN ('dir %MODULES_DIR% /b') DO (
    fart.exe %MODULES_DIR%\%%f "import resources_rc" "from . resources_rc import *"
)

ECHO Finished correcting generated files!
