@echo off

echo building python to exe ...

:: ���뵱ǰĿ¼
set DIRNAME=%~dp0
cd %DIRNAME%

:: ����pyinstaller���
python -m PyInstaller -F -n excel_split --distpath . split.py

if %errorlevel% NEQ 0 (
    echo build failed.
    pause
    exit
)
echo build success.
pause