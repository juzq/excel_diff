@echo off

echo building python to exe ...

:: 进入当前目录
set DIRNAME=%~dp0
cd %DIRNAME%

:: 调用pyinstaller打包
python -m PyInstaller -F -n excel_split --distpath . split.py

if %errorlevel% NEQ 0 (
    echo build failed.
    pause
    exit
)
echo build success.
pause