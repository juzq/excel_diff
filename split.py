import sys
import os
import pandas as pd

EXCEL_DIFF_PATH = "EXCEL_DIFF_PATH"


def split_excel_to_csv(excel_file: str, excel_diff_path: str):
    # 读取 Excel 文件（优化内存和速度）
    xls = pd.ExcelFile(excel_file, engine="openpyxl")
    file_name = os.path.basename(excel_file)  # 直接提取文件名
    csv_path = f"{excel_diff_path}/split/{file_name}"
    if not os.path.exists(csv_path):
        os.makedirs(csv_path)
    # 并行处理每个 Sheet
    for sheet_name in xls.sheet_names:
        # 按块读取大型文件（内存友好）
        df = pd.read_excel(xls, sheet_name=sheet_name, engine="openpyxl")
        # 生成 CSV 路径并保存
        csv_file = f"{csv_path}/{sheet_name}.csv"
        df.to_csv(csv_file, index=False, encoding="utf-8-sig")
        print(f"split csv file: {csv_file}")


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("用法: python split.py [excel文件]")
        sys.exit(-1)
    excel_diff_path = os.getenv(EXCEL_DIFF_PATH)
    if excel_diff_path is None:
        print(f"未定义环境变量: {EXCEL_DIFF_PATH}")
        sys.exit(-1)
    excel_file = sys.argv[1]
    if not os.path.exists(excel_file):
        print(f"excel文件: {excel_file}不存在")
        sys.exit(-1)
    split_excel_to_csv(excel_file, excel_diff_path)
