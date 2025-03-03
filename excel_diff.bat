@echo off
setlocal

:: У���������
if "%~2"=="" (
    echo ������������ȷ���봫������������
    exit /b 1
)

:: ���split�ļ���
set "target_folder=%EXCEL_DIFF_PATH%/split"
if exist "%target_folder%" (
    :: ����Ŀ���ļ���
    pushd "%target_folder%" || (
        echo �޷�����split�ļ��С�
        exit /b 1
    )

    :: �Ƴ������ļ�����Ŀ¼
    echo ��������ļ���...
    attrib -h -s -r * /s /d >nul 2>&1  :: �Ƴ���������
    del /f /s /q * >nul 2>&1          :: ɾ�������ļ�
    for /d %%d in (*) do (             :: ɾ��������Ŀ¼
        rd /s /q "%%d" >nul 2>&1
    )
)

set file1_path=%1
python "%EXCEL_DIFF_PATH%/split.py" %file1_path%
if not "%ERRORLEVEL%" == "0" (
    exit /b 1
)
:: ��ȡ�����ļ���������չ����
for %%I in ("%file1_path%") do set "file1_name=%%~nxI"

set file2_path=%2
python "%EXCEL_DIFF_PATH%/split.py" %file2_path%
if not "%ERRORLEVEL%" == "0" (
    exit /b 1
)
:: ��ȡ�����ļ���������չ����
for %%I in ("%file2_path%") do set "file2_name=%%~nxI"


"%BC_PATH%/BCompare.exe" "%EXCEL_DIFF_PATH%/split/%file1_name%" "%EXCEL_DIFF_PATH%/split/%file2_name%"

