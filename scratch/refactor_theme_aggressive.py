import os
import re

def refactor_theme_aggressive(directory):
    replacements = [
        # Helper functions replacement
        (re.compile(r'getThemeTextColor\(\s*isDark:\s*(isDark|isDarkMode|ref\.watch\(themeProvider\))\s*\)'), r'Theme.of(context).colorScheme.onSurface'),
        (re.compile(r'getThemeTextColor\(\s*\)'), r'Theme.of(context).colorScheme.onSurface'),
        (re.compile(r'getThemeSubTextColor\(\s*isDark:\s*(isDark|isDarkMode|ref\.watch\(themeProvider\))\s*\)'), r'Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7)'),
        (re.compile(r'getThemeSubTextColor\(\s*\)'), r'Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7)'),
        (re.compile(r'getThemeBackgroundColor\(\s*isDark:\s*(isDark|isDarkMode|ref\.watch\(themeProvider\))\s*\)'), r'Theme.of(context).scaffoldBackgroundColor'),
        (re.compile(r'getThemeBackgroundColor\(\s*\)'), r'Theme.of(context).scaffoldBackgroundColor'),
        
        # Variable replacements in ternaries
        (re.compile(r'(isDark|isDarkMode|ref\.watch\(themeProvider\))\s*\?\s*appBackgroundColorDark\s*:\s*appBackgroundColor'), r'Theme.of(context).scaffoldBackgroundColor'),
        (re.compile(r'(isDark|isDarkMode|ref\.watch\(themeProvider\))\s*\?\s*darkSecondary\s*:\s*Colors\.white'), r'Theme.of(context).colorScheme.surface'),
        (re.compile(r'(isDark|isDarkMode|ref\.watch\(themeProvider\))\s*\?\s*darkPrimary\s*:\s*Colors\.white'), r'Theme.of(context).colorScheme.surface'),
        
        # Specific patterns found in grep
        (re.compile(r'ref\.watch\(themeProvider\)\s*\?\s*Colors\.grey\.shade800\s*:\s*Colors\.white'), r'Theme.of(context).colorScheme.surface'),
        (re.compile(r'isDark\s*\?\s*darkSecondary\.withValues\(alpha:\s*0\.5\)\s*:\s*Colors\.grey\.shade100'), r'Theme.of(context).colorScheme.secondaryContainer'),
        (re.compile(r'isDark\s*\?\s*darkSecondary\s*:\s*Colors\.grey'), r'Theme.of(context).colorScheme.secondaryContainer'),
        
        # Replace ref.watch(themeProvider) with context based brightness if used inside build
        # This is risky if not inside build, but we'll try to target ConsumerWidget/ConsumerStatefulWidget build methods
        (re.compile(r'final\s+(isDark|isDarkMode)\s*=\s*ref\.(watch|read)\(themeProvider\);'), r'final \1 = Theme.of(context).brightness == Brightness.dark;'),
    ]
    
    for root, dirs, files in os.walk(directory):
        for file in files:
            if file.endswith('.dart') and file not in ['app_theme.dart', 'theme_provider.dart', 'utils.dart', 'app_colors.dart']:
                path = os.path.join(root, file)
                with open(path, 'r') as f:
                    content = f.read()
                
                new_content = content
                for pattern, subst in replacements:
                    new_content = pattern.sub(subst, new_content)
                
                if new_content != content:
                    with open(path, 'w') as f:
                        f.write(new_content)
                    print(f"Aggressively Refactored Theme: {path}")

if __name__ == "__main__":
    refactor_theme_aggressive('/Users/apple/Desktop/NarjisInfotech/FlutterProjects/_pro_matrimony/pro_matrimony_dark_theme/lib')
