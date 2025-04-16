@echo off
setlocal enabledelayedexpansion

:: 获取当前脚本所在目录
set "script_dir=%~dp0"

:: 检查并移除末尾的反斜杠
if "!script_dir:~-1!"=="\" (
    set "script_dir=!script_dir:~0,-1!"
)

set "default_path=C:\Program Files (x86)\Beyond Compare 4"

if exist "%default_path%\BCompare.exe" (
    setx BC_PATH "%default_path%"
    echo 已添加环境变量 BC_PATH: "%default_path%"
) else (
    set /p input_path=请输入Beyond Compare安装路径：
    if exist "!input_path!\BCompare.exe" (
        setx BC_PATH "!input_path!"
        echo 已添加环境变量 BC_PATH: "!input_path!"
    ) else (
        echo 未找到"!input_path!"目录内存在BCompare.exe，安装失败。
        pause
        exit /b 1
    )
)

setx EXCEL_DIFF_PATH "%script_dir%"
echo 已添加环境变量 EXCEL_DIFF_PATH: "%script_dir%"

@REM :: 检查 Path 中是否已包含该路径
@REM echo %PATH% | findstr /C:"%DIR%" >nul
@REM if errorlevel 1 (
@REM     :: 添加到用户环境变量 Path
@REM     setx PATH "%PATH%;%DIR%"
@REM     echo 已添加 "%DIR%" 添加到环境变量 PATH。
@REM )

:: 获取当前用户级 Path 的值
for /f "tokens=3*" %%A in ('reg query "HKCU\Environment" /v Path 2^>nul') do (
    set "raw_path=%%A %%B"
)

:: 移除末尾的空格
set "current_user_path=!raw_path!"
:trim
if "!current_user_path:~-1!"==" " (
    set "current_user_path=!current_user_path:~0,-1!"
    goto trim
)

set "new_path=%script_dir%"
:: 检查是否已包含要添加的路径
echo !current_user_path! | findstr /C:"%new_path%" >nul
if errorlevel 1 (
    :: 追加新的路径
    set "updated_path=!current_user_path!;%new_path%;"
    :: 设置新的用户级 Path
    setx Path "!updated_path!"
    echo 已添加 "%new_path%" 到环境变量 PATH。
)
echo;
echo;
echo 安装成功，请不要删除或重命名当前目录："%script_dir%"
echo;
pause