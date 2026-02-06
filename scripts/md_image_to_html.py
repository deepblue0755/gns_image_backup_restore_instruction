#!/usr/bin/env python3

import sys
import re

if len(sys.argv) != 3:
    print(f"Usage: {sys.argv[0]} <input markdown_file> <output markdown_file>")
    sys.exit(1)

path = sys.argv[1]
out_path = sys.argv[2]

with open(path, "r", encoding="utf-8") as f:
    lines = f.readlines()
type(lines)

out = []

# Regex to match: ![](xxx){yyy}
md_img_re = re.compile(
    r'^(\s*)!\[\]\(([^)]+)\)\{([^}]*)\}\s*$'
)

# Extract width=xxx from {...}
width_re = re.compile(r'width\s*=\s*([^,\s]+)')

DEFAULT_WIDTH = "100%"

for line in lines:
    m = md_img_re.match(line)
    if not m:
        out.append(line)
        continue

    indent = m.group(1)
    img_path = m.group(2)
    attr_text = m.group(3)

    # Try to extract width
    wm = width_re.search(attr_text)
    width = wm.group(1) if wm else DEFAULT_WIDTH

    # 1. Comment original Markdown image
    out.append(f"{indent}<!-- {line.rstrip()} -->\n")

    # 2. Insert HTML block below
    out.append(f"""{indent}<div align="center">
{indent}    <img src="{img_path}" width="{width}">
{indent}</div>
""")

with open(out_path, "w", encoding="utf-8") as f:
    f.writelines(out)

print("Done: Markdown images converted to centered HTML blocks.")
