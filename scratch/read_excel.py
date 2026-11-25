import openpyxl

wb = openpyxl.load_workbook("design_docs/IdealJodi Register.xlsx")
print("Sheet names:", wb.sheetnames)

for sheet_name in wb.sheetnames:
    print(f"\n--- SHEET: {sheet_name} ---")
    sheet = wb[sheet_name]
    for r in range(1, min(100, sheet.max_row + 1)):
        row_vals = [sheet.cell(r, c).value for c in range(1, sheet.max_column + 1)]
        # Filter out rows that are entirely None to make it readable
        if any(v is not None for v in row_vals):
            print(f"Row {r}: {row_vals}")
