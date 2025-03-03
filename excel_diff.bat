@echo off
setlocal

:: 校验参数个数
if "%~2"=="" (
    echo 参数个数不正确，请传入两个参数！
    exit /b 1
)

:: 清空split文件夹
set "target_folder=%EXCEL_DIFF_PATH%/split"
if exist "%target_folder%" (
    :: 进入目标文件夹
    pushd "%target_folder%" || (
        echo 无法进入split文件夹。
        exit /b 1
    )

    :: 移除所有文件和子目录
    echo 正在清空文件夹...
    attrib -h -s -r * /s /d >nul 2>&1  :: 移除所有属性
    del /f /s /q * >nul 2>&1          :: 删除所有文件
    for /d %%d in (*) do (             :: 删除所有子目录
        rd /s /q "%%d" >nul 2>&1
    )
)

set file1_path=%1
python "%EXCEL_DIFF_PATH%/split.py" %file1_path%
if not "%ERRORLEVEL%" == "0" (
    exit /b 1
)
:: 提取完整文件名（含扩展名）
for %%I in ("%file1_path%") do set "file1_name=%%~nxI"

set file2_path=%2
python "%EXCEL_DIFF_PATH%/split.py" %file2_path%
if not "%ERRORLEVEL%" == "0" (
    exit /b 1
)
:: 提取完整文件名（含扩展名）
for %%I in ("%file2_path%") do set "file2_name=%%~nxI"


"%BC_PATH%/BCompare.exe" "%EXCEL_DIFF_PATH%/split/%file1_name%" "%EXCEL_DIFF_PATH%/split/%file2_name%"

