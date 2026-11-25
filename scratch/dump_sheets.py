import openpyxl

wb = openpyxl.load_workbook("design_docs/IdealJodi Register.xlsx")

with open("scratch/register_sheets.md", "w") as f:
    for sheet_name in wb.sheetnames:
        f.write(f"# SHEET: {sheet_name}\n\n")
        sheet = wb[sheet_name]
        
        # Determine table headers
        headers = [sheet.cell(1, c).value for c in range(1, sheet.max_column + 1)]
        headers = [h if h is not None else f"Col{i}" for i, h in enumerate(headers)]
        
        f.write("| " + " | ".join(headers) + " |\n")
        f.write("| " + " | ".join(["---"] * len(headers)) + " |\n")
        
        for r in range(2, sheet.max_row + 1):
            row_vals = [sheet.cell(r, c).value for c in range(1, sheet.max_column + 1)]
            if any(v is not None for v in row_vals):
                row_str = []
                for val in row_vals:
                    if val is None:
                        row_str.append("")
                    else:
                        # Clean up formatting for markdown table
                        val_clean = str(val).replace("\n", "<br>").replace("|", "\\|")
                        row_str.append(val_clean)
                f.write("| " + " | ".join(row_str) + " |\n")
        f.write("\n\n")

print("DUMP COMPLETED successfully to scratch/register_sheets.md")
