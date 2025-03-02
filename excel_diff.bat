@echo off
setlocal
set file1_path=%1
python "%EXCEL_DIFF_PATH%/split.py" %file1_path%
:: 提取完整文件名（含扩展名）
for %%I in ("%file1_path%") do set "file1_name=%%~nxI"

set file2_path=%2
python "%EXCEL_DIFF_PATH%/split.py" %file2_path%
:: 提取完整文件名（含扩展名）
for %%I in ("%file2_path%") do set "file2_name=%%~nxI"


"%BC_PATH%/BCompare.exe" "%EXCEL_DIFF_PATH%/split/%file1_name%" "%EXCEL_DIFF_PATH%/split/%file2_name%"

