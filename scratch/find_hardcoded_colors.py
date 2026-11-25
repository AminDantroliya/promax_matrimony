import os
import re

# Regex patterns to locate direct Color calls in UI files
COLOR_HEX_RE = re.compile(r'\bColor\(0x[fF]{2}([a-fA-F0-9]{6})\)')
HEX_DECORATION_RE = re.compile(r'\bColor\(0x[a-fA-F0-9]{8}\)')
COLOR_LITERALS_RE = re.compile(r'\bColors\.(white|black|grey|blue|red|green|amber|orange|transparent|white[0-9]{2}|black[0-9]{2}|grey\.[a-zA-Z0-9]+)\b')

def scan_files(directory):
    found_colors = {}
    
    for root, dirs, files in os.walk(directory):
        if '.dart_tool' in root or '.git' in root:
            continue
            
        for file in files:
            if not file.endswith('.dart'):
                continue
                
            # Skip color/theme configuration files themselves
            if file in ['app_colors.dart', 'app_theme.dart', 'theme_provider.dart', 'theme_provider.g.dart']:
                continue
                
            filepath = os.path.join(root, file)
            try:
                with open(filepath, 'r', encoding='utf-8') as f:
                    lines = f.readlines()
                    
                matches_in_file = []
                for idx, line in enumerate(lines):
                    line_num = idx + 1
                    
                    # Search for hex colors
                    hex_matches = HEX_DECORATION_RE.findall(line)
                    for match in hex_matches:
                        # Skip if it is inside gradient/paint configs or common constants that are theme-independent (e.g. transparent or brand gradients)
                        if 'Colors.transparent' in line or 'transparent' in line.lower() or 'gradient' in line.lower():
                            continue
                        matches_in_file.append((line_num, f"Color match: {line.strip()}"))
                        
                    # Search for standard Colors literals
                    literal_matches = COLOR_LITERALS_RE.findall(line)
                    for match in literal_matches:
                        # We only want to report if they affect theme compatibility (e.g. background, borders, text, shapes).
                        # Let's skip transparent as it's usually correct, and red/green when used for validation alerts if appropriate.
                        if match in ['transparent']:
                            continue
                        matches_in_file.append((line_num, f"Literal Colors.{match}: {line.strip()}"))
                        
                if matches_in_file:
                    rel_path = os.path.relpath(filepath, directory)
                    found_colors[rel_path] = matches_in_file
                    
            except Exception as e:
                print(f"Error reading {filepath}: {e}")
                
    return found_colors

if __name__ == '__main__':
    lib_dir = '/Users/apple/Desktop/NarjisInfotech/FlutterProjects/_pro_matrimony/pro_matrimony_dark_theme/lib'
    colors_dict = scan_files(lib_dir)
    
    total_files = len(colors_dict)
    total_occurrences = sum(len(occurrences) for occurrences in colors_dict.values())
    
    print(f"Total files with hardcoded color references: {total_files}")
    print(f"Total color occurrences: {total_occurrences}\n")
    
    for path, occurrences in sorted(colors_dict.items()):
        print(f"[{path}]:")
        for line_num, detail in occurrences[:10]:  # Show first 10 for readability
            print(f"  Line {line_num}: {detail}")
        if len(occurrences) > 10:
            print(f"  ... and {len(occurrences) - 10} more occurrences.")
