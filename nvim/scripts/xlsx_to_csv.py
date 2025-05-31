import sys
import pandas as pd

def xlsx_to_csv(xlsx_path, csv_path=None, sheet=0):
    df = pd.read_excel(xlsx_path, sheet_name=sheet)
    if csv_path is None:
        csv_path = xlsx_path.rsplit(".", 1)[0] + ".csv"
    df.to_csv(csv_path, index=False)
    print(f"Saved CSV to {csv_path}")

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: xlsx_to_csv.py <file.xlsx> [sheet_name_or_index]")
        sys.exit(1)
    xlsx_path = sys.argv[1]
    sheet = sys.argv[2] if len(sys.argv) > 2 else 0
    xlsx_to_csv(xlsx_path, sheet = sheet)

