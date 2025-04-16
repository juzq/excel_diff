@echo off
setlocal enabledelayedexpansion

:: ��ȡ��ǰ�ű�����Ŀ¼
set "script_dir=%~dp0"

:: ��鲢�Ƴ�ĩβ�ķ�б��
if "!script_dir:~-1!"=="\" (
    set "script_dir=!script_dir:~0,-1!"
)

set "default_path=C:\Program Files (x86)\Beyond Compare 4"

if exist "%default_path%\BCompare.exe" (
    setx BC_PATH "%default_path%"
    echo ����ӻ������� BC_PATH: "%default_path%"
) else (
    set /p input_path=������Beyond Compare��װ·����
    if exist "!input_path!\BCompare.exe" (
        setx BC_PATH "!input_path!"
        echo ����ӻ������� BC_PATH: "!input_path!"
    ) else (
        echo δ�ҵ�"!input_path!"Ŀ¼�ڴ���BCompare.exe����װʧ�ܡ�
        pause
        exit /b 1
    )
)

setx EXCEL_DIFF_PATH "%script_dir%"
echo ����ӻ������� EXCEL_DIFF_PATH: "%script_dir%"

@REM :: ��� Path ���Ƿ��Ѱ�����·��
@REM echo %PATH% | findstr /C:"%DIR%" >nul
@REM if errorlevel 1 (
@REM     :: ��ӵ��û��������� Path
@REM     setx PATH "%PATH%;%DIR%"
@REM     echo ����� "%DIR%" ��ӵ��������� PATH��
@REM )

:: ��ȡ��ǰ�û��� Path ��ֵ
for /f "tokens=3*" %%A in ('reg query "HKCU\Environment" /v Path 2^>nul') do (
    set "raw_path=%%A %%B"
)

:: �Ƴ�ĩβ�Ŀո�
set "current_user_path=!raw_path!"
:trim
if "!current_user_path:~-1!"==" " (
    set "current_user_path=!current_user_path:~0,-1!"
    goto trim
)

set "new_path=%script_dir%"
:: ����Ƿ��Ѱ���Ҫ��ӵ�·��
echo !current_user_path! | findstr /C:"%new_path%" >nul
if errorlevel 1 (
    :: ׷���µ�·��
    set "updated_path=!current_user_path!;%new_path%;"
    :: �����µ��û��� Path
    setx Path "!updated_path!"
    echo ����� "%new_path%" ���������� PATH��
)
echo;
echo;
echo ��װ�ɹ����벻Ҫɾ������������ǰĿ¼��"%script_dir%"
echo;
pause