@echo off

set "package_dir=excel_diff"

cd %~dp0
:: ���Ŀ��Ŀ¼�Ƿ���ڣ�����������򴴽�
if not exist "%package_dir%" (
    echo Ŀ��Ŀ¼�����ڣ����ڴ���...
    mkdir "%package_dir%"
)

:: �����ļ���Ŀ��Ŀ¼
copy /Y "excel_diff.bat" "%package_dir%"
copy /Y "excel_split.exe" "%package_dir%"
copy /Y "��װ.bat" "%package_dir%"

7z a excel_diff.zip "%package_dir%"

rd /s /q "%package_dir%"

echo package success.

pause