@echo off

set "package_dir=excel_diff"

cd %~dp0
:: 检查目标目录是否存在，如果不存在则创建
if not exist "%package_dir%" (
    echo 目标目录不存在，正在创建...
    mkdir "%package_dir%"
)

:: 复制文件到目标目录
copy /Y "excel_diff.bat" "%package_dir%"
copy /Y "excel_split.exe" "%package_dir%"
copy /Y "安装.bat" "%package_dir%"

7z a excel_diff.zip "%package_dir%"

rd /s /q "%package_dir%"

echo package success.

pause