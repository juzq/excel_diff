#### 环境变量
* Beyond Compare路径：BC_PATH
* excel_diff路径：EXCEL_DIFF_PATH

### git
```
git config --global difftool.excel.cmd 'excel_diff.bat "$LOCAL" "$REMOTE"'
git difftool --tool=excel
```