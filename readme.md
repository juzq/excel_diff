## Excel对比工具
使用Beyond Compare对比一个Excel文件中的所有个工作表（Sheet），并支持在git和svn中调用该工具来进行对比。

### 环境配置
* 安装[Beyond Compare](https://www.beyondcomparepro.com/download)，并设置环境变量：BC_PATH，值为Beyond Compare路径，例如`C:\Program Files (x86)\Beyond Compare 4`。
* 设置环境变量：EXCEL_DIFF_PATH，值为excel_diff路径，例如`C:\workspace\test\excel_diff`。
* 将%EXCEL_DIFF_PATH%添加到PATH环境变量。
* 安装python3.7+，并添加到PATH环境变量。
* 安装pandas模块：`pip install pandas`。

### Beyond Compare设置
* 忽略文件时间戳：会话-会话设置-比较-比较时间戳（取消勾选），左下角（还要更新会话默认）确定。

### Git
#### 命令行
* 配置difftool对比工具：`git config --global difftool.excel.cmd 'excel_diff.bat "$LOCAL" "$REMOTE"'`。
* 对比未提交的excel：`git difftool --tool=excel`。
* 对比提交历史中的excel：`git difftool --tool=excel <commit_id1> <commit_id2>`.
#### SourceTree
* 配置外部对比工具：Tools-Options-Diff-External Diff/Merge，External Diff Tool选择自定义，Diff Command填`excel_diff.bat`，Arguments填`\"$LOCAL\" \"$REMOTE\"`（会自动填充）。
* 对比未提交的excel：指定文件右键-External Diff，也可以直接按快捷键Ctrl+D。
* 对比提交历史中的excel：选中要对比的Excel，按快捷键Ctrl+D。


### SVN
* 打开TortoiseSVN设置，Diff Viewer-Advanced...-.xlsx-修改External Program为`excel_diff.bat %base %mine`
* 对比提交历史中的excel：选中要对比的excel，右键，Show changes...
