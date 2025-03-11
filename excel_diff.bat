@echo off
setlocal

:: У���������
if "%~2"=="" (
    echo ������������ȷ���봫������������
    exit /b 1
)

set current_dir=%cd%

:: ���split�ļ���
set "target_folder=%EXCEL_DIFF_PATH%/split"
if exist "%target_folder%" (
    :: ����Ŀ���ļ���
    pushd "%target_folder%" || (
        echo �޷�����split�ļ��С�
        exit /b 1
    )

    :: �Ƴ������ļ�����Ŀ¼
    echo ��������ԱȻ���...
    :: �Ƴ���������
    attrib -h -s -r * /s /d >nul 2>&1
    :: ɾ�������ļ�
    del /f /s /q * >nul 2>&1
    :: ɾ��������Ŀ¼
    for /d %%d in (*) do (
        rd /s /q "%%d" >nul 2>&1
    )
)

cd %current_dir%
echo ��ǰ·��: %cd%

set file1_path=%1
echo ���ڲ��excel: %file1_path%
python "%EXCEL_DIFF_PATH%/split.py" %file1_path%
if not "%ERRORLEVEL%" == "0" (
    exit /b 1
)
:: ��ȡ�����ļ���������չ����
for %%I in ("%file1_path%") do set "file1_name=%%~nxI"
:: ȥ���ļ����е����ţ�svn����������"
set file1_name=%file1_name:"=%

set file2_path=%2
echo ���ڲ��excel: %file2_path%
python "%EXCEL_DIFF_PATH%/split.py" %file2_path%
if not "%ERRORLEVEL%" == "0" (
    exit /b 1
)
:: ��ȡ�����ļ���������չ����
for %%I in ("%file2_path%") do set "file2_name=%%~nxI"
:: ȥ���ļ����е����ţ�svn����������"
set file2_name=%file2_name:"=%


"%BC_PATH%/BCompare.exe" %EXCEL_DIFF_PATH%/split/%file1_name% %EXCEL_DIFF_PATH%/split/%file2_name%

